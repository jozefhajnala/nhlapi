#' Create an NHL API URL for draft prospects
#'
#' @param prospectIds `integer()`, vector of one or more ids of draft
#'   prospects or `NULL` (default) for all exposed prospects.
#'
#' @examples \dontrun{
#'   nhl_url_draft_prospects()
#' }
#'
#' @return `character()` of same length as `prospectIds` or length `1`
#'   if `prospectIds` is `NULL`.
nhl_url_draft_prospects <- function(prospectIds = NULL) {
  suffixes <- if (!is.null(prospectIds)) list(prospectIds)
  nhl_url(endPoint = "draft/prospects", suffixes = suffixes)
}


#' Retrieve metadata on NHL draft prospects from the API
#'
#' @inheritParams nhl_url_draft_prospects
#'
#' @return `data.frame`, with information on draft prospects, one row
#'   per draft prospect.
#' @export
#'
#' @examples \dontrun{
#'   # Get information on current draft prospects
#'   nhl_draft_prospects()
#' }
nhl_draft_prospects <- function(prospectIds = NULL) {
  x <- nhl_url_draft_prospects(prospectIds = prospectIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "prospects")
  x
}
