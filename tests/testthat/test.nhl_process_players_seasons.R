context("nhl_process_player_seasons")

testthat::test_that(
  "Process empty data",
  testthat::expect_equal(
    nhl_process_player_seasons(list(), 1L),
    data.frame(playerId = integer(0), seasonStart = integer(0))
  )
)


context("nhl_process_players_seasons")

testthat::test_that(
  "Process empty data",
  testthat::expect_equal(
    nhl_process_players_seasons(list(list()), 1L),
    data.frame()
  )
)
