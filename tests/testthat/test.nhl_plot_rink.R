context("plot_rink")

expect_image_equal <- function(object, expected, ...) {
  # compare svg character vs reference
  # helpers are defined in setup.R
  stopifnot(is.character(expected) && file.exists(expected))
  testthat::expect_equal(
    round_svg_numbers(ignore_svg_id(plot_image(object))),
    round_svg_numbers(ignore_svg_id(readLines(expected))),
    ...
  )
}

testthat::test_that(
  "Rink generated with plot_rink() is equal to prototype", {
    testthat::skip_if(skipSelectedTests)

    expect_image_equal(
      nhl_plot_rink(),
      "prototype/rink.svg"
    )
  }
)
