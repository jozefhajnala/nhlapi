context("nhl_retrieve_players_allseasons")

testthat::test_that(
  "Retrieve all seasons for 2 players", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_retrieve_players_allseasons(c(8449231, 8450183)),
      retrievedplayersallseasons
    )
  }
)
