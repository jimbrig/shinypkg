
#  ------------------------------------------------------------------------
#
# Title : App Assets
#    By : Jimmy Briggs
#  Date : 2026-09-12
#
#  ------------------------------------------------------------------------

#' Shiny App Assets
#'
#' @family app
#' @family ui
#' @family assets
#'
#' @description
#' Functions to manage and include various static assets in the shiny application's
#' user interface.
#'
#' `app_assets()` is the primary high-level function that is used in the main app's [app_ui()]
#' and, depending on the provided arguments and environment/runtime, will call the more specific
#' asset related functions as needed. See the Functions section for details.
#'
#' @section Functions:
#'
#' - `app_assets()`: High level wrapper on top of the independent bundled assets to be
#'   called from the main application's user interface in its HTML `<head>`.
#' - `app_logo()`: The primary application logo. Supports multiple and/or dark and light
#'   mode variants.
#' - `app_favicon()`: The application's favicon or favicon bundle.
#' - `app_loader()`: The application's loading screen and spinner.
#' - `app_html_meta()`: The application's `<meta>` HTML tags
#' - `app_html_deps()`: Bundled internal [htmltools::htmlDependency()]s for the app.
#' - `app_external_deps()`: Bundled or integrated external dependencies for the app.
#'
#'

app_assets <- function() {
  ensure_resource_path()
  htmltools::tags$head(
    htmltools::tagList(
      app_meta(),
      app_favicon(),
      app_loader(),
      app_html_deps()
    )
  )
}


# logo --------------------------------------------------------------------

#' App Logo
#'
#' @description
#' App Logo
#'
#' @param path Path
#' @param theme Theme
#' @param width Width
#' @param height Height
#' @param alt Alt Text
#'
#' @returns
#' `htmltools::tags$img()`
#'
#' @export
#'
#' @importFrom rlang arg_match
#' @importFrom htmltools tags
app_logo <- function(path = pkg_sys_www("images", "logo.png"), theme = c("light", "dark"), width = "auto", height = 50, alt = "App Logo") {
  ensure_resource_path()
  theme <- rlang::match_arg(theme)
  cls <- switch(theme, "light" = "logo-light", "dark" = "logo-dark")
  htmltools::tags$img(src = path, class = cls, alt = alt, width = width, height = height)
}

# favicon -----------------------------------------------------------------

#' App Favicon
#'
#' @family assets
#'
#' @description
#' App Favicon
#'
#' @param path Path
#'
#' @returns
#' `htmltools::tags$link()`
#'
#' @export
#'
#' @importFrom mime guess_type
#' @importFrom htmltools tags
app_favicon <- function(path = pkg_sys_www("images", "favicon.ico")) {
  ensure_resource_path()
  mime_type <- mime::guess_type(path, mime_extra = c("ico" = "image/x-icon"))
  htmltools::tags$link(rel = "icon", type = mime_type, href = path)
}

# loader ----------------------------------------------------------------------------------------------------------

#' App Loader
#'
#' @family assets
#'
#' @description
#' Generates a loading screen for the shiny application.
#'
#' @param text The text to display in the loading screen.
#' @param color The color of the loading spinner.
#' @param background The background color of the loading screen.
#' @param timeout The timeout for the loading screen in milliseconds.
#' @param ... Additional arguments passed to the loading function.
#'
#' @returns
#' An HTML element that displays a loading spinner and text.
#'
#' @export
#'
#' @importFrom shinybusy busy_start_up spin_epic
app_loader <- function(text = "Loading ...", color = app_colors("white"), background = app_colors("primary"), timeout = 1500, ...) {
  shinybusy::busy_start_up(
    loader = shinybusy::spin_epic("orbit", color = color),
    text = text,
    timeout = timeout,
    color = color,
    background = background,
    ...
  )
}

# disconnect ------------------------------------------------------------------------------------------------------



# <meta> ------------------------------------------------------------------


# html deps -------------------------------------------------------------------------------------------------------




