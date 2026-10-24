
#  ------------------------------------------------------------------------
#
# Title : Package Documentation
#    By : Jimmy Briggs
#  Date : 2026-09-10
#
#  ------------------------------------------------------------------------

# roxygen2 --------------------------------------------------------------------------------------------------------

usethis::use_package_doc()

desc::desc_set("Config/roxygen2/markdown", "TRUE")
desc::desc_set("Config/roxygen2/version", utils::packageVersion("roxygen2"))

fs::dir_create("man/roxygen")
fs::file_create("man/roxygen/meta.R")

attachment::att_amend_desc(use.config = TRUE, update.config = TRUE, path.c = "dev/attachment.config.yml")


# readme ----------------------------------------------------------------------------------------------------------

usethis::use_readme_md()

# changelog -------------------------------------------------------------------------------------------------------

file.create("CHANGELOG.md")
usethis::use_build_ignore("CHANGELOG.md")
usethis::use_github_action(url = "https://github.com/noclocks/.github/blob/main/.github/workflows/changelog.yml")


# badges ----------------------------------------------------------------------------------------------------------

usethis::use_badge(badge_name = "Automate Changelog", href = "https://github.com/jimbrig/shinypkg/actions/workflows/changelog.yml", src = "https://github.com/jimbrig/shinypkg/actions/workflows/changelog.yml/badge.svg")


# vignettes -------------------------------------------------------------------------------------------------------

usethis::use_vignette("shinypkg.qmd", title = "Getting Started")
# usethis::use_vignette("testing.qmd", title = "Testing")

# images ----------------------------------------------------------------------------------------------------------

fs::dir_create("man/figures")

fs::file_copy(
  file.path(fs::path_package("shiny"), "help", "figures", "logo.png"),
  file.path(this.path::this.proj(), "man", "figures", "shiny.png")
)

fs::file_copy(
  file.path(fs::path_package("bslib"), "help", "figures", "logo.png"),
  file.path(this.path::this.proj(), "man", "figures", "bslib.png")
)


# pkgdown ---------------------------------------------------------------------------------------------------------

usethis::use_pkgdown_github_pages()
file.rename(".github/workflows/pkgdown.yaml", ".github/workflows/pkgdown.yml")

usethis::use_directory("pkgdown", ignore = TRUE)
fs::file_move("_pkgdown.yml", "pkgdown/_pkgdown.yml")
pkgdown::build_favicons()

# badges ----------------------------------------------------------------------------------------------------------

usethis::use_lifecycle_badge(stage = "experimental")
usethis::use_r_universe_badge()
usethis::use_badge("Automate Changelog", "https://github.com/jimbrig/shinypkg/actions/workflows/changelog.yml", "https://github.com/jimbrig/shinypkg/actions/workflows/changelog.yml/badge.svg")
usethis::use_badge("pkgdown", "https://github.com/jimbrig/shinypkg/actions/workflows/pkgdown.yml", "https://github.com/jimbrig/shinypkg/actions/workflows/pkgdown.yml/badge.svg")
usethis::use_badge("R CMD Check", "https://github.com/jimbrig/shinypkg/actions/workflows/check.yml", "https://github.com/jimbrig/shinypkg/actions/workflows/check.yml/badge.svg")

# fragments -------------------------------------------------------------------------------------------------------

fs::dir_create("man/fragments")
