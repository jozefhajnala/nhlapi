context("make_log")

testthat::test_that(
  "Default make_log works",
  testthat::expect_true(
    grepl("dummy", make_log("dummy"))
  )
)

testthat::test_that(
  "make_Log works with endNewLine",
  testthat::expect_true(
    grepl("\n$", make_log("dummy", endNewLine = TRUE))
  )
)

testthat::test_that(
  "make_Log works with newLine",
  testthat::expect_true(
    grepl("^\n", make_log("dummy", newLine = TRUE))
  )
)

testthat::test_that(
  "emit_log is silent when it should be",
  testthat::expect_equal(
    capture.output(
      emit_log("test", lvl = 30, trh = 40),
      type = "message"
    ),
    character(0)
  )
)

testthat::test_that(
  "emit_log logs when it should",
  testthat::expect_message(
    emit_log("test", lvl = 30, trh = 0),
    "test"
  )
)

testthat::test_that(
  "log_i works", {
    optVal <- getOption("nhlapi_log_threshold")
    options(nhlapi_log_threshold = 0L)
    expect_message(
      log_i("test"),
      "test"
    )
    options(nhlapi_log_threshold = optVal)
  }
)
