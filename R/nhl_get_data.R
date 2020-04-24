#' Get URL using `fromJSON`
#'
#' @param url `character(1)`, the URL to get the data from.
#' @param flatten `logical(1)`, if `TRUE` (default) automatically
#'   flattens nested data frames into a single non-nested data frame.
#' @param silent `logical(1)`, passed to `try()`.
#' @param retries `integer(1)`, number of retries in case of failed
#'   data retrieval (`0L` for no no retries).
#' @param retrySleep `integer(1)`, number of seconds to `Sys.sleep()`
#'   in between retries.
#' @param noRetryPatt `character(1)`, string pattern. If the error
#'   condition's message contains this pattern, there will be no
#'   retries. Useful for e.g. `404` returns where retries are likely
#'   useless.
#' @importFrom jsonlite fromJSON
#'
#' @return retrieved data if succeeded, or a `try-error` class object
#'   otherwise.
nhl_from_json <- function(
  url,
  flatten = getOption("nhlapi_flatten"),
  silent = getOption("nhlapi_try_silent"),
  retries = getOption("nhlapi_get_retries"),
  retrySleep = getOption("nhlapi_get_retry_sleep"),
  noRetryPatt = getOption("nhlapi_get_noretry")
) {
  log_d("nhl_from_json", "start", url, "retries:", retries)
  attempt <- 0L
  failed <- TRUE
  while (attempt <= retries && isTRUE(failed)) {
    log_d("nhl_from_json", "attempt no:", attempt)
    if (attempt > 0L) Sys.sleep(retrySleep)
    res <- try(
      jsonlite::fromJSON(url, flatten = flatten),
      silent = silent
    )
    failed <- inherits(res, "try-error")
    if (failed) {
      errMsg <- attr(res, "condition")[["message"]]
      log_w("nhl_from_json", url, "error for attempt no:", attempt, errMsg)
      noRetry <- isTRUE(grepl(noRetryPatt, errMsg))
      if (noRetry) {
        log_d("nhl_from_json", "not retrying, error in line with noRetry")
        break
      }
    }
    attempt <- attempt + 1L
  }
  log_d("nhl_from_json", "done", url)
  res
}


#' Get data from the API for 1 URL
#'
#' @description Gets data from the NHL API using [nhl_from_json()].
#'
#' @inheritParams nhl_from_json
#' @seealso [nhl_from_json()], [nhl_url()]
#'
#' @return `list` with the retrieved data or class `nhl_get_data_error`.
nhl_get_data_worker <- function(
  url,
  flatten = getOption("nhlapi_flatten"),
  silent = getOption("nhlapi_try_silent"),
  retries = getOption("nhlapi_get_retries"),
  retrySleep = getOption("nhlapi_get_retry_sleep")
) {
  log_d("nhl_get_data_worker", "start", url)
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
  log_d("nhl_get_data_worker", "done", url)
  res
}


#' Get data from the API for one or more urls
#'
#' @param urls `character()`, vector of urls to retrieve
#'   the data from.
#'
#' @inheritParams nhl_get_data_worker
#' @export
#'
#' @seealso [nhl_get_data_worker()]
#'
#' @examples \dontrun{
#'   nhl_get_data(c(
#'     "https://statsapi.web.nhl.com/api/v1/teams/1",
#'     "https://statsapi.web.nhl.com/api/v1/people/8477474"
#'   ))
#'
#'   nhl_get_data(
#'     "https://statsapi.web.nhl.com/api/v1/teams/1",
#'     flatten = FALSE
#'   )
#' }
#'
#' @return `list` of results retrieved using [nhl_get_data_worker()].
#'   One element per url. The elements contain the retrieved data
#'   if retrieval succeeded, otherwise an `nhl_get_data_error` class
#'   object.
nhl_get_data <- function(urls, flatten = getOption("nhlapi_flatten")) {
  log_d("nhl_get_data", "start", toString(urls))
  res <- lapply(urls, nhl_get_data_worker, flatten = flatten)
  util_report_get_data_errors(res)
  log_d("nhl_get_data", "done")
  res
}
