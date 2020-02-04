#' Create an NHL API URL for teams
#'
#' @param teamIds `integer()`, ids of the teams or `NULL` (default)
#'   for all teams. As of end of 2019, the valid team ids seem to be
#'   in the `1:54` range.
#'
#' @examples \dontrun{
#'   nhl_url_teams()
#'   nhl_url_teams(1:3)
#' }
#'
#' @return `character()` of same length as `teamIds` or length `1`
#'   if `teamIds` is `NULL`
nhl_url_teams <- function(teamIds = NULL) {
  nhl_url(endPoint = "teams", suffixes = if (!is.null(teamIds)) list(teamIds))
}

nhl_process_team <- function(x) {
  res <- util_process_copyright(x)
  res_df <- res[["teams"]]
  res_df <- util_attributes_to_cols(res, res_df)
  res_df
}

nhl_process_teams <- function(x) {
  util_rbindlist(lapply(x, nhl_process_team))
}

#' Retrieve metadata on NHL teams from the API
#'
#' @description Retrieves team metadata such as the teams names,
#'   abbreviations, locations, conferences, venues, etc.
#'
#' @details The API allows to retrieve data on all teams at once,
#'   which is achieved by the default `NULL` value for the team id.
#'
#' @inheritParams nhl_url_teams
#'
#' @examples \dontrun{
#'   nhl_teams()
#'   nhl_teams(1:3)
#' }
#'
#' @export
#' @return `data.frame` with data on teams, one row per team.
nhl_teams <- function(teamIds = NULL) {
  x <- nhl_url_teams(teamIds = teamIds)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_teams(x)
  x
}
