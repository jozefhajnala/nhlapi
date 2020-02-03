context("nhl_players_seasons")

testthat::test_that(
  "Retrieve playoff seasons for 1 player", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_players_seasons(
        playerIds = 8451101L,
        seasons = "19951996",
        playoffs = TRUE
      ),
      retrievedplayerplayoffs
    )
  }
)
context("nhl_players_allseasons")

testthat::test_that(
  "Retrieve all seasons for 2 players", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_players_allseasons(playerIds = c(8449231, 8450183)),
      retrievedplayersallseasons
    )
  }
)
