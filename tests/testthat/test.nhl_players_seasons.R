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

testthat::test_that(
  "Retrieve playoff seasons for 1 player, numeric season", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_players_seasons(
        playerIds = 8451101L,
        seasons = 1995,
        playoffs = TRUE
      ),
      retrievedplayerplayoffs
    )
  }
)

testthat::test_that(
  "Retrieve playoff seasons for 1 player name, numeric season", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_players_seasons(
        "Joe Sakic",
        seasons = "19951996",
        playoffs = TRUE
      ),
      retrievedplayerplayoffs
    )
  }
)

testthat::test_that(
  "Error if neither playerIds nor names provided",
  testthat::expect_error(
    nhl_players_seasons(seasons = "19951996"),
    "Please provide either playerNames or playerIds"
  )
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

testthat::test_that(
  "Error if neither playerIds nor names provided",
  testthat::expect_error(
    nhl_players_allseasons(),
    "Please provide either playerNames or playerIds"
  )
)

testthat::test_that(
  "Retrieve all seasons for 2 players by names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_players_allseasons(c("ken thompson", "art farrell")),
      retrievedplayersallseasons
    )
  }
)
