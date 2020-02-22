context("nhl_url_add_suffixes")

testthat::test_that(
  "Add 1 suffix to 1 url",
  testthat::expect_equal(
    nhl_url_add_suffixes(endpointurls[1L], "1"),
    paste0(baseurl, "people/1")
  )
)

testthat::test_that(
  "Add 1 suffix to 2 urls",
  testthat::expect_equal(
    nhl_url_add_suffixes(endpointurls, "1"),
    paste0(baseurl, c("people/1", "teams/1"))
  )
)

testthat::test_that(
  "Add 2 suffixes to 2 urls",
  testthat::expect_equal(
    nhl_url_add_suffixes(endpointurls, suffixes = list(c(1, 2))),
    paste0(baseurl, c("people/1", "teams/1", "people/2", "teams/2"))
  )
)

testthat::test_that(
  "Add complex suffixes to 1 url",
  testthat::expect_equal(
    nhl_url_add_suffixes(
      endpointurls[1L],
      suffixes = list(c(1, 2), c("stats", "some"))
    ),
    paste0(
      baseurl,
      c(
        "people/1/stats", "people/2/stats",
        "people/1/some", "people/2/some"
      )
    )
  )
)

testthat::test_that(
  "Add complex suffixes to 2 urls",
  testthat::expect_equal(
    nhl_url_add_suffixes(
      endpointurls,
      suffixes = list(c(1, 2), c("stats", "some"))
    ),
    paste0(baseurl, c(
      "people/1/stats", "teams/1/stats",
      "people/2/stats", "teams/2/stats",
      "people/1/some", "teams/1/some",
      "people/2/some", "teams/2/some"
    ))
  )
)
