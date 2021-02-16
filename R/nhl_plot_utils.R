#' Plot an NHL rink
#'
#' @description Initialize a plot in base graphics with
#'   a to-scale NHL rink as the background
#' @details The placement of rink features & their sizes
#'   are exact according to the NHL rule book; see citation.
#' @export
#' @importFrom graphics lines polygon plot segments
#' @examples \dontrun{
#'   # Retrieve some game feed data
#'   gameFeeds <- lapply(
#'    2019010001:2019010010,
#'    nhlapi::nhl_games_feed
#'   )
#'
#'   # Create a data.frame with plays
#'   getPlaysDf <- function(gm) {
#'     playsRes <- try(gm[[1L]][["liveData"]][["plays"]][["allPlays"]])
#'     if (inherits(playsRes, "try-error")) data.frame() else playsRes
#'   }
#'   plays <- lapply(gameFeeds, getPlaysDf)
#'   plays <- nhlapi:::util_rbindlist(plays)
#'   plays <- plays[!is.na(plays$coordinates.x), ]
#'
#'   # Move the coordinates to non-negative values before plotting
#'   plays$coordx <- plays$coordinates.x + abs(min(plays$coordinates.x))
#'   plays$coordy <- plays$coordinates.y + abs(min(plays$coordinates.y))
#'
#'   # Select goals only
#'   goals <- plays[plays$result.event == "Goal", ]
#'
#'   # Create the plot and add goals
#'   nhlapi::plot_rink()
#'   points(goals$coordinates.x, goals$coordinates.y)
#' }
nhl_plot_rink <- function() {

  quadrants <- list(c(1, 1), c(1, -1), c(-1, -1), c(-1, 1))
  rink_width <- 200 / 2
  rink_height <- 85 / 2

  # blank plot with correct dimensions and aspect ratio
  plot(
    NA,
    xlim = c(-1, 1) * rink_width,
    ylim = c(-1, 1) * rink_height,
    asp = 1,
    bty = "n",
    axes = FALSE,
    xlab = "",
    ylab = ""
  )

  # Rink is symmetric by quadrant -- write code to plot one quadrant,
  # and then reflect it 4 times
  lapply(
    quadrants,
    plot_quadrant,
    quadrants = quadrants,
    rink_width = rink_width,
    rink_height = rink_height
  )

}

plot_quadrant <- function(
  multipliers,
  quadrants,
  rink_width,
  rink_height
) {

  # utils and constants
  ## dimensional constants
  end_width <- 11 # between goal line & end boards
  nzone_width <- 50 / 2 # width of neutral zone

  # between face-off dot & reference line
  # (goal line for D zone, center for N zone)
  dot_displacement <- 20

  # span between centers of face-off dots
  dot_y <- 44 / 2
  crease_width <- 8 / 2
  hash_width <- 2
  hash_delta_x <- (5 + 9 / 12) / 2
  trapezoid_width_small <- 22 / 2
  trapezoid_width_large <- 28 / 2
  board_radius <- 28
  faceoff_radius <- 15
  crease_radius <- 6
  dot_radius <- 1
  center_dot_radius <- 0.5
  ### where the curved portion of the boards begins
  board_curve_x <- rink_width - board_radius
  board_curve_y <- rink_height - board_radius
  ### where the goal line intersects the curved portion of the boards
  goal_x_coord <- rink_width - end_width

  sdst <- function(x, y) sqrt(x^2 - y^2)


  goal_y_coord <- board_curve_y + sdst(board_radius, board_radius - end_width)
  ### coordinates of the face-off dots
  dzone_dot_x <- rink_width - end_width - dot_displacement
  ### coordinates of the goal crease
  ### (end of straight line & angle where circle is truncated)
  crease_x_coord <- rink_width - end_width - sdst(crease_radius, crease_width)
  crease_theta <- asin(crease_width / crease_radius)
  ### where the hash marks meet the D zone circle
  hash_delta_y <- sdst(faceoff_radius, hash_delta_x)
  ## colors
  nhl_red <- "#cf142b"    # PMS 186
  nhl_blue <- "#0033ab"   # PMS 286
  nhl_crease <- "#41b6e6" # PSM 298

  # simplest way I could come up with to go from multipliers -> quadrants,
  #  to use to get the arc endpoints for circular segments (e.g.
  #  the end boards go from 0 to pi/2 in quadrant 0, pi/2 to pi in quadrant 1
  #  there may be something with asin & acos that can be applied to +/-1
  #  but it was tantalizingly out of reach.
  get_quadrant <- function(x) {
    switch(
      paste(x, collapse = ""),
      "11" = 0,
      "-11" = 1,
      "-1-1" = 2,
      "1-1" = 3
    )
  }
  # a circle
  plot_circle <- function(h, k, r, ...) {
    tgrid <- seq(0, 2 * pi, length.out = 100L)
    lines(h + r * cos(tgrid), k + r * sin(tgrid), ...)
  }
  # a filled circle
  plot_filled_circle <- function(h, k, r, ...) {
    tgrid <- seq(0, 2 * pi, length.out = 100L)
    polygon(h + r * cos(tgrid), k + r * sin(tgrid), border = NA, ...)
  }
  # a circular arc between angles (in radians) t0 and t1
  plot_circle_arc <- function(h, k, r, t0, t1, ...) {
    tgrid <- seq(t0, t1, length.out = 100L)
    lines(h + r * cos(tgrid), k + r * sin(tgrid), ...)
  }
  # a filled arc between angles (in radians) t0 and t1
  plot_sector <- function(h, k, r, t0, t1, ...) {
    tgrid <- seq(t0, t1, length.out = 100L)
    polygon(
      h + c(0, r * cos(tgrid), 0),
      k + c(0, r * sin(tgrid), 0),
      border = NA,
      ...
    )
  }

  xmult <- multipliers[1L]
  ymult <- multipliers[2L]
  quadrant <- get_quadrant(multipliers)
  is_even_quad <- quadrant %% 2 == 0
  theta0 <- quadrant * pi / 2
  theta1 <- theta0 + pi / 2
  # for the goal crease, which is not a 1/4 circle
  alpha0 <- if (xmult == 1) pi else 0
  alpha1 <- alpha0 + (if (is_even_quad) 1 else -1) * crease_theta

  # add boards (circle for arced portion)
  #   nice about segments -- defaults to being horizontal in one direction
  segments(0, ymult * rink_height, xmult * board_curve_x)
  segments(xmult * rink_width, ymult * board_curve_y, y1 = 0)
  plot_circle_arc(
    xmult * board_curve_x,
    ymult * board_curve_y,
    board_radius,
    theta0,
    theta1
  )

  # add center, goal & zone lines
  if (is_even_quad) segments(0, 0, y1 = ymult * rink_height, col = nhl_red)
  segments(xmult * goal_x_coord, 0, y1 = ymult * goal_y_coord, col = nhl_red)
  segments(xmult * nzone_width, 0, y1 = ymult * rink_height, col = nhl_blue)

  # add face-off circles
  plot_circle_arc(0, 0, faceoff_radius, theta0, theta1, col = nhl_blue)
  plot_circle(xmult * dzone_dot_x, ymult * dot_y, faceoff_radius, col = nhl_red)

  # add hash marks to defensive circles
  for (submult in quadrants) {
    y0 <- ymult * dot_y + submult[2L] * hash_delta_y
    segments(
      xmult * dzone_dot_x + submult[1L] * hash_delta_x,
      y0,
      y1 = y0 + submult[2L] * hash_width,
      col = nhl_red
    )
  }

  # add face-off dots
  plot_sector(
    0,
    0,
    center_dot_radius,
    theta0,
    theta1,
    col = nhl_blue
  )

  plot_filled_circle(
    xmult * dzone_dot_x,
    ymult * dot_y,
    dot_radius,
    col = nhl_red
  )

  plot_filled_circle(
    xmult * dot_displacement,
    ymult * dot_y,
    dot_radius,
    col = nhl_red
  )

  # add goal creases
  # "paint" the crease before the lines for proper layering
  polygon(
    xmult * c(rep(goal_x_coord, 2L), crease_x_coord),
    ymult * c(0, rep(crease_width, 2L)),
    col = nhl_crease,
    border = NA
  )

  ## straight portion orthogonal to goal line
  segments(
    xmult * goal_x_coord,
    ymult * crease_width,
    xmult * crease_x_coord,
    col = nhl_red
  )

  ## arced portion truncated at intersection with straight portion
  plot_circle_arc(
    xmult * goal_x_coord,
    0,
    crease_radius,
    alpha0,
    alpha1,
    col = nhl_red
  )

  plot_sector(
    xmult * goal_x_coord,
    0,
    crease_radius,
    alpha0,
    alpha1,
    col = nhl_crease
  )

  # add trapezoid
  segments(
    xmult * goal_x_coord,
    ymult * trapezoid_width_small,
    xmult * rink_width,
    ymult * trapezoid_width_large,
    col = nhl_red
  )

}
