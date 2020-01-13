#' Create an NHL API URL
#'
#' @param endPoint `character(1)` the endpoint.
#' @param suffixes `character()` vector of suffixes, appended to the url.
#' @param params `named list` of parameters that will be concatenated
#'   to the end of the url after `?`.
#' @param baseUrl `character(1)`, basee location of the NHL API.
#'
#' @export
#'
#' @examples
#'   nhl_url("people", "8477474")
#'
#' @return `character(1)`, the created URL.
nhl_url <- function(
  endPoint = NULL,
  suffixes = NULL,
  params = NULL,
  baseUrl = getOption("nhlapi_baseurl")
) {
  sUrl <- baseUrl
  if (!is.null(endPoint)) {
    sUrl <- paste0(sUrl, endPoint, "/")
  }
  if (!is.null(suffixes)) {
    sUrl <- paste0(sUrl, paste(suffixes, collapse = "/"))
  }
  if (!is.null(params)) {
    sUrl <- paste(
      sUrl,
      paste(names(params), params, sep = "=", collapse = "&"),
      sep = "?"
    )
  }
  sUrl
}
