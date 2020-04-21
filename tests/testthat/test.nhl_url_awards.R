context("nhl_url_awards")

testthat::test_that(
  "nhl_url_awards generates award url",
  testthat::expect_equal(
    nhl_url_awards(),
    paste0(baseurl, "awards")
  )
)

testthat::test_that(
  "nhl_url_teams generates single year award url",
  testthat::expect_equal(
    nhl_url_awards(1),
    paste0(baseurl, "awards/1")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple award urls from character",
  testthat::expect_equal(
    nhl_url_awards(c("1", "2")),
    paste0(baseurl, c("awards/1", "awards/2"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple award urls from integer",
  testthat::expect_equal(
    nhl_url_awards(1:2),
    paste0(baseurl, c("awards/1", "awards/2"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple award urls from numeric",
  testthat::expect_equal(
    nhl_url_awards(c(1.0, 2.0)),
    paste0(baseurl, c("awards/1", "awards/2"))
  )
)
