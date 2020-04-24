#' Create an NHL API URL for standings
#'
#' @inheritParams nhl_make_seasons
#' @param standingsTypes `character()`, defining the standings
#'   types to retrieve. Valid standings types are for example
#'   `"regularSeason"` or `"byDivision"`. See
#'   [nhl_md_standings_types()] for all values and their
#'   descriptions.
#' @param expand `character()`, of parameters passed as `expand`
#'   to the API URL. A valid example seems to be `"standings.record"`.
#'   `NULL` for no expand parameter.
#'
#' @examples \dontrun{
#'  nhl_url_standings(seasons = 2015:2016)
#'  nhl_url_standings(
#'    standingsType = "byDivision",
#'    expand = "standings.record"
#'  )
#' }
#'
#' @return `character()`, vector of URLs.
nhl_url_standings <- function(
  seasons = NULL,
  standingsTypes = NULL,
  expand = NULL
) {
  params <- list(
    season = seasons,
    standingsType = standingsTypes,
    expand = expand
  )
  nhl_url(endPoint = "standings", params = params)
}

#' Retrieve metadata on NHL standings from the API
#'
#' @inheritParams nhl_url_standings
#'
#' @return `list`, with information on standings
#'   depending on provided arguments.
#'
#' @examples \dontrun{
#'  # Get current standings
#'  nhl_standings()
#'
#'  # Get standings for historical seasons
#'  nhl_standings(seasons = 2015:2016)
#'
#'  # Get standings for historical seasons
#'  nhl_standings(
#'    seasons = 2015:2016,
#'    standingsType = "byDivision",
#'    expand = "standings.record"
#'  )
#' }
#'
#' @export
nhl_standings <- function(
  seasons = NULL,
  standingsTypes = NULL,
  expand = NULL
) {
  x <- nhl_url_standings(
    seasons = seasons,
    standingsTypes = standingsTypes,
    expand = expand
  )
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_results(x, elName = "records")
  x
}
