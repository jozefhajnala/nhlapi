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
