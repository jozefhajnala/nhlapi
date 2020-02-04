context("nhl_process_teams")

testthat::test_that(
  "nhl_process_teams processes 2 teams",
  testthat::expect_equal(
    nhl_process_teams(x = teams),
    teams_processed
  )
)
