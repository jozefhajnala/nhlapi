context("nhl_schedule")

testthat::test_that(
  "nhl_schedule_today has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_schedule_today()[[1L]]
    testthat::expect_true(all(is.element(
      c(
        "copyright",
        "totalItems", "totalEvents", "totalGames", "totalMatches",
        "wait", "dates"
      ),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_schedule_seasons returns sensible info", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_schedule_seasons(2015)[[1L]]

    testthat::expect_true(all(is.element(
      c(
        "copyright",
        "totalItems", "totalEvents", "totalGames", "totalMatches",
        "wait", "dates"
      ),
      names(res)
    )))

    testthat::expect_true(
      res$totalGames > 1000
    )

    testthat::expect_true(
      is.data.frame(res$dates)
    )
  }
)

testthat::test_that(
  "nhl_schedule_seasons returns sensible info for playoffs", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_schedule_seasons(2015, gameTypes = "P")[[1L]]

    testthat::expect_true(all(is.element(
      c(
        "copyright",
        "totalItems", "totalEvents", "totalGames", "totalMatches",
        "wait", "dates"
      ),
      names(res)
    )))

    testthat::expect_true(
      res$totalGames > 10
    )

    testthat::expect_true(
      res$totalGames < 150
    )

    testthat::expect_true(
      is.data.frame(res$dates)
    )
  }
)

testthat::test_that(
  "nhl_schedule_seasons returns sensible info for 1 team, regular", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_schedule_seasons(2015, gameTypes = "R", teamIds = 2)[[1L]]

    testthat::expect_true(all(is.element(
      c(
        "copyright",
        "totalItems", "totalEvents", "totalGames", "totalMatches",
        "wait", "dates"
      ),
      names(res)
    )))

    testthat::expect_true(
      res$totalGames > 75
    )

    testthat::expect_true(
      res$totalGames < 90
    )

    testthat::expect_true(
      is.data.frame(res$dates)
    )
  }
)


testthat::test_that(
  "nhl_schedule_date_range returns sensible info for 1 team, regular", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_schedule_date_range(
      startDate = "2015-10-01", endDate = "2015-11-30",
      gameTypes = "R", teamIds = 2
    )[[1L]]

    testthat::expect_true(all(is.element(
      c(
        "copyright",
        "totalItems", "totalEvents", "totalGames", "totalMatches",
        "wait", "dates"
      ),
      names(res)
    )))

    testthat::expect_true(
      res$totalGames > 20
    )

    testthat::expect_true(
      res$totalGames < 30
    )

    testthat::expect_true(
      is.data.frame(res$dates)
    )
  }
)

testthat::test_that(
  "nhl_schedule_date_range returns info for 1 team, regular, with expand", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_schedule_date_range(
      startDate = "2015-10-01", endDate = "2015-11-30",
      gameTypes = "R", teamIds = 2, expand = "schedule.linescore"
    )[[1L]]

    testthat::expect_true(all(is.element(
      c(
        "copyright",
        "totalItems", "totalEvents", "totalGames", "totalMatches",
        "wait", "dates"
      ),
      names(res)
    )))

    testthat::expect_true(
      ncol(res$dates$games[[1]]) > 40
    )
    testthat::expect_true(
      is.data.frame(res$dates)
    )
  }
)
