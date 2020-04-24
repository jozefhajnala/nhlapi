#' Create an NHL API URL for tournaments
#'
#' @param tournamentTypes `character()`, vector of one or more tournament
#'   types. Currently supported types seem to be.
#'   * `"playoffs"`
#'   * `"olympics"`
#'   * `"worldCup"`
#'
#'  Those are exposed via shorthand functions
#'  * [nhl_tournaments_playoffs()]
#'  * [nhl_tournaments_olympics()]
#'  * [nhl_tournaments_worldcups()]
#'
#' @inheritParams nhl_make_seasons
#' @param expand `character()`, of parameters passed as `expand`
#'   to the API URL. Two valid examples seem to be `"round.series"`
#'   and `"schedule.game.seriesSummary"`. `NULL` for no expand
#'   parameter.
#'
#' @examples \dontrun{
#'   nhl_url_tournaments("olympics")
#'   nhl_url_tournaments("playoffs", 2015:2016)
#'   nhl_url_tournaments("playoffs", 2015:2016, "round.series")
#' }
#'
#' @seealso [nhl_md_tournament_types()]
#'
#' @return `character()` of same length as combinations of
#'   `tournamentTypes`, `seasons` and `expand`.
nhl_url_tournaments <- function(
  tournamentTypes,
  seasons = NULL,
  expand = NULL
) {
  suffixes <- list(tournamentTypes)
  params <- list(season = seasons, expand = expand)
  nhl_url(endPoint = "tournaments", suffixes = suffixes, params = params)
}

#' Retrieve data on tournaments from the API
#'
#' @inheritParams nhl_url_tournaments
#'
#' @return `list`, with information on tournaments, one element per
#'  `tournamentTypes` and parameters (`seasons` and `expand`)
#'  combinations.
#'
#' @examples \dontrun{
#'   # Get info on playoffs in one season
#'   nhl_tournaments("playoffs", 2015)
#'
#'   # Get info on playoffs in 2 seasons, expand rounds
#'   nhl_tournaments("playoffs", 2015:2016, "round.series")
#' }
#'
#' @export
nhl_tournaments <- function(
  tournamentTypes,
  seasons = NULL,
  expand = NULL
) {
  x <- nhl_url_tournaments(
    tournamentTypes = tournamentTypes,
    seasons = seasons,
    expand = expand
  )
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x
}

#' @describeIn nhl_tournaments Shortcut to get information on playoffs.
#' @export
#' @examples \dontrun{
#'   nhl_tournaments_playoffs(2015:2016, "round.series")
#' }
nhl_tournaments_playoffs <- function(seasons = NULL, expand = NULL) {
  nhl_tournaments("playoffs", seasons = seasons, expand = expand)
}

#' @describeIn nhl_tournaments Shortcut to get information on Olympics.
#' @export
#' @examples \dontrun{
#'   nhl_tournaments_olympics(2009, "round.series")
#' }
nhl_tournaments_olympics <- function(seasons = NULL, expand = NULL) {
  nhl_tournaments("olympics", seasons = seasons, expand = expand)
}

#' @describeIn nhl_tournaments Shortcut to get information on world cups.
#' @export
#' @examples \dontrun{
#'   nhl_tournaments_worldcups(2003)
#' }
nhl_tournaments_worldcups <- function(seasons = NULL, expand = NULL) {
  nhl_tournaments("worldCup", seasons = seasons, expand = expand)
}
