#' Create an NHL API URL for venues
#'
#' @param venueIds `integer()`, vector of one or more venue ids
#'   or `NULL` (default) for all currently exposed venues. The
#'   exported values seem incomplete, so it may be worth it to
#'   investigate other ids.
#'
#' @examples \dontrun{
#'   nhl_url_venues()
#'   nhl_url_venues(5000:5006)
#' }
#'
#' @return `character()` of same length as `venueIds` or length `1`
#'   if `venueIds` is `NULL`.
nhl_url_venues <- function(venueIds = NULL) {
  suffixes <- if (!is.null(venueIds)) list(venueIds)
  nhl_url(endPoint = "venues", suffixes = suffixes)
}


#' Retrieve metadata on NHL venues from the API
#'
#' @inheritParams nhl_url_venues
#'
#' @return `data.frame`, with information on venues, one row per venue.
#' @export
#'
#' @examples \dontrun{
#'   # Get information on currently exposed venues
#'   nhl_venues()
#'
#'   # Get information on 3 historical venues
#'   nhl_venues(5000:5006)
#' }
nhl_venues <- function(venueIds = NULL) {
  x <- nhl_url_venues(venueIds = venueIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "venues")
  x
}
