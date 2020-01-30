#' Retrieve metadata for players based on names or ids
#'
#' Retrieves information on players from the NHL API based on
#'   `playerNames` or `playerIds`. If `playerNames` are provided,
#'   they take precedence over `playerIds`.
#'
#' @inheritParams nhl_url_players
#' @inheritParams util_map_player_ids
#'
#' @return data.frame
#' @export
#'
#' @examples \dontrun{
#'  # With player names
#'  nhl_retrieve_players(c("joe SAKIC", "patrick roy"))
#'  # With playerIds
#'  nhl_retrieve_players(playerIds = c(8451101, 8458554))
#' }
nhl_retrieve_players <- function(playerNames, playerIds = NULL) {
  if (missing(playerNames) && is.null(playerIds)) {
    stop("Please provide either playerNames or playerIds.")
  }
  if (!missing(playerNames)) {
    playerIds <- util_prepare_player_ids(playerNames)
  }
  x <- nhl_url_players(playerIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players(x)
  x
}
