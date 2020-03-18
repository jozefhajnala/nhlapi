#' Create an NHL API URL for drafts
#'
#' @param draftYears `integer()`, vector of one or more years in `YYYY`
#'   format or `NULL` (default) for the current year's draft. Also
#'   accepts a character vector of years in `YYYY` format.
#'
#' @examples \dontrun{
#'   nhl_url_drafts()
#'   nhl_url_drafts(2015:2017)
#' }
#'
#' @return `character()` of same length as `draftYears` or length `1`
#'   if `draftYears` is `NULL`
nhl_url_drafts <- function(draftYears = NULL) {
  suffixes <- if (!is.null(draftYears)) list(draftYears)
  nhl_url(endPoint = "draft", suffixes = suffixes)
}


#' Retrieve metadata on NHL drafts from the API
#'
#' @inheritParams nhl_url_drafts
#'
#' @return `data.frame`, with information on drafts, one row
#'   year.
#' @export
#'
#' @examples \dontrun{
#'   # Get information on current draft
#'   nhl_drafts()
#'
#'   # Get information on 3 historical drafts
#'   nhl_drafts(2015:2017)
#' }
nhl_drafts <- function(draftYears = NULL) {
  x <- nhl_url_drafts(draftYears = draftYears)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "drafts")
  x
}
