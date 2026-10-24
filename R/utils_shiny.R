
#  ------------------------------------------------------------------------
#
# Title : Shiny Utilities
#    By : Jimmy Briggs
#  Date : 2026-09-12
#
#  ------------------------------------------------------------------------

# resource path -----------------------------------------------------------

#' Shiny Resource Path
#'
#' @name resource_path
#' @family app
#' @family ui
#' @family assets
#' @family utils
#'
#' @description
#' Functions for managing the resource path(s) for the shiny app(s):
#'
#' - `add_resource_path()`: Adds a resource path to the Shiny application.
#' - `ensure_resource_path()`: Ensures that a resource path exists, adding it if necessary.
#'
#' @param prefix The prefix for the resource path, default is "www".
#' @param path The path to the resources, default is the package's www directory.
#' @param inform Whether to inform about existing paths or not in `ensure_resource_path()`.
#'   Default is set via the `options("shinypkg.inform")` package option, and if unset will
#'   default to `FALSE`.
#'
#' @returns
#' Both functions invisibly return the current resource paths as a named list.
NULL

#' @export
#' @rdname resource_path
#' @importFrom shiny addResourcePath resourcePaths
add_resource_path <- function(prefix = "www", path = pkg_sys_www()) {
  shiny::addResourcePath(prefix, path)
  invisible(shiny::resourcePaths())
}

#' @export
#' @rdname resource_path
#' @importFrom shiny resourcePaths
#' @importFrom cli cli_alert_info
ensure_resource_path <- function(prefix = "www", path = pkg_sys_www(), inform = opt("inform")) {
  resource_paths <- shiny::resourcePaths()
  if (!prefix %in% names(resource_paths)) {
    add_resource_path(prefix, path)
  } else {
    if (!quiet) {
      cli::cli_alert_info(
        "Resource path {.field {prefix}} already exists at {.path {resource_paths[[prefix]]}}."
      )
    }
  }
  invisible(shiny::resourcePaths())
}

# internal ----------------------------------------------------------------

#' @keywords internal
#' @noRd
init_shiny_resource_path <- function() {
  add_resource_path()
}

