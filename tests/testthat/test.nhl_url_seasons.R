context("nhl_url_seasons")

testthat::test_that(
  "nhl_url_seasons generates seasons url",
  testthat::expect_equal(
    nhl_url_seasons(),
    paste0(baseurl, "seasons")
  )
)

testthat::test_that(
  "nhl_url_teams generates single year seasons url",
  testthat::expect_equal(
    nhl_url_seasons(2015),
    paste0(baseurl, "seasons/20152016")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple seasons urls from character",
  testthat::expect_equal(
    nhl_url_seasons(c("20152016", "20162017")),
    paste0(baseurl, c("seasons/20152016", "seasons/20162017"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple seasons urls from integer",
  testthat::expect_equal(
    nhl_url_seasons(2015:2016),
    paste0(baseurl, c("seasons/20152016", "seasons/20162017"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple seasons urls from numeric",
  testthat::expect_equal(
    nhl_url_seasons(c(2015.0, 2016.0)),
    paste0(baseurl, c("seasons/20152016", "seasons/20162017"))
  )
)
