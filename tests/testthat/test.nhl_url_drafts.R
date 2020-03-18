context("nhl_url_drafts")

testthat::test_that(
  "nhl_url_drafts generates draft url",
  testthat::expect_equal(
    nhl_url_drafts(),
    paste0(baseurl, "draft")
  )
)

testthat::test_that(
  "nhl_url_teams generates single year draft url",
  testthat::expect_equal(
    nhl_url_drafts(2015),
    paste0(baseurl, "draft/2015")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple draft urls from character",
  testthat::expect_equal(
    nhl_url_drafts(c("2015", "2016")),
    paste0(baseurl, c("draft/2015", "draft/2016"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple draft urls from integer",
  testthat::expect_equal(
    nhl_url_drafts(2015:2016),
    paste0(baseurl, c("draft/2015", "draft/2016"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple draft urls from numeric",
  testthat::expect_equal(
    nhl_url_drafts(c(2015.0, 2016.0)),
    paste0(baseurl, c("draft/2015", "draft/2016"))
  )
)
