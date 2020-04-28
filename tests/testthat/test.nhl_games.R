context("nhl_games")

testthat::test_that(
  "nhl_games_content has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_games_content(2017010001)[[1L]]
    testthat::expect_true(all(is.element(
      c("copyright", "link", "editorial", "media", "highlights"),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_games_feed has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_games_feed(2017010001)[[1L]]
    testthat::expect_true(all(is.element(
      c("copyright", "gamePk", "link", "metaData", "gameData", "liveData"),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_games_boxscore has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_games_boxscore(2017010001)[[1L]]
    testthat::expect_true(all(is.element(
      c("copyright", "teams", "officials"),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_games_linescore has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_games_linescore(2017010001)[[1L]]
    testthat::expect_true(all(is.element(
      c(
        "copyright", "currentPeriod", "currentPeriodOrdinal",
        "currentPeriodTimeRemaining",  "periods", "shootoutInfo",
        "teams", "powerPlayStrength", "hasShootout",
        "intermissionInfo", "powerPlayInfo"
      ),
      names(res)
    )))
  }
)
