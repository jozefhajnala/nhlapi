context("nhl_url_players_stats")

testthat::test_that(
  "nhl_url_players_stats generates 1 player url",
  testthat::expect_equal(
    nhl_url_players_stats(8477474),
    paste0(
      baseurl,
      "people/8477474/stats"
    )
  )
)

testthat::test_that(
  "nhl_url_players_stats generates 2 player url",
  testthat::expect_equal(
    nhl_url_players_stats(c(8477474, 8477475)),
    paste0(
      baseurl,
      c("people/8477474/stats", "people/8477475/stats")
    )
  )
)
