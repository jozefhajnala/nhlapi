context("nhl_process_results")

testthat::test_that(
  "nhl_process_results processes 2 teams",
  testthat::expect_equal(
    nhl_process_results(x = teams, elName = "teams"),
    teams_processed
  )
)

testthat::test_that(
  "Process 2 players",
  testthat::expect_equal(
    nhl_process_result(testplayers[[1L]], elName = "people"),
    testplayers_processed[1L, ]
  )
)

testthat::test_that(
  "Process 2 players",
  testthat::expect_equal(
    nhl_process_results(testplayers, elName = "people"),
    testplayers_processed
  )
)
