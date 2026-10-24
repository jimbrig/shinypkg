
#  ------------------------------------------------------------------------
#
# Title : Environment Utilities
#    By : Jimmy Briggs
#  Date : 2026-09-18
#
#  ------------------------------------------------------------------------


# topic -------------------------------------------------------------------



# environment predicates --------------------------------------------------

env_in_shiny <- function() {
  shiny::isRunning()
}

env_in_shiny_session <- function() {
  !is.null(shiny::getDefaultReactiveDomain())
}

env_in_shiny_devmode <- function() {
  if (!env_in_shiny()) {
    return(FALSE)
  }
  isTRUE(getOption("shiny.devmode", FALSE)) && !identical(Sys.getenv("TESTTHAT"), "true")
}

env_in_test <- function() {
  !is.null(Sys.getenv("TEST"))
}

env_in_cran <- function() {
  !is.null(Sys.getenv("NOT_CRAN"))
}

env_in_git <- function() {
  system("git rev-parse --is-inside-work-tree", intern = TRUE) == "true"
}

env_in_github <- function() {
  fs::file_exists("/github/workflow/event.json")
}

env_in_cicd <- function() {
  env_in_github() || isTRUE(as.logical(Sys.getenv("CI")))
}
