#' Make a vector of seasons consumable by the API
#'
#' @description The NHL API wants seasons defined in format
#'   YYYYZZZZ where ZZZZ = YYYY + 1. This is a helper to take
#'   a vector of years in YYYY format and create a vector of
#'   such seasons to be used with the API.
#'
#' @param years `integer()`, vector of season starting years,
#'   e.g.for season 1995-1996 it would be 1995.
#'
#' @examples
#'   nhl_make_seasons(1995:2000)
#'
#' @export
#'
#' @return `character()`, vector of seasons suited for the NHL API.
nhl_make_seasons <- function(years = 1950L:2019L) {
  paste0(years, years + 1L)
}

#' Flatten a list into a data frame keeping classes
#'
#' @param x `list()`, note that a `data.frame` is also a `list`.
#'
#' @importFrom methods as
#'
#' @examples \dontrun{
#'   x <- list(a = 1L, b = list(1, list(2L, TRUE)))
#'   nhl_util_flatten_list(x)
#'  }
#'
#' @return data.frame with the list flattened and classes preserved.
util_flatten_list <- function(x) {
  classes <- rapply(x, class)
  unlisted <- as.list(unlist(x, recursive = TRUE, use.names = TRUE))
  data.frame(
    Map(methods::as, unlisted, classes),
    stringsAsFactors = FALSE
  )
}

#' Move copyright information to attribute
#'
#' @description Removes the element named `el` from `x` if
#'   present and keeps the information as an equally named
#'   attribute.
#'
#' @param x `list()`, to be processed.
#' @param el `character(1)`, name of the element to remove.
#'   Defaults to `"copyright"` as this is the intended use
#'   of the function.
#'
#' @return `list` with the `el` element removed and added
#'   as attribute, if it is present in `x`. Unchanged `x`
#'   otherwise.
util_process_copyright <- function(x, el = "copyright") {
  if (el %in% names(x)) {
    attrb <- attributes(x)
    attrb[el] <- x[[el]]
    newnames <- setdiff(names(x), el)
    x <- x[newnames]
    mostattributes(x) <- attrb
    names(x) <- newnames
  }
  invisible(x)
}

#' Safely rbind multiple data.frames
#'
#' @description Attempts to replace `do.call(rbind, lst)`
#'   taking into consideration that some data frames in
#'   `lst` can have missing columns. Those are filled by
#'   `NA` values.
#'
#' @param lst `list()` of data frames to be rbinded into one
#' @param fill `logical(1)` if `FALSE`, just returns
#'   `do.call(rbind, lst)`
#'
#' @return data.frame
#' @examples \dontrun{
#'   util_rbindlist(list(mtcars[1, 2:3], mtcars[2, 4:5]))
#' }
util_rbindlist <- function(lst, fill = TRUE) {
  if (!isTRUE(fill)) {
    return(do.call(rbind, lst))
  }
  lst_nms <- lapply(lst, names)
  if (length(unique(lst_nms)) == 1L) {
    # all names equal, use default rbind
    return(do.call(rbind, lst))
  }
  lst_allNms <- unique(unlist(lst_nms))
  filldf <- function(df, allNms) {
    filledCols <- vapply(
      setdiff(allNms, names(df)),
      function(thisCol) NA,
      FUN.VALUE = logical(1)
    )
    data.frame(c(df, filledCols))
  }
  filleddfs <- lapply(lst, filldf, allNms = lst_allNms)
  do.call(rbind, filleddfs)
}
