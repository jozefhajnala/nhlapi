context("nhl_get_data")

testthat::test_that(
  "nhl_get_data retrieves player data", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_get_data(nhl_url_players(8451101L)),
      testplayers[[1L]]
    )
  }
)

testthat::test_that(
  "nhl_get_data returns try-error object", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      class(nhl_get_data("http://nonexisting.url", silent = TRUE)[[1L]]),
      "try-error"
    )
  }
)


context("nhl_get_datas")

testthat::test_that(
  "nhl_get_datas retrieves 2 players data", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::expect_equal(
      nhl_get_datas(nhl_url_players(c(8451101L, 8451033L))),
      testplayers
    )
  }
)
