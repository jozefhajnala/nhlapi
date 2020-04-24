#' Create an NHL API stats URL for players
#'
#' @inheritParams nhl_url_players
#' @inheritParams nhl_url
#'
#' @examples \dontrun{nhl_url_players_stats(8477474)}
#'
#' @return `character()`, of API URLs, same length as `playerIds`.
nhl_url_players_stats <- function(playerIds, params = NULL) {
  nhl_url(
    endPoint = "people",
    suffixes = list(playerIds, "stats"),
    params = params
  )
}

#' Create an NHL API URL for  players' seasons statistics
#'
#' @details If multiple players and seasons are provided, URLs will
#'   be created for all combinations of players and seasons.
#'
#' @inheritParams nhl_url_players
#' @inheritParams nhl_make_seasons

#' @param playoffs `logical(1)`, if `FALSE` (default) get the regular
#'   seasons data, if `TRUE`, get the data for the playoffs.
#' @examples \dontrun{
#'   # Joe Sakic, regular season 1995/1996
#'   nhl_url_players_seasons(8451101L, 1995)
#'   # Joe Sakic, playoffs 1995/1996, 1996/1997 and 1997/1998
#'   nhl_url_players_seasons(
#'     8451101L,
#'     1995:1997,
#'     playoffs = TRUE
#'    )
#' }
nhl_url_players_seasons <- function(playerIds, seasons, playoffs = FALSE) {
  statsString <- if (isTRUE(playoffs))
    "statsSingleSeasonPlayoffs"
  else
    "statsSingleSeason"
  nhl_url_players_stats(
    playerIds,
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
  nhl_url_players_stats(
    playerIds = playerIds,
    params = c(stats = "yearByYear")
  )
}

nhl_process_player_seasons <- function(x, playerId) {
  playerId <- as.integer(playerId)
  res <- util_process_copyright(x)
  resDf <- res[["stats"]][["splits"]][[1L]]
  if (!is.data.frame(resDf) && length(resDf) == 0L) {
    resDf <- data.frame()
  }
  resDf <- util_attributes_to_cols(res, resDf)
  resDf[["playerId"]] <- rep(playerId, nrow(resDf))
  resDf[["seasonStart"]] <- as.integer(substr(resDf[["season"]], 1L, 4L))
  resDf <- util_process_minsonice(resDf)
  resDf
}

nhl_process_players_allseasons <- function(x, playerIds) {
  util_rbindlist(Map(nhl_process_player_seasons, x, playerIds))
}

nhl_process_players_seasons <- function(x, playerIds) {
  util_rbindlist(Map(nhl_process_player_seasons, x, playerIds))
}

#' Retrieve all seasons statistics for players
#'
#' @inheritParams nhl_url_players_allseasons
#' @inheritParams util_map_player_ids
#'
#' @return `data.frame`, with all season statistics for
#'   selected players.
#' @export
#'
#' @examples \dontrun{
#'  # With player names
#'  nhl_players_allseasons(c("joe sakic", "Peter Forsberg"))
#'
#'  # With player ids
#'  nhl_players_allseasons(c(8451101, 8458554))
#' }
nhl_players_allseasons <- function(
  playerNames,
  playerIds = NULL
) {
  if (missing(playerNames) && is.null(playerIds)) {
    stop("Please provide either playerNames or playerIds.")
  }
  if (!missing(playerNames)) {
    playerIds <- util_prepare_player_ids(playerNames)
  }
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
#' @return `data.frame`, with selected season statistics
#'   for selected players.

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
  if (missing(playerNames) && is.null(playerIds)) {
    stop("Please provide either playerNames or playerIds.")
  }
  if (!missing(playerNames)) {
    playerIds <- util_prepare_player_ids(playerNames)
  }
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
