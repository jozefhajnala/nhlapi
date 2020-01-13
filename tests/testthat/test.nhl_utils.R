context("nhl_make_seasons")

testthat::test_that(
  "nhl_make_seasons generates seasons correctly",
  testthat::expect_equal(
    nhl_make_seasons(1995:1997),
    c("19951996", "19961997", "19971998")
  )
)
