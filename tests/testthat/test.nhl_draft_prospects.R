context("nhl_draft_prospects")

testthat::test_that(
  "nhl_draft_prospects has correct names", {
    testthat::skip_if_offline(host = "nhl.com")
    res <- nhl_draft_prospects()
    testthat::expect_true(all(
      c(
        "id", "fullName", "link", "firstName", "lastName",
        "birthDate", "height", "weight", "shootsCatches",
        "draftStatus", "birthCountry", "birthCity",
        "birthStateProvince", "nationality", "nhlPlayerId"
      ) %in% names(res)
    ))
  }
)
