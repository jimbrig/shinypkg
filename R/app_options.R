
#  ------------------------------------------------------------------------
#
# Title : Shiny App Options
#    By : Jimmy Briggs
#  Date : 2026-10-24
#
#  ------------------------------------------------------------------------

app_opts <- function(..., env = get_active_config_env(), reset = FALSE) {
  # if (reset) reset_app_opts()
  # defaults <- switch()
}

# app_default_opts <- function(env = get_active_config_env()) {
#
#   common <- list(
#     "host" = "0.0.0.0",
#     "port" = 8080L,
#     "autoreload" = FALSE,
#     "error" = NULL,
#     "sanitize.errors" = TRUE,
#     "fullstacktrace" = FALSE,
#     "maxRequestSize" = 50*1024^2, # 5MB
#     "minified" = TRUE
#   )
#
#   switch(
#     env,
#     "default"
#   )
# }


#' Set Busy Indicator Options
#'
#' @description
#' Set options for the busy indicator in Shiny applications.
#'
#' @param spinner_type The type of spinner to use. Default is "dots".
#' @param spinner_color The color of the spinner. Default is the primary color from LandRise.
#' @param fade_opacity The opacity of the fade effect. Default is 0.1.
#' @inheritDotParams shiny::busyIndicatorOptions
#'
#' @export
#'
#' @returns
#' An object with busy indicator options set.
#'
#' @importFrom shiny busyIndicatorOptions
app_busy_indicator_opts <- function(
    spinner_type = "dots",
    spinner_color = landrise_colors("primary"),
    fade_opacity = 0.1,
    ...
) {
  shiny::busyIndicatorOptions(
    spinner_type = spinner_type,
    spinner_color = spinner_color,
    fade_opacity = fade_opacity,
    ...
  )
}

#' Navigation Options
#'
#' @inheritParams bslib::navbar_options
#'
#' @returns
#' A list of options for the app navigation bar.
#'
#' @export
#'
#' @importFrom bslib navbar_options
app_nav_opts <- function(
    ...,
    position = c("static-top", "fixed-top", "fixed-bottom"),
    bg = NULL,
    theme = "auto",
    collapsible = TRUE,
    underline = TRUE
) {
  bslib::navbar_options(
    ...,
    position = match.arg(position),
    bg = bg,
    theme = theme,
    collapsible = collapsible,
    underline = underline
  )
}

#' @keywords internal
#' @noRd
.shiny_opts <- c(
  "autoreload",
  "autoreload.interval",
  "autoreload.pattern",
  "bookmarkStore",
  "customMessageHandlers",
  "defaultBrowserHeight",
  "defaultBrowserWidth",
  "deprecation.messages",
  "devmode",
  "disconnected",
  "error",
  "fullstacktrace",
  "host",
  "http.headers",
  "json.digits",
  "launch.browser",
  "maxRequestSize",
  "minified",
  "port",
  "reactlog",
  "sanitize.errors",
  "stacktraceoffset",
  "suppressMissingContextError",
  "table.class",
  "testmode",
  "trace",
  "usecairo"
)
