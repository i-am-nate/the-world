# the-world

## Constructing a database of the entire world using MySQL in PopSQL and an interactive storyboard of dashboards in Tableau

### About
A database of every global region and various subregions created entirely in MySQL within PopSQL (1204 lines) and a visualized within Tableau. See the fully interactive storyboard of dashboard maps [hosted on Tableau Public](https://public.tableau.com/shared/BZWFTSTDP?:display_count=n&:origin=viz_share_link).

### Overview
I love geography and travelling. A while ago, I started keeping track in my Notes app on my iPhone every region on earth, some info about it, and if I'd visited it or not (and if so, when). I also want to collect a turtle from specifically every country, so if I've collected that or was recorded too.

I felt this would be a good challenge to create a database of tables called 'the_world' using MySQL. I first created a continents table and imported the data. I then created a regions table (instead of 7 individual continent tables) and two more tables to represent subregions within a given region (I chose the US and Canada to start).

I also made 4 views (functionally they're tables but comprised of variables from the 4 tables). These explore any region I've personally visited, any region I've not visited, ranking every population of every type of region, and grouping every subregion by subcontinent and ranking the population of each subregion.

The 4 tables and the 4 views are available as csvs within the csvs folder in this repository.

I've included a data dictionary in this repository to explain what each variable observes. I certainly could have added infitite more features (such as land area, average age, average number of sunny days per year, year establisted, etc.), and maybe I'll continue adding to this until it's a greater and greater one-stop-shop resource for any given geographical region on earth.

You'll find the exported PopSQL 'the_world.sql' file as well as its equivelent RTF counterpart 'popsql_query.rtf' in the root of this repository.

I wanted to visualize these regions, as well as add some additional layers of information suitable for visualization and have greater levels of region granularity. I first compliled population and area data and input these values into Google Sheets to export csvs. I landed on 4 dashboards which can be interacted with each in their own right on the Tableau storyboard. However, you can see static examples below of each of the four maps: the world, the US, Canada, and Michigan (my home state). Each of these maps allow user control over filtering to discover all sorts of insights.
