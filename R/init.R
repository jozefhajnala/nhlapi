.onLoad <- function(libName, pkgName) { # nocov start
   options(
    nhlapi_baseurl = "https://statsapi.web.nhl.com/api/v1/",
    nhlapi_try_silent = TRUE,
    nhlapi_player_map = hashedPlayers
  )
} # nocov end
