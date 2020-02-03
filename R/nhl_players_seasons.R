#' Retrieve all seasons statistics for players
#'
#' @inheritParams nhl_url_players_allseasons
#' @inheritParams util_map_player_ids
#'
#' @return data.frame
#' @export
#'
#' @examples \dontrun{
#'  nhl_players_allseasons(c(8451101, 8458554))
#' }
nhl_players_allseasons <- function(
  playerNames,
  playerIds = NULL
) {
  x <- nhl_url_players_allseasons(playerIds = playerIds)
  x <- nhl_get_data(x)
  playerIds <- playerIds[!util_locate_get_data_errors(x)]
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players_allseasons(x, playerIds = playerIds)
  x
}

#' Retrieve selected seasons statistics for players
#'
#' @inheritParams nhl_url_players_seasons
#' @inheritParams util_map_player_ids
#'
#' @return data.frame
#' @export
#'
#' @examples \dontrun{
#'  nhl_players_seasons(
#'    playerIds = c(8451101, 8458554),
#'    seasons = "19951996",
#'    playoffs = TRUE
#'  )
#' }
nhl_players_seasons <- function(
  playerNames,
  seasons,
  playerIds = NULL,
  playoffs = FALSE
) {
  x <- nhl_url_players_seasons(
    playerIds = playerIds,
    seasons = seasons,
    playoffs = playoffs
  )
  x <- nhl_get_data(x)
  playerIds <- rep(playerIds, times = length(seasons))
  playerIds <- playerIds[!util_locate_get_data_errors(x)]
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players_seasons(x, playerIds = playerIds)
  x
}

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
#'   nhl_url_players_seasons(8451101L, "19951996")
#'   # Joe Sakic, playoffs 1995/1996 and 1996/1997
#'   nhl_url_players_seasons(
#'     8451101L,
#'     c("19951996", "19961997"),
#'     playoffs = TRUE
#'    )
#' }
nhl_url_players_seasons <- function(playerIds, seasons, playoffs = FALSE) {
  statsString <- if (isTRUE(playoffs))
    "statsSingleSeasonPlayoffs"
  else
    "statsSingleSeason"
  nhl_url_add_params(
    nhl_url_players_stats(playerIds),
    params = list(stats = statsString, season = seasons)
  )
}

#' Create an NHL API URL for all players' seasons statistics
#'
#' @inheritParams nhl_url_players_seasons
#' @examples \dontrun{
#'   # Joe Sakic, all seasons
#'   nhl_url_players_allseasons(8451101L)
#' }
nhl_url_players_allseasons <- function(playerIds) {
  nhl_url_add_params(
    nhl_url_players_stats(playerIds = playerIds),
    params = c(stats = "yearByYear")
  )
}

#' Create an NHL API stats URL for players
#'
#' @inheritParams nhl_url_players
#'
#' @examples \dontrun{nhl_url_players_stats(8477474)}
#'
#' @return `character()` of same length as `playerIds`
nhl_url_players_stats <- function(playerIds) {
  nhl_url(endPoint = "people", suffixes = list(playerIds, "stats"))
}


nhl_process_player_seasons <- function(x, playerId) {
  playerId <- as.integer(playerId)
  res <- util_process_copyright(x)
  res_df <- res[["stats"]][["splits"]][[1L]]
  if (!is.data.frame(res_df) && length(res_df) == 0L) {
    res_df <- data.frame()
  }
  res_df <- util_attributes_to_cols(res, res_df)
  res_df[["playerId"]] <- rep(playerId, nrow(res_df))
  res_df[["seasonStart"]] <- as.integer(substr(res_df[["season"]], 1L, 4L))
  res_df <- util_process_minsonice(res_df)
  res_df
}

nhl_process_players_allseasons <- function(x, playerIds) {
  util_rbindlist(Map(nhl_process_player_seasons, x, playerIds))
}

nhl_process_players_seasons <- function(x, playerIds) {
  util_rbindlist(Map(nhl_process_player_seasons, x, playerIds))
}
