#' Create an NHL API URL for conferences
#'
#' @param conferenceIds `integer()`, ids of the conferences or `NULL` (default)
#'   for all conferences As of end of 2019, the valid conference ids seem to be
#'   in the `1:7` range.
#'
#' @examples \dontrun{
#'   nhl_url_conferences()
#'   nhl_url_conferences(1:3)
#' }
#'
#' @return `character()` of same length as `teamIds` or length `1`
#'   if `teamIds` is `NULL`
nhl_url_conferences <- function(conferenceIds = NULL) {
  suffixes <- if (!is.null(conferenceIds)) list(conferenceIds)
  nhl_url(endPoint = "conferences", suffixes = suffixes)
}


#' Retrieve metadata on NHL conferences from the API
#'
#' @inheritParams nhl_url_conferences
#'
#' @return `data.frame`, with information on conferences, one row
#'   per conference.
#' @export
#'
#' @examples \dontrun{
#'   # Get information on all conferences
#'   nhl_conferences()
#'
#'   # Get information on 2 selected conferences
#'   nhl_conferences(5:6)
#' }
nhl_conferences <- function(conferenceIds = NULL) {
  x <- nhl_url_conferences(conferenceIds = conferenceIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "conferences")
  x
}
