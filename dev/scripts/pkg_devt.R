
#  ------------------------------------------------------------------------
#
# Title : Package Development Script
#    By : Jimmy Briggs
#  Date : 2026-09-10
#
#  ------------------------------------------------------------------------

c(
  # aaa & zzz
  "aaa",
  "zzz",
  # app
  "app_run",
  "app_ui",
  "app_server",
  "app_theme",
  "app_assets",
  "app_config",
  # modules
  "mod_home",
  "mod_about",
  # utils
  "utils_pkg",
  "utils_shiny",
  "utils_checks"
) |>
  purrr::walk(usethis::use_r, open = FALSE)

fs::dir_create("inst/www")
