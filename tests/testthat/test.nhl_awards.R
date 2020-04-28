context("nhl_awards")

testthat::test_that(
  "nhl_awards has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    res <- nhl_awards(1:3)
    testthat::expect_equal(
      names(res),
      c(
        "name", "shortName", "description",
        "recipientType", "history", "imageUrl",
        "homePageUrl", "link", "url", "copyright"
      )
    )
  }
)
