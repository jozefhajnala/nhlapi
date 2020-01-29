#' Get data from the API for 1 URL
#'
#' @description Gets data from the NHL API using `jsonlite`.
#'
#' @param url `character(1)`, the URL to get the data from.
#' @param flatten `logical(1)`, if `TRUE` (default) automatically
#'   flattens nested data frames into a single non-nested data frame.
#' @param silent `logical(1)`, passed to `try()`.
#'
#' @importFrom jsonlite fromJSON
#' @seealso [nhl_url()]
#'
#' @return `list` with the retrieved data or class `try-error`.
nhl_get_data_worker <- function(
  url,
  flatten = TRUE,
  silent = getOption("nhlapi_try_silent")
) {
  res <- try(
    jsonlite::fromJSON(url, flatten = flatten),
    silent = silent
  )
  if (inherits(res, "try-error")) {
    res <- list(res)
    class(res) <- append(class(res), "nhl_get_data_error")
  }
  attr(res, "url") <- url
  res
}

#' Get data from the API for multiple urls
#'
#' @param urls `character()`, vector of urls to retrieve
#'   the data from.
#' @inheritParams nhl_get_data_worker
#'
#' @return `list` of results retrieved using [nhl_get_data_worker()].
nhl_get_datas <- function(urls, flatten = TRUE) {
  res <- lapply(urls, nhl_get_data_worker, flatten = flatten)
  util_report_get_data_errors(res)
  res
}
