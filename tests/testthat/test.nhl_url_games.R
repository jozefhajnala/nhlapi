context("nhl_url_games")

testthat::test_that(
  "nhl_url_games generates 1 game and 1 element url",
  testthat::expect_equal(
    nhl_url_games(2017010001, "content"),
    paste0(baseurl, "game/2017010001/content")
  )
)

testthat::test_that(
  "nhl_url_games generates 2 games and 1 element urls",
  testthat::expect_equal(
    nhl_url_games(c(2017010001, 2017010002), "content"),
    paste0(baseurl, c(
      "game/2017010001/content",
      "game/2017010002/content"
    ))
  )
)

testthat::test_that(
  "nhl_url_games generates 2 games and 2 elements urls",
  testthat::expect_equal(
    nhl_url_games(c(2017010001, 2017010002), c("content", "boxscore")),
    paste0(baseurl, c(
      "game/2017010001/content",
      "game/2017010002/content",
      "game/2017010001/boxscore",
      "game/2017010002/boxscore"
    ))

  )
)

testthat::test_that(
  "nhl_url_games generates 2 games and 2 elements urls for character ids",
  testthat::expect_equal(
    nhl_url_games(c("2017010001", "2017010002"), c("content", "boxscore")),
    paste0(baseurl, c(
      "game/2017010001/content",
      "game/2017010002/content",
      "game/2017010001/boxscore",
      "game/2017010002/boxscore"
    ))

  )
)

testthat::test_that(
  "nhl_url_games generates 2 games and 2 elements urls for integer ids",
  testthat::expect_equal(
    nhl_url_games(2017010001:2017010002, c("content", "boxscore")),
    paste0(baseurl, c(
      "game/2017010001/content",
      "game/2017010002/content",
      "game/2017010001/boxscore",
      "game/2017010002/boxscore"
    ))

  )
)
