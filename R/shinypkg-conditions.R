
#  ------------------------------------------------------------------------
#
# Title : Custom Conditions
#    By : Jimmy Briggs
#  Date : 2026-09-15
#
#  ------------------------------------------------------------------------

# topic -------------------------------------------------------------------

#' `shinypkg` Custom Conditions
#'
#' @name shinypkg-conditions
#' @aliases conditions
#' @family conditions
#' @family package
#'
#' @description
#' Functions for creating and handling custom `shinypkg`-specific conditions, including errors, warnings, and messages.
#'
#' - `shinypkg_abort()`: creates a condition representing an error and when thrown, aborts execution.
#' - `shinypkg_warn()`: creates a condition representing a warning condition
#' - `shinypkg_inform()`: creates a condition representing a message condition
#'
#' These functions wrap [cli::cli_abort()], [cli::cli_warn()], and [cli::cli_inform()] respectively,
#' adding `shinypkg`-specific context and class names to the condition objects for easier downstream
#' handling and identification.
#'
#' @details
#' The condition class hierarchy is structured like so:
#'
#' ```plaintext
#' <shinypkg_condition>
#'   ├── <shinypkg_error>
#'   │   ├── <shinypkg_{custom}_error>
#'   ├── <shinypkg_warning>
#'   │   ├── <shinypkg_{custom}_warning>
#'   ├── <shinypkg_message>
#'   └────── <shinypkg_{custom}_message>
#' ```
#'
#' where `<shinypkg_condition>` is the base class for all `shinypkg` conditions
#' and sits on top of the existing `rlang` and base R condition classes.
#'
#' For example, an `shinypkg` error thrown without any additional custom class added
#' to it using `shinypkg_abort()` will have the following classes:
#'
#' ```R
#' [1] "shinypkg_error" "shinypkg_condition" "rlang_error" "error" "condition"
#' ```
#'
#' This allows for filtering and handling of `shinypkg`-specific conditions while
#' still being compatible with the broader R condition system.
#'
#' @param msg Character string or vector containing the message to be displayed. This gets
#'   passed to [cli::cli_bullets()] allowing for `cli`'s custom formatting,
#'   `glue` interpolation, inline markup syntax, and other features.
#' @param cls Optional character vector of additional classes to assign to the condition.
#' @inheritParams cli::cli_abort
#'
#' @returns
#' These functions do not return values, but are used for their side effects, namely
#' creating and signaling conditions. The `shinypkg_abort()` function will stop
#' execution, while `shinypkg_warn()` & `shinypkg_inform()` will allow execution
#' to proceed.
#'
#' @examples
#' \dontrun{
#' shinypkg_abort("This is a shinypkg error.")
#'
#' # catch a condition and check its classes
#' err <- rlang::catch_cnd(shinypkg_abort("Error Message"))
#' class(err)
#'
#' # catch a warning and check its classes
#' wrn <- rlang::catch_cnd(shinypkg_warn("Warning Message"))
#' class(wrn)
#'
#' # catch a message and check its classes
#' msg <- rlang::catch_cnd(shinypkg_inform("Message"))
#' class(msg)
#' }
NULL

# abort -------------------------------------------------------------------

#' @rdname shinypkg-conditions
#' @export
#' @importFrom cli cli_abort
#' @importFrom rlang caller_env
shinypkg_abort <- function(msg = NULL, cls = NULL, ..., parent = NULL, call = rlang::caller_env(), .envir = parent.frame()) {
  classes <- c(cls, "shinypkg_error", "shinypkg_condition")
  cli::cli_abort(message = msg, class = classes, parent = parent, call = call, .envir = .envir, ...)
}

# warn --------------------------------------------------------------------

#' @rdname shinypkg-conditions
#' @export
#' @importFrom cli cli_warn
shinypkg_warn <- function(msg = NULL, cls = NULL, ..., .envir = parent.frame()) {
  classes <- c(cls, "shinypkg_warning", "shinypkg_condition")
  cli::cli_warn(message = msg, class = classes, .envir = .envir, ...)
}


# inform ------------------------------------------------------------------

#' @rdname shinypkg-conditions
#' @export
#' @importFrom cli cli_inform
shinypkg_inform <- function(msg = NULL, cls = NULL, ..., .envir = parent.frame()) {
  classes <- c(cls, "shinypkg_message", "shinypkg_condition")
  cli::cli_inform(message = msg, class = classes, .envir = .envir, ...)
}

# checks ------------------------------------------------------------------

#' `shinypkg` Check Conditions
#'
#' @description
#' These functions are specialized versions of the `shinypkg` condition functions that are intended for
#' use in the package's internal checking functions. They create conditions with
#' specific classes that can be used to identify and handle errors, warnings, and messages.
#'
#' @section Functions:
#' - `shinypkg_abort_check()`: creates an `shinypkg_error` condition for checks.
#' - `shinypkg_warn_check()`: creates an `shinypkg_warning` condition for checks.
#' - `shinypkg_inform_check()`: creates an `shinypkg_message` condition for checks.
#'
#' @section Aliases:
#' - `check_abort()`: alias for `shinypkg_abort_check()`
#' - `check_warn()`: alias for `shinypkg_warn_check()`
#' - `check_inform()`: alias for `shinypkg_inform_check()`
#'
#' @inherit shinypkg_abort
#'
#' @export
shinypkg_abort_check <- function(msg, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  shinypkg_abort(msg = msg, cls = "shinypkg_check_error", ..., call = call, .envir = .envir)
}

#' @rdname shinypkg_abort_check
#' @export
check_abort <- shinypkg_abort_check

#' @rdname shinypkg_abort_check
#' @export
shinypkg_warn_check <- function(msg, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  shinypkg_warn(msg = msg, cls = "shinypkg_check_warning", ..., call = call, .envir = .envir)
}

#' @rdname shinypkg_abort_check
#' @export
check_warn <- shinypkg_warn_check

#' @rdname shinypkg_abort_check
#' @export
shinypkg_inform_check <- function(msg, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  shinypkg_inform(msg = msg, cls = "shinypkg_check_message", ..., .envir = .envir)
}

#' @rdname shinypkg_abort_check
#' @export
check_inform <- shinypkg_inform_check


# testing helpers ---------------------------------------------------------


# internal ----------------------------------------------------------------


