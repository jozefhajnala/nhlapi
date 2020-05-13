#' Create an NHL API URL for seasons
#'
#' @inheritParams nhl_make_seasons
#'
#' @examples
#'   nhlapi:::nhl_url_seasons()
#'   nhlapi:::nhl_url_seasons(2015:2017)
#'   nhlapi:::nhl_url_seasons("20152016")
#'
#' @return `character()`, of API URLs, same length as `seasons`
#'   or length `1` if `seasons` is `NULL`.
nhl_url_seasons <- function(seasons = NULL) {
  nhl_url(endPoint = "seasons", suffixes = list(nhl_make_seasons(seasons)))
}


#' Retrieve metadata on NHL seasons from the API
#'
#' @inheritParams nhl_url_seasons
#'
#' @return `data.frame`, with information on seasons, one row
#'   per year.
#' @export
#'
#' @examples \dontrun{
#'   # Get information on current draft
#'   nhl_seasons()
#'
#'   # Get information on 3 historical seasons
#'   nhl_seasons(2015:2017)
#' }
nhl_seasons <- function(seasons = NULL) {
  x <- nhl_url_seasons(seasons = seasons)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "seasons")
  x
}
