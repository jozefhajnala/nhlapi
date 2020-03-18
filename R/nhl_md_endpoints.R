#' Get game type metadata
#'
#' @return `list`, with metadata on game types.
#' @export
nhl_md_game_types <- function() {
  nhl_get_data(nhl_url(endPoint = "gameTypes"))
}


#' Get game status metadata
#'
#' @return `list`, with metadata on game statuses.
#' @export
nhl_md_game_statuses <- function() {
  nhl_get_data(nhl_url(endPoint = "gameStatus"))
}


#' Get play types metadata
#'
#' @return `list`, with metadata on play types.
#' @export
nhl_md_play_types <- function() {
  nhl_get_data(nhl_url(endPoint = "playTypes"))
}


#' Get tournament types metadata
#'
#' @return `list`, with metadata on tournament types.
#' @export
nhl_md_tournament_types <- function() {
  nhl_get_data(nhl_url(endPoint = "tournamentTypes"))
}


#' Get standings types metadata
#'
#' @return `list`, with metadata on standings types.
#' @export
nhl_md_standings_types <- function() {
  nhl_get_data(nhl_url(endPoint = "standingsTypes"))
}


#' Get stat types metadata
#'
#' @return `list`, with metadata on stat types.
#' @export
nhl_md_stat_types <- function() {
  nhl_get_data(nhl_url(endPoint = "statTypes"))
}


#' Get event types metadata
#'
#' @return `list`, with metadata on event types.
#' @export
nhl_md_event_types <- function() {
  nhl_get_data(nhl_url(endPoint = "eventTypes"))
}
