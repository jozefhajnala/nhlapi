context("nhl_retrieve_players")

testthat::test_that(
  "Retrieve 2 players", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_retrieve_players(c(8451101L, 8451033L)),
      testplayers_processed
    )
  }
)
