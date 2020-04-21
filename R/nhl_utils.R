#' Make a vector of seasons consumable by the API
#'
#' @description The NHL API wants seasons defined in format
#'   YYYYZZZZ where ZZZZ = YYYY + 1. This is a helper to take
#'   a vector of years in YYYY format and create a vector of
#'   such seasons to be used with the API.
#'
#' @param seasons `numeric()`, vector of starting years of desired
#'   seasons in `YYYY` format, e.g. `1995` for season 1995-1996.
#'   Accepts vectors such as `c(1995:2000, 2010)`.
#'
#'   Alternatively, also accepts `character()` with seasons in the
#'   format `"YYYYZZZZ"`, where ZZZZ = YYYY + 1, e.g. `"19951996"`.
#'   This is the format that ultimately gets sent to the NHL API.
#'
#'   Some API endpoints, notably `seasons` exposed via `nhl_seasons()`
#'   also allow the value `"current"` to passed.
#'
#' @examples \dontrun{
#'   nhl_make_seasons(1995:2000)
#' }
#'
#' @return `character()`, vector of seasons suited for the NHL API.
nhl_make_seasons <- function(seasons = 1950L:2019L) {
  if (is.character(seasons) && all(nchar(seasons) == 8L)) {
    return(seasons)
  }
  reservedValues <- c("current")
  if (length(seasons) == 1L && seasons %in% reservedValues) {
    return(seasons)
  }
  paste0(seasons, seasons + 1L)
}

#' Flatten a list into a data frame keeping classes
#'
#' DEPRECATED, NOT USED, TO BE REMOVED.
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
  if (is.null(x)) return(data.frame())
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
  lst <- Filter(function(x) nrow(x) != 0L, lst)

  if (length(lst) == 0L) {
    return(data.frame())
  }
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
    if (identical(names(df), allNms)) {
      return(data.frame(df, row.names = NULL))
    }
    filledCols <- vapply(
      setdiff(allNms, names(df)),
      function(thisCol) NA,
      FUN.VALUE = logical(1)
    )
    data.frame(c(df, filledCols), stringsAsFactors = FALSE)
  }
  filleddfs <- lapply(lst, filldf, allNms = lst_allNms)
  do.call(rbind, filleddfs)
}


#' Inherit attributes from another object
#'
#' @description Take attributes with names specified by `atrs`
#'   from object `src` and adds them as the same attributes to `tgt`.
#'
#' @param src `object`, with attributes to be inherited by `tgt`.
#' @param tgt `object`, onto which attributes of `src` should be added.
#' @param atrs `character()`, vector of names of attributes
#'   of `src` to be added to `tgt.
#'
#' @return `object` same as `tgt` with attributes added
util_inherit_attributes <- function(src, tgt, atrs = c("url", "copyright")) {
  relevantAttrs <- intersect(names(attributes(src)), atrs)
  for (i in relevantAttrs) {
    attr(tgt, which = i) <- attr(src, which = i)
  }
  tgt
}

util_nhl_is_get_data_error <- function(x) {
  inherits(x, "nhl_get_data_error")
}

util_locate_get_data_errors <- function(x) {
  vapply(x, util_nhl_is_get_data_error, logical(1))
}

util_remove_get_data_errors <- function(x) {
  Filter(Negate(util_nhl_is_get_data_error), x)
}

#' Report errors encountered during `nhl_get_data`
#'
#' @param x `list`, results created by [nhl_get_data()].
#' @param reporter `function`, used to report the constructed
#'   error message, e.g. `message`, `warning`, `writeLines`,
#'   etc.
#' @param ... further arguments passed to `reporter`, e.g.
#'   `con = file("~/log.txt")` in case `writeLines` is the
#'   `reporter`.
#'
#' @examples \dontrun{
#' c("none", "8451101", "some") %>%
#'   nhl_url_players() %>%
#'   nhl_get_data() %>%
#'   util_report_get_data_errors(
#'     reporter = log_file,
#'     con = file("~/log.txt")
#'   )
#' }
#'
#' @return `character()`, urls for which the retrieval
#'   resulted in an error, invisibly.
util_report_get_data_errors <- function(x, reporter = log_e, ...) {
  errors <- Filter(util_nhl_is_get_data_error, x)
  errorUrls <- vapply(errors, attr, which = "url", FUN.VALUE = character(1))
  errorCount <- length(errorUrls)
  errorMsg <- if (errorCount > 0L) {
    paste(
      "The following", length(errorUrls), "of",
      length(x), "url retrievals errored:\n",
      paste(errorUrls, collapse = "\n ")
    )
  } else {
    "No errors encountered"
  }
  if (errorCount > 0L) {
    reporter(errorMsg, ...)
  }
  invisible(errorUrls)
}


#' Convert "mins:secs" character to numeric minutes
#'
#' @param chr `character()` vector in format `"mins:secs"`.
#' @param splitter `character(1)`, string that splits
#' minutes and seconds in elements of `chr`.
#' @return `numeric()` vector of times in minutes.
#' @examples \dontrun{
#'    nhlstats:::MakeMinsOnIce(c("20:00", "1500:30"))
#' }
util_convert_minsonice <- function(chr, splitter = ":")  {
  mins <- strsplit(chr, split = splitter, fixed = TRUE)
  vapply(mins, function(x) {
    if (length(x) == 1L && is.na(x)) return(NA_real_)
    return(as.integer(x[1L]) + as.integer(x[2L]) / 60)
  }, FUN.VALUE = numeric(1))
}


#' Convert time columns from "mins:secs" to numeric minutes
#'
#' @param df `data.frame`.
#' @param patt `character(1)`, pattern to match column names that
#'   contain time information in "mm:ss" format.
#'
#' @return `data.frame`, with time columns converted from
#'   "mm:ss" characters to numeric minutes.
util_process_minsonice <- function(df, patt = "timeOn|TimeOn") {
  timeColsToConvert <- grep(patt, names(df), value = TRUE)
  for (thisCol in timeColsToConvert) {
    df[[thisCol]] <- util_convert_minsonice(df[[thisCol]])
  }
  df
}

#' Add attributes as data frame columns
#'
#' @description Take attributes with names specified by `atrs`
#'   from object `lst` and adds their value into columns with the same
#'   name in `df`.
#'
#' @param lst `list`, with attributes to be added as columns to `df`.
#' @param df `data.frame`, onto which new columns containing attributes
#'   of `lst` should be added.
#' @param atrs `character()`, vector of names of attributes
#'   of `lst`.
#'
#' @return `data.frame` same as `df` with columns added
util_attributes_to_cols <- function(lst, df, atrs = c("url", "copyright")) {
  relevantAttrs <- intersect(names(attributes(lst)), atrs)
  for (i in relevantAttrs) {
    df[[i]] <- rep(attr(lst, which = i), nrow(df))
  }
  df
}

#' Get MD5 hash for a character vector
#'
#' @description Writes `x` to a temporary file
#'   using `writeChar()` and computes the `md5sum()`
#'   on that file, removing the file afterwards.
#'
#' @param x `character()` vector.
#'
#' @importFrom tools md5sum
#' @return `character(1)`, the MD5 hash.
#'
#' @examples \dontrun{
#'   util_md5sum_str("test")
#' }
util_md5sum_str <- function(x) {
  stopifnot(is.character(x))
  on.exit(unlink(tmpFile, force = TRUE))
  tmpFile <- tempfile()
  writeChar(x, tmpFile)
  res <- tools::md5sum(path.expand(tmpFile))
  res <- unname(res)
  res
}

#' Retrieve a player id from the name
#'
#' @description Using a table of hashed names and
#'   ids, get a player id based on the name.
#'
#' @param x `character(1)` a player's name, not case
#'   sensitive for convenience.
#' @param map `data.frame`, with 2 columns:
#'  - `nameMd5`: `character()` of hashed player names
#'  - `id`: `integer()` of player ids used by the NHL API
#'
#' @return `integer(1)`, id of the player or `NA_integer`
#'   if not found.
#'
#' @examples \dontrun{
#'   util_map_player_id(
#'    "Joe Sakic",
#'    data.frame(
#'      nameMd5 = "bfa8adc1bf05dd7b8a3eeca6556d6930",
#'      id = 1L,
#'      stringsAsFactors = FALSE
#'    )
#'  )
#' }
util_map_player_id <- function(x, map = getOption("nhlapi_player_map")) {
  md <- util_md5sum_str(tolower(x))
  res <- map[map[["nameMd5"]] == md, "id"]
  if (length(res) == 0L) {
    res <- NA_integer_
    log_w("Id for player: ", x, " not found.")
  }
  res
}

#' Retrieve a player ids from their names
#'
#' @inheritParams util_map_player_id
#' @param playerNames `character()`, vector of one or more player names.
#'   Not case sensitive for convenience.
#'
#' @return `integer()` named vector of player ids,
#'   `NA_integer`` for those names where id was not
#'   found#'
#'
#' @examples \dontrun{
#'   util_map_player_ids(c("Joe SAKIC", "peter Forsberg", "test"))
#' }
util_map_player_ids <- function(
  playerNames,
  map = getOption("nhlapi_player_map")
) {
  vapply(playerNames, util_map_player_id, FUN.VALUE = integer(1), map = map)
}


#' Prepare player ids based on player names
#'
#' @inheritParams util_map_player_ids
#'
#' @return `integer()` named vector of found valid player
#'  ids, those not found omitted.
#' @examples \dontrun{
#'  util_prepare_player_ids(c("joe sakic", "fake player"))
#' }
util_prepare_player_ids <- function(
  playerNames,
  map = getOption("nhlapi_player_map")
) {
  if (!is.character(playerNames)) {
    stop("playerNames must be a character vector.")
  }
  playerIds <- util_map_player_ids(playerNames, map = map)
  playerIds <- playerIds[!is.na(playerIds)]
  playerIds
}

#' Generate the sysdata.rda file
#'
#' @param playerIds `integer()`, vector of playerIds.
#' @param tgtPath `character(1)`, path where to save
#'   the generated object, `NULL` to not save.
#'
#' @return `data.frame` with player name hashes and ids.
util_generate_sysdata <- function(
  playerIds = 8444849L:8490000L,
  tgtPath = "sysdata.rda"
) {
  players <- nhl_players(playerIds = playerIds)
  hashedPlayers <- players[c("id", "fullName")]
  hashedPlayers[["nameMd5"]] <- vapply(
    tolower(hashedPlayers[["fullName"]]),
    FUN = util_md5sum_str,
    FUN.VALUE = character(1)
  )
  hashedPlayers[["fullName"]] <- NULL
  if (!is.null(tgtPath)) {
    save(hashedPlayers, file = tgtPath, version = 2, compress = "xz")
  }
  hashedPlayers
}

nhl_process_result <- function(x, elName) {
  res <- util_process_copyright(x)
  res_df <- res[[elName]]
  if (identical(res_df, list())) res_df <- as.data.frame(res_df)
  res_df <- util_attributes_to_cols(res, res_df)
  res_df
}

nhl_process_results <- function(x, elName) {
  res <- lapply(x, nhl_process_result, elName = elName)
  bindedRes <- try(util_rbindlist(res), silent = TRUE)
  if (inherits(bindedRes, "try-error")) {
    warning("util_rbindlist failed, returning unbinded data.")
    res
  } else {
    bindedRes
  }
}
