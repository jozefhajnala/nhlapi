#' Get data from the API
#'
#' @description Gets data from the NHL API using `jsonlite`.
#'
#' @param sUrl `character(1)`, the URL to get the data from.
#' @param silent `logical(1)`, passed to `try()`.
#'
#' @importFrom jsonlite fromJSON
#' @seealso [nhl_url()]
#'
#' @return `list` with the retrieved data or class `try-error`.
nhl_get_data <- function(sUrl, silent = getOption("nhlapi_try_silent")) {
  res <- try(jsonlite::fromJSON(sUrl, flatten = TRUE), silent = silent)
  if (inherits(res, "try-error")) {
    res <- list(res)
    class(res) <- append(class(res), "nhl_get_data_error")
  }
  attr(res, "url") <- sUrl
  res
}

#' Get data from the API for multiple urls
#'
#' @param urls `character()`, vector of urls to retrieve
#'   the data from.
#'
#' @return `list` of results retrieved using [nhl_get_data()].
nhl_get_datas <- function(urls) {
  res <- lapply(urls, nhl_get_data)
  util_report_get_data_errors(res)
  res
}
