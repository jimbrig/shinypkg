
#  ------------------------------------------------------------------------
#
# Title : Shiny App Cache
#    By : Jimmy Briggs
#  Date : 2026-10-24
#
#  ------------------------------------------------------------------------

#' Shiny App Cache
#'
#' @description
#' - `app_cache()`: Defines an "application-wide" cache for storing data in memory.
#' - `app_session_cache()`: Defines a cache for storing data specific to a user session.
#'
#' @returns
#' - `app_cache()`: A cache object that can be used to store data in memory.
#' - `app_session_cache()`: A cache object that can be used to store data specific
#'
#' @export
#'
#' @importFrom cachem cache_mem
app_cache <- function() {
  cachem::cache_mem(max_size = 500e6)
}

#' @rdname app_cache
#' @export
#' @importFrom cachem cache_mem
app_session_cache <- function() {
  cachem::cache_mem(max_size = 100e6)
}
