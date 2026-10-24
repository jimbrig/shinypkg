
#  ------------------------------------------------------------------------
#
# Title : Check Utilities
#    By : Jimmy Briggs
#  Date : 2026-09-06
#
#  ------------------------------------------------------------------------

# topic -------------------------------------------------------------------

#' Check Functions
#'
#' @name checks
#' @family checks
#' @family utils
#'
#' @description
#' Collection of various checking functions primarily used for incorporating argument validation checks for package
#' functions.
#'
#' These check functions act as assertions, and will either return the provided objects invisibly, or throw exceptions.
NULL

# inherits ----------------------------------------------------------------

#' Class Inheritance Checks
#'
#' @description
#' These functions perform checks that assert the underlying class of objects passed to them.
#'
#' - `check_inherits()`: checks that object `x` is of class `class` using [base::inherits()]
#' - `check_inherits2()`: checks that object `x` is of class `class` using [base::.class2()]
#' - `check_inherits_any()`: checks that object `x` is at least one of the provided `classes` via [rlang::inherits_any()]
#' - `check_inherits_all()`: checks that object `x` is all of the provided `classes` via [rlang::inherits_all()]
#'
#' If validation fails for any of these functions, an error is thrown via `check_abort()` displaying a friendly
#' error message.
#'
#' @param x The object to check.
#' @param class,classes The name of the class or classes to use during checking.
#' @inheritParams rlang::args_error_context
#'
#' @returns
#' If checks pass, invisibly returns the provided `x` object. If checks fail, a condition error is thrown.
#'
#' @export
check_inherits <- function(x, class, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!inherits(x, class)) {
    check_abort("{.arg {arg}} must inherit from class {.cls {class}}, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

#' @rdname check_inherits
#' @export
check_inherits2 <- function(x, class, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!(class %in% .class2(x))) {
    check_abort("{.arg {arg}} must inherit from class {.cls {class}}, not {.cls {.class2(x)}}", call = call)
  }
  invisible(x)
}

#' @rdname check_inherits
#' @export
#' @importFrom rlang inherits_any
check_inherits_any <- function(x, classes, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::inherits_any(x, classes)) {
    check_abort(
      "{.arg {arg}} must inherit from one of the classes: {.cls {classes}}, not {.obj_type_friendly {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @rdname check_inherits
#' @export
#' @importFrom rlang inherits_all
check_inherits_all <- function(x, classes, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::inherits_all(x, classes)) {
    check_abort(
      "{.arg {arg}} must inherit from all of the classes: {.cls {classes}}, not {.obj_type_friendly {x}}.",
      call = call
    )
  }
  invisible(x)
}

# types -------------------------------------------------------------------

check_typeof <- function(x, type, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!identical(typeof(x), type)) {
    check_abort("{.arg {arg}} must be of type {.cls {type}}, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_environment <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_typeof(x, "environment", arg = arg, call = call)
}

check_string <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  rlang::try_fetch(
    {
      rlang::check_string(x, allow_empty = FALSE, arg = arg, call = call)
    },
    error = function(err) {
      check_abort("{.arg {arg}} must be a string, not {.obj_type_friendly {x}}.", arg = arg, call = call)
    }
  )
  invisible(x)
}

check_character <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_character(x)) {
    check_abort("{.arg {arg}} must be character, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_logical <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.logical(x)) {
    check_abort("{.arg {arg}} must be a logical value, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_numeric <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.numeric(x)) {
    check_abort("{.arg {arg}} must be a numeric value, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_integer <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_integer(x)) {
    check_abort("{.arg {arg}} must be an integer, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_percent <- function(x, arg = rlang::caller_arg(x), allow_negative = FALSE, call = rlang::caller_env()) {
  check_numeric(x, arg = arg, call = call)
  if (length(x) != 1 || is.na(x)) {
    check_abort("{.arg {arg}} must be a single numeric value, not {.obj_type_friendly {x}}.", call = call)
  }
  if (allow_negative) {
    if (x < -1 || x > 1) {
      check_abort("{.arg {arg}} must be between -1 and 1, not {.val {x}}.", call = call)
    }
  } else {
    if (x < 0 || x > 1) {
      check_abort("{.arg {arg}} must be between 0 and 1, not {.val {x}}.", call = call)
    }
  }
  invisible(x)
}

check_function <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.function(x)) {
    check_abort("{.arg {arg}} must be a function, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_vector <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.vector(x)) {
    check_abort("{.arg {arg}} must be a vector, not {.obj_type_friendly {x}}.", call = call)
  }
  if (length(x) == 0) {
    check_abort("{.arg {arg}} contains no elements.", call = call)
  }
  invisible(x)
}

check_matrix <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "matrix", arg = arg, call = call)
  if (nrow(x) == 0) {
    check_abort("{.arg {arg}} contains no rows.", call = call)
  }
  invisible(x)
}

check_list <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.list(x) || is.data.frame(x)) {
    check_abort("{.arg {arg}} must be a list, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_data_frame <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.data.frame(x)) {
    check_abort("{.arg {arg}} must be a data frame, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

check_tibble <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "tbl_df", arg = arg, call = call)
  invisible(x)
}

check_row <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_data_frame(x, arg = arg, call = call)
  if (nrow(x) != 1) {
    check_abort("{.arg {arg}} must be a single row data frame, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

# empty -------------------------------------------------------------------

#' Check Not Empty
#'
#' @description
#' Checks the provided `x` is not "empty" via [rlang::is_empty()].
#'
#' @inheritParams check_inherits
#'
#' @returns
#' If checks pass, invisibly returns the provided `x` object. If checks fail, a condition error is thrown.
#'
#' @export
#'
#' @importFrom rlang is_empty
check_not_empty <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (rlang::is_empty(x)) {
    check_abort("{.arg {arg}} must not be empty.", call = call)
  }
  invisible(x)
}

# lists & names ---------------------------------------------------------------------------------------------------

check_list <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_typeof(x, "list", arg = arg, call = call)
}

#' @importFrom rlang is_named
check_named <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_named(x)) {
    check_abort("{.arg {arg}} must be a named list.", call = call)
  }
  invisible(x)
}

check_names <- function(x, req_names, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_named(x, arg = arg, call = call)
  missing_names <- setdiff(req_names, names(x))
  if (length(missing_names) > 0) {
    check_abort("{.arg {arg}} is missing the following required names: {.field {missing_names}}.", call = call)
  }
  invisible(x)
}

check_in_set <- function(x, set, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!x %in% set) {
    check_abort("{.arg {arg}} must be one of {.field {set}}, not {.val {x}}.", call = call)
  }
  invisible(x)
}

# shiny -------------------------------------------------------------------

check_shiny_app <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "shiny.appobj", arg = arg, call = call)
  invisible(x)
}

check_shiny_session <- function(x = shiny::getDefaultReactiveDomain(), arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (is.null(x)) {
    caller <- as.character(sys.call(-1L)[[1]])
    check_abort(
      c(
        "The function {.fn {caller}} requires an active shiny session.",
        "i" = "Make sure you're calling this function from within a reactive context (i.e. observer, reactive, or event handler).",
        "i" = "This function cannot be called during app initialization or outside reactive contexts."
      ),
      call = call
    )
  }
  check_inherits(x, "ShinySession", arg = arg, call = call)
}

check_shiny_tag <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "shiny.tag", arg = arg, call = call)
}

check_shiny_taglist <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "shiny.tag.list", arg = arg, call = call)
}

check_shiny_reactive <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits_all(x, c("reactiveExpr", "reactive", "function"), arg = arg, call = call)
}

check_shiny_request <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_environment(x, arg = arg, call = call)
  check_names(x, c("REQUEST_METHOD", "PATH_INFO", "rook.input"), arg = arg, call = call)
  check_in_set(x$REQUEST_METHOD, c("GET", "POST", "PUT", "DELETE", "PATCH", "HEAD", "OPTIONS"), arg = arg, call = call)
  invisible(x)
}

check_shiny_response <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "httpResponse", arg = arg, call = call)
  check_names(x, c("status", "content_type", "content", "headers"), arg = arg, call = call)
  invisible(x)
}

# bslib -------------------------------------------------------------------

check_bslib_page <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_shiny_taglist(x, arg = arg, call = call)
  check_inherits(x, "bslib_page", arg = arg, call = call)
}

# httr2 -----------------------------------------------------------------------------------------------------------

check_request <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "httr2_request", arg = arg, call = call)
}

check_response <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  check_inherits(x, "httr2_response", arg = arg, call = call)
}

# scalars ---------------------------------------------------------------------------------------------------------

#' @importFrom rlang is_string
check_string <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_string(x)) {
    check_abort("{.arg {arg}} must be a single string, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

#' @importFrom rlang is_function
check_function <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_function(x)) {
    check_abort("{.arg {arg}} must be a function, not {.obj_type_friendly {x}}.", call = call)
  }
  invisible(x)
}

# http ------------------------------------------------------------------------------------------------------------

#' @importFrom rlang is_integerish
check_status_code <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!rlang::is_integerish(x, n = 1, finite = TRUE) || x < 100 || x > 599) {
    check_abort(
      "{.arg {arg}} must be a single HTTP status code between 100 and 599, not {.val {x}}.",
      call = call
    )
  }
  invisible(x)
}

check_url_path <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.character(x) || length(x) == 0 || !all(nzchar(x)) || !all(startsWith(x, "/"))) {
    check_abort(
      "{.arg {arg}} must be a character vector of URL paths, each beginning with {.val /}.",
      call = call
    )
  }
  invisible(x)
}

# json ------------------------------------------------------------------------------------------------------------

check_json_str <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is_valid_json_str(x)) {
    check_abort("{.arg {arg}} must be a valid JSON string.", arg = arg, call = call)
  }
  invisible(x)
}

check_json_file <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is_valid_json_file(x)) {
    check_abort("{.arg {arg}} must be a valid path to a JSON file.", arg = arg, call = call)
  }
  invisible(x)
}
