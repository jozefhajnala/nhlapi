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
nhl_get_data <- function(sUrl, silent = FALSE) {
  res <- try(jsonlite::fromJSON(sUrl), silent = silent)
  if (inherits(res, "try-error")) {
    res <- list(res)
    class(res) <- append(class(res), "nhl_get_data_error")
  }
  attr(res, "url") <- sUrl
  res
}

nhl_get_datas <- function(urls) {
  lapply(urls, nhl_get_data)
}
