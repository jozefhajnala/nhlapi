context("nhl_url_teams")

testthat::test_that(
  "nhl_url_teams generates all teams url",
  testthat::expect_equal(
    nhl_url_teams(),
    paste0(baseurl, "teams")
  )
)

testthat::test_that(
  "nhl_url_teams generates single team url",
  testthat::expect_equal(
    nhl_url_teams(1),
    paste0(baseurl, "teams/1")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple teams url",
  testthat::expect_equal(
    nhl_url_teams(c(1, 2)),
    paste0(baseurl, c("teams/1", "teams/2"))
  )
)
