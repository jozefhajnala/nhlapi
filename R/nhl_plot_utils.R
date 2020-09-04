#' Plot an NHL rink
#' @description Initialize a plot in base graphics with a to-scale NHL rink as the background
#' @details The placement of rink features & their sizes are exact according to the NHL rulebook; see citation.
#' @references \url{https://nhl.bamcontent.com/images/assets/binary/308893668/binary-file/file.pdf}
#' @export
plot_rink = function() {
  # blank plot with correct dimensions and aspect ratio
  plot(NA, xlim=c(-1, 1)*.5*rink_width, ylim=c(-1, 1)*.5*rink_height,
       asp=1, bty='n', axes=FALSE, xlab='', ylab='')
  # add straight boards
  plot_symm_hseg(board_curve_x, rink_height/2)
  plot_symm_hseg(board_curve_x, -rink_height/2)
  plot_symm_vseg(-rink_width/2, board_curve_y)
  plot_symm_vseg(rink_width/2, board_curve_y)

  # add arced boards
  plot_circle_arc(-board_curve_x, board_curve_y, board_radius, pi/2, pi)
  plot_circle_arc(board_curve_x, board_curve_y, board_radius, 0, pi/2)
  plot_circle_arc(board_curve_x, -board_curve_y, board_radius, -pi/2, 0)
  plot_circle_arc(-board_curve_x, -board_curve_y, board_radius, -pi/2, -pi)

  # add center, goal & zone lines
  plot_symm_vseg(0, rink_height/2, col=nhl_red)
  plot_symm_vseg(-goal_x_coord, goal_y_coord, col=nhl_red)
  plot_symm_vseg(goal_x_coord,  goal_y_coord, col=nhl_red)
  plot_symm_vseg(-nzone_width/2, rink_height/2, col=nhl_blue)
  plot_symm_vseg(nzone_width/2,  rink_height/2, col=nhl_blue)

  # add faceoff circles
  plot_circle(0, 0, faceoff_radius, col=nhl_blue)
  plot_circle(-dzone_dot_x, dot_y,  faceoff_radius, col=nhl_red)
  plot_circle(dzone_dot_x, dot_y,   faceoff_radius, col=nhl_red)
  plot_circle(dzone_dot_x, -dot_y,  faceoff_radius, col=nhl_red)
  plot_circle(-dzone_dot_x, -dot_y, faceoff_radius, col=nhl_red)

  # add faceoff dots
  ## within circles
  plot_filled_circle(0, 0, .5, col=nhl_blue)
  plot_filled_circle(-dzone_dot_x, dot_y,  dot_radius, col=nhl_red)
  plot_filled_circle(dzone_dot_x, dot_y,   dot_radius, col=nhl_red)
  plot_filled_circle(dzone_dot_x, -dot_y,  dot_radius, col=nhl_red)
  plot_filled_circle(-dzone_dot_x, -dot_y, dot_radius, col=nhl_red)

  ## neutral zone
  plot_filled_circle(-dot_displacement, dot_y,  dot_radius, col=nhl_red)
  plot_filled_circle(dot_displacement, dot_y,   dot_radius, col=nhl_red)
  plot_filled_circle(dot_displacement, -dot_y,  dot_radius, col=nhl_red)
  plot_filled_circle(-dot_displacement, -dot_y, dot_radius, col=nhl_red)

  # add goal creases
  ## straight portion orthogonal to goal line
  lines(c(-goal_x_coord, crease_x_coord), c(crease_width/2, crease_width/2),  col=nhl_red)
  lines(c(-goal_x_coord, crease_x_coord), -c(crease_width/2, crease_width/2), col=nhl_red)
  lines(c(goal_x_coord, -crease_x_coord), c(crease_width/2, crease_width/2),  col=nhl_red)
  lines(c(goal_x_coord, -crease_x_coord), -c(crease_width/2, crease_width/2), col=nhl_red)

  ## arced portion truncated at intersection with straight portion
  plot_circle_arc(-goal_x_coord, 0, crease_radius, -crease_theta, crease_theta, col=nhl_red)
  plot_circle_arc(goal_x_coord, 0, crease_radius, pi-crease_theta, pi+crease_theta, col=nhl_red)
}

# utils/constants
## dimensional constants
rink_width = 200
rink_height = 85
end_width = 11 # between goal line & end boards
nzone_width = 50 # width of neutral zone
dot_displacement = 20 # between faceoff dot & reference line (goal line for D zone, center for N zone)
dot_span = 44 # span between centers of faceoff dots
crease_width = 8
board_radius = 28
faceoff_radius = 15
crease_radius = 6
dot_radius = 1
center_dot_radius = .5
### where the curved portion of the boards begins
board_curve_x = rink_width/2 - board_radius
board_curve_y = rink_height/2 - board_radius
### where the goal line intersects the curved portion of the boards
goal_x_coord = rink_width/2 - end_width
goal_y_coord = board_curve_y + sqrt(board_radius^2 - (board_radius-end_width)^2)
### coordinates of the faceoff dots
dzone_dot_x = rink_width/2 - end_width - dot_displacement
dot_y = dot_span/2
### coordinates of the goal crease (end of straight line & angle where circle is truncated)
crease_x_coord = -rink_width/2 + end_width + sqrt(crease_radius^2-(crease_width/2)^2)
crease_theta = asin(crease_width/2/crease_radius)
## colors
nhl_red = '#cf142b'  # PMS 186
nhl_blue = '#0033ab' # PMS 286
# a vertical segment symmetric about 0
plot_symm_vseg = function(x, y, ...) lines(c(x, x), c(-y, y), ...)
# a horizontal segment symmetric about 0
plot_symm_hseg = function(x, y, ...) lines(c(-x, x), c(y, y), ...)
# a circle
plot_circle = function(h, k, r, ...) {
  tgrid = seq(0, 2*pi, length.out = 100L)
  lines(h + r*cos(tgrid), k + r*sin(tgrid), ...)
}
# a filled circle
plot_filled_circle = function(h, k, r, ...) {
  tgrid = seq(0, 2*pi, length.out = 100L)
  polygon(h + r*cos(tgrid), k + r*sin(tgrid), border = NA, ...)
}
# a circular arc between angles (in radians) t0 and t1
plot_circle_arc = function(h, k, r, t0, t1, ...) {
  tgrid = seq(t0, t1, length.out = 100L)
  xseq = h + r*cos(tgrid)
  yseq = k + r*sin(tgrid)
  lines(xseq, yseq, ...)
}
