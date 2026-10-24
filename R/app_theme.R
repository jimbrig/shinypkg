
#  ------------------------------------------------------------------------
#
# Title : App Theme
#    By : Jimmy Briggs
#  Date : 2026-09-21
#
#  ------------------------------------------------------------------------


# palette -----------------------------------------------------------------

#' Application's Color Palette
#'
#' @description
#' Color palette for the shiny app.
#'
#' @export
app_color_palette <- c(
  primary = "#063C6C",
  secondary = "#0E2B4C",
  success = "#28a745",
  danger = "#B22222",
  warning = "#ffc107",
  info = "#6BD3D0",
  neutral = "#95A5A6",
  light = "#f5f5f5",
  dark = "#031633",
  white = "#ffffff",
  black = "#000000",
  gray = "#6c757d",
  orange = "#E74C3C",
  dark_gray = "#2c3e50",
  royal_blue = "#1e4d92",
  light_green = "#d4edda",
  light_blue = "#cce5ff",
  light_yellow = "#fff3cd",
  light_red = "#f8d7da",
  light_gray = "#f8f9fa",
  light_purple = "#e2d3f3",
  light_orange = "#ffeeba",
  light_cyan = "#d1ecf1",
  light_pink = "#f5c6cb"
)

# colors ------------------------------------------------------------------

#' App Colors
#'
#' @description
#' Function for accessing colors in the app's defined color palette.
#'
#' @param ... The colors to return.
#'
#' @returns
#' A vector of colors.
#'
#' @export
#'
#' @examples
#' app_colors()
#' app_colors("primary", "secondary")
app_colors <- function(...) {
  dots <- rlang::list2(...)
  if (length(dots) == 0L) {
    return(app_color_palette)
  }
  requested <- unlist(dots)
  out <- unname(unlist(app_color_palette[requested]))
  if (any(is.na(out))) {
    missing <- requested[is.na(out)]
    shinypkg_warn(
      c(
        "The following colors are not defined in the application's color palette: {.field {missing}}",
        "i" = "Run {.code app_colors()} to see all available colors and their names that are defined"
      )
    )
  }
  out
}

# themes ------------------------------------------------------------------

#' App Theme
#'
#' @description
#' This function generates a custom Bootstrap theme for the shiny app.
#'
#' @inheritParams bslib::bs_theme
#' @inheritDotParams bslib::bs_theme
#'
#' @returns
#' A Bootstrap theme generated via [bslib::bs_theme()] leveraging the defined app's colors and assets.
#'
#' @export
#'
#' @seealso [preview_app_theme()] to preview the theme.
#'
#' @importFrom bslib bs_theme bs_add_rules
app_theme <- function(preset = "bootstrap", ..., custom_rules = NULL) {

  theme <- bslib::bs_theme(
    version = 5,
    preset = preset,
    spacer = "1rem",
    "enable-shadows" = TRUE,
    primary = app_colors("primary"),
    secondary = app_colors("secondary"),
    success = app_colors("success"),
    danger = app_colors("danger"),
    warning = app_colors("warning"),
    info = app_colors("info"),
    font_scale = 0.9,
    ...
  )

  if (!is.null(custom_rules)) {
    theme <- theme |> bslib::bs_add_rules(!!!custom_rules)
  }

  theme

}


# preview -----------------------------------------------------------------


#' Preview App Theme
#'
#' @description
#' This function previews the shiny app theme via [bslib::bs_theme_preview()].
#'
#' @inheritDotParams bslib::bs_theme_preview
#'
#' @returns
#' A preview of the theme as a running shiny app.
#'
#' @export
#'
#' @importFrom bslib bs_theme_preview
preview_app_theme <- function(...) {
  bslib::bs_theme_preview(theme = app_theme(), with_themer = TRUE, ...)
}

