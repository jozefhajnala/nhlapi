context("nhl_url_players_allseasons")

testthat::test_that(
  "nhl_url_players_allseasons generates for 2 players",
  testthat::expect_equal(
    nhl_url_players_allseasons(c(8477474, 8477475)),
    paste0(
      baseurl,
      c(
        "people/8477474/stats?stats=yearByYear",
        "people/8477475/stats?stats=yearByYear"
      )
    )
  )
)
