context("nhl_get_data_worker")

testthat::test_that(
  "nhl_get_data retrieves player data", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    testthat::expect_equal(
      nhl_get_data_worker(nhl_url_players(8451101L)),
      testplayers[[1L]]
    )
  }
)

testthat::test_that(
  "nhl_get_data returns try-error object", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    testthat::expect_equal(
      class(nhl_get_data_worker("http://nonexisting.url", silent = TRUE)[[1L]]),
      "try-error"
    )
  }
)


context("nhl_get_data")

testthat::test_that(
  "nhl_get_data retrieves 2 players data", {
    testthat::skip_if_offline(host = "nhl.com")
    testthat::skip_if(skipRemoteTests)

    testthat::expect_equal(
      nhl_get_data(nhl_url_players(c(8451101L, 8451033L))),
      testplayers
    )
  }
)


context("nhl_from_json work with successes")

testthat::test_that(
  "nhl_from_json", {
    testthat::with_mock(
      "jsonlite::fromJSON" = function(...) TRUE,
      testthat::expect_true(nhl_from_json("test"))
    )
  }
)

testthat::test_that(
  "nhl_from_json", {
    testthat::with_mock(
      "jsonlite::fromJSON" = function(...) stop("I must fail."),
      testthat::expect_s3_class(
        nhl_from_json("test", silent = TRUE, retries = 0, retrySleep = 0),
        "try-error"
      )
    )
  }
)

testthat::test_that(
  "nhl_from_json retries and fails n times", {
    testthat::with_mock(
      "jsonlite::fromJSON" = function(...) stop("I failed.", call. = FALSE),
      expect_equal(
        capture.output(
          invisible(
            nhl_from_json("test", silent = FALSE, retries = 1, retrySleep = 0)
          ),
          type = "message"
        ),
        rep("Error : I failed.", 2)
      )
    )
  }
)

testthat::test_that(
  "nhl_from_json retries then succeeds", {
    testenv <- new.env()
    testthat::with_mock(
      "jsonlite::fromJSON" = function(...) {
        # Should give TRUE 1st and 2nd time, FALSE 3rd called
        thisOutcome <- get("outcome", envir = testenv)
        assign("outcome", thisOutcome[-1L], envir = testenv)
        if (thisOutcome[1L]) stop("I failed.", call. = FALSE) else TRUE
      }, {
        assign("outcome", c(TRUE, TRUE, FALSE), envir = testenv)
        expect_true(
          nhl_from_json("test", silent = TRUE, retries = 2, retrySleep = 0)
        )
        assign("outcome", c(TRUE, TRUE, FALSE), envir = testenv)
        expect_true(
          nhl_from_json("test", silent = TRUE, retries = 5, retrySleep = 0)
        )
        assign("outcome", c(TRUE, TRUE, FALSE), envir = testenv)
        expect_s3_class(
          nhl_from_json("test", silent = TRUE, retries = 0, retrySleep = 0),
          "try-error"
        )
        assign("outcome", c(TRUE, TRUE, FALSE), envir = testenv)
        expect_s3_class(
          nhl_from_json("test", silent = TRUE, retries = 1, retrySleep = 0),
          "try-error"
        )
        assign("outcome", c(TRUE, TRUE, FALSE), envir = testenv)
        expect_equal(
          capture.output(
            invisible(
              nhl_from_json("test", silent = FALSE, retries = 1, retrySleep = 0)
            ),
            type = "message"
          ),
          rep("Error : I failed.", 2)
        )
      }
    )
    rm(testenv)
  }
)

testthat::test_that(
  "nhl_from_json no retries for noRetryPatt, only for valid", {
    noRetryRes <- "HTTP error 400."
    doRetryRes <- "HTTP error 300."
    fullOutcome <- c(rep(doRetryRes, 4L), rep(noRetryRes, 6L))
    testenv <- new.env()
    testthat::with_mock(
      "jsonlite::fromJSON" = function(...) {
        # We want to retry for HTTP error 300, but not for 400
        thisOutcome <- get("outcome", envir = testenv)
        assign("outcome", thisOutcome[-1L], envir = testenv)
        stop(thisOutcome[[1L]], call. = FALSE)
      }, {
        assign("outcome", fullOutcome, envir = testenv)
        expect_equal(
          capture.output(
            invisible(
              nhl_from_json(
                "test",
                silent = FALSE, retries = 9, retrySleep = 0,
                noRetryPatt = "HTTP error 404|HTTP error 400"
              )
            ),
            type = "message"
          ),
          c(rep("Error : HTTP error 300.", 4L), "Error : HTTP error 400.")
        )
      }
    )
    rm(testenv)
  }
)
