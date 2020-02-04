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

testthat::test_that(
  "util_flatten_list returns a data frame for NULL",
  testthat::expect_equal(
    util_flatten_list(NULL),
    data.frame()
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

testthat::test_that(
  "util_rbindlist works with 0-row data.frames",
  testthat::expect_equal(
    util_rbindlist(list(data.frame(one = integer(0)), data.frame(two = 2))),
    data.frame(two = 2)
  )
)

testthat::test_that(
  "util_rbindlist works with 0-row 0-col data.frames",
  testthat::expect_equal(
    util_rbindlist(list(data.frame(), data.frame(two = 2))),
    data.frame(two = 2)
  )
)

context("util_inherit_attributes")

testthat::test_that(
  "util_inherit_attributes works as intended",
  testthat::expect_equal(
    util_inherit_attributes(
      src = testplayers[[1L]],
      tgt = testplayers_processed[1L, ]
    ),
    testpl_processed_wattr
  )
)


context("util_report_get_data_errors")

testthat::test_that(
  "util_report_get_data_errors returns correctly",
  testthat::expect_equal(
    util_report_get_data_errors(testdatawitherrors),
    c(
      "https://statsapi.web.nhl.com/api/v1/people/none",
      "https://statsapi.web.nhl.com/api/v1/people/some"
    )
  )
)

testthat::test_that(
  "util_report_get_data_errors uses reported message",
  testthat::expect_message(
    util_report_get_data_errors(testdatawitherrors, reporter = message),
    paste(
      "The following 2 of 3 url retrievals errored:",
      " https://statsapi.web.nhl.com/api/v1/people/none",
      " https://statsapi.web.nhl.com/api/v1/people/some",
      sep = "\n"
    )
  )
)

testthat::test_that(
  "util_report_get_data_errors uses reported message",
  testthat::expect_warning(
    util_report_get_data_errors(testdatawitherrors, reporter = warning),
    paste(
      "The following 2 of 3 url retrievals errored:",
      " https://statsapi.web.nhl.com/api/v1/people/none",
      " https://statsapi.web.nhl.com/api/v1/people/some",
      sep = "\n"
    )
  )
)


context("util_locate_get_data_errors")

testthat::test_that(
  "util_locate_get_data_errors works as intended",
  testthat::expect_equal(
    util_locate_get_data_errors(testdatawitherrors),
    c(FALSE, TRUE, TRUE)
  )
)


context("util_convert_minsonice")

testthat::test_that(
  "util_convert_minsonice",
  testthat::expect_equal(
    util_convert_minsonice(c("20:00", "1500:30", NA)),
    c(20, 1500.5, NA_real_)
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


context("util_md5sum_str")

testthat::test_that(
  "util_md5sum_str computes",
  testthat::expect_equal(
    util_md5sum_str("test"),
    "e2a3e68d23ce348b8f68b3079de3d4c9"
  )
)


context("util_map_player_id")

testthat::test_that(
  "util_map_player_id computes",
  testthat::expect_equal(
    util_map_player_id(
      "Joe Sakic",
      data.frame(
        nameMd5 = "9d2a915c8610dbc524c1bc800e010fcc",
        id = 1L,
        stringsAsFactors = FALSE
      )
    ),
    1L
  )
)

testthat::test_that(
  "util_map_player_id retuns NA for not found",
  testthat::expect_equal(
    util_map_player_id(
      "Not-exiting name",
      data.frame(
        nameMd5 = "bfa8adc1bf05dd7b8a3eeca6556d6930",
        id = 1L,
        stringsAsFactors = FALSE
      )
    ),
    NA_integer_
  )
)


context("util_map_player_ids")

testthat::test_that(
  "util_map_player_ids works",
  testthat::expect_equal(
    util_map_player_ids(
      c("joe sakic", "test", "peter Forsberg")
    ),
    c(
      "joe sakic" = 8451101L,
      "test" = NA_integer_,
      "peter Forsberg" = 8458520L
    )
  )
)


context("util_prepare_player_ids")

testthat::test_that(
  "Stop if playerNames not character",
  testthat::expect_error(
    util_prepare_player_ids(c(1, 2)),
    "playerNames must be a character vector."
  )
)

testthat::test_that(
  "Retrieve and skip NAs",
  testthat::expect_equal(
    util_prepare_player_ids(c("joe sakic", "fake player")),
    c("joe sakic" = 8451101L)
  )
)


context("util_generate_sysdata")

testthat::test_that(
  "sysdata.rda generated correctly for a player", {
    testthat::skip_if_offline(host = "nhl.com")
    tmpFile <- tempfile()
    res <- util_generate_sysdata(8444855L, tgtPath = tmpFile)
    load(tmpFile)
    testthat::expect_equal(
      res,
      hashedPlayers
    )
    unlink(tmpFile, force = TRUE)
  }
)
