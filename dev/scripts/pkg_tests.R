
usethis::use_testthat()
usethis::use_test("shinypkg")
usethis::use_test_helper("shiny")

shinytest2::use_shinytest2()
pw::pw_init(where = this.path::this.proj())
