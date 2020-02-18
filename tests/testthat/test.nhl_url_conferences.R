context("nhl_url_conferences")

testthat::test_that(
  "nhl_url_teams generates all conference url",
  testthat::expect_equal(
    nhl_url_conferences(),
    paste0(baseurl, "conferences")
  )
)

testthat::test_that(
  "nhl_url_teams generates single conference url",
  testthat::expect_equal(
    nhl_url_conferences(1),
    paste0(baseurl, "conferences/1")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple conference url",
  testthat::expect_equal(
    nhl_url_conferences(c(1, 2)),
    paste0(baseurl, c("conferences/1", "conferences/2"))
  )
)
