nhl_process_player <- function(x) {
  x <- util_process_copyright(x)
  util_flatten_list(x[["people"]])
}

nhl_process_players <- function(x) {
  util_rbindlist(lapply(x, nhl_process_player))
}
