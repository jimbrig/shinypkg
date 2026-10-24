
#  ------------------------------------------------------------------------
#
# Title : aaa.R - Package Shared Resources & roxygen2
#    By : Jimmy Briggs
#  Date : 2026-09-21
#
#  ------------------------------------------------------------------------

# rlang -------------------------------------------------------------------

#' @inheritParams rlang::args_error_context
#' @inheritParams rlang::args_dots_empty
#' @inheritParams rlang::args_data_masking
NULL

# parameters --------------------------------------------------------------

#' Shared Parameters
#'
#' @name .shared-params
#' @keywords internal
#' @noRd
#'
#' @description
#' These parameters are used in multiple functions throughout the package.
#' They are defined here to make it easier to update them in one place.
#'
#' To use these parameters in a function, simply include the following
#' in the function's documentation:
#'
#' ```
#' #' @inheritParams .shared-params
#' ```
#'
#' @param conn,pool Database connection or pool object.
#' @param id Module's namespace identifier.
#' @param input,output,session Shiny input, output, and session objects.
#' @param req,resp `httr2` request and response objects.
NULL


# returns - shiny app -----------------------------------------------------

#' Shared `app` Return
#'
#' @name .shared-return-app
#' @keywords internal
#' @noRd
#'
#' @description
#' Use this shared return for functions returning a shiny app object:
#'
#' ```
#' #' @inherit .shared-return-app returns
#' ```
#'
#' @returns
#' An object of class `shiny.appobj` via [shiny::shinyApp()].
NULL


# returns - modules -------------------------------------------------------

#' Shared Shiny Module Returns
#'
#' @name .shared-return-module
#' @keywords internal
#' @noRd
#'
#' @description
#' Use this shared return for module server functions that return a list of
#' reactive expressions.
#'
#' ```
#' #' @inherit .shared-return-module returns
#' ```
#'
#' @returns
#' A list containing [shiny::reactive()] expressions to be passed along to the calling
#' shiny module or server.
NULL



