
#  ------------------------------------------------------------------------
#
# Title : Package Utilities
#    By : Jimmy Briggs
#  Date : 2026-09-06
#
#  ------------------------------------------------------------------------

# meta ------------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_name <- function() {
  "shinypkg"
}

#' name of the srcts/ library - this logic will likely change as that system is solidified,
#' this is essentially a placeholder for now
#' @keywords internal
#' @noRd
pkg_lib_name <- function() {
  snakecase::to_upper_camel_case(pkg_lib_name)
}

#' @keywords internal
#' @noRd
#' @importFrom utils packageVersion
pkg_version <- local({
  version <- NULL
  function() {
    if (is.null(version)) {
      version <<- as.character(utils::packageVersion(pkg_name()))
    }
    version
  }
})

# NOTES:
# maybe a better approach for this could be to use the git based implementation below
# for the local dev scenario only, and rely on a custom `Config/` field in the DESCRIPTION
# instead for the other approaches...

#' @keywords internal
#' @noRd
pkg_git_version <- local({
  git_last_commit <- NULL
  git_last_date <- NULL
  function() {
    # if local development in a checked out repo/package
    if (interactive() && env_in_git()) {
      if (is.null(git_last_commit)) {
        git_last_commit <- system("git rev-parse --short HEAD", intern = TRUE)
      }
      if (is.null(git_last_date)) {
        git_last_date <- system("git log -1 --format=%cd --date=format:\"%Y-%m-%d\"", intern = TRUE)
      }
      paste0("Version: ", git_last_commit, " (", git_last_date, ")")
    }

    # if called from an installed package - use the github ref

  }
})

# user agent ------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_user_agent <- function() {
  paste0(pkg_name(), "/", pkg_version())
}

# system file -----------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_sys <- function(...) {
  normalizePath(system.file(..., package = pkg_name()), winslash = "/")
}

#' @keywords internal
#' @noRd
#' @importFrom shiny isRunning
#' @importFrom fs path_rel
pkg_sys_www <- function(..., shiny = env_in_shiny()) {
  abs <- pkg_sys("www", ...)
  if (!shiny) return(abs)
  as.character(fs::path_rel(abs, start = pkg_sys()))
}

# startup message -------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
#' @importFrom crayon bold cyan yellow
pkg_startup_msg <- function() {
  msg_banner <- paste0(crayon::cyan(crayon::bold(pkg_banner())), "\n")
  msg_title <- paste0(crayon::bold(crayon::yellow(pkg_name(), paste0("v", pkg_version()))), "\n")
  msg_desc <- crayon::bold(crayon::yellow("Shiny App Package"))
  invisible(paste0(msg_banner, msg_title, msg_desc))
}

# environment -----------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
#' @importFrom rlang new_environment
pkg_env_init <- function() {
  if (!exists(".pkg_env")) {
    return()
  }
  # package config
  # .pkg_env$config <- rlang::new_environment()
  # shiny
  # .pkg_env$shiny <- rlang::new_environment()
  # healthchecks
  # .pkg_env$health <- rlang::new_environment()

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
#' @importFrom rlang env_get
pkg_env_get <- function(key, default = NULL) {
  rlang::env_get(env = .pkg_env, nm = key, default = default)
}

#' @keywords internal
#' @noRd
#' @importFrom rlang env_poke
pkg_env_set <- function(key, value, create = FALSE) {
  rlang::env_poke(env = .pkg_env, nm = key, value = value, create = create)
}

#' @keywords internal
#' @noRd
#' @importFrom rlang env_cache
pkg_env_cache <- function(key, default) {
  rlang::env_cache(env = .pkg_env, nm = key, default = default)
}

# verbosity -------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_is_verbose <- function() {
  getOption("shinypkg.verbose", default = "inform") %in% c("inform", "debug")
}

#' @keywords internal
#' @noRd
pkg_is_debug <- function() {
  identical(getOption("shinypkg.verbose", default = "inform"), "debug")
}

# banner ----------------------------------------------------------------------------------------------------------

#' @keywords internal
#' @noRd
pkg_banner <- function() {
  .pkg_banner_str
}

#' @keywords internal
#' @noRd
#' @seealso https://manytools.org/hacker-tools/ascii-banner/
.pkg_banner_str <- r"(
         __    _                   __
   _____/ /_  (_)___  __  ______  / /______ _
  / ___/ __ \/ / __ \/ / / / __ \/ //_/ __ `/
 (__  ) / / / / / / / /_/ / /_/ / ,< / /_/ /
/____/_/ /_/_/_/ /_/\__, / .___/_/|_|\__, /
                   /____/_/         /____/
)"
