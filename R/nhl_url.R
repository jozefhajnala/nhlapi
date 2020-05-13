#' Create an NHL API URL
#'
#' @param endPoint `character(1)`, the API endpoint.
#' @inheritParams nhl_url_add_suffixes
#' @inheritParams nhl_url_add_params
#' @param baseUrl `character(1)`, URL of the NHL API base location.
#'
#' @examples
#'   nhlapi:::nhl_url("people", "8477474")
#'
#' @return `character()`, the created URLs.
nhl_url <- function(
  endPoint = NULL,
  suffixes = NULL,
  params = NULL,
  baseUrl = getOption("nhlapi_baseurl")
) {
  log_d("nhl_url", "start")
  url <- baseUrl
  if (!is.null(endPoint)) {
    url <- paste0(url, endPoint)
  }
  url <- nhl_url_add_suffixes(url, suffixes = suffixes)
  url <- nhl_url_add_params(url = url, params = params)
  log_d("nhl_url", "returning", url)
  url
}

#' Add parameters to URLs
#'
#' @param url `character()`, vector of URLs.
#' @param params `named list()` of parameters that will be
#'   concatenated to the end of the URLs after `?`. Parameters
#'   can have multiple values, in which case multiple URLs
#'   are created. Multiple parameters are separated by `&`.
#'
#' @return `character()`, URLs with parameters added. Same
#'   length as all the combinations of `url` and `params`.
nhl_url_add_params <- function(url, params = NULL) {
  params <- util_drop_nulls(params)
  if (util_all_null(params)) return(url)
  if ("season" %in% names(params)) {
    params[["season"]] <- nhl_make_seasons(params[["season"]])
  }
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

#' Add suffixes to URLs
#'
#' @inheritParams nhl_url_add_params
#' @param suffixes `list()`, of suffixes that will be
#'   concatenated to the end of the URLs, separated by `/`.
#'
#' @return `character()`, URLs with suffixes added. Same
#'   length as all the combinations of `url` and `suffixes`.
nhl_url_add_suffixes <- function(url, suffixes) {
  suffixes <- util_drop_nulls(suffixes)
  if (util_all_null(suffixes)) return(url)
  suffixes <- lapply(
    suffixes,
    format,
    scientific = FALSE, trim = TRUE, justify = "none"
  )
  res <- expand.grid(c(list(url = url), suffixes), stringsAsFactors = FALSE)
  apply(res, 1L, paste, collapse = "/")
}
