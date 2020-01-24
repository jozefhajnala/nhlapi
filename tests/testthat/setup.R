baseurl <- getOption("nhlapi_baseurl")
endpointurls <- paste0(baseurl, c("people", "teams"))
playerIds <- c("some", "8451101", 8451033L, "wrong")
seasonsPlayerIds <- c(8449231,  "wrong", 8450183, "none")
seasons <- c("19951996", "19961997")

copyright <- paste(
  "NHL and the NHL Shield are registered trademarks",
  "of the National Hockey League.",
  "NHL and NHL team marks are the property of the NHL and its teams.",
  "© NHL 2020. All Rights Reserved."
)

testplayers <- list(
  structure(
    list(
      copyright = paste(
        "NHL and the NHL Shield are registered trademarks",
        "of the National Hockey League.",
        "NHL and NHL team marks are the property of the NHL and its teams.",
        "© NHL 2020. All Rights Reserved."
      ),
      people = structure(
        list(
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
          primaryPosition.abbreviation = "C"
        ),
        .Names = c(
          "id",
          "fullName",
          "link",
          "firstName",
          "lastName",
          "primaryNumber",
          "birthDate",
          "birthCity",
          "birthStateProvince",
          "birthCountry",
          "nationality",
          "height",
          "weight",
          "active",
          "rookie",
          "shootsCatches",
          "rosterStatus",
          "primaryPosition.code",
          "primaryPosition.name",
          "primaryPosition.type",
          "primaryPosition.abbreviation"
        ),
        class = "data.frame",
        row.names = 1L
      )
    ),
    .Names = c("copyright", "people"),
    url = "https://statsapi.web.nhl.com/api/v1/people/8451101"
  ),
  structure(
    list(
      copyright = paste(
        "NHL and the NHL Shield are registered trademarks",
        "of the National Hockey League.",
        "NHL and NHL team marks are the property of the NHL and its teams.",
        "© NHL 2020. All Rights Reserved."
      ),
      people = structure(
        list(
          id = 8451033L,
          fullName = "Patrick Roy",
          link = "/api/v1/people/8451033",
          firstName = "Patrick",
          lastName = "Roy",
          primaryNumber = "33",
          birthDate = "1965-10-05",
          birthCity = "Quebec",
          birthStateProvince = "QC",
          birthCountry = "CAN",
          nationality = "CAN",
          height = "6' 2\"",
          weight = 190L,
          active = FALSE,
          rookie = FALSE,
          shootsCatches = "L",
          rosterStatus = "N",
          primaryPosition.code = "G",
          primaryPosition.name = "Goalie",
          primaryPosition.type = "Goalie",
          primaryPosition.abbreviation = "G"
        ),
        .Names = c(
          "id",
          "fullName",
          "link",
          "firstName",
          "lastName",
          "primaryNumber",
          "birthDate",
          "birthCity",
          "birthStateProvince",
          "birthCountry",
          "nationality",
          "height",
          "weight",
          "active",
          "rookie",
          "shootsCatches",
          "rosterStatus",
          "primaryPosition.code",
          "primaryPosition.name",
          "primaryPosition.type",
          "primaryPosition.abbreviation"
        ),
        class = "data.frame",
        row.names = 1L
      )
    ),
    .Names = c("copyright", "people"),
    url = "https://statsapi.web.nhl.com/api/v1/people/8451033"
  )
)


testplayers_processed <- data.frame(
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
  url = c(
    "https://statsapi.web.nhl.com/api/v1/people/8451101",
    "https://statsapi.web.nhl.com/api/v1/people/8451033"
  ),
  copyright = paste(
    "NHL and the NHL Shield are registered trademarks",
    "of the National Hockey League.",
    "NHL and NHL team marks are the property of the NHL and its teams.",
    "© NHL 2020. All Rights Reserved."
  ),
  stringsAsFactors = FALSE
)

testdatawitherrors <- list(
  testplayers[1],
  structure(
    list(
      structure(
        "Error in open.connection(con, \"rb\") : HTTP error 400.\n",
        class = "try-error",
        condition = structure(
          list(message = "HTTP error 400."),
          .Names = c("message"),
          class = c("simpleError", "error", "condition")
        )
      )
    ),
    class = c("list", "nhl_get_data_error"),
    url = "https://statsapi.web.nhl.com/api/v1/people/none"
  ),
  structure(
    list(
      structure(
        "Error in open.connection(con, \"rb\") : HTTP error 400.\n",
        class = "try-error",
        condition = structure(
          list(message = "HTTP error 400."),
          .Names = c("message"),
          class = c("simpleError", "error", "condition")
        )
      )
    ),
    class = c("list", "nhl_get_data_error"),
    url = "https://statsapi.web.nhl.com/api/v1/people/some"
  )
)


retrievedplayersallseasons <- data.frame(
  season = c(
    "19131914",
    "19131914",
    "19131914",
    "19141915",
    "19151916",
    "19161917",
    "19171918",
    "18931894",
    "18941895",
    "18951896",
    "18961897",
    "18971898",
    "18981899",
    "18991900",
    "19001901"
  ),
  sequenceNumber = c(
    1L, 2L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L
  ),
  stat.timeOnIce = c(
    0,
    0,
    0,
    NA,
    NA,
    NA,
    NA,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ),
  stat.assists = c(
    0L, 0L, 3L, 0L, 0L, 0L, 0L, NA, NA, NA, 0L, 0L, 0L, 0L, 0L
  ),
  stat.goals = c(
    7L, 0L, 0L, 14L, 8L, 1L, 0L, NA, NA, NA, 2L, 6L, 8L, 13L, 10L
  ),
  stat.pim = c(
    15L, 0L, NA, 9L, 6L, 8L, 0L, NA, NA, NA, NA, NA, NA, NA, NA
  ),
  stat.games = c(
    10L, 1L, 3L, 11L, 10L, 14L, 1L, NA, NA, NA, 2L, 2L, 8L, 7L, 8L
  ),
  stat.penaltyMinutes = c(
    "15", "0", NA, "9", "6", "8", "0", NA, NA, NA, NA, NA, NA, NA, NA
  ),
  stat.points = c(
    7L, 0L, 3L, 14L, 8L, 1L, 0L, NA, NA, NA, 2L, 6L, 8L, 13L, 10L
  ),
  stat.gameWinningGoals = c(
    NA, NA, NA, NA, NA, NA, 0L, NA, NA, NA, NA, NA, NA, NA, NA
  ),
  stat.overTimeGoals = c(
    NA, NA, NA, NA, NA, NA, 0L, NA, NA, NA, NA, NA, NA, NA, NA
  ),
  team.name = c(
    "Mtl. HLP",
    "Mtl. Shamrocks",
    "Laval U.",
    "All-Montreal",
    "Laval U.",
    "Mtl. Wanderers",
    "Montreal Wanderers",
    "Mtl. St. Mary's",
    "Mtl. St. Mary's",
    "Mtl. St. Mary's",
    "Mtl. Shamrocks",
    "Berlin HC",
    "Mtl. Shamrocks",
    "Mtl. Shamrocks",
    "Mtl. Shamrocks"
  ),
  team.link = c(
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/41",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null",
    "/api/v1/teams/null"
  ),
  team.id = c(
    NA, NA, NA, NA, NA, NA, 41L, NA, NA, NA, NA, NA, NA, NA, NA
  ),
  league.name = c(
    "MTMHL",
    "MCHL",
    "MTMHL",
    "MCHL",
    "MCHL",
    "NHA",
    "National Hockey League",
    "AHAC-Jr",
    "AHAC-Jr",
    "AHAC-Jr",
    "AHAC",
    "OHA",
    "CAHL",
    "CAHL",
    "CAHL"
  ),
  league.link = c(
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/133",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null",
    "/api/v1/league/null"
  ),
  league.id = c(
    NA, NA, NA, NA, NA, NA, 133L, NA, NA, NA, NA, NA, NA, NA, NA
  ),
  url = c(
    rep(paste0(baseurl, "people/8449231/stats?stats=yearByYear"), 7),
    rep(paste0(baseurl, "people/8450183/stats?stats=yearByYear"), 8)
  ),
  copyright = rep(copyright, 15L),
  playerId = c(
    8449231L,
    8449231L,
    8449231L,
    8449231L,
    8449231L,
    8449231L,
    8449231L,
    8450183L,
    8450183L,
    8450183L,
    8450183L,
    8450183L,
    8450183L,
    8450183L,
    8450183L
  ),
  seasonStart = c(
    1913L, 1913L, 1913L, 1914L, 1915L, 1916L, 1917L, 1893L,
    1894L, 1895L, 1896L, 1897L, 1898L, 1899L, 1900L
  ),
  stat.powerPlayTimeOnIce = c(
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ),
  stat.evenTimeOnIce = c(
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ),
  stat.shortHandedTimeOnIce = c(
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ),
  stat.shifts = c(
    NA, NA, NA, NA, NA, NA, NA, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L
  ),
  stringsAsFactors = FALSE
)


testpl_processed_wattr <- testplayers_processed[1L, ]
attr(testpl_processed_wattr, "url") <-
  "https://statsapi.web.nhl.com/api/v1/people/8451101"


retrievedplayerplayoffs <- data.frame(
  season = "19951996",
  stat.assists = 16L,
  stat.goals = 18L,
  stat.pim = 14L,
  stat.shots = 98L,
  stat.games = 22L,
  stat.powerPlayGoals = 6L,
  stat.powerPlayPoints = 16L,
  stat.penaltyMinutes = "14",
  stat.shotPct = 18.4,
  stat.gameWinningGoals = 6L,
  stat.overTimeGoals = 2L,
  stat.shortHandedGoals = 0L,
  stat.shortHandedPoints = 0L,
  stat.plusMinus = 10L,
  stat.points = 34L,
  url = paste0(
    "https://statsapi.web.nhl.com/api/v1/people/",
    "8451101/stats?stats=statsSingleSeasonPlayoffs&season=19951996"
  ),
  copyright = paste(
    "NHL and the NHL Shield are registered trademarks",
    "of the National Hockey League.",
    "NHL and NHL team marks are the property of the NHL and its teams.",
    "© NHL 2020. All Rights Reserved."
  ),
  playerId = 8451101L,
  seasonStart = 1995L,
  stringsAsFactors = FALSE
)
