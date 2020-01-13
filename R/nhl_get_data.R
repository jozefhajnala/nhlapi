#' Get data from the API
#'
#' @description Gets data from the NHL API using `jsonlite`.
#'
#' @param sUrl `character(1)`, the URL to get the data from.
#'
#' @importFrom jsonlite fromJSON
#' @seealso [nhl_url()]
#'
#' @return `list` with the retrieved data or class `try-error`.
nhl_get_data <- function(sUrl) {
  res <- try(jsonlite::fromJSON(sUrl))
  attr(res, "url") <- sUrl
  if (inherits(res, "try-error")) {
   return(list(res))
  }
  res
}

nhl_get_datas <- function(urls) {
  lapply(urls, nhl_get_data)
}