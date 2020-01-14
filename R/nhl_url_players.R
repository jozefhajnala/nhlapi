#' Create an NHL API URL for players
#'
#' @param playerIds `integer()`, ids of the players.
#'
#' @examples \dontrun{
#'   nhl_url_players(c(8477474, 8477475))
#' }
#'
#' @return `character()` of same length as `playerIds`
nhl_url_players <- function(playerIds) {
  nhl_url(endPoint = "people", suffixes = list(playerIds))
}
