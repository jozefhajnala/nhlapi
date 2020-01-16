baseurl <- getOption("nhlapi_baseurl")
endpointurls <- paste0(baseurl, c("people", "teams"))

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
          primaryPosition = structure(
            list(
              code = "C",
              name = "Center",
              type = "Forward",
              abbreviation = "C"
            ),
            .Names = c("code", "name", "type", "abbreviation"),
            class = "data.frame",
            row.names = 1L
          )
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
          "primaryPosition"
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
          primaryPosition = structure(
            list(
              code = "G",
              name = "Goalie",
              type = "Goalie",
              abbreviation = "G"
            ),
            .Names = c("code", "name", "type", "abbreviation"),
            class = "data.frame",
            row.names = 1L
          )
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
          "primaryPosition"
        ),
        class = "data.frame",
        row.names = 1L
      )
    ),
    .Names = c("copyright", "people"),
    url = "https://statsapi.web.nhl.com/api/v1/people/8451033"
  )
)
