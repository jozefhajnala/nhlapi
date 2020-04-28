message("\n\nRunning  testthat::test_dir")
Sys.setenv(NHLAPI_REMOTE_TESTS = "true")
pkgload::load_all(".")
testResults <- testthat::test_dir(
  path = "./tests/testthat",
  stop_on_failure = TRUE
)
