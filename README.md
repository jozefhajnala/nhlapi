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

- [ ] Game-IDs
- [ ] Tournaments
- [ ] Schedule
- [ ] Standings

### Minor endpoints

- [x] Divisions `nhl_divisions()`
- [x] Conferences `nhl_conferences()`
- [x] Drafts `nhl_drafts()`
- [x] Seasons `nhl_seasons()`
- [ ] Awards
- [ ] Venues
- [ ] Draft prospects

### Metadata endpoints

- [x] Game Types `nhl_md_game_types()`
- [x] Game Statuses `nhl_md_game_statuses()`
- [x] Play Types `nhl_md_play_types()`
- [x] Tournament Types `nhl_md_tournament_types()`
- [x] Standings Types `nhl_md_standings_types()`
- [x] Stats Types `nhl_md_stat_types()`
- [x] Event Types `nhl_md_event_types()`
