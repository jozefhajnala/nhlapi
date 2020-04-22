context("nhl_tournaments")

testthat::test_that(
  "nhl_tournaments_playoffs has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    res <- nhl_tournaments_playoffs(2015L)[[1L]]
    testthat::expect_true(all(is.element(
      c("copyright", "id", "name", "season", "defaultRound", "rounds"),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_tournaments_olympics has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    res <- nhl_tournaments_olympics(2009)[[1L]]
    testthat::expect_true(all(is.element(
      c("copyright", "id", "name", "season"),
      names(res)
    )))
  }
)

testthat::test_that(
  "nhl_tournaments_worldcups has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    res <- nhl_tournaments_worldcups(2003L)[[1L]]
    testthat::expect_true(all(is.element(
      c("copyright", "id", "name", "season", "rounds"),
      names(res)
    )))
  }
)
