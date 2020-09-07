#' Create an NHL API URL for games
#'
#' @param gameIds `numeric()`, vector of one or more game ids. The
#'   game id is a 10 digit number where the
#'   * first 4 digits identify the season of the game, for instance
#'     2017 for the 2017-2018 season.
#'   * next 2 digits give the type of game, where
#'       * 01 - preseason,
#'       * 02 - regular season,
#'       * 03 - playoffs,
#'       * 04 - all-star.
#'   * final 4 digits identify the specific game number
#'       * for regular season and preseason games, this ranges from
#'         0001 to the number of games played. That is 1271 for
#'         seasons with 31 teams and 1230 for seasons with 30 teams.
#'       * for playoff games, the
#'           * second digit gives the round of the playoffs
#'           * third digit specifies the match-up
#'           * fourth digit specifies the game (out of 7)
#'
#' @param element `character()` vector of one or more valid elements.
#'   Currently the valid elements seem to be:
#'   * `"linescore"`
#'   * `"boxscore"`
#'   * `"content"`
#'   * `"feed/live"`
#'
#' @examples
#'   nhlapi:::nhl_url_games(2017010001, "content")
#'   nhlapi:::nhl_url_games(
#'     c(2017010001, 2017010002),
#'     c("content", "boxscore")
#'   )
#'
#' @return `character()`, of same length as `gameIds`.
nhl_url_games <- function(gameIds, element) {
  suffixes <- list(gameIds, element)
  nhl_url(endPoint = "game", suffixes = suffixes)
}


#' Retrieve metadata on NHL games from the API
#'
#' @inheritParams nhl_url_games
#'
#' @return `list`, with information on games, one element per game
#'   and element combination.
#'
#' @examples \dontrun{
#'   # Get content for one game
#'   nhl_games(2017010001, "content")
#'
#'   # Get both box score and content for 2 games
#'   nhl_games(c(2017010001, 2017010002), c("content", "boxscore"))
#'
#'   # Get content for a game
#'   nhl_games_content(2017010001)
#'
#'   # Get the game feed for a game
#'   nhl_games_feed(2017010001)
#'
#'   # Get the box score for a game
#'   nhl_games_boxscore(2017010001)
#'
#'   # Get the line score for a game
#'   nhl_games_linescore(2017010001)
#' }
#'
#' @export
nhl_games <- function(gameIds, element) {
  x <- nhl_url_games(gameIds = gameIds, element = element)
  x <- nhl_get_data(x)
  x <- util_remove_get_data_errors(x)
  x
}


#' @describeIn nhl_games Complex endpoint returning multiple types
#'   of media relating to the game including videos of shots,
#'   goals and saves.
#' @export
nhl_games_content <- function(gameIds) {
  nhl_games(gameIds = gameIds, element = "content")
}

#' @describeIn nhl_games returns all data about a specified game id
#'   including play data with on-ice coordinates and post-game
#'   details like first, second and third stars and details about
#'   shootouts. Note that the data returned is sizable, often over
#'   30 000 lines.
#' @export
nhl_games_feed <- function(gameIds) {
  nhl_games(gameIds = gameIds, element = "feed/live")
}

#' @describeIn nhl_games Returns far less detail than `nhl_games_feed()`
#'   and may be more suitable for analyzing post-game statistics
#'   including goals, shots, penalty minutes, blocked, takeaways, etc.
#' @export
nhl_games_boxscore <- function(gameIds) {
  nhl_games(gameIds = gameIds, element = "boxscore")
}

#' @describeIn nhl_games Returns even fewer details than
#'   `nhl_games_boxscore()`. Has goals, shots on goal, power-play
#'   and goalie pulled status, number of skaters and shootout
#'   information if applicable.
#' @export
nhl_games_linescore <- function(gameIds) {
  nhl_games(gameIds = gameIds, element = "linescore")
}
