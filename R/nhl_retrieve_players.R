#' Retrieve metadata for players
#'
#' @inheritParams nhl_url_players
#'
#' @return data.frame
#' @export
#'
#' @examples \dontrun{
#'  nhl_retrieve_players(c(8451101, 8458554))
#' }
nhl_retrieve_players <- function(playerIds) {
  x <- nhl_url_players(playerIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players(x)
  x
}
