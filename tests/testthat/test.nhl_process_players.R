context("nhl_process_players")

testthat::test_that(
  "Process 2 players",
  testthat::expect_equal(
    nhl_process_players(testplayers),
    data.frame(
      id = c(8451101L, 8451033L),
      fullName = c("Joe Sakic", "Patrick Roy"),
      link = c("/api/v1/people/8451101", "/api/v1/people/8451033"),
      firstName = c("Joe", "Patrick"),
      lastName = c("Sakic", "Roy"),
      primaryNumber = c("19", "33"),
      birthDate = c("1969-07-07", "1965-10-05"),
      birthCity = c("Burnaby", "Quebec"),
      birthStateProvince = c("BC", "QC"),
      birthCountry = c("CAN", "CAN"),
      nationality = c("CAN", "CAN"),
      height = c("5' 11\"", "6' 2\""),
      weight = c(195L, 190L),
      active = c(FALSE, FALSE),
      rookie = c(FALSE, FALSE),
      shootsCatches = c("L", "L"),
      rosterStatus = c("I", "N"),
      primaryPosition.code = c("C", "G"),
      primaryPosition.name = c("Center", "Goalie"),
      primaryPosition.type = c("Forward", "Goalie"),
      primaryPosition.abbreviation = c("C", "G"),
      stringsAsFactors = FALSE
    )
  ))
