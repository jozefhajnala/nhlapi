context("nhl_venues")

testthat::test_that(
  "nhl_venues has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    res <- nhl_venues()
    testthat::expect_equal(
      names(res),
      c("id", "name", "link", "appEnabled", "url", "copyright")
    )
  }
)
