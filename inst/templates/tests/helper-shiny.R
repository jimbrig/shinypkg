
#  ------------------------------------------------------------------------
#
# Title : Shiny Test Helpers
#    By : Jimmy Briggs
#  Date : 2026-10-24
#
#  ------------------------------------------------------------------------

require(testthat)
require(shiny)
require(shinytest2)
require(withr)
require(htmltools)
require(tibble)


# expects -----------------------------------------------------------------

expect_shiny_tag <- function(tag) {
  testthat::expect_s3_class(tag, "shiny.tag")
}

expect_shiny_taglist <- function(taglist) {
  testthat::expect_s3_class(taglist, "shiny.tag.list")
}

expect_shiny_app <- function(app) {
  testthat::expect_s3_class(app, "shiny.appobj")
}

expect_bslib_fragment <- function(obj) {
  expect_shiny_tag(obj)
  testthat::expect_s3_class(obj, "bslib_fragment")
}

expect_shiny_module_ui <- function(ui, expected_id) {
  testthat::expect_s3_class(ui, "shiny.tag.list")
  testthat::expect_true(grepl(paste0('id="', expected_id, '"'), as.character(ui)))
}

expect_html_structure <- function(html, expected_class = NULL, expected_id = NULL, expected_tag = NULL) {
  html_char <- as.character(html)
  if (!is.null(expected_class)) {
    testthat::expect_true(grepl(paste0('class="[^"]*', expected_class), html_char))
  }
  if (!is.null(expected_id)) {
    testthat::expect_true(grepl(paste0('id="', expected_id, '"'), html_char))
  }
  if (!is.null(expected_tag)) {
    testthat::expect_true(grepl(paste0('<', expected_tag), html_char))
  }
}

# test session -----------------------------------------------------------

create_test_session <- function() {
  session <- shiny::MockShinySession$new()
  session$clientData <- list(url_protocol = "http:", url_hostname = "localhost", url_port = "3838", url_pathname = "/", url_search = "", url_hash_initial = "", url_hash = "", singletons = "", pixelratio = 1)
  return(session)
}

# playwright -------------------------------------------------------------

skip_if_not_interactive <- function() {
  testthat::skip_if_not(interactive())
}

skip_if_missing_binary <- function(binary) {
  testthat::skip_if_not(unname(Sys.which(binary)) != "")
}

run_playwright_tests <- function(engine = c("npx", "bunx")) {
  engine <- rlang::arg_match(engine)
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("pw")
  skip_if_missing_binary(engine)
  pw_dir <- testthat::test_path("../playwright") |> normalizePath(winslash = "/", mustWork = FALSE)
  testthat::skip_if_not(dir.exists(pw_dir))
  withr::with_dir(
    new = pw_dir,
    code = {
      options(shiny.autoload.r = FALSE)
      res <- system2(command = engine, args = c("playwright", "test"))
    }
  )
  testthat::expect_equal(res, 0L)
}


