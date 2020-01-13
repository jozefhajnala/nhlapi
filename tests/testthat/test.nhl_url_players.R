context("nhl_url_player")

testthat::test_that(
  "nhl_url_player generates a player url",
  testthat::expect_equal(
    nhl_url_players(8477474),
    paste0(baseurl, "people/8477474")
  )
)

testthat::test_that(
  "nhl_url_player generates multiple player urls",
  testthat::expect_equal(
    nhl_url_players(c(8477474, 8477475)),
    paste0(baseurl, c("people/8477474", "people/8477475"))
  )
)
