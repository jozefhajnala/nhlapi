#' Create an NHL API URL for  players' seasons statistics
#'
#' @details If multiple players and seasons are provided, urls will
#'   be created for all combinations of players and seasons.
#'
#' @param playerIds `integer()`, ids of the players.
#' @param seasons `character()`, seasons in the format `"YYYYZZZZ"`,
#' where ZZZZ = YYYY + 1, e.g. `"19951996"`.
#' @param playoffs `logical(1)` if `FALSE` (default) get the regular
#' seasons data, if `TRUE`, get the data for the playoffs.
#' @examples \dontrun{
#'   # Joe Sakic, regular season 1995/1996
#'   nhl_url_player_season(8451101L, "19951996")
#'   # Joe Sakic, playoffs 1995/1996 and 1996/1997
#'   nhl_url_player_season(8451101L, c("19951996", "19961997"), playoffs = TRUE)
#' }
nhl_url_player_season <- function(playerIds, seasons, playoffs = FALSE) {
  statsString <- if (isTRUE(playoffs))
    "statsSingleSeasonPlayoffs"
  else
    "statsSingleSeason"
  args <- expand.grid(
    playerIds = playerIds,
    seasons = seasons,
    stringsAsFactors = FALSE
  )
  apply(args, 1, function(x) nhl_url(
    endPoint = "people",
    suffixes = c(x[1L], "stats"),
    params = list(stats = statsString, season = x[2L])
  ))
}
