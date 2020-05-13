#' Create an NHL API URL for schedules
#'
#' @inheritParams nhl_make_seasons
#' @inheritParams nhl_url_teams
#' @param startDate `character(1)`, date in the format `"YYYY-MM-DD"`
#'   defining the start of the date interval for which the schedule is
#'   to be retrieved.
#' @param endDate `character(1)`, date in the format `"YYYY-MM-DD"`
#'   defining the end of the date interval for which the schedule is
#'   to be retrieved.
#' @param expand `character()`, of parameters passed as `expand`
#'   to the API URL. Some valid examples seem to be `"round.series"`
#'   and `"schedule.broadcasts"`, `"schedule.linescore"`,
#'   `"schedule.ticket"`. `NULL` for no expand parameter.
#' @param gameTypes `character()`, defining the game types to retrieve.
#'   Valid game types are for example `"R"` for regular season or `"P"`
#'   for playoffs. See [nhl_md_game_types()] for all values and their
#'   descriptions.
#' @examples
#'  nhlapi:::nhl_url_schedule(seasons = 2015:2016)
#'  nhlapi:::nhl_url_schedule(
#'    startDate = "2018-01-02",
#'    endDate = "2018-01-02"
#'  )
#'  nhlapi:::nhl_url_schedule(
#'    startDate = "2018-01-02",
#'    endDate = "2018-01-02",
#'    teamIds = c(29, 30),
#'    expand = "schedule.linescore"
#'  )
#'
#' @return `character()`, vector of URLs.
nhl_url_schedule <- function(
  seasons = NULL,
  teamIds = NULL,
  startDate = NULL,
  endDate = NULL,
  gameTypes = NULL,
  expand = NULL
) {
  params <- list(
    season = seasons,
    teamId = teamIds,
    startDate = startDate,
    endDate = endDate,
    gameTypes = gameTypes,
    expand = expand
  )
  nhl_url(endPoint = "schedule", params = params)
}

#' Retrieve metadata on NHL schedule from the API
#'
#' The general-purpose `nhl_schedule()` exposes many parameters,
#'   some useful helpers are exposed as separate functions to
#'   reflect common use cases. Arguments can be passed to these
#'   named via `...`.
#'  * [nhl_schedule_today()]
#'  * [nhl_schedule_seasons()]
#'  * [nhl_schedule_date_range()]
#'
#' @inheritParams nhl_url_schedule
#'
#' @return `list`, with information on schedule, depending on
#'   provided arguments.
#'
#' @examples \dontrun{
#'  # Get current schedule
#'  nhl_schedule()
#'
#'  # Get schedule for historical seasons
#'  nhl_schedule(seasons = 2015:2016)
#'
#'  # Get schedule for a date range
#'  nhl_schedule(startDate = "2018-01-02", endDate = "2018-01-02")
#'
#'  # Get schedule for a date range, specific teams
#'  # and expand on line scores
#'  nhl_schedule(
#'    startDate = "2018-01-02",
#'    endDate = "2018-01-02",
#'    teamIds = c(29, 30),
#'    expand = "schedule.linescore"
#'  )
#' }
#'
#' @export
nhl_schedule <- function(
  seasons = NULL,
  teamIds = NULL,
  startDate = NULL,
  endDate = NULL,
  gameTypes = NULL,
  expand = NULL
) {
  x <- nhl_url_schedule(
    seasons = seasons,
    teamIds = teamIds,
    startDate = startDate,
    endDate = endDate,
    gameTypes = gameTypes,
    expand = expand
  )
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x
}

#' @describeIn nhl_schedule Shortcut to get information on
#'   today's schedule.
#' @param ... other named parameters passed to [nhl_schedule()].
#' @export
#' @examples \dontrun{
#'   nhl_schedule_today()
#' }
nhl_schedule_today <- function(...) {
  nhl_schedule(...)
}

#' @describeIn nhl_schedule Shortcut to get information on schedule for
#'   one or more seasons.
#' @export
#' @examples \dontrun{
#'   # Schedule for seasons starting in 2015 and 2016
#'   nhl_schedule_seasons(2015:2016)
#'
#'   # Schedule for seasons starting in 2015 and 2016
#'   # Only 1 team and expand line scores
#'   nhl_schedule_seasons(
#'     2015:2016,
#'     teamIds = 1,
#'     expand = "schedule.linescore"
#'   )
#' }
nhl_schedule_seasons <- function(seasons, ...) {
  nhl_schedule(seasons = seasons, ...)
}

#' @describeIn nhl_schedule Shortcut to get information on
#'   schedule for a range of dates in `"YYYY-MM-DD"` format.
#' @export
#' @examples \dontrun{
#'   # Schedule for October and November 2015
#'   nhl_schedule_date_range(
#'     startDate = "2015-10-01",
#'     endDate = "2015-11-30"
#'   )
#'
#'   # Schedule for October and November 2015
#'   # Regular seasons only, specific team and expand line scores
#'   nhl_schedule_date_range(
#'     startDate = "2015-10-01", endDate = "2015-11-30",
#'     gameTypes = "R",
#'     teamIds = 2,
#'     expand = "schedule.linescore"
#'   )
#' }
nhl_schedule_date_range <- function(startDate, endDate, ...) {
  nhl_schedule(startDate = startDate, endDate = endDate, ...)
}
