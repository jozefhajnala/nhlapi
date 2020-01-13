context("nhl_url")

testthat::test_that(
  "nhl_url generates base url",
  testthat::expect_equal(
    nhl_url(),
    baseurl
  )
)

testthat::test_that(
  "nhl_url generates url with suffix and params",
  testthat::expect_equal(
    nhl_url(
      endPoint = "people",
      suffixes = c("1", "stats"),
      params = list(stats = "statsSingleSeason", season = "20102011")
    ),
    paste0(
      baseurl,
      "people/1/stats?stats=statsSingleSeason&season=20102011"
    )
  )
)
