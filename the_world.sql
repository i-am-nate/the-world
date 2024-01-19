/*
Available tables to SELECT * FROM:
    continents  |   7 rows,  8 columns
        regions | 266 rows, 18 columns
            us  |  56 rows,  9 columns
            ca  |  13 rows,  9 columns

Available views to SELECT * FROM:
    every_population_ranked    | 337 rows, 3 columns
    population_by_subcontinent |  33 rows, 2 columns
    anywhere_ive_been          |  68 rows, 2 columns
    anywhere_ive_not_been      | 269 rows, 2 columns
*/
SELECT * FROM ;

----------------------------------------------------

-- already created 'the_world' db in the terminal
SHOW databases;
USE the_world;

-- table creation: continents
CREATE TABLE continents (
    continent_id int AUTO_INCREMENT,
    continent_name varchar(255) NOT NULL,
    population_estimate int NOT NULL,
    subcontinents int NOT NULL,
    un_countries int NOT NULL,
    defacto_autonomies int NOT NULL,
    external_subregions int NOT NULL,
    have_visited bool DEFAULT FALSE,
    PRIMARY KEY (continent_id),
    CONSTRAINT continents_ak1 UNIQUE (continent_name)
);

-- some column modifications: continents
ALTER TABLE continents AUTO_INCREMENT=1001;
ALTER TABLE continents DROP COLUMN subcontinents;
ALTER TABLE continents MODIFY COLUMN population_estimate bigint NOT NULL;

-- data insertion: continents
INSERT INTO continents (continent_name, population_estimate, un_countries, defacto_autonomies, external_subregions, have_visited)
VALUES  ('North America', 592296233, 23, 28, 44, TRUE),
        ('Europe', 747636045, 46, 53, 55, TRUE),
        ('Asia', 4560667108, 46, 52, 52, TRUE),
        ('South America', 434254119, 12, 12, 17, FALSE),
        ('Africa', 1275920972, 54, 55, 66, FALSE),
        ('Oceania', 45857655, 14, 19, 28, FALSE),
        ('Antarctica', 3200, 0, 0, 4, FALSE);

-- more column modifications: continents
ALTER TABLE continents
ADD type varchar(255) DEFAULT 'Continent';
ALTER TABLE continents MODIFY COLUMN type varchar(255) after population_estimate;

-- handy if error is thrown and data needs reset due to auto-increment
TRUNCATE TABLE continents;

SELECT * FROM continents;

-- table creation: countries
CREATE TABLE regions (
    region_id int NOT NULL AUTO_INCREMENT,
    continent_id int NOT NULL,
    continent_name varchar(255),
    region_name varchar(255) NOT NULL,
    country_code char(8) NOT NULL,
    emoji char(8) NOT NULL,
    type enum('UN country', 'De facto autonomy', 'External subregion'),
    population_estimate int NOT NULL,
    have_visited bool DEFAULT FALSE,
    country_order int,
    times_visited int,
    first_visit year,
    last_visit year,
    have_turtle bool DEFAULT FALSE,
    video_link varchar(255),
    travel_link varchar(255),
    PRIMARY KEY (region_id),
    CONSTRAINT fk_continent_id FOREIGN KEY (continent_id)
    REFERENCES continents(continent_id),
    CONSTRAINT ak_country_code UNIQUE (country_code)
);

TRUNCATE TABLE regions;

-- some column modifications: regions
ALTER TABLE regions MODIFY COLUMN travel_link varchar(1000);
ALTER TABLE regions MODIFY COLUMN emoji char(8) after region_id;
ALTER TABLE regions MODIFY COLUMN region_name varchar(255) after emoji;
ALTER TABLE regions MODIFY COLUMN population_estimate int DEFAULT NULL;

-- data insertion: continents
INSERT INTO regions (continent_id, continent_name, region_name, country_code, emoji, type, population_estimate, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES (1001, 'North America', 'Canada', 'ca', '🇨🇦', 'UN country', 38954600, TRUE, 2, 12, 2004, 2023, FALSE, 'https://youtu.be/SxhUsPBFPkU?si=gPEsV0-RF7o2OFt_', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Canada.html');
-- North America 1001
INSERT INTO regions (continent_id, continent_name, region_name, country_code, emoji, type, population_estimate, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES  (1001, 'North America', 'United States', 'us', '🇺🇸', 'UN country', 335893238, TRUE, 1, 99, 1996, 2024, FALSE, 'https://youtu.be/Xp_TGilL9Sk?si=i5nB9twR0SB-15QJ', ''),
        (1001, 'North America', 'Mexico', 'mx', '🇲🇽', 'UN country', 129406736, TRUE, 9, 1, 2018, 2018, TRUE, 'https://youtu.be/Kxy74EAjAec?si=YAGt-L4_U_CYeUtv', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Mexico.html, https://www.gov.uk/foreign-travel-advice/mexico'),
        (1001, 'North America', 'Belize', 'bz', '🇧🇿', 'UN country', 441471, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/3MrYk3kCUGk?si=vpq79482zW9xoPxC', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Belize.html'),
        (1001, 'North America', 'Guatemala', 'gt', '🇬🇹', 'UN country', 17602431, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/L1TSpYN0MBg?si=l2Ha6uwvkGjVkGAi', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Guatemala.html'),
        (1001, 'North America', 'Honduras', 'hn', '🇭🇳', 'UN country', 9745149, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/ND8PduJlN6A?si=9sDC1p5gC7vhs5-5', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Honduras.html'),
        (1001, 'North America', 'El Salvador', 'sv', '🇸🇻', 'UN country', 6884888, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/-t5uzY77zwA?si=tax1vrzvBGcg9Due', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/ElSalvador.html'),
        (1001, 'North America', 'Nicaragua', 'ni', '🇳🇮', 'UN country', 6733763, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/rr65vnslEZ0?si=IbMwyjjLSsm_n_bO', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Nicaragua.html'),
        (1001, 'North America', 'Costa Rica', 'cr', '🇨🇷', 'UN country', 5262225, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/DaBEGru_IEc?si=eqGep8VhggIitI65', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/CostaRica.html'),
        (1001, 'North America', 'Panama', 'pa', '🇵🇦', 'UN country', 4337406, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/P722VC7b9iM?si=e91Ada6uTAFvstQM', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Panama.html'),
        (1001, 'North America', 'Bahamas', 'bs', '🇧🇸', 'UN country', 397360, TRUE, 3, 1, 2005, 2005, FALSE, 'https://youtu.be/J9aV4Zn8JJE?si=DglwVotIL4xYl5eZ', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Bahamas.html'),
        (1001, 'North America', 'Cuba', 'cu', '🇨🇺', 'UN country', 11089511, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/iQnhoYc2QTg?si=27jtrmJ7hbiRcMq5', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Cuba.html'),
        (1001, 'North America', 'San Andrés and Providencia (CO)', 'sap', '🇨🇴🇨🇴🇨🇴', 'External subregion', 61898, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/hW-RSfg972g?si=5OFZ_p2xQBjGvxzB', ''),
        (1001, 'North America', 'Cayman Islands (UK)', 'ky', '🇰🇾🇬🇧🇬🇧', 'External subregion', 71105, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/XkFeBmvqLTw?si=BXqf60Dv9g28cLZq', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/CaymanIslands.html'),
        (1001, 'North America', 'Jamaica', 'jm', '🇯🇲', 'UN country', 2825544, TRUE, 4, 2, 2013, 2014, FALSE, 'https://youtu.be/LaLumU4pSf8?si=cqfaekJe-dIGK5Hu', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Jamaica.html'),
        (1001, 'North America', 'Turks and Caicos (UK)', 'tc', '🇹🇨🇬🇧🇬🇧', 'External subregion', 46131, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/-lbjRhqMo4g?si=PZjWVgZCmvhVTNly', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/TurksandCaicosIslands.html'),
        (1001, 'North America', 'Haiti', 'ht', '🇭🇹', 'UN country', 11743017, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/O0G9a2Kn6-Q?si=orWityqXVEG7owu_', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Haiti.html, https://www.gov.uk/foreign-travel-advice/haiti'),
        (1001, 'North America', 'Dominican Republic', 'do', '🇩🇴', 'UN country', 10760028, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/dQv3t5VCc3U?si=-hjJhp2hKCwiJoxa', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/DominicanRepublic.html'),
        (1001, 'North America', 'Puerto Rico (US)', 'pr', '🇵🇷🇺🇸🇺🇸', 'External subregion', 3205691, TRUE, NULL, 1, 2023, 2023, FALSE, 'https://www.youtube.com/watch?v=NUOjIZp5424', ''),
        (1001, 'North America', 'US Virgin Islands (US)', 'vi', '🇻🇮🇺🇸🇺🇸', 'External subregion', 87146, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/YVy7UkxzxEA?si=VyPsaZndbjpVNHzM', ''),
        (1001, 'North America', 'British Virgin Islands (UK)', 'vg', '🇻🇬🇬🇧🇬🇧', 'External subregion', 31538, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/Anep2LKaP8A?si=Ju6XHBgXYp4B8vbh', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/BritishVirginIslands.html'),
        (1001, 'North America', 'Anguilla (UK)', 'ai', '🇦🇮🇬🇧🇬🇧', 'External subregion', 15701, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/zU8CWzFWWTY?si=pCqF0UdyrEg8DWMY', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Anguilla.html'),
        (1001, 'North America', 'Saint Martin (FR)', 'mf', '🇫🇷🇫🇷🇫🇷', 'External subregion', 32358, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/7FwYTIJc9QY?si=IpCzkuW3ix_KKGTz', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/FrenchWestIndies.html.html?wcmmode=disabled'),
        (1001, 'North America', 'Sint Maarten (NL)', 'sx', '🇸🇽🇳🇱', 'De facto autonomy', 42938, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/PbY5_udWMvE?si=dC5_2k-9KdQaezdX', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/SintMaarten.html'),
        (1001, 'North America', 'Saint Barthélemy (FR)', 'bl', '🇧🇱🇫🇷', 'De facto autonomy', 10585, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/kczhBB2pfms?si=7tELGtVFgICF23V9', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/FrenchWestIndies.html.html?wcmmode=disabled'),
        (1001, 'North America', 'Saba (NL)', 'sab', '🇳🇱🇳🇱🇳🇱', 'External subregion', 2035, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/z90cGdK3T0E?si=AhG3oNK9Csy-cYXY', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/BonaireSintEustatiusandSaba.html'),
        (1001, 'North America', 'Sint Eustatius (NL)', 'seu', '🇳🇱🇳🇱🇳🇱', 'External subregion', 3293, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/MJCIx2ptKa0?si=ci36jti0LJV48WVA', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/BonaireSintEustatiusandSaba.html'),
        (1001, 'North America', 'St Kitts and Nevis', 'kn', '🇰🇳', 'UN country', 47195, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/y5FPRLgQ41Q?si=19BXcWWEonlqtkko', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/SaintKittsandNevis.html'),
        (1001, 'North America', 'Antigua and Barbuda', 'ag', '🇦🇬', 'UN country', 100772, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/5OpiUD3qtY8?si=iCVS_H3a5zQpfZNq', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/AntiguaandBarbuda.html'),
        (1001, 'North America', 'Montserrat (UK)', 'ms', '🇲🇸🇬🇧🇬🇧', 'External subregion', 4433, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/Da_dU1KikNc?si=H2zWLyb17kPLFXR0', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Montserrat.html'),
        (1001, 'North America', 'Guadeloupe (FR)', 'gp', '🇬🇵🇫🇷🇫🇷', 'External subregion', 691931, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/2psykRCagVc?si=39yyK0gHHxgyQcuO', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/FrenchWestIndies.html.html?wcmmode=disabled'),
        (1001, 'North America', 'Dominica', 'dm', '🇩🇲', 'UN country', 67408, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/OGaML8Gg8JQ?si=avkid_nTSr-lWqyA', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Dominica.html'),
        (1001, 'North America', 'Martinique (FR)', 'mq', '🇲🇶🇫🇷🇫🇷', 'External subregion', 360749, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/7o_XA3n-dRk?si=Xc6WKNG-Q8UFFWUB', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/FrenchWestIndies.html.html?wcmmode=disabled'),
        (1001, 'North America', 'St Lucia', 'lc', '🇱🇨', 'UN country', 178696, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/x8SLZvHOBvI?si=4z_kc845-NNF7lwU', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/SaintLucia.html'),
        (1001, 'North America', 'St Vincent and the Grenadines', 'vc', '🇻🇨', 'UN country', 110872, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/E5DV8mD9_eQ?si=IjhQTDqc-CjSlTn6', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/SaintVincentandtheGrenadines.html'),
        (1001, 'North America', 'Barbados', 'bb', '🇧🇧', 'UN country', 267800, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/uvA3DUJCxpY?si=lcKIINgm6MYF5FDS', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Barbados.html'),
        (1001, 'North America', 'Grenada', 'gd', '🇬🇩', 'UN country', 112579, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/fHZ_cVHPRmM?si=lAp2X_HWF10b6rpV', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Grenada.html'),
        (1001, 'North America', 'Trinidad and Tobago', 'tt', '🇹🇹', 'UN country', 1365805, FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/fHZ_cVHPRmM?si=lAp2X_HWF10b6rpV', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/TrinidadandTobago.html'),
        (1001, 'North America', 'Bonaire (NL)', 'bq', '🇧🇶🇳🇱🇳🇱', 'External subregion', 24090, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/og-3ZMjv1fI?si=_ge6uwswQs4gNnoi', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/BonaireSintEustatiusandSaba.html'),
        (1001, 'North America', 'Curaçao (NL)', 'cw', '🇨🇼🇳🇱', 'De facto autonomy', 148925, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/lfXxwC0jE3E?si=YTMRhsP345mCw4R2', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Curacao.html'),
        (1001, 'North America', 'Aruba (NL)', 'aw', '🇦🇼🇳🇱', 'De facto autonomy', 106739, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/UQsB1lLxIYM?si=2Tbj6zqpMHmoY0hu', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Aruba.html'),
        (1001, 'North America', 'Saint Pierre and Miquelon (FR)', 'pm', '🇵🇲🇫🇷🇫🇷', 'External subregion', 6092, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/UcuK3O_dtv8?si=4F6O6nhigssj8uB7', 'https://www.gov.uk/foreign-travel-advice/st-pierre-and-miquelon'),
        (1001, 'North America', 'Bermuda (UK)', 'bm', '🇧🇲🇬🇧🇬🇧', 'External subregion', 64055, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/2wX4I66Y6xs?si=DzvDH5iG2X19OyEk', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Bermuda.html'),
        (1001, 'North America', 'Greenland (DK)', 'gl', '🇬🇱🇩🇰', 'De facto autonomy', 56865, FALSE, NULL, 0, NULL, NULL, FALSE, 'https://youtu.be/USfQ8BF7sWs?si=o90MMOd89r2lFjLY', '');
-- Europe 1002
INSERT INTO regions (emoji, region_name, continent_id, continent_name, country_code, type, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES ('🇮🇸', 'Iceland', 1002, 'Europe', 'is', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇫🇴🇩🇰', 'Faroe Islands (DK)', 1002, 'Europe', 'fo', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇪', 'Ireland', 1002, 'Europe', 'ie', 'UN country', TRUE, 5, 1, 2015, 2015, TRUE, '', ''),
       ('🇮🇲🇬🇧', 'Isle of Man (UK)', 1002, 'Europe', 'im', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇬🇧', 'United Kingdom', 1002, 'Europe', 'uk', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇵🇹', 'Portugal', 1002, 'Europe', 'pt', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇪🇸', 'Spain', 1002, 'Europe', 'es', 'UN country', TRUE, 7, 1, 2018, 2018, TRUE, '', ''),
       ('🇬🇮🇬🇧🇬🇧', 'Gibralter (UK)', 1002, 'Europe', 'gi', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇩', 'Andorra', 1002, 'Europe', 'ad', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇬🇬🇬🇧', 'Guernsey (UK)', 1002, 'Europe', 'gg', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇯🇪🇬🇧', 'Jersey (UK)', 1002, 'Europe', 'je', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇫🇷', 'France', 1002, 'Europe', 'fr', 'UN country', TRUE, 8, 1, 2018, 2018, TRUE, '', ''),
       ('🇳🇱', 'Netherlands', 1002, 'Europe', 'nl', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇪', 'Belgium', 1002, 'Europe', 'be', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇺', 'Luxembourg', 1002, 'Europe', 'lu', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇩🇪', 'Germany', 1002, 'Europe', 'de', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇩🇰', 'Denmark', 1002, 'Europe', 'dk', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇳🇴', 'Norway', 1002, 'Europe', 'no', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇸🇪', 'Sweden', 1002, 'Europe', 'se', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇽🇫🇮', 'Åland (FI)', 1002, 'Europe', 'ax', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇨🇭', 'Switzerland', 1002, 'Europe', 'ch', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇨', 'Monaco', 1002, 'Europe', 'mc', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇹', 'Italy', 1002, 'Europe', 'it', 'UN country', TRUE, 11, 1, 2019, 2019, TRUE, '', ''),
       ('🇻🇦', 'Vatican City', 1002, 'Europe', 'va', 'UN country', TRUE, 12, 1, 2019, 2019, TRUE, '', ''),
       ('🇸🇲', 'San Marino', 1002, 'Europe', 'sm', 'UN country', TRUE, 13, 1, 2019, 2019, TRUE, '', ''),
       ('🇲🇹', 'Malta', 1002, 'Europe', 'mt', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇮', 'Liechtenstein', 1002, 'Europe', 'li', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇹', 'Austria', 1002, 'Europe', 'at', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇭🇺', 'Hungary', 1002, 'Europe', 'hu', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇨🇿', 'Czechia', 1002, 'Europe', 'cz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇸🇰', 'Slovakia', 1002, 'Europe', 'sk', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇵🇱', 'Poland', 1002, 'Europe', 'pl', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇸🇮', 'Slovenia', 1002, 'Europe', 'si', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇭🇷', 'Croatia', 1002, 'Europe', 'hr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇦', 'Bosnia and Herzegovina', 1002, 'Europe', 'ba', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇪', 'Montenegro', 1002, 'Europe', 'me', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇷🇸', 'Serbia', 1002, 'Europe', 'rs', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇽🇰', 'Kosovo', 1002, 'Europe', 'kos', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇱', 'Albania', 1002, 'Europe', 'al', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇰', 'North Macedonia', 1002, 'Europe', 'mk', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇬🇷', 'Greece', 1002, 'Europe', 'gr', 'UN country', TRUE, 10, 1, 2019, 2019, TRUE, '', ''),
       ('🇨🇾', 'Cyprus', 1002, 'Europe', 'cy', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇨🇾🇨🇾', 'Northern Cyprus', 1002, 'Europe', 'ncy', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇬', 'Bulgaria', 1002, 'Europe', 'bg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇷🇴', 'Romania', 1002, 'Europe', 'ro', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇩', 'Moldova', 1002, 'Europe', 'md', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇩🇲🇩', 'Transnistria', 1002, 'Europe', 'tra', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇺🇦', 'Ukraine', 1002, 'Europe', 'ua', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇾', 'Belarus', 1002, 'Europe', 'by', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇹', 'Lithuania', 1002, 'Europe', 'lt', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇻', 'Latvia', 1002, 'Europe', 'lv', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇪🇪', 'Estonia', 1002, 'Europe', 'ee', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇫🇮', 'Finland', 1002, 'Europe', 'fi', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇳🇴🇳🇴🇳🇴', 'Svalbard (NO)', 1002, 'Europe', 'sj', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇷🇺', 'Russia', 1002, 'Europe', 'ru', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', '');
-- Asia 1003
INSERT INTO regions (emoji, region_name, continent_id, continent_name, country_code, type, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES ('🇹🇷', 'Türkiye', 1003, 'Asia', 'tr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇬🇪', 'Georgia', 1003, 'Asia', 'ge', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇬🇪🇬🇪', 'Abkhazia', 1003, 'Asia', 'abk', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇬🇪🇬🇪', 'South Ossetia', 1003, 'Asia', 'sos', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇲', 'Armenia', 1003, 'Asia', 'am', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇿', 'Azerbaijan', 1003, 'Asia', 'az', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇷', 'Iran', 1003, 'Asia', 'ir', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇶', 'Iraq', 1003, 'Asia', 'iq', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇸🇾', 'Syria', 1003, 'Asia', 'sy', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇧', 'Lebanon', 1003, 'Asia', 'lb', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇯🇴', 'Jordan', 1003, 'Asia', 'jo', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇱', 'Israel', 1003, 'Asia', 'il', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇵🇸🇵🇸', 'Palestine', 1003, 'Asia', 'ps', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇸🇦', 'Saudi Arabia', 1003, 'Asia', 'sa', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇰🇼', 'Kuwait', 1003, 'Asia', 'kw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇭', 'Bahrain', 1003, 'Asia', 'bh', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇶🇦', 'Qatar', 1003, 'Asia', 'qa', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇪', 'United Arab Emirates', 1003, 'Asia', 'ae', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇴🇲', 'Oman', 1003, 'Asia', 'om', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇾🇪', 'Yemen', 1003, 'Asia', 'ye', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇰🇿', 'Kazakhstan', 1003, 'Asia', 'kz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇺🇿', 'Uzbekistan', 1003, 'Asia', 'uz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇹🇲', 'Turkmenistan', 1003, 'Asia', 'tm', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇦🇫', 'Afghanistan', 1003, 'Asia', 'af', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇰🇬', 'Kyrgyzstan', 1003, 'Asia', 'kg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇹🇯', 'Tajikistan', 1003, 'Asia', 'tj', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇵🇰', 'Pakistan', 1003, 'Asia', 'pk', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇳', 'India', 1003, 'Asia', 'in', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇰', 'Sri Lanka', 1003, 'Asia', 'lk', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇻', 'Maldives', 1003, 'Asia', 'mv', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇩', 'Bangladesh', 1003, 'Asia', 'bd', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇳🇵', 'Nepal', 1003, 'Asia', 'np', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇧🇹', 'Bhutan', 1003, 'Asia', 'bt', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇳', 'Mongolia', 1003, 'Asia', 'mn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇨🇳', 'China', 1003, 'Asia', 'cn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇭🇰🇨🇳', 'Hong Kong', 1003, 'Asia', 'hk', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇴🇨🇳', 'Macau', 1003, 'Asia', 'mo', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇹🇼🇨🇳', 'Taiwan', 1003, 'Asia', 'tw', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇰🇵', 'North Korea', 1003, 'Asia', 'kp', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇰🇷', 'South Korea', 1003, 'Asia', 'kr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇯🇵', 'Japan', 1003, 'Asia', 'jp', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇲', 'Myanmar', 1003, 'Asia', 'mm', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇹🇭', 'Thailand', 1003, 'Asia', 'th', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇱🇦', 'Laos', 1003, 'Asia', 'la', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇰🇭', 'Cambodia', 1003, 'Asia', 'kh', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇻🇳', 'Vietnam', 1003, 'Asia', 'vn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇲🇾', 'Malaysia', 1003, 'Asia', 'my', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇸🇬', 'Singapore', 1003, 'Asia', 'sg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇮🇩', 'Indonesia', 1003, 'Asia', 'id', 'UN country', TRUE, 6, 1, 2017, 2017, TRUE, '', ''),
       ('🇧🇳', 'Brunei', 1003, 'Asia', 'bn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇹🇱', 'Timor-Leste', 1003, 'Asia', 'tl', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
       ('🇵🇭', 'Philippines', 1003, 'Asia', 'ph', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', '');
-- South America 1004
INSERT INTO regions (emoji, region_name, continent_id, continent_name, country_code, type, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES  ('🇨🇴', 'Colombia', 1004, 'South America', 'co', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇻🇪', 'Venezuela', 1004, 'South America', 've', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇻🇪🇻🇪🇻🇪', 'Nueva Espaerta (VE)', 1004, 'South America', 'nes', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇾', 'Guyana', 1004, 'South America', 'gy', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇷', 'Suriname', 1004, 'South America', 'sr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇫🇫🇷🇫🇷', 'French Guiana (FR)', 1004, 'South America', 'gf', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇧🇷', 'Brazil', 1004, 'South America', 'br', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇨', 'Ecuador', 1004, 'South America', 'ec', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇨🇪🇨🇪🇨', 'Galápagos Islands (EC)', 1004, 'South America', 'gpi', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇪', 'Peru', 1004, 'South America', 'pe', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇧🇴', 'Bolivia', 1004, 'South America', 'bo', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇾', 'Paraguay', 1004, 'South America', 'py', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇱', 'Chile', 1004, 'South America', 'cl', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🗿🇨🇱🇨🇱', 'Easter Island (CL)', 1004, 'South America', 'eai', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇦🇷', 'Argentina', 1004, 'South America', 'ar', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇫🇰🇬🇧🇬🇧', 'Falkland Islands (UK)', 1004, 'South America', 'fk', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇺🇾', 'Uruguay', 1004, 'South America', 'uy', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', '');
-- Africa 1005
INSERT INTO regions (emoji, region_name, continent_id, continent_name, country_code, type, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES  ('🇲🇷', 'Mauritania', 1005, 'Africa', 'mr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇦', 'Morocco', 1005, 'Africa', 'ma', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇭🇲🇦🇲🇦', 'Western Sahara (MA)', 1005, 'Africa', 'eh', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇮🇨🇪🇸🇪🇸', 'Canary Islands (ES)', 1005, 'Africa', 'can', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇹🇵🇹🇵🇹', 'Madeira (PT)', 1005, 'Africa', 'mad', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇹🇵🇹🇵🇹', 'Azores (PT)', 1005, 'Africa', 'azr', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇸🇪🇸🇪🇸', 'Ceuta (ES)', 1005, 'Africa', 'cta', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇸🇪🇸🇪🇸', 'Melilla (ES)', 1005, 'Africa', 'mla', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇩🇿', 'Algeria', 1005, 'Africa', 'dz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇳', 'Tunisia', 1005, 'Africa', 'tn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇮🇹🇮🇹🇮🇹', 'Pelagie Islands (IT)', 1005, 'Africa', 'pli', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇱🇾', 'Libya', 1005, 'Africa', 'ly', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇩', 'Chad', 1005, 'Africa', 'td', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇬', 'Egypt', 1005, 'Africa', 'eg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇩', 'Sudan', 1005, 'Africa', 'sd', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇻', 'Cabo Verde', 1005, 'Africa', 'cv', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇳', 'Senegal', 1005, 'Africa', 'sn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇲', 'The Gambia', 1005, 'Africa', 'gm', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇼', 'Guinea-Bissau', 1005, 'Africa', 'gw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬��', 'Guinea', 1005, 'Africa', 'gn', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇱', 'Sierra Leone', 1005, 'Africa', 'sl', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇱🇷', 'Liberia', 1005, 'Africa', 'lr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇮', 'Côte d''Ivire', 1005, 'Africa', 'ci', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇱', 'Mali', 1005, 'Africa', 'ml', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇧🇫', 'Burkina Faso', 1005, 'Africa', 'bf', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇭', 'Ghana', 1005, 'Africa', 'gh', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇬', 'Togo', 1005, 'Africa', 'tg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇧🇯', 'Benin', 1005, 'Africa', 'bj', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇪', 'Niger', 1005, 'Africa', 'ne', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇬', 'Nigeria', 1005, 'Africa', 'ng', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇲', 'Cameroon', 1005, 'Africa', 'cm', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇶', 'Equatorial Guinea', 1005, 'Africa', 'gq', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇦', 'Gabon', 1005, 'Africa', 'ga', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇹', 'São Tomé and Principe', 1005, 'Africa', 'st', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇫', 'Central African Republic', 1005, 'Africa', 'cf', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇬', 'Republic of the Congo', 1005, 'Africa', 'cg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇩', 'Democratic Republic of the Congo', 1005, 'Africa', 'cd', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇸', 'South Sudan', 1005, 'Africa', 'ss', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇹', 'Ethiopia', 1005, 'Africa', 'et', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇪🇷', 'Eritrea', 1005, 'Africa', 'er', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇩🇯', 'Djibouti', 1005, 'Africa', 'dj', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇴', 'Somalia', 1005, 'Africa', 'so', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇾🇪🇾🇪🇾🇪', 'Socotra Archipelago (YE)', 1005, 'Africa', 'soc', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇴🇸🇴', 'Somaliland', 1005, 'Africa', 'som', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇰🇪', 'Kenya', 1005, 'Africa', 'ke', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇺🇬', 'Uganda', 1005, 'Africa', 'ug', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇷🇼', 'Rwanda', 1005, 'Africa', 'rw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇧🇮', 'Burundi', 1005, 'Africa', 'bi', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇿', 'Tanzania', 1005, 'Africa', 'tz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇿', 'Mozambique', 1005, 'Africa', 'mz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇼', 'Malawi', 1005, 'Africa', 'mw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇿🇲', 'Zambia', 1005, 'Africa', 'zm', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇿🇼', 'Zimbabwe', 1005, 'Africa', 'zw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇦🇴', 'Angola', 1005, 'Africa', 'ao', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇭🇬🇧🇬🇧', 'Saint Helena, Ascension, and Tristan da Cunha (UK)', 1005, 'Africa', 'sh', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇦', 'Namibia', 1005, 'Africa', 'na', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇧🇼', 'Botswana', 1005, 'Africa', 'bw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇿🇦', 'South Africa', 1005, 'Africa', 'za', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇱🇸', 'Lesotho', 1005, 'Africa', 'ls', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇿', 'Eswatini', 1005, 'Africa', 'sz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇰🇲', 'Comoros', 1005, 'Africa', 'km', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇾🇹🇫🇷🇫🇷', 'Mayotte (FR)', 1005, 'Africa', 'yt', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇬', 'Madagascar', 1005, 'Africa', 'mg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇷🇪🇫🇷🇫🇷', 'Réunion (FR)', 1005, 'Africa', 're', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇺', 'Mauritius', 1005, 'Africa', 'mu', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇨', 'Seychelles', 1005, 'Africa', 'sc', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', '');
-- Oceania 1006
INSERT INTO regions (emoji, region_name, continent_id, continent_name, country_code, type, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES  ('🇨🇽🇦🇺🇦🇺', 'Christmas Island (AU)', 1006, 'Oceania', 'cx', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇨🇦🇺🇦🇺', 'Cocos (Keeling) Islands (AU)', 1006, 'Oceania', 'cc', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇦🇺', 'Australia', 1006, 'Oceania', 'au', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇿', 'New Zealand', 1006, 'Oceania', 'nz', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇬', 'Papua New Guinea', 1006, 'Oceania', 'pg', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇬🇵🇬', 'Bougainville (PG)', 1006, 'Oceania', 'bgv', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇼', 'Palau', 1006, 'Oceania', 'pw', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇬🇺🇺🇸🇺🇸', 'Guam (US)', 1006, 'Oceania', 'gu', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇵🇺🇸🇺🇸', 'Northern Mariana Islands (US)', 1006, 'Oceania', 'mp', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇫🇲', 'Micronesia', 1006, 'Oceania', 'fm', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇲🇭', 'Marshall Islands', 1006, 'Oceania', 'mh', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇷', 'Nauru', 1006, 'Oceania', 'nr', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇸🇧', 'Solomon Islands', 1006, 'Oceania', 'sb', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇻🇺', 'Vanuatu', 1006, 'Oceania', 'vu', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇻', 'Tuvulu', 1006, 'Oceania', 'vt', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇨🇫🇷', 'New Caledonia (FR)', 1006, 'Oceania', 'nc', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇫🇦🇺🇦🇺', 'Norfolk Island (AU)', 1006, 'Oceania', 'nf', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇫🇯', 'Fiji', 1006, 'Oceania', 'fj', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇴', 'Tonga', 1006, 'Oceania', 'to', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇼🇫🇫🇷🇫🇷', 'Wallis and Futuna (FR)', 1006, 'Oceania', 'wf', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇹🇰🇳🇿🇳🇿', 'Tokelau (NZ)', 1006, 'Oceania', 'tk', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇼🇸', 'Samoa', 1006, 'Oceania', 'ws', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇦🇸🇺🇸🇺🇸', 'American Samoa (US)', 1006, 'Oceania', 'as', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇳🇺🇳🇿', 'Niue (NZ)', 1006, 'Oceania', 'nu', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇨🇰🇳🇿', 'Cook Islands (NZ)', 1006, 'Oceania', 'ck', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇫🇫🇷', 'French Polynesia (FR)', 1006, 'Oceania', 'pf', 'De facto autonomy', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇰🇮', 'Kiribati', 1006, 'Oceania', 'ki', 'UN country', FALSE, 0, 0, NULL, NULL, FALSE, '', ''),
        ('🇵🇳🇬🇧🇬🇧', 'Pitcairn Islands (UK)', 1006, 'Oceania', 'pn', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, '', '');
-- Antarctica 1007
INSERT INTO regions (emoji, region_name, continent_id, continent_name, country_code, type, have_visited, country_order, times_visited, first_visit, last_visit, have_turtle, video_link, travel_link)
VALUES  ('🇦🇶🇦🇶🇦🇶', 'Antarctica (proper)', 1007, 'Antarctica', 'aq', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/JYCrqkTKfBc?si=QegyQhOAk6lEuegw', 'https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Antarctica.html, https://www.gov.uk/foreign-travel-advice/antarctica-british-antarctic-territory'),
        ('🇹🇫🇫🇷🇫🇷', 'French Southern & Antarctic Lands (FR)', 1007, 'Antarctica', 'tf', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/QDbIwaHIiT0?si=umWoWV1ejLMKWUK_', ''),
        ('🇬🇸🇬🇧🇬🇧', 'South Georgia and the South Sandwich Islands (UK)', 1007, 'Antarctica', 'gs', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/IvzrNf9t0JY?si=Cn0Srqwjls7R6scy', 'https://www.gov.uk/foreign-travel-advice/south-georgia-and-south-sandwich-islands'),
        ('🇦🇺🇦🇺🇦🇺', 'Heard Island and McDonald Islands (AU)', 1007, 'Antarctica', 'hm', 'External subregion', FALSE, 0, 0, NULL, NULL, FALSE, 'https://youtu.be/WVKK1jgI-TE?si=SDVr_VrB7EYVZvAn', '');



SELECT * FROM regions;

-- adding data to population_estimate column query by query, ending with region_id = 266
/* UPDATE regions
SET population_estimate = 0
WHERE region_id = 266; */

-- adding data to video_link and travel_link columns query by query, ending with region_id = 266
UPDATE regions
SET video_link  = 'https://youtu.be/WVKK1jgI-TE?si=SDVr_VrB7EYVZvAn',
    travel_link = ''
WHERE region_id = 266;

-- table creation (temporary): capitals
CREATE TABLE capitals (
    region_id int AUTO_INCREMENT,
    capital varchar(255) NOT NULL,
    CONSTRAINT fk_region_id FOREIGN KEY (region_id)
    REFERENCES regions(region_id)
);

-- data insertion (temporary): capitals
-- North America 1001
INSERT INTO capitals (capital)
VALUES  ('Ottawa'),
        ('Washington, D.C.');
INSERT INTO capitals (capital)
VALUES  ('Mexico City'),
        ('Belmopan'),
        ('Guatemala City'),
        ('Tegucigalpa/Comayagüela'),
        ('San Salvador'),
        ('Managua'),
        ('San José'),
        ('Panama City'),
        ('Nassau'),
        ('Havana'),
        ('San Andrés'),
        ('George Town'),
        ('Kingston'),
        ('Cockburn Town'),
        ('Port-au-Prince'),
        ('Santo Domingo'),
        ('San Juan'),
        ('Charlotte Amalie'),
        ('Road Town'),
        ('The Valley'),
        ('Marigot'),
        ('Philipsburg'),
        ('Gustavia'),
        ('The Bottom'),
        ('Oranjestad'),
        ('Basseterre'),
        ('St. John''s'),
        ('Plymouth/Brades/Little Bay'),
        ('Basse-Terre'),
        ('Roseau'),
        ('Fort-de-France'),
        ('Castries'),
        ('Kingstown'),
        ('Bridgetown'),
        ('St. George''s'),
        ('Port of Spain'),
        ('Kralendijk'),
        ('Willemstad'),
        ('Oranjestad'),
        ('St. Pierre'),
        ('Hamilton'),
        ('Nuuk');
-- Europe 1002
INSERT INTO capitals (capital)
VALUES  ('Reykjavík'),
        ('Tórshavn'),
        ('Dublin'),
        ('Douglas'),
        ('London'),
        ('Lisbon'),
        ('Madrid'),
        ('Gibralter'),
        ('Andorra la Vella'),
        ('St. Peter Port'),
        ('St. Helier'),
        ('Paris'),
        ('Amsterdam/The Hague'),
        ('Brussels'),
        ('Luxembourg'),
        ('Berlin'),
        ('Copenhagen'),
        ('Oslo'),
        ('Stockholm'),
        ('Mariehamn'),
        ('Bern'),
        ('Monaco'),
        ('Rome'),
        ('Vatican City'),
        ('San Marino'),
        ('Valletta'),
        ('Vaduz'),
        ('Vienna'),
        ('Budapest'),
        ('Prague'),
        ('Bratislava'),
        ('Warsaw'),
        ('Ljubljana'),
        ('Zagreb'),
        ('Sarajevo'),
        ('Podgorica'),
        ('Belgrade'),
        ('Pristina'),
        ('Tirana'),
        ('Skopje'),
        ('Athens'),
        ('Nicosia'),
        ('Nicosia'),
        ('Sofia'),
        ('Bucharest'),
        ('Chișinău'),
        ('Tiraspol'),
        ('Kiev'),
        ('Minsk'),
        ('Vilnius'),
        ('Riga'),
        ('Tallinn'),
        ('Helsinki'),
        ('Longyearbyen'),
        ('Moscow');
-- Asia 1003
INSERT INTO capitals (capital)
VALUES  ('Ankara'),
        ('Tbilisi'),
        ('Sukhumi'),
        ('Tskhinvali'),
        ('Yerevan'),
        ('Baku'),
        ('Tehran'),
        ('Baghdad'),
        ('Damascus'),
        ('Beirut'),
        ('Amman'),
        ('Jerusalem'),
        ('Ramallah'),
        ('Riyadh'),
        ('Kuwait City'),
        ('Manama'),
        ('Doha'),
        ('Abu Dhabi'),
        ('Muscat'),
        ('Aden/Sanaa'),
        ('Astana'),
        ('Tashkent'),
        ('Ashgabat'),
        ('Kabul'),
        ('Bishkek'),
        ('Dushanbe'),
        ('Islamabad'),
        ('New Delhi'),
        ('Colombo/Sri Jayawardenepura Kotte'),
        ('Malé'),
        ('Dhaka'),
        ('Kathmandu'),
        ('Thimphu'),
        ('Ulaanbaatar'),
        ('Beijing'),
        ('Hong Kong'),
        ('Macau'),
        ('Taipei'),
        ('Pyongyang'),
        ('Seoul'),
        ('Tokyo'),
        ('Naypyidaw'),
        ('Bangkok'),
        ('Vientiane'),
        ('Phnom Penh'),
        ('Hanoi'),
        ('Kuala Lumpur/Putrajaya'),
        ('Singapore'),
        ('Jakarta'),
        ('Bandar Seri Begawan'),
        ('Dili'),
        ('Manila');
-- South America 1004
INSERT INTO capitals (capital)
VALUES  ('Bogotá'),
        ('Caracas'),
        ('La Asunción'),
        ('Georgetown'),
        ('Paramaribo'),
        ('Cayenne'),
        ('Brasília'),
        ('Quito'),
        ('Puerto Baquerizo Moreno'),
        ('Lima'),
        ('La Paz/Sucre'),
        ('Asunción'),
        ('Santiago'),
        ('Hanga Roa'),
        ('Buenos Aires'),
        ('Stanley'),
        ('Montevideo');
-- Africa 1005
INSERT INTO capitals (capital)
VALUES  ('Nouakchott'),
        ('Rabat'),
        ('Laayoune/Tifariti'),
        ('Las Palmas de Gran Canaria/Santa Cruz de Tenerife'),
        ('Funchal'),
        ('Ponta Delgada/Angra do Heroísmo/Horta'),
        ('Ceuta'),
        ('Melilla'),
        ('Algiers'),
        ('Tunis'),
        ('Lampedusa'),
        ('Tripoli'),
        ('N''Djamena'),
        ('Cairo'),
        ('Khartoum'),
        ('Praia'),
        ('Dakar'),
        ('Banjul'),
        ('Bissau'),
        ('Conakry'),
        ('Freetown'),
        ('Monrovia'),
        ('Abidjan/Yamoussoukro'),
        ('Bamako'),
        ('Ouagadougou'),
        ('Accra'),
        ('Lomé'),
        ('Cotonou/Porto-Novo'),
        ('Niamey'),
        ('Abuja'),
        ('Yaoundé'),
        ('Malabo'),
        ('Libreville'),
        ('São Tomé'),
        ('Bangui'),
        ('Brazzaville'),
        ('Kinshasa'),
        ('Juba'),
        ('Addis Ababa'),
        ('Asmara'),
        ('Djibouti'),
        ('Mogadishu'),
        ('Hadibu'),
        ('Hargeisa'),
        ('Nairobi'),
        ('Kampala'),
        ('Kigali'),
        ('Gitega/Bujumbura'),
        ('Dodoma'),
        ('Maputo'),
        ('Lilongwe'),
        ('Lusaka'),
        ('Harare'),
        ('Luanda'),
        ('Jamestown'),
        ('Windhoek'),
        ('Gaborone'),
        ('Bloemfontein/Cape Town/Pretoria'),
        ('Maseru'),
        ('Lobamba/Mbabane'),
        ('Moroni'),
        ('Mamoudzou'),
        ('Antananarivo'),
        ('Saint-Denis'),
        ('Port Louis'),
        ('Victoria');
-- Oceania 1006
INSERT INTO capitals (capital)
VALUES  ('Flying Fish Cove'),
        ('West Island'),
        ('Canberra'),
        ('Wellington'),
        ('Port Moresby'),
        ('Buka'),
        ('Ngerulmud'),
        ('Hagåtña'),
        ('Saipan'),
        ('Palikir'),
        ('Majuro'),
        ('Yaren'),
        ('Honiara'),
        ('Port Vila'),
        ('Funafuti'),
        ('Nouméa'),
        ('Kingston'),
        ('Suva'),
        ('Nuku''alofa'),
        ('Mata Utu'),
        ('Fakaofo/Atafu/Nukunonu'),
        ('Apia'),
        ('Pago Pago'),
        ('Alofi'),
        ('Avarua'),
        ('Papeete'),
        ('South Tarawa'),
        ('Adamstown');
-- Antarctica 1007
INSERT INTO capitals (capital)
VALUES  ('(none)'),
        ('Saint Pierre (RE)'),
        ('King Edward Point'),
        ('(none)');

SELECT * FROM capitals;

SELECT * FROM regions;

-- preparing to join capitals temporary table with regions table
CREATE TABLE regions_new
SELECT regions.*, capitals.capital
FROM regions
INNER JOIN capitals
ON regions.region_id=capitals.region_id;

RENAME TABLE regions TO regions_old, regions_new TO regions;
ALTER TABLE regions MODIFY COLUMN capital varchar(255) after type;

SELECT * FROM regions;

-- table creation (temporary): subcontinents_per_region
CREATE TABLE subcontinents_per_region (
    region_id int AUTO_INCREMENT,
    subcontinent varchar(255),
    CONSTRAINT fk2_region_id FOREIGN KEY (region_id)
    REFERENCES capitals(region_id)
);

SELECT * FROM subcontinents_per_region;

-- data insertion (temporary): subcontinents_per_region
INSERT INTO subcontinents_per_region (subcontinent)
VALUES  ('Northern America'),
        ('Northern America'),
        ('Northern America'),
        ('Central America'),
        ('Central America'),
        ('Central America'),
        ('Central America'),
        ('Central America'),
        ('Central America'),
        ('Central America'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('Caribbean'),
        ('North Atlantic'),
        ('North Atlantic'),
        ('North Atlantic'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Western Europe'),
        ('Western Europe'),
        ('Western Europe'),
        ('Western Europe'),
        ('Western Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Western Europe'),
        ('Western Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Western Europe'),
        ('Western Europe'),
        ('Central Europe'),
        ('Central Europe'),
        ('Central Europe'),
        ('Central Europe'),
        ('Central Europe'),
        ('Balkans'),
        ('Balkans'),
        ('Balkans'),
        ('Balkans'),
        ('Balkans'),
        ('Balkans'),
        ('Balkans'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Southern Europe'),
        ('Balkans'),
        ('Eastern Europe'),
        ('Eastern Europe'),
        ('Eastern Europe'),
        ('Eastern Europe'),
        ('Eastern Europe'),
        ('Baltics'),
        ('Baltics'),
        ('Baltics'),
        ('Northern Europe'),
        ('Northern Europe'),
        ('Eastern Europe'),
        ('Anatolia'),
        ('Caucasus'),
        ('Caucasus'),
        ('Caucasus'),
        ('Caucasus'),
        ('Caucasus'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Middle East'),
        ('Central Asia'),
        ('Central Asia'),
        ('Central Asia'),
        ('Central Asia'),
        ('Central Asia'),
        ('Central Asia'),
        ('South Asia'),
        ('South Asia'),
        ('South Asia'),
        ('South Asia'),
        ('South Asia'),
        ('South Asia'),
        ('South Asia'),
        ('East Asia'),
        ('East Asia'),
        ('East Asia'),
        ('East Asia'),
        ('East Asia'),
        ('East Asia'),
        ('East Asia'),
        ('East Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southeast Asia'),
        ('Southern America'),
        ('Southern America'),
        ('Caribbean'),
        ('Southern America'),
        ('Southern America'),
        ('Southern America'),
        ('Southern America'),
        ('Southern America'),
        ('Eastern Pacific'),
        ('Southern America'),
        ('Southern America'),
        ('Southern America'),
        ('Southern America'),
        ('Eastern Pacific'),
        ('Southern America'),
        ('Southern Atlantic'),
        ('Southern America'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('North Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('West Africa'),
        ('Central Africa'),
        ('Central Africa'),
        ('Central Africa'),
        ('Central Africa'),
        ('Central Africa'),
        ('Central Africa'),
        ('Central Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('East Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Atlantic'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Southern Africa'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('Indian Ocean Islands'),
        ('South Pacific'),
        ('South Pacific'),
        ('South Pacific'),
        ('Melanesia'),
        ('Micronesia'),
        ('Micronesia'),
        ('Micronesia'),
        ('Micronesia'),
        ('Micronesia'),
        ('Micronesia'),
        ('Melanesia'),
        ('Melanesia'),
        ('Polynesia'),
        ('Melanesia'),
        ('South Pacific'),
        ('Melanesia'),
        ('Polynesia'),
        ('Polynesia'),
        ('South Pacific'),
        ('Polynesia'),
        ('Polynesia'),
        ('Polynesia'),
        ('Polynesia'),
        ('Polynesia'),
        ('Micronesia'),
        ('South Pacific'),
        ('Mainland'),
        ('Southern Ocean'),
        ('Southern Ocean'),
        ('Southern Ocean');

-- preparing to join capitals temporary table with regions table
CREATE TABLE subcontinents_per_region_new
SELECT regions.*, subcontinents_per_region.subcontinent
FROM regions
INNER JOIN subcontinents_per_region
ON regions.region_id=subcontinents_per_region.region_id;

RENAME TABLE subcontinents_per_region TO subcontinents_per_region_old, subcontinents_per_region_new TO subcontinents_per_region;
RENAME TABLE regions TO regions_old_2, subcontinents_per_region TO regions;
ALTER TABLE regions MODIFY COLUMN subcontinent varchar(255) after continent_name;

SELECT * FROM regions;
SELECT * FROM continents;

-- table creation: us [united states]
CREATE TABLE us (
    region_id int DEFAULT 2,
    us_id int AUTO_INCREMENT,
    us_abbr char(8) NOT NULL,
    us_name varchar(255) NOT NULL,
    type varchar(255) NOT NULL,
    capital varchar(255) NOT NULL,
    population_estimate int,
    have_visited bool NOT NULL,
    visit_order int NOT NULL,
    PRIMARY KEY (us_id),
    CONSTRAINT uc_us UNIQUE (us_abbr, us_name)
);

-- data insertion: us
INSERT INTO us (us_abbr, us_name, type, capital, population_estimate, have_visited, visit_order)
VALUES  ('AL', 'Alabama', 'State', 'Montgomery', 5108468, 1, 47),
        ('AK', 'Alaska', 'State', 'Juneau', 733406, 0, 0),
        ('AS', 'American Samoa', 'Territory', 'Pago Pago', 49710, 0, 0),
        ('AZ', 'Arizona', 'State', 'Phoenix', 7431344, 1, 22),
        ('AK', 'Arkansas', 'State', 'Little Rock', 3067732, 1, 18),
        ('CA', 'California', 'State', 'Sacramento', 38965193, 1, 33),
        ('CO', 'Colorado', 'State', 'Denver', 5877610, 1, 43),
        ('CT', 'Connecticut', 'State', 'Hartford', 3617176, 1, 31),
        ('DE', 'Delaware', 'State', 'Dover', 1031890, 1, 32),
        ('DC', 'District of Colombia', 'Federal district', 'Washington', 678972, 1, 12),
        ('FL', 'Florida', 'State', 'Tallahassee', 22610726, 1, 5),
        ('GA', 'Georgia', 'State', 'Atlanta', 11029227, 1, 23),
        ('GU', 'Guam', 'Territory', 'Hagåtña', 153836, 0, 0),
        ('HA', 'Hawaii', 'State', 'Honolulu', 1435138, 1, 9),
        ('ID', 'Idaho', 'State', 'Boise', 1964726, 1, 38),
        ('IL', 'Illinois', 'State', 'Springfield', 12549689, 1, 4),
        ('IN', 'Indiana', 'State', 'Indianapolis', 6862199, 1, 3),
        ('IA', 'Iowa', 'State', 'Des Moines', 3207004, 1, 46),
        ('KS', 'Kansas', 'State', 'Tokeka', 2940546, 1, 20),
        ('KY', 'Kentucky', 'State', 'Frankfort', 4526154, 1, 6),
        ('LA', 'Louisiana', 'State', 'Baton Rouge', 4573749, 1, 49),
        ('ME', 'Maine', 'State', 'Augusta', 1395722, 1, 28),
        ('MD', 'Maryland', 'State', 'Annapolis', 6180253, 1, 11),
        ('MA', 'Massachusetts', 'State', 'Boston', 7001399, 1, 29),
        ('MI', 'Michigan', 'State', 'Lansing', 10037261, 1, 1),
        ('MN', 'Minnesota', 'State', 'Saint Paul', 5737915, 1, 35),
        ('MS', 'Mississippi', 'State', 'Jackson', 2939690, 1, 48),
        ('MO', 'Missouri', 'State', 'Jefferson City', 6196156, 1, 21),
        ('MT', 'Montana', 'State', 'Helena', 1132812, 1, 37),
        ('NE', 'Nebraska', 'State', 'Lincoln', 1978379, 1, 44),
        ('NV', 'Nevada', 'State', 'Carson City', 3194176, 1, 34),
        ('NH', 'New Hampshire', 'State', 'Concord', 1402054, 1, 27),
        ('NJ', 'New Jersey', 'State', 'Trenton', 9290841, 1, 17),
        ('NM', 'New Mexico', 'State', 'Santa Fe', 2114371, 0, 0),
        ('NY', 'New York', 'State', 'Albany', 19571216, 1, 16),
        ('NC', 'North Carolina', 'State', 'Raleigh', 10835491, 1, 8),
        ('ND', 'North Dakata', 'State', 'Bismarck', 783926, 1, 36),
        ('MP', 'Northern Mariana Islands', 'Territory', 'Saipan', 47329, 0, 0),
        ('OH', 'Ohio', 'State', 'Columbus', 11785935, 1, 2),
        ('OK', 'Oklahoma', 'State', 'Oklahoma City', 4053824, 1, 19),
        ('OR', 'Oregon', 'State', 'Salem', 4233358, 1, 41),
        ('PA', 'Pennsylvania', 'State', 'Harrisburg', 12961683, 1, 10),
        ('PR', 'Puerto Rico', 'Territory', 'San Juan', 3205691, 1, 50),
        ('RI', 'Rhode Island', 'State', 'Providence', 1095962, 1, 30),
        ('SC', 'South Carolina', 'State', 'Columbia', 5373555, 1, 25),
        ('SD', 'South Dakota', 'State', 'Pierre', 919318, 1, 45),
        ('TN', 'Tennessee', 'State', 'Nashville', 7126489, 1, 7),
        ('TX', 'Texas', 'State', 'Austin', 30503301, 1, 14),
        ('VI', 'US Virgin Islands', 'Territory', 'Charlotte Amalie', 87146, 0, 0),
        ('UT', 'Utah', 'State', 'Salt Lake City', 3417734, 1, 42),
        ('VT', 'Vermont', 'State', 'Montpelier', 647464, 1, 26),
        ('VA', 'Virginia', 'State', 'Richmond', 8715698, 1, 13),
        ('WA', 'Washington', 'State', 'Olympia', 7812880, 1, 40),
        ('WV', 'West Virgina', 'State', 'Charleston', 1770071, 1, 15),
        ('WI', 'Wisconsin', 'State', 'Madison', 5910955, 1, 24),
        ('WY', 'Wyoming', 'State', 'Cheyenne', 584057, 1, 39);

        SELECT * FROM us;

-- some column modifications: us
ALTER TABLE us MODIFY COLUMN us_name varchar(255) after us_id;
ALTER TABLE us MODIFY COLUMN region_id varchar(255) after capital;

-- table creation: ca [canada]
CREATE TABLE ca (
    region_id int DEFAULT 1,
    ca_id int AUTO_INCREMENT,
    ca_abbr char(8) NOT NULL,
    ca_name varchar(255) NOT NULL,
    type varchar(255) NOT NULL,
    capital varchar(255) NOT NULL,
    population_estimate int,
    have_visited bool NOT NULL,
    visit_order int NOT NULL,
    PRIMARY KEY (ca_id),
    CONSTRAINT uc_ca UNIQUE (ca_abbr, ca_name)
);

-- data insertion: ca
INSERT INTO ca (ca_abbr, ca_name, type, capital, population_estimate, have_visited, visit_order)
VALUES  ('AB', 'Alberta', 'Province', 'Edmonton', 4262635, 0, 0),
        ('BC', 'British Columbia', 'Province', 'Victoria', 5000879, 0, 0),
        ('MB', 'Manitoba', 'Province', 'Winnipeg', 1342153, 0, 0),
        ('NB', 'New Brunswick', 'Province', 'Fredericton', 775610, 0, 0),
        ('NL', 'Newfoundland and Labrador', 'Province', 'St. John''s', 510550, 0, 0),
        ('NT', 'Northwest Territories', 'Territory', 'Yellowknife', 41070, 0, 0),
        ('NS', 'Nova Scotia', 'Province', 'Halifax', 969383, 0, 0),
        ('NU', 'Nunavut', 'Territory', 'Iqaluit', 36858, 0, 0),
        ('ON', 'Ontario', 'Province', 'Toronto', 14223942, 1, 1),
        ('PE', 'Prince Edward Island', 'Province', 'Charlottetown', 154331, 0, 0),
        ('QC', 'Quebec', 'Province', 'Quebec City', 8501833, 1, 2),
        ('SK', 'Saskatchewan', 'Province', 'Regina', 1132505, 0, 0),
        ('YT', 'Yukon', 'Territory', 'Whitehorse', 40232, 0, 0);

-- some column modifications: ca
ALTER TABLE ca MODIFY COLUMN ca_name varchar(255) after ca_id;
ALTER TABLE ca MODIFY COLUMN region_id varchar(255) after capital;
        SELECT * FROM ca;

-- view 1: every_population_ranked
CREATE VIEW every_population_ranked AS
    SELECT * FROM (
    SELECT
        c.continent_name AS name,
        c.population_estimate AS population_estimate
        FROM continents c
        UNION
        SELECT r.region_name AS name,
        r.population_estimate AS population_estimate
        FROM regions r
        UNION
        SELECT us.us_name AS name,
        us.population_estimate AS population_estimate
        FROM us
        UNION
        SELECT ca.ca_name AS name,
        ca.population_estimate AS population_estimate
        FROM ca
    ) epr ORDER BY population_estimate DESC;

-- editing view 1
CREATE OR REPLACE VIEW every_population_ranked AS
    SELECT * FROM (
    SELECT
        c.continent_name AS name,
        c.type AS type,
        c.population_estimate AS population_estimate
        FROM continents c
        UNION
        SELECT r.region_name AS name,
        r.type AS type,
        r.population_estimate AS population_estimate
        FROM regions r
        UNION
        SELECT us.us_name AS name,
        us.type AS type,
        us.population_estimate AS population_estimate
        FROM us
        WHERE type <> 'Territory'
        UNION
        SELECT ca.ca_name AS name,
        ca.type AS type,
        ca.population_estimate AS population_estimate
        FROM ca
    ) epr ORDER BY population_estimate DESC;

SELECT * FROM every_population_ranked;

-- to allow for grouping of values within columns
SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- view 2: population_by_subcontinent
CREATE OR REPLACE VIEW population_by_subcontinent AS
    SELECT subcontinent, SUM(population_estimate) AS population_estimate
    FROM regions
    GROUP BY subcontinent
    ORDER BY population_estimate DESC;

SELECT * FROM population_by_subcontinent;

-- view 3: anywhere_ive_been
CREATE OR REPLACE VIEW anywhere_ive_been AS
    SELECT * FROM (
    SELECT c.continent_name AS name, c.type AS type FROM continents c
    WHERE have_visited = 1
    UNION
    SELECT r.region_name AS name, r.type AS type FROM regions r
    WHERE have_visited = 1
    UNION
    SELECT us.us_name AS name, us.type AS type FROM us
    WHERE have_visited = 1 AND type <> 'Territory'
    UNION
    SELECT ca.ca_name AS name, ca.type AS type FROM ca
    WHERE have_visited = 1
    ) aib
    ORDER BY name ASC;

SELECT * FROM anywhere_ive_been;

-- view 4: anywhere_ive_not_been
CREATE OR REPLACE VIEW anywhere_ive_not_been AS
    SELECT * FROM (
    SELECT c.continent_name AS name, c.type AS type FROM continents c
    WHERE have_visited = 0
    UNION
    SELECT r.region_name AS name, r.type AS type FROM regions r
    WHERE have_visited = 0
    UNION
    SELECT us.us_name AS name, us.type AS type FROM us
    WHERE have_visited = 0 AND type <> 'Territory'
    UNION
    SELECT ca.ca_name AS name, ca.type AS type FROM ca
    WHERE have_visited = 0
    ) aib
    ORDER BY name ASC;

SELECT * FROM anywhere_ive_not_been;