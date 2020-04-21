context("nhl_url_draft_prospects")

testthat::test_that(
  "nhl_url_draft_prospects generates draft prospect url",
  testthat::expect_equal(
    nhl_url_draft_prospects(),
    paste0(baseurl, "draft/prospects")
  )
)

testthat::test_that(
  "nhl_url_teams generates single year draft prospect url",
  testthat::expect_equal(
    nhl_url_draft_prospects(1),
    paste0(baseurl, "draft/prospects/1")
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple draft prospect urls from character",
  testthat::expect_equal(
    nhl_url_draft_prospects(c("1", "2")),
    paste0(baseurl, c("draft/prospects/1", "draft/prospects/2"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple draft prospect urls from integer",
  testthat::expect_equal(
    nhl_url_draft_prospects(1:2),
    paste0(baseurl, c("draft/prospects/1", "draft/prospects/2"))
  )
)

testthat::test_that(
  "nhl_url_teams generates multiple draft prospect urls from numeric",
  testthat::expect_equal(
    nhl_url_draft_prospects(c(1.0, 2.0)),
    paste0(baseurl, c("draft/prospects/1", "draft/prospects/2"))
  )
)
