nhl_retrieve_players <- function(playerIds) {
  x <- nhl_url_players(playerIds)
  x <- nhl_get_datas(x)
  x <- util_remove_get_data_errors(x)
  x <- nhl_process_players(x)
  x
}
