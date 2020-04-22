context("nhl_url_schedule")

testthat::test_that(
  "nhl_url_schedule with no params and expand",
  testthat::expect_equal(
    nhl_url_schedule(),
    paste0(baseurl, "schedule")
  )
)

testthat::test_that(
  "nhl_url_schedule with seasons",
  testthat::expect_equal(
    nhl_url_schedule(seasons = 2015:2016),
    paste0(baseurl, "schedule?", c("season=20152016", "season=20162017"))
  )
)

testthat::test_that(
  "nhl_url_schedule with date range and team id",
  testthat::expect_equal(
    nhl_url_schedule(
      startDate = "2018-01-02",
      endDate = "2018-01-02",
      teamIds = 30
    ),
    paste0(
      baseurl, "schedule?",
      "teamId=30&startDate=2018-01-02&endDate=2018-01-02"
    )
  )
)

testthat::test_that(
  "nhl_url_schedule with date range, 2 teams and expand",
  testthat::expect_equal(
    nhl_url_schedule(
      startDate = "2018-01-02",
      endDate = "2018-01-02",
      teamIds = c(29, 30),
      expand = "schedule.linescore"
    ),
    paste0(
      baseurl, "schedule?",
      c("teamId=29&", "teamId=30&"),
      "startDate=2018-01-02&endDate=2018-01-02&expand=schedule.linescore"
    )
  )
)

testthat::test_that(
  "nhl_url_schedule with season, only regular",
  testthat::expect_equal(
    nhl_url_schedule(seasons = 2015, gameTypes = "R"),
    paste0(baseurl, "schedule?season=20152016&gameTypes=R")
  )
)
