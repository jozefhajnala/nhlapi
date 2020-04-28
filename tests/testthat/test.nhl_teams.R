context("nhl_teams")

testthat::test_that(
  "nhl_teams retrieves 2 teams", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    testthat::expect_equal(
      nhl_teams(teamIds = 1:2)[, c("id", "name", "link")],
      teams_processed[, c("id", "name", "link")]
    )
  }
)
