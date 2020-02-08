context("nhl_teams_stats")

testthat::test_that(
  "Statas for 2 teams and 2 seasons", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_teams = mock_return,
        nhl_teams_stats(
          teamIds = 1:2,
          seasons = c("19931994", "19931994")
        )
      ),
      list(
        teamIds = 1:2,
        params = list(
          expand = "team.stats",
          season = c("19931994", "19931994")
        )
      )
    )
  }
)
