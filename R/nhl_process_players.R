nhl_process_player <- function(x) {
  res <- util_process_copyright(x)
  res_df <- res[["people"]]
  res_df <- util_attributes_to_cols(res, res_df)
  res_df
}

nhl_process_players <- function(x) {
  util_rbindlist(lapply(x, nhl_process_player))
}
