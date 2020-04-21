context("nhl_url_venues")

testthat::test_that(
  "nhl_url_venues generates venues url",
  testthat::expect_equal(
    nhl_url_venues(),
    paste0(baseurl, "venues")
  )
)

testthat::test_that(
  "nhl_url_teams generates single year venues url",
  testthat::expect_equal(
    nhl_url_venues(5000),
    paste0(baseurl, "venues/5000")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple venues urls from character",
  testthat::expect_equal(
    nhl_url_venues(c("5000", "5006")),
    paste0(baseurl, c("venues/5000", "venues/5006"))
  )
)
#
testthat::test_that(
  "nhl_url_teams generates multiple venues urls from integer",
  testthat::expect_equal(
    nhl_url_venues(5005:5006),
    paste0(baseurl, c("venues/5005", "venues/5006"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple venues urls from numeric",
  testthat::expect_equal(
    nhl_url_venues(c(5005.0, 5006.0)),
    paste0(baseurl, c("venues/5005", "venues/5006"))
  )
)
