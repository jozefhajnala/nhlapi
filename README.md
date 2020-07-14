# nhlapi <img src="https://user-images.githubusercontent.com/23148397/82825728-05f92900-9eac-11ea-88bc-4de15b14c7c4.png" align="right" width="200" />

A minimum-dependency R interface to the NHL API.

[![CRAN Version](https://www.r-pkg.org/badges/version/nhlapi?color=green)](https://cran.r-project.org/package=nhlapi)
![CRAN Checks](https://github.com/jozefhajnala/nhlapi/workflows/check_cran/badge.svg)
[![Dependencies](https://tinyverse.netlify.com/badge/nhlapi)](https://cran.r-project.org/package=nhlapi)
![Remote API Tests](https://github.com/jozefhajnala/nhlapi/workflows/test_remote_api/badge.svg)
[![Coverage](https://img.shields.io/codecov/c/github/jozefhajnala/nhlapi/master.svg)](https://codecov.io/github/jozefhajnala/nhlapi?branch=master)

## Installation

`{nhlapi}` is an R package that provides functionality to retrieve and process the data exposed by the open 'NHL' API. This includes information on players, teams, games, tournaments, drafts, standings, schedules and other endpoints. A lower-level interface to access the data via URLs directly is also provided. See [below for a full list of endpoints](#implemented-api-endpoints)

You can install `{nhlapi}` from CRAN.

```r
install.packages("nhlapi")
```

You can also install the latest development version from the master branch on GitHub using the `{remotes}` package.

```r
remotes::install_github("jozefhajnala/nhlapi")
```

## Use and develop with Docker

The Docker image [jozefhajnala/nhlapi](https://hub.docker.com/repository/docker/jozefhajnala/nhlapi) has RStudio and a set of useful packages for both interactive use of the `{nhlapi}` package and its development. 

Running the following command and opening `localhost:8787` in a web browser should open RStudio with a setup ready for analysis and development. Login user is `rstudio` and passowrd is `pass` (can be changed by changing the PASSWORD option below):

```bash
docker run --rm -p 8787:8787 -e PASSWORD=pass jozefhajnala/nhlapi
```

## Usage

You retrieve the data from the NHL API by calling the functions exported by the nhlapi package. They start with `nhl_` so you can easily find them with autocomplete in your favorite editor:

![nhlapi Preview](https://user-images.githubusercontent.com/23148397/80225712-b5dc3c00-864b-11ea-9613-a5c08749933f.gif)

## Implemented API endpoints

### Major endpoints

- [x] Teams
    - [x] Team Metadata `nhl_teams()`
    - [x] Team Rosters `nhl_teams_rosters()`
    - [x] Team Schedules `nhl_teams_shedule_next()`, `nhl_teams_shedule_previous()`
    - [x] Team Stats `nhl_teams_stats()`
    
- [x] People (Players)
    - [x] Players metadata `nhl_players`
    - [x] Players season/playoff stats `nhl_players_seasons()`
    - [x] Players all season stats `nhl_players_allseasons()`

- [x] Games
    - [x] Games content `nhl_games_content()`
    - [x] Games full live feed `nhl_games_feed()`
    - [x] Games box score info `nhl_games_boxscore()`
    - [x] Games line score info`nhl_games_linescore()`

- [x] Tournaments
    - [x] Playoffs `nhl_tournaments_playoffs()`
    - [x] Olympics `nhl_tournaments_olympics()`
    - [x] World Cups `nhl_tournaments_worldcups()`
    
- [x] Schedule
    - [x] Generic API with all parameters `nhl_schedule()`
    - [x] Today `nhl_schedule_today()`
    - [x] Custom seasons `nhl_schedule_seasons()`
    - [x] Custom date ranges `nhl_schedule_date_range()`

- [x] Standings `nhl_standings()`

### Minor endpoints

- [x] Divisions `nhl_divisions()`
- [x] Conferences `nhl_conferences()`
- [x] Drafts `nhl_drafts()`
- [x] Seasons `nhl_seasons()`
- [x] Awards `nhl_awards()`
- [x] Venues `nhl_venues()`
- [x] Draft prospects `nhl_draft_prospects()`

### Metadata endpoints

- [x] Game Types `nhl_md_game_types()`
- [x] Game Statuses `nhl_md_game_statuses()`
- [x] Play Types `nhl_md_play_types()`
- [x] Tournament Types `nhl_md_tournament_types()`
- [x] Standings Types `nhl_md_standings_types()`
- [x] Stats Types `nhl_md_stat_types()`
- [x] Event Types `nhl_md_event_types()`


## Acknowledgments

Thanks go to Drew Hynes for documenting this so well in [https://gitlab.com/dword4/nhlapi/blob/master/stats-api.md](https://gitlab.com/dword4/nhlapi/blob/master/stats-api.md)


## Copyright message

> NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams. © NHL 2020. All Rights Reserved.
