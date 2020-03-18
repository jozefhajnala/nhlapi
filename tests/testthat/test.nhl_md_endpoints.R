context("nhl_md_endpoints")

testthat::test_that(
  "nhl_md_game_types", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_game_types()
      ),
      paste0(getOption("nhlapi_baseurl"), "gameTypes")
    )
  }
)

testthat::test_that(
  "nhl_md_game_statuses", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_game_statuses()
      ),
      paste0(getOption("nhlapi_baseurl"), "gameStatus")
    )
  }
)

testthat::test_that(
  "nhl_md_play_types", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_play_types()
      ),
      paste0(getOption("nhlapi_baseurl"), "playTypes")
    )
  }
)

testthat::test_that(
  "nhl_md_tournament_types", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_tournament_types()
      ),
      paste0(getOption("nhlapi_baseurl"), "tournamentTypes")
    )
  }
)

testthat::test_that(
  "nhl_md_standings_types", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_standings_types()
      ),
      paste0(getOption("nhlapi_baseurl"), "standingsTypes")
    )
  }
)

testthat::test_that(
  "nhl_md_stat_types", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_stat_types()
      ),
      paste0(getOption("nhlapi_baseurl"), "statTypes")
    )
  }
)

testthat::test_that(
  "nhl_md_event_types", {
    testthat::expect_equal(
      testthat::with_mock(
        nhl_get_data = mock_identity,
        nhl_md_event_types()
      ),
      paste0(getOption("nhlapi_baseurl"), "eventTypes")
    )
  }
)
