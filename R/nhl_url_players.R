#' Create an NHL API URL for players
#'
#' @param playerIds `integer()`, ids of the players.
#'
#' @examples \dontrun{nhl_url_player(8477474)}
#'
#' @return `character()` of same length as `playerIds`
nhl_url_players <- function(playerIds) {
  vapply(
    X = playerIds,
    FUN = function(x) nhl_url(endPoint = "people", suffixes = x),
    FUN.VALUE = character(1)
  )
}
