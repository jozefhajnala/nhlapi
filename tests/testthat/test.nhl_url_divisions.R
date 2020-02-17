context("nhl_url_divisions")

testthat::test_that(
  "nhl_url_teams generates all division url",
  testthat::expect_equal(
    nhl_url_divisions(),
    paste0(baseurl, "divisions")
  )
)

testthat::test_that(
  "nhl_url_teams generates single division url",
  testthat::expect_equal(
    nhl_url_divisions(1),
    paste0(baseurl, "divisions/1")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple division url",
  testthat::expect_equal(
    nhl_url_divisions(c(1, 2)),
    paste0(baseurl, c("divisions/1", "divisions/2"))
  )
)
