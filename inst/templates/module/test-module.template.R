
#  ------------------------------------------------------------------------
#
# Title : {{title}} Shiny Module Tests
#    By : {{author}}
#  Date : {{date}}
#
#  ------------------------------------------------------------------------

# server ------------------------------------------------------------------

test_that("mod_{{name}}_server", {
  shiny::testServer(
    app = mod_{{name}}_server,
    args = list(),
    expr = {
      ns <- session$ns
      testthat::expect_s3_class(ns, "function")
      testthat::expect_match(id, regexp = ns(""))
      testthat::expect_match("test", regexp = ns("test"))
    },
    session = shiny::MockShinySession$new()
  )
})

# UI ----------------------------------------------------------------------

test_that("mod_{{name}}_ui", {
  ui <- mod_{{name}}_ui("test")
  testthat::
  expect_shinytaglist(ui)
  fmls <- formals(mod_{{name}}_ui)
  for (i in c("id")) { expect_true(i %in% names(fmls)) }
})


# demo --------------------------------------------------------------------

test_that("mod_{{name}}_demo", {
  demo <- mod_{{name}}_demo()
  expect_no_error(demo)
  expect_s3_class(demo, "shiny.appobj")
})

