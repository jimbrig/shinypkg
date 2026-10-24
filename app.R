
#  ------------------------------------------------------------------------
#
# Title : shinypkg Shiny App
#    By : Jimmy Briggs
#  Date : 2026-10-24
#
#  ------------------------------------------------------------------------

require(this.path)
require(pkgload)

pkgload::load_all(path = this.path::this.proj(), export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
shinypkg::run_app()
