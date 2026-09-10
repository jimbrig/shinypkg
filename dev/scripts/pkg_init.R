
#  ------------------------------------------------------------------------
#
# Title : Package Initialization Script
#    By : Jimmy Briggs
#  Date : 2026-09-10
#
#  ------------------------------------------------------------------------

usethis::create_package("shinypkg")
usethis::use_directory("dev", TRUE)

usethis::use_git()
usethis::use_github()
