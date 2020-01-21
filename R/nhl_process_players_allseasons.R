nhl_process_player_seasons <- function(x, playerId) {
  playerId <- as.integer(playerId)
  res <- util_process_copyright(x)
  res_df <- res[["stats"]][["splits"]][[1L]]
  if (!is.data.frame(res_df) && length(res_df) == 0L) {
    res_df <- data.frame()
  }
  res_df <- util_inherit_attributes(res, res_df)
  res_df[["playerId"]] <- rep(playerId, nrow(res_df))
  res_df[["seasonStart"]] <- as.integer(substr(res_df[["season"]], 1L, 4L))
  res_df <- util_process_minsonice(res_df)
  res_df
}

nhl_process_players_allseasons <- function(x, playerIds) {
  util_rbindlist(Map(nhl_process_player_seasons, x, playerIds))
}

nhl_process_players_seasons <- function(x, playerIds) {
  util_rbindlist(Map(nhl_process_player_seasons, x, playerIds))
}
