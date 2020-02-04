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

testthat::test_that(
  "nhl_url_teams generates all teams url with rosters",
  testthat::expect_equal(
    nhl_url_teams(params = list(expand = "team.roster")),
    paste0(baseurl, "teams", "?expand=team.roster")
  )
)

testthat::test_that(
  "nhl_url_teams generates all teams url with rosters for 2 seasons",
  testthat::expect_equal(
    nhl_url_teams(
      params = list(
        expand = "team.roster",
        season = c("19941995", "19951996")
      )
    ),
    paste0(
      baseurl, "teams", "?expand=team.roster",
      c("&season=19941995", "&season=19951996")
    )
  )
)
