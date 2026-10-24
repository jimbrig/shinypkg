
AppInfo <- S7::new_class(
  name = "AppInfo",
  properties = list(
    name = S7::class_character,
    title = S7::class_character,
    description = S7::class_character,
    version = S7::new_property(class = S7::class_character, default = pkg_version()),
    url = S7::class_character,
    repo = S7::class_character,
    docs = S7::class_character,
    authors = S7::class_character,
    license = S7::class_character,
    extras = S7::class_list
  )
)

info <- AppInfo(
  name = pkg_name(),
  title = "Shiny App",
  description = "Demonstration Shiny App",
  repo = "https://github.com/jimbrig/shinypkg",
  docs = "https://docs.jimbrig.com/shinypkg"
)

app_info <- function(...) {
  info_lst <- S7::props(info) |> purrr::compact()
  if (missing(...)) return(info_lst)
  info_lst[[...]]
}

# app_info("name")
