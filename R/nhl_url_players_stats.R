#' Create an NHL API stats URL for players
#'
#' @param playerIds `integer()`, ids of the players.
#'
#' @examples \dontrun{nhl_url_players_stats(8477474)}
#'
#' @return `character()` of same length as `playerIds`
nhl_url_players_stats <- function(playerIds) {
  nhl_url(endPoint = "people", suffixes = list(playerIds, "stats"))
}
