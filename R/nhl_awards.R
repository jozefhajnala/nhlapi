#' Create an NHL API URL for awards
#'
#' @param awardIds `integer()`, vector of one or more award ids
#'   or `NULL` (default) for all awards. The current set of valid
#'   ids seems to be `1:24`.
#'
#' @examples
#'   nhlapi:::nhl_url_awards()
#'   nhlapi:::nhl_url_awards(1:3)
#'
#' @return `character()`, API URLs, same length as `awardIds` or
#'   length `1` if `awardIds` is `NULL`.
nhl_url_awards <- function(awardIds = NULL) {
  nhl_url(endPoint = "awards", suffixes = list(awardIds))
}


#' Retrieve metadata on NHL awards from the API
#'
#' @inheritParams nhl_url_awards
#'
#' @return `data.frame`, with information on awards, one row per award.
#' @export
#'
#' @examples \dontrun{
#'   # Get information on current draft
#'   nhl_awards()
#'
#'   # Get information on 3 historical awards
#'   nhl_awards(1:3)
#' }
nhl_awards <- function(awardIds = NULL) {
  x <- nhl_url_awards(awardIds = awardIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "awards")
  x
}
