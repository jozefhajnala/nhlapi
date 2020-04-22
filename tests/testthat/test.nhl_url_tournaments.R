context("nhl_url_tournaments")

testthat::test_that(
  "nhl_url_tournaments 1 type with no seasons",
  testthat::expect_equal(
    nhl_url_tournaments("playoffs"),
    paste0(baseurl, "tournaments/playoffs")
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with no seasons",
  testthat::expect_equal(
    nhl_url_tournaments(c("playoffs", "olympics")),
    paste0(baseurl, c("tournaments/playoffs", "tournaments/olympics"))
  )
)

testthat::test_that(
  "nhl_url_tournaments 1 types with 1 integer season",
  testthat::expect_equal(
    nhl_url_tournaments("playoffs", seasons = 2015),
    paste0(baseurl, "tournaments/playoffs?season=20152016")
  )
)

testthat::test_that(
  "nhl_url_tournaments 1 types with 1 character season",
  testthat::expect_equal(
    nhl_url_tournaments("playoffs", seasons = "20152016"),
    paste0(baseurl, "tournaments/playoffs?season=20152016")
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 2 integer seasons",
  testthat::expect_equal(
    nhl_url_tournaments(c("playoffs", "olympics"), seasons = 2015:2016),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016",
      "tournaments/olympics?season=20152016",
      "tournaments/playoffs?season=20162017",
      "tournaments/olympics?season=20162017"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 2 numeric seasons",
  testthat::expect_equal(
    nhl_url_tournaments(c("playoffs", "olympics"), c(2015.0, 2016.0)),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016",
      "tournaments/olympics?season=20152016",
      "tournaments/playoffs?season=20162017",
      "tournaments/olympics?season=20162017"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 1 type with no seasons and expand",
  testthat::expect_equal(
    nhl_url_tournaments("playoffs", expand = "round.series"),
    paste0(baseurl, "tournaments/playoffs?expand=round.series")
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with no seasons and expand",
  testthat::expect_equal(
    nhl_url_tournaments(
      c("playoffs", "olympics"),
      expand = "round.series,schedule.game.seriesSummary"
    ),
    paste0(baseurl, c(
      "tournaments/playoffs?expand=round.series,schedule.game.seriesSummary",
      "tournaments/olympics?expand=round.series,schedule.game.seriesSummary"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 1 integer season and expand",
  testthat::expect_equal(
    nhl_url_tournaments(
      c("playoffs", "olympics"),
      seasons = 2015L,
      expand = "round.series"
    ),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016&expand=round.series",
      "tournaments/olympics?season=20152016&expand=round.series"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 2 integer seasons and expand",
  testthat::expect_equal(
    nhl_url_tournaments(
      c("playoffs", "olympics"),
      seasons = 2015:2016,
      expand = "round.series"
    ),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016&expand=round.series",
      "tournaments/olympics?season=20152016&expand=round.series",
      "tournaments/playoffs?season=20162017&expand=round.series",
      "tournaments/olympics?season=20162017&expand=round.series"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 2 integer seasons and expand",
  testthat::expect_equal(
    nhl_url_tournaments(
      c("playoffs", "olympics"),
      seasons = 2015:2016,
      expand = "round.series"
    ),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016&expand=round.series",
      "tournaments/olympics?season=20152016&expand=round.series",
      "tournaments/playoffs?season=20162017&expand=round.series",
      "tournaments/olympics?season=20162017&expand=round.series"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 2 numeric seasons and expand",
  testthat::expect_equal(
    nhl_url_tournaments(
      c("playoffs", "olympics"),
      seasons = c(2015.0, 2016.0),
      expand = "round.series"
    ),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016&expand=round.series",
      "tournaments/olympics?season=20152016&expand=round.series",
      "tournaments/playoffs?season=20162017&expand=round.series",
      "tournaments/olympics?season=20162017&expand=round.series"
    ))
  )
)

testthat::test_that(
  "nhl_url_tournaments 2 types with 2 character seasons and expand",
  testthat::expect_equal(
    nhl_url_tournaments(
      c("playoffs", "olympics"),
      seasons = c("20152016", "20162017"),
      expand = "round.series"
    ),
    paste0(baseurl, c(
      "tournaments/playoffs?season=20152016&expand=round.series",
      "tournaments/olympics?season=20152016&expand=round.series",
      "tournaments/playoffs?season=20162017&expand=round.series",
      "tournaments/olympics?season=20162017&expand=round.series"
    ))
  )
)
