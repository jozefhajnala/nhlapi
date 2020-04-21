context("nhl_seasons")

testthat::test_that(
  "nhl_seasons has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    res <- nhl_seasons(2000:2005)
    testthat::expect_equal(
      names(res),
      c(
        "seasonId", "regularSeasonStartDate", "regularSeasonEndDate",
        "seasonEndDate", "numberOfGames", "tiesInUse",
        "olympicsParticipation", "conferencesInUse", "divisionsInUse",
        "wildCardInUse", "url", "copyright"
      )
    )
  }
)
