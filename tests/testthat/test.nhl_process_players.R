context("nhl_process_players")

testthat::test_that(
  "Process 2 players",
  testthat::expect_equal(
    nhl_process_players(testplayers),
    testplayers_processed
  ))
