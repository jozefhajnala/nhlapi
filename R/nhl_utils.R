#' Make a vector of seasons consumable by the API
#'
#' @description The NHL API wants seasons defined in format
#'   YYYYZZZZ where ZZZZ = YYYY + 1. This is a helper to take
#'   a vector of years in YYYY format and create a vector of
#'   such seasons to be used with the API.
#'
#' @param years `integer()`, vector of season starting years,
#'   e.g.for season 1995-1996 it would be 1995.
#'
#' @examples
#'   nhl_make_seasons(1995:2000)
#'
#' @export
#'
#' @return `character()`, vector of seasons suited for the NHL API.
nhl_make_seasons <- function(years = 1950L:2019L) {
  paste0(years, years + 1L)
}
