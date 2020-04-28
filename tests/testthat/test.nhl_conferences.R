context("nhl_divisions")

testthat::test_that(
  "nhl_divisions work even with empty data returned", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    testthat::expect_equal(
      nhl_conferences(1:2),
      conferences_done
    )
  }
)
