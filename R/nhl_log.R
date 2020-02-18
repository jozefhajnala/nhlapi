#' Create a log message
#' @description Construct a nice log message
#' @param msg \code{character(1)} string to be logged
#' @param ... additional character strings to be logged (will be pasted to
#' \code{msg} and collapsed using the \code{collapse} argument)
#' @param type \code{character(1)} ideally 1 uppercase letter
#' @param dtFormat \code{character(1)} passed to format for Sys.time
#' @param newLine \code{logical(1)} if \code{TRUE}, newLine will be pasted
#' to the beginning of the message
#' @param sep \code{character(1)} string to separate parts of the message
#' @param collapse \code{character(1)} string to collapse \code{msg} and
#' \code{...}
#' @param lineBreak \code{character(1)} string to replace line breaks in
#' \code{msg}
#' @param endNewLine \code{logical(1)} if \code{TRUE}, newLine will be pasted
#' to the end of the message
#' @return \code{character(1)} constructed log message
#' @examples \dontrun{make_log("Dummy warning", type = "W")}
make_log <- function(
  msg, ..., type = "I", dtFormat = getOption("nhlapi_log_datetime"),
  newLine = FALSE, sep = " | ", collapse = " ", lineBreak = "$",
  endNewLine = FALSE
){
  msg <- paste(
    msg, paste(list(...), collapse = collapse),
    collapse = collapse
  )
  msg <- gsub("\n", lineBreak, msg)
  msg <- paste(
    format(Sys.time(), dtFormat),
    length(sys.calls()) - 3L,
    type, msg,
    sep = sep
  )
  if (isTRUE(newLine)) {
    msg <- paste("\n", msg, sep = "")
  }
  if (isTRUE(endNewLine)) {
    msg <- paste(msg, "\n", sep = "")
  }
  invisible(msg)
}

emit_log <- function(msg, lvl, trh = getOption("nhlapi_log_threshold")) {
  invisible(if (lvl > trh) message(msg))
}

log_d <- function(msg, ...) emit_log(make_log(msg, ..., type = "D"), 10L)
log_i <- function(msg, ...) emit_log(make_log(msg, ..., type = "I"), 20L)
log_w <- function(msg, ...) emit_log(make_log(msg, ..., type = "W"), 30L)
log_e <- function(msg, ...) emit_log(make_log(msg, ..., type = "E"), 40L)
