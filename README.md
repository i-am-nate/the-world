# the-world

## Constructing a database of the entire world using only MySQL within PopSQL

### About
A database of every global region and various subregions created entirely in MySQL within PopSQL (1204 lines).

### Overview
I love geography and travelling. A while ago, I started keeping track in my Notes app on my iPhone every region on earth, some info about it, and if I'd visited it or not (and if so, when). I also want to collect a turtle from specifically every country, so if I've collected that or was recorded too.

I felt this would be a good challenge to create a database of tables called 'the_world' using MySQL. I first created a continents table and imported the data. I then created a regions table (instead of 7 individual continent tables) and two more tables to represent subregions within a given region (I chose the US and Canada).

I've included a data dictionary in this repository to explain what each variable observes. I certainly could have added infitite more features (such as land area, average age, average number of sunny days per year, year establisted, etc.), and maybe I'll continue adding to this until it's a greater and greater one-stop-shop resource for any given geographical region on earth.
