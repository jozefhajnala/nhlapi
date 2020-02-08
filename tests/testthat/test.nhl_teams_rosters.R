context("nhl_teams_rosters")

testthat::test_that(
  "Roster for the Devils in 1980-81", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      dim(nhl_teams_rosters(2, "19801981")[["roster.roster"]][[1L]]),
      c(27L, 8L)
    )
  }
)

testthat::test_that(
  "Roster for 2 teams and 2 seasons", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_teams = mock_return,
        nhl_teams_rosters(
          teamIds = 1:2,
          seasons = c("19931994", "19931994")
        )
      ),
      list(
        teamIds = 1:2,
        params = list(
          expand = "team.roster",
          season = c("19931994", "19931994")
        )
      )
    )
  }
)
