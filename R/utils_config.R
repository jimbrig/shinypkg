
#  ------------------------------------------------------------------------
#
# Title : Configuration Utilities
#    By : Jimmy Briggs
#  Date : 2026-10-24
#
#  ------------------------------------------------------------------------

# Renviron ----------------------------------------------------------------

#' Read .Renviron File
#'
#' @family config
#' @family utils
#'
#' @description
#' Attempts to read a .Renviron file from the specified path or current working directory.
#' Used during package initialization to load environment variables.
#'
#' @param path Path to .Renviron file. Defaults to current working directory.
#' @param warn Logical. Show warning if file not found? Default `FALSE`.
#'
#' @returns
#' Invisibly returns `TRUE` if file was read successfully, `FALSE` otherwise.
#'
#' @keywords internal
#'
#' @importFrom cli cli_alert_warning
read_renviron <- function(path = NULL, warn = FALSE) {
  if (is.null(path)) path <- file.path(getwd(), ".Renviron")
  if (!file.exists(path)) {
    if (warn) cli::cli_alert_warning("No .Renviron file found at {.path {path}}.")
    return(invisible(FALSE))
  }
  readRenviron(path)
  invisible(TRUE)
}

# active config -----------------------------------------------------------

#' Manage Active Configuration
#'
#' @name active_config
#' @family config
#' @family utils
#'
#' @description
#' Functions for quickly accessing or setting the active configuration file and environment
#' for [config::get()] & `config.yml` file(s).
#'
#' @details
#' The possible configuration "modes" or names are "default", "development", "production", and "testing"
#'
#' The environment variables used to manage these are the underlying `R_CONFIG_ACTIVE` and `R_CONFIG_FILE`
#' environment variables used by [config::get()] as well as additional `SHINY_` prefixed variants of those names, i.e.:
#' `SHINY_CONFIG_ACTIVE` and `SHINY_CONFIG_FILE`.
#'
#' Under standard scenarios the `SHINY_CONFIG_ACTIVE`/`R_CONFIG_ACTIVE` values will be `"default"` and the
#' `SHINY_CONFIG_FILE`/`R_CONFIG_FILE` values will be set to the resulting path from `pkg_sys_config("config.yml")`,
#' which is this package's installation folder's `config/config.yml` file path.
#'
#' Get:
#'
#' - `get_active_config_env()`: Returns the active configuration run-time environment (`SHINY_CONFIG_ACTIVE`, `R_CONFIG_ACTIVE`).
#' - `get_active_config_file()`: Returns the active configuration file (`SHINY_CONFIG_FILE`, `R_CONFIG_FILE`).
#'
#' Set:
#'
#' - `set_active_config_env(env)`: Sets the active configuration environment
#' - `set_active_config_file(file)`: Sets the active configuration file
#'
#' @param default For `get_active_config_env()`, the `default` argument refers to the default environment to
#'   return if no active environment is set and defaults to "default". Possible values are "default", "development",
#'   "production", and "testing". For `get_active_config_file()`, the `default` argument refers to the fallback,
#'   default file path to use if no active config file environment variable is set and defaults to
#'   `pkg_sys_config("config.yml")`, or this package's internally bundled `config/config.yml` file.
#'
#' @param env The configuration environment to set as active. Possible values are "default", "development",
#'  "production", and "testing".
#'
#' @param file The configuration file path to set as active. Must be a valid `config.yml` file.
#'
#' @returns
#' - `get_active_config_env()`: The active configuration environment as a string.
#' - `get_active_config_file()`: The active configuration file as a string.
#' - `set_active_config_env(env)`: Returns the previous active configuration environment.
#' - `set_active_config_file(file)`: Returns the previous active configuration file.
#'
#' @seealso [config::get()]
NULL

#' @rdname active_config
#' @export
#' @importFrom rlang arg_match
get_active_config_env <- function(default = c("default", "development", "production", "testing")) {
  default <- rlang::arg_match(default)
  get_env_cascade(c("SHINY_CONFIG_ACTIVE", "R_CONFIG_ACTIVE"), default = default)
}

#' @rdname active_config
#' @export
#' @importFrom rlang arg_match
set_active_config_env <- function(env) {
  old_env <- get_active_config_env()
  rlang::arg_match(env, c("default", "development", "production", "testing"))
  Sys.setenv(SHINY_CONFIG_ACTIVE = env, R_CONFIG_ACTIVE = env)
  invisible(old_env)
}

#' @rdname active_config
#' @export
get_active_config_file <- function(default = pkg_sys_config("config.yml")) {
  get_env_cascade(c("SHINY_CONFIG_FILE", "R_CONFIG_FILE"), default = default)
}

#' @rdname active_config
#' @export
set_active_config_file <- function(file) {
  old_file <- get_active_config_file()
  check_file(path = file, ext = "yml")
  Sys.setenv(SHINY_CONFIG_FILE = file, R_CONFIG_FILE = file)
  invisible(old_file)
}

# helpers ---------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
get_env_cascade <- function(env_vars, default = NULL) {
  for (var in env_vars) {
    value <- Sys.getenv(var, unset = "")
    if (value != "") return(value)
  }
  default
}

