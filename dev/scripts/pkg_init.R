
#  ------------------------------------------------------------------------
#
# Title : Package Initialization Script
#    By : Jimmy Briggs
#  Date : 2026-09-10
#
#  ------------------------------------------------------------------------

usethis::create_package("shinypkg")
usethis::use_directory("dev", TRUE)

desc::desc_set(
  "Title" = "Shiny App as R Package",
  "Description" = "Streamlines the process of creating a Shiny app as an R package."
)

desc::desc_set_dep("R", type = "Depends", version = ">= 4.2.0")
desc::desc_set_dep("rlang", type = "Imports", version = ">= 1.1.0")
desc::desc_set_dep("shiny", type = "Imports", version = ">= 1.14.0")
desc::desc_set_dep("bslib", type = "Imports", version = ">= 0.12.0")


desc::desc_set("Config/rcmdcheck/ignore-inconsequential-notes", "true")
desc::desc_set("Config/testthat/edition", "3")

desc::desc_normalize()

usethis::use_mit_license(copyright_holder = "Jimmy Briggs <jimmy.briggs@jimbrig.com>")

usethis::use_git()
usethis::use_github()
usethis::use_github_links()

usethis::use_directory(".github", ignore = TRUE)
usethis::use_git_ignore(c("*.html"), ".github")
# usethis::use_github_file(repo_spec = "noclocks/.github", path = ".github/dependabot.yml", save_as = ".github/dependabot.yml")



file.create("AGENTS.md")
usethis::use_build_ignore("AGENTS.md")
usethis::use_directory(".cursor", TRUE)
usethis::use_git_ignore(c("mcp.env"), ".cursor")
usethis::use_directory(".vscode", ignore = TRUE)

file.create(".Rprofile")
usethis::use_build_ignore(".Rprofile")

usethis::use_build_ignore("shinypkg.code-workspace")
usethis::use_build_ignore(".editorconfig")
usethis::use_build_ignore(".gitattributes")
usethis::use_build_ignore(".cursorignore")
usethis::use_build_ignore(".Renviron")

attachment::att_amend_desc(use.config = TRUE, update.config = TRUE, path.c = "dev/attachment.config.yml")
usethis::use_dev_package("shinydocker", type = "Suggests", remote = "coatless-rpkg/shinydocker")
usethis::use_dev_package("shinyhealth", type = "Suggests", remote = "jimbrig/shinyhealth")
usethis::use_dev_package("pw", type = "Suggests", remote = "ThinkR-open/pw")
attachment::att_amend_desc(update.config = TRUE, path.c = "dev/attachment.config.yml", extra.suggests = c("shinytest2", "shinyloadtest", "spelling", "testthat", "pw", "quarto", "knitr", "rmarkdown", "shinydocker", "shinyhealth"))

usethis::use_build_ignore("app.R")

usethis::use_air()

usethis::use_directory("srcts", TRUE)

usethis::use_data_raw("internal")
usethis::use_data_raw("exported")

usethis::use_github_action(name = "check-standard")
usethis::use_github_action(name = "document")
usethis::use_github_action(name = "shiny-deploy")
usethis::use_github_action(url = "https://github.com/posit-dev/setup-air/blob/main/examples/format-suggest.yaml")
usethis::use_github_action(url = "https://github.com/posit-dev/setup-air/blob/main/examples/format-check.yaml")
usethis::use_github_action(url = "https://github.com/ThinkR-open/pw/blob/main/inst/playwright.yml")

file.create(".github/workflows/shiny-deploy")
