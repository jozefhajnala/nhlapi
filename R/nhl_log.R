#' Create a log message
#'
#' @param msg `character(1)`, to be logged.
#' @param ... additional `character()` strings to be logged. Will be
#'   pasted to `msg` and collapsed using the `collapse` argument.
#' @param type `character(1)` ideally 1 uppercase letter.
#' @param dtFormat `character(1)`, passed to format for `[Sys.time()]`
#' @param newLine `logical(1)`, if `TRUE`, new line will be pasted.
#'   to the beginning of the message.
#' @param sep `character(1) string`, to separate parts of the message.
#' @param collapse `character(1)`, to collapse `msg` and `...`.
#' @param lineBreak `character(1)`, replacing line breaks in `msg`.
#' @param endNewLine `logical(1)`, if `TRUE`, new line will be
#'   pasted to the end of the message.
#'
#' @return `character(1)`, constructed log message.
#'
#' @examples
#'   nhlapi:::make_log("Dummy warning", type = "W")
make_log <- function(
  msg, ..., type = "I", dtFormat = getOption("nhlapi_log_datetime"),
  newLine = FALSE, sep = " | ", collapse = " ", lineBreak = "$",
  endNewLine = FALSE
) {
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
