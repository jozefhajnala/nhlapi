context("nhl_drafts")

testthat::test_that(
  "nhl_drafts has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_drafts(2000L)
    testthat::expect_equal(
      names(res),
      c("draftYear", "rounds", "url", "copyright")
    )
  }
)
