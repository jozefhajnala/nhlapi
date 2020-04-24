#' Create an NHL API URL for teams
#'
#' @param teamIds `integer()`, ids of the teams or `NULL` (default)
#'   for all teams. As of end of 2019, the valid team ids seem to be
#'   in the `1:54` range.
#' @inheritParams nhl_url
#'
#' @examples \dontrun{
#'   nhl_url_teams()
#'   nhl_url_teams(1:3)
#' }
#'
#' @return `character()`, API URLs, same length as `teamIds` or
#'   length `1` if `teamIds` is `NULL`.
nhl_url_teams <- function(teamIds = NULL, params = NULL) {
  suffixes <- list(teamIds)
  nhl_url(endPoint = "teams", suffixes = suffixes, params = params)
}

#' Retrieve metadata on NHL teams from the API
#'
#' @description Retrieves team metadata such as the teams names,
#'   abbreviations, locations, conferences, venues, etc.
#'
#' @details The API allows to retrieve data on all teams at once,
#'   which is achieved by the default `NULL` value for the team id.
#'
#' @inheritParams nhl_url_teams
#' @param params `named list()`, further parameters passed to
#'   `nhl_url_teams`.
#'
#' @examples \dontrun{
#'   nhl_teams()
#'   nhl_teams(1:3)
#' }
#'
#' @export
#' @return `data.frame`, with data on teams, one row per team.
nhl_teams <- function(teamIds = NULL, params = NULL) {
  x <- nhl_url_teams(teamIds = teamIds, params = params)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "teams")
  x
}

#' Get rosters for teams
#'
#' @inheritParams nhl_url_teams
#' @inheritParams nhl_url_players_seasons
#'
#' @return `data.frame`, with an element called `roster.roster`
#'   that in itself is a `data.frame` with the roster data.
#'
#' @export
#'
#' @examples  \dontrun{
#'   # Current rosters for all teams
#'   nhl_teams_rosters()
#'
#'   # Rosters for all teams for past seasons
#'   nhl_teams_rosters(seasons = c("19931994", "19931994"))
#'
#'   # Roster for Devils and Islanders
#'   nhl_teams_rosters(
#'     teamIds = 1:2,
#'     seasons = c("19931994", "19931994")
#'   )
#' }
nhl_teams_rosters <- function(teamIds = NULL, seasons = NULL) {
  params <- list(expand = "team.roster", season = seasons)
  nhl_teams(teamIds = teamIds, params = params)
}

#' Get details for the teams' upcoming game
#'
#' @inheritParams nhl_url_teams
#'
#' @return `data.frame`, with elements with names starting with
#'   `nextGameSchedule` that contain data on the teams' upcoming
#'    game. One row per team.
#'
#' @export
#'
#' @examples  \dontrun{
#'   # Next game for all teams
#'   nhl_teams_shedule_next()
#'
#'   # Next game for selected teams
#'   nhl_teams_shedule_next(c(1,3,5))
#' }
nhl_teams_shedule_next <- function(teamIds = NULL) {
  nhl_teams(teamIds = teamIds, params = c(expand = "team.schedule.next"))
}

#' Get details for the teams' previous game
#'
#' @inheritParams nhl_url_teams
#'
#' @return `data.frame`, with elements with names starting with
#'   `previousGameSchedule` that contain data on the teams'
#'   previous game. One row per team.
#'
#' @export
#'
#' @examples  \dontrun{
#'   # Next game for all teams
#'   nhl_teams_shedule_previous()
#'
#'   # Next game for selected teams
#'   nhl_teams_shedule_previous(c(1,3,5))
#' }
nhl_teams_shedule_previous <- function(teamIds = NULL) {
  nhl_teams(teamIds = teamIds, params = c(expand = "team.schedule.previous"))
}

#' Get team statistics per seasons
#'
#' @inheritParams nhl_url_teams
#' @inheritParams nhl_url_players_seasons
#'
#' @return `data.frame`, with seasons statistics for the selected
#'   team(s), one row per each team and season combination.
#' @export
#'
#' @examples \dontrun{
#'   # All teams, current seasons
#'   nhl_teams_stats()
#'
#'   # 2 teams, 3 seasons
#'   nhl_teams_stats(1:2, c("20052006", "20062007", "20072008"))
#' }
nhl_teams_stats <- function(teamIds = NULL, seasons = NULL) {
  params <- list(expand = "team.stats", season = seasons)
  nhl_teams(teamIds = teamIds, params = params)
}
