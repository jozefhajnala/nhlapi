nhl_retrieve_players <- function(x) {
  x <- nhl_url_players(x)
  x <- nhl_get_datas(x)
  x <- nhl_process_players(x)
  x
}
