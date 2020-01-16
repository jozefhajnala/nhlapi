context("nhl_process_player")

testthat::test_that(
  "Process 2 player1",
  testthat::expect_equal(
    nhl_process_player(testplayers[[1L]]),
    data.frame(
      id = 8451101L,
      fullName = "Joe Sakic",
      link = "/api/v1/people/8451101",
      firstName = "Joe",
      lastName = "Sakic",
      primaryNumber = "19",
      birthDate = "1969-07-07",
      birthCity = "Burnaby",
      birthStateProvince = "BC",
      birthCountry = "CAN",
      nationality = "CAN",
      height = "5' 11\"",
      weight = 195L,
      active = FALSE,
      rookie = FALSE,
      shootsCatches = "L",
      rosterStatus = "I",
      primaryPosition.code = "C",
      primaryPosition.name = "Center",
      primaryPosition.type = "Forward",
      primaryPosition.abbreviation = "C",
      stringsAsFactors = FALSE
    )
  )
)
