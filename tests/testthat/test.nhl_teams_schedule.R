context("nhl_teams_schedule")

testthat::test_that(
  "Next match schedule for 2 teams", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_teams = mock_return,
        nhl_teams_shedule_next(teamIds = 1:2)
      ),
      list(
        teamIds = 1:2,
        params = c(expand = "team.schedule.next")
      )
    )
  }
)

testthat::test_that(
  "Next match schedule for 2 teams", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_teams = mock_return,
        nhl_teams_shedule_previous(teamIds = 1:2)
      ),
      list(
        teamIds = 1:2,
        params = c(expand = "team.schedule.previous")
      )
    )
  }
)
