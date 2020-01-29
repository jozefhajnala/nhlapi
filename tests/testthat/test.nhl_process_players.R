context("nhl_process_player")

testthat::test_that(
  "Process 2 player1",
  testthat::expect_equal(
    nhl_process_player(testplayers[[1L]]),
    testplayers_processed[1L, ]
  )
)


context("nhl_process_players")

testthat::test_that(
  "Process 2 players",
  testthat::expect_equal(
    nhl_process_players(testplayers),
    testplayers_processed
  ))
