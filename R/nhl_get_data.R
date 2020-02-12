#' Get data from the API for 1 URL
#'
#' @description Gets data from the NHL API using `jsonlite`.
#'
#' @inheritParams nhl_from_json
#' @seealso [nhl_url()]
#'
#' @return `list` with the retrieved data or class `nhl_get_data_error`.
nhl_get_data_worker <- function(
  url,
  flatten = getOption("nhlapi_flatten"),
  silent = getOption("nhlapi_try_silent"),
  retries = getOption("nhlapi_get_retries"),
  retrySleep = getOption("nhlapi_get_retry_sleep")
) {
  log_i(url)
  res <- nhl_from_json(
    url = url,
    flatten = flatten,
    silent = silent,
    retries = retries,
    retrySleep = retrySleep
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
#' @export
#'
#' @return `list` of results retrieved using [nhl_get_data_worker()].
nhl_get_data <- function(urls, flatten = getOption("nhlapi_flatten")) {
  res <- lapply(urls, nhl_get_data_worker, flatten = flatten)
  util_report_get_data_errors(res)
  res
}


#' Get URL using fromJSON
#'
#' @param url `character(1)`, the URL to get the data from.
#' @param flatten `logical(1)`, if `TRUE` (default) automatically
#'   flattens nested data frames into a single non-nested data frame.
#' @param silent `logical(1)`, passed to `try()`.
#' @param retries `integer(1)`, number of retries in case of failed
#'   data retrieval (`0L` for no no retries).
#' @param retrySleep `integer(1)`, number of seconds to `Sys.sleep()`
#'   in between retries.
#'
#' @importFrom jsonlite fromJSON
#'
#' @return retrieved data if succeeded, or a `try-error` class object
#'   otherwise.
nhl_from_json <- function(
  url,
  flatten = getOption("nhlapi_flatten"),
  silent = getOption("nhlapi_try_silent"),
  retries = getOption("nhlapi_get_retries"),
  retrySleep = getOption("nhlapi_get_retry_sleep")
) {
  attempt <- 0L
  failed <- TRUE
  while (attempt <= retries && isTRUE(failed)) {
    if (attempt > 0L) Sys.sleep(retrySleep)
    res <- try(
      jsonlite::fromJSON(url, flatten = flatten),
      silent = silent
    )
    failed <- inherits(res, "try-error")
    attempt <- attempt + 1L
  }
  res
}
