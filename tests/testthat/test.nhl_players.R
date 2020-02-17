context("nhl_players")

testthat::test_that(
  "Retrieve 2 players", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_players(playerIds = c(8451101L, 8451033L)),
      testplayers_processed
    )
  }
)

testthat::test_that(
  "Stop if neither playerNames nor playerIds provided",
  testthat::expect_error(
    nhl_players(),
    "Please provide either playerNames or playerIds."
  )
)

testthat::test_that(
  "Stop if playerNames not character",
  testthat::expect_error(
    nhl_players(c(1, 2)),
    "playerNames must be a character vector."
  )
)
