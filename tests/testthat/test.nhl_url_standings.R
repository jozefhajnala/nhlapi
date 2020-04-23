context("nhl_url_standings")

testthat::test_that(
  "nhl_url_standings with no params and expand",
  testthat::expect_equal(
    nhl_url_standings(),
    paste0(baseurl, "standings")
  )
)

testthat::test_that(
  "nhl_url_standings with seasons",
  testthat::expect_equal(
    nhl_url_standings(seasons = 2015:2016),
    paste0(baseurl, "standings?", c("season=20152016", "season=20162017"))
  )
)

testthat::test_that(
  "nhl_url_standings with seasons and expand",
  testthat::expect_equal(
    nhl_url_standings(seasons = 2015:2016, expand = "standings.record"),
    paste0(
      baseurl, "standings?",
      c("season=20152016", "season=20162017"),
      "&expand=standings.record"
    )
  )
)

testthat::test_that(
  "nhl_url_standings with seasons and expand",
  testthat::expect_equal(
    nhl_url_standings(
      seasons = 2015:2016,
      standingsTypes = c("regularSeason", "byDivision"),
      expand = "standings.record"
    ),
    paste0(
      baseurl, "standings?", c(
        "season=20152016&standingsType=regularSeason",
        "season=20162017&standingsType=regularSeason",
        "season=20152016&standingsType=byDivision",
        "season=20162017&standingsType=byDivision"
      ),
      "&expand=standings.record"
    )
  )
)
