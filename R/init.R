.onLoad <- function(libName, pkgName) { # nocov start
  options(
    nhlapi_baseurl = "https://statsapi.web.nhl.com/api/v1/",
    nhlapi_try_silent = TRUE,
    nhlapi_player_map = hashedPlayers,
    nhlapi_get_retries = 2L,
    nhlapi_get_retry_sleep = 1,
    nhlapi_flatten = TRUE,
    nhlapi_get_noretry = "HTTP error 404|HTTP error 400",
    nhlapi_log_datetime = "%H:%M:%S",
    nhlapi_log_threshold = 25L
  )
} # nocov end
