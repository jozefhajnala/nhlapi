context("nhl_url_players_seasons")

testthat::test_that(
  "nhl_url_players_seasons generates 1 regular season url for 1 player",
  testthat::expect_equal(
    nhl_url_players_seasons(8477474, "20172018"),
    paste0(
      baseurl,
      "people/8477474/stats?stats=statsSingleSeason&season=20172018"
    )
  )
)

testthat::test_that(
  "nhl_url_players_seasons generates 1 playoffs url for 1 player",
  testthat::expect_equal(# Patrick Roy, playoffs 95-96
    nhl_url_players_seasons(8451033L, "19951996", playoffs = TRUE),
    paste0(
      baseurl,
      "people/8451033/stats?stats=statsSingleSeasonPlayoffs&season=19951996"
    )
  )
)

testthat::test_that(
  "nhl_url_players_seasons generates 2 playoff urls for 1 player",
  testthat::expect_equal(
    nhl_url_players_seasons(
      8451101L,
      c("19951996", "19961997"),
      playoffs = TRUE
    ),
    paste0(baseurl, c(
      "people/8451101/stats?stats=statsSingleSeasonPlayoffs&season=19951996",
      "people/8451101/stats?stats=statsSingleSeasonPlayoffs&season=19961997"
    ))
  )
)

testthat::test_that(
  "nhl_url_players_seasons generates 2 regular season urls for 2 players",
  testthat::expect_equal(
    nhl_url_players_seasons(c(8451101L, 8451102L), c("19951996", "19961997")),
    paste0(baseurl, c(
      "people/8451101/stats?stats=statsSingleSeason&season=19951996",
      "people/8451102/stats?stats=statsSingleSeason&season=19951996",
      "people/8451101/stats?stats=statsSingleSeason&season=19961997",
      "people/8451102/stats?stats=statsSingleSeason&season=19961997"
    ))
  )
)
