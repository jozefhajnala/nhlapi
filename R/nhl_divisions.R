#' Create an NHL API URL for divisions
#'
#' @param divisionIds `integer()`, ids of the divisions or `NULL` (default)
#'   for all divisions As of end of 2019, the valid division ids seem to be
#'   in the `1:25` range.
#'
#' @examples \dontrun{
#'   nhl_url_divisions()
#'   nhl_url_divisions(1:3)
#' }
#'
#' @return `character()` of same length as `teamIds` or length `1`
#'   if `teamIds` is `NULL`
nhl_url_divisions <- function(divisionIds = NULL) {
  suffixes <- if (!is.null(divisionIds)) list(divisionIds)
  nhl_url(endPoint = "divisions", suffixes = suffixes)
}


#' Retrieve metadata on NHL divisions from the API
#'
#' @inheritParams nhl_url_divisions
#'
#' @return data.frame, with information on divisions, one line
#'   per division.
#' @export
#'
#' @examples \dontrun{
#'   # All divisions
#'   nhl_divisions()
#'
#'  # Only 2 divisions
#'   nhl_divisions(15:16)
#' }
nhl_divisions <- function(divisionIds = NULL) {
  x <- nhl_url_divisions(divisionIds = divisionIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "divisions")
  x
}
