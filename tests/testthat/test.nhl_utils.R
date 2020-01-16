context("nhl_make_seasons")

testthat::test_that(
  "nhl_make_seasons generates seasons correctly",
  testthat::expect_equal(
    nhl_make_seasons(1995:1997),
    c("19951996", "19961997", "19971998")
  )
)


context("util_flatten_list")

testthat::test_that(
  "util_flatten_list works on simple list",
  testthat::expect_equal(
    util_flatten_list(list(a = 1L, b = list(1, list(2L, TRUE)))),
    data.frame(a = 1L, b1 = 1, b2 = 2L, b3 = TRUE)
  )
)


context("util_process_copyright")

testthat::test_that(
  "util_process_copyright works on simple list",
  testthat::expect_equal(
    names(util_process_copyright(testplayers[[1L]])),
    "people"
  )
)


context("util_rbindlist")

testthat::test_that(
  "util_rbindlist works with fill=FALSE",
  testthat::expect_equal(
    util_rbindlist(list(mtcars, mtcars), fill = FALSE),
    do.call(rbind, list(mtcars, mtcars))
  )
)

testthat::test_that(
  "util_rbindlist works on data frames with same columns",
  testthat::expect_equal(
    util_rbindlist(list(mtcars, mtcars)),
    do.call(rbind, list(mtcars, mtcars))
  )
)

testthat::test_that(
  "util_rbindlist works on data frames with different columns",
  testthat::expect_equal(
    util_rbindlist(list(mtcars[1, 2:3], mtcars[2, 4:5])),
    data.frame(
      cyl = c(6, NA),
      disp = c(160, NA),
      hp = c(NA,  110),
      drat = c(NA, 3.9)
    )
  )
)


context("util_attributes_to_cols")

testthat::test_that(
  "util_attributes_to_cols works as intended",
  testthat::expect_equal(
    util_attributes_to_cols(
      lst = testplayers[[1L]],
      df = testplayers_processed[1L, ]
    ),
    testplayers_processed[1L, ]
  )
)
