context("nhl_standings")

testthat::test_that(
  "nhl_standings is a data frame with correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_standings()

    testthat::expect_true(
      is.data.frame(res)
    )

    testthat::expect_true(all(is.element(
      c(
        "standingsType", "teamRecords",
        "league.id", "league.name",  "league.link",
        "division.id", "division.name", "division.nameShort",
        "division.link", "division.abbreviation",
        "conference.id", "conference.name",  "conference.link",
        "url", "copyright"
      ),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_standings for 2 seasons", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_standings(seasons = 2015:2016)

    testthat::expect_true(
      is.data.frame(res)
    )

    testthat::expect_true(all(is.element(
      c(
        "standingsType", "teamRecords",
        "league.id", "league.name",  "league.link",
        "division.id", "division.name", "division.nameShort",
        "division.link", "division.abbreviation",
        "conference.id", "conference.name",  "conference.link",
        "url", "copyright"
      ),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_standings for 2 seasons by division", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_standings(seasons = 2015:2016, standingsTypes = "byDivision")

    testthat::expect_true(
      is.data.frame(res)
    )

    testthat::expect_true(all(is.element(
      c(
        "standingsType", "teamRecords",
        "league.id", "league.name",  "league.link",
        "division.id", "division.name", "division.nameShort",
        "division.link", "division.abbreviation",
        "conference.id", "conference.name",  "conference.link",
        "url", "copyright"
      ),
      names(res)
    )))

    testthat::expect_equal(
      unique(res$standingsType),
      "byDivision"
    )
  }
)

testthat::test_that(
  "nhl_standings for 2 seasons by division with expand", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_standings(
      seasons = 2015:2016,
      standingsTypes = "byDivision",
      expand = "standings.record"
    )

    testthat::expect_true(
      is.data.frame(res)
    )

    testthat::expect_true(all(is.element(
      c(
        "standingsType", "teamRecords",
        "league.id", "league.name",  "league.link",
        "division.id", "division.name", "division.nameShort",
        "division.link", "division.abbreviation",
        "conference.id", "conference.name",  "conference.link",
        "url", "copyright"
      ),
      names(res)
    )))

    testthat::expect_equal(
      unique(res$standingsType),
      "byDivision"
    )

    # This is one of the expansions:
    testthat::expect_true(
      "records.divisionRecords" %in% names(res$teamRecords[[1]])
    )
    testthat::expect_true(is.list(
        res$teamRecords[[1]]$records.divisionRecords
    ))
    testthat::expect_true(is.data.frame(
      res$teamRecords[[1]]$records.divisionRecords[[1]]
    ))
  }
)
