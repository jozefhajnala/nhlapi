# nhlapi

R interface to the NHL API

![MSWin](https://github.com/jozefhajnala/nhlapi/workflows/check_win/badge.svg)
![MacOS](https://github.com/jozefhajnala/nhlapi/workflows/check_macos/badge.svg)

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
