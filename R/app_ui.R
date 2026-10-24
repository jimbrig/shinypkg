
#  ------------------------------------------------------------------------
#
# Title : Shiny App User Interface (UI)
#    By : Jimmy Briggs
#  Date : 2026-09-10
#
#  ------------------------------------------------------------------------

# app_ui ------------------------------------------------------------------

#' App User Interface (UI)
#'
#' @name app_ui
#' @family app
#' @family ui
#'
#' @description
#' Core user-interface function for the shiny app.
#'
#' @param req (Internal) Initial HTTP request object.
#'
#' @returns
#' The user-interface (UI) for the shiny application as an [htmltools::tagList()].
#'
#' @seealso [bslib::page_navbar()]
#'
#' @export
#'
#' @importFrom htmltools tagList tags
#' @importFrom bslib page_navbar nav_panel nav_menu nav_item nav_spacer
#' @importFrom bsicons bs_icon
#' @importFrom shiny icon textOutput actionLink
app_ui <- function(req) {

  force(req)

  htmltools::tagList(
    app_assets(),
    bslib::page_navbar(

    )
  )

}


# header ------------------------------------------------------------------

#' App Header UI
#'
#' @family app
#' @family ui
#'
#' @description
#' This function generates an HTML `<header>` tag for use as the application's
#' header. This function feeds the main [app_ui()] function's [bslib::page_navbar()]
#' `header` argument.
#'
#' @param id Character string to use as the ID for the header. Defaults to "header".
#' @param ... A collection of [htmltools::tag]s to include in the header.
#'
#' @returns
#' An `htmltools::tags$header()` HTML tag for the app header.
#'
#' @importFrom htmltools tags
#'
#' @export
app_header_ui <- function(id = "header", ...) {
  htmltools::tags$header(id = id, ...)
}


# title -------------------------------------------------------------------

#' App Title UI
#'
#' @family app
#' @family ui
#'
#' @param id Character string to use as the ID for the title. Defaults to "title".
#' @param logo Optional logo to include in the title. Defaults to [app_logo()].
#' @param text Optional text to include in the title. Default to NULL.
#' @param ... Additional content to include in the title.
#'
#' @returns
#' An `htmltools::tags$div()` with the app title.
#'
#' @importFrom htmltools tags
#'
#' @export
app_title_ui <- function(id = "app-title", logo = app_logo(), text = NULL, ...) {
  htmltools::tags$div(
    id = id,
    class = "navbar-brand",
    if (!is.null(logo)) logo,
    if (!is.null(text)) htmltools::tags$span(text),
    ...
  )
}
