#' Retrieve all seasons statistics for players
#'
#' @inheritParams nhl_url_players_allseasons
#'
#' @return data.frame
#' @export
#'
#' @examples \dontrun{
#'  nhl_retrieve_players_allseasons(c(8451101, 8458554))
#' }
nhl_retrieve_players_allseasons <- function(playerIds) {
  x <- nhl_url_players_allseasons(playerIds)
  x <- nhl_get_data(x)
  playerIds <- playerIds[!util_locate_get_data_errors(x)]
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players_allseasons(x, playerIds = playerIds)
  x
}

#' Retrieve selected seasons statistics for players
#'
#' @inheritParams nhl_url_players_seasons
#'
#' @return data.frame
#' @export
#'
#' @examples \dontrun{
#'  nhl_retrieve_players_seasons(c(8451101, 8458554), "19951996", TRUE)
#' }
nhl_retrieve_players_seasons <- function(playerIds, seasons, playoffs = FALSE) {
  x <- nhl_url_players_seasons(playerIds, seasons, playoffs = playoffs)
  x <- nhl_get_data(x)
  playerIds <- rep(playerIds, times = length(seasons))
  playerIds <- playerIds[!util_locate_get_data_errors(x)]
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players_seasons(x, playerIds = playerIds)
  x
}
