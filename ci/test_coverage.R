message("\n\nRunning package_coverage()")
Sys.setenv(NHLAPI_REMOTE_TESTS = "true")
Sys.setenv(NHLAPI_SELECTED_TESTS = "true")
coverage <- covr::package_coverage(path = ".", quiet = FALSE)

message("\nPrinting package_coverage")
print(coverage)

message("\nPublishing package_coverage")
covr::codecov(
  coverage = coverage,
  token = Sys.getenv("NHLAPI_TOKEN_CODECOV")
)

message("\nDone.\n")
