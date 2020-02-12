#' Create an NHL API URL
#'
#' @param endPoint `character(1)` the endpoint.
#' @param suffixes `list` of suffixes that will be
#'   concatenated to the end of the urls, separated by
#'   `/`.
#' @param params `named list` of parameters that will be concatenated
#'   to the end of the url after `?`.
#' @param baseUrl `character(1)`, base location of the NHL API.
#'
#' @export
#'
#' @examples
#'   nhl_url("people", "8477474")
#'
#' @return `character()`, the created URLs.
nhl_url <- function(
  endPoint = NULL,
  suffixes = NULL,
  params = NULL,
  baseUrl = getOption("nhlapi_baseurl")
) {
  url <- baseUrl
  if (!is.null(endPoint)) {
    url <- paste0(url, endPoint)
  }
  if (!is.null(suffixes)) {
    url <- nhl_url_add_suffixes(url, suffixes = suffixes)
  }
  if (!is.null(params)) {
    url <- nhl_url_add_params(url = url, params = params)
  }
  url
}

#' Add parameters to urls
#'
#' @param url `character()` vector of urls.
#' @param params `named list()` of parameters that will be
#'   concatenated to the end of the urls after `?`. Parameters
#'   can have multiple values, in which case multiple urls
#'   are created.
#'
#' @return `character()` of the same length as all the
#'   combinations of `url` and `params`.
nhl_url_add_params <- function(url, params) {
  params <- lapply(
    params,
    format,
    scientific = FALSE, trim = TRUE, justify = "none"
  )
  res <- expand.grid(c(list(url = url), params), stringsAsFactors = FALSE)
  res$sep <- ifelse(grepl("?", res$url, fixed = TRUE), "&", "?")
  apply(res, 1L, function(x) {
    pars <- x[setdiff(names(x), c("url", "sep"))]
    parString <- paste(names(pars), pars, sep = "=", collapse = "&")
    paste0(x["url"], x["sep"], parString)
  })
}

#' Add suffixes to urls
#'
#' @param url `character()` vector of urls.
#' @param suffixes `list()` of suffixes that will be
#'   concatenated to the end of the urls, separated by
#'   `/`.
#'
#' @return `character()` of the same length as all the
#'   combinations of `url` and `suffixes`.
nhl_url_add_suffixes <- function(url, suffixes) {
  suffixes <- lapply(
    suffixes,
    format,
    scientific = FALSE, trim = TRUE, justify = "none"
  )
  res <- expand.grid(c(list(url = url), suffixes), stringsAsFactors = FALSE)
  apply(res, 1L, paste, collapse = "/")
}
