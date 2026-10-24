
if (file.exists(".Renviron")) readRenviron(".Renviron")

brand_request <- function(domain, api_key = Sys.getenv("BRANDFETCH_API_KEY"), ...) {

  if (!nzchar(api_key)) {
    cli::cli_abort("{.arg api_key} is required. Try setting the {.env BRANDFETCH_API_KEY} environment variable.")
  }

  httr2::request("https://api.brandfetch.io/v2/brands") |>
    httr2::req_method("GET") |>
    httr2::req_headers("Accept" = "application/json", "Content-Type" = "application/json") |>
    httr2::req_auth_bearer_token(api_key) |>
    httr2::req_url_path_append(domain)
}

brand_resp_tidy <- function(resp) {
  resp_json <- httr2::resp_body_json(resp)

  init_tspec <- tibblify::tspec_row(
    id = tibblify::tib_chr("id"),
    name = tibblify::tib_chr("name"),
    domain = tibblify::tib_chr("domain"),
    tag_line = tibblify::tib_chr("description"),
    description = tibblify::tib_chr("longDescription"),
    quality_score = tibblify::tib_dbl("qualityScore"),
    links = tibblify::tib_df(
      .key = "links",
      .required = FALSE,
      name = tibblify::tib_chr("name"),
      url = tibblify::tib_chr("url")
    )
  )

  resp_init <- tibblify::tibblify(resp_json, spec = init_tspec)

  # logos -------------------------------------------------------------------
  logo_themes <- c()
  logo_types <- c()
  logo_urls <- c()
  logo_backgrounds <- c()
  logo_exts <- c()
  logo_heights <- c()
  logo_widths <- c()
  logo_sizes <- c()

  logo_formats <- resp_json$logos |> purrr::map(purrr::pluck, "formats")

  for (i in seq_along(resp_json$logos)) {

    theme <- resp_json$logos[[i]]$theme
    type <- resp_json$logos[[i]]$type

    formats <- resp_json$logos[[i]]$formats

    for (j in seq_along(formats)) {

      url <- formats[[j]]$src
      bg <- formats[[j]]$background
      ext <- formats[[j]]$format
      height <- formats[[j]]$height
      width <- formats[[j]]$width
      size <- formats[[j]]$size

      if (is.null(bg)) { bg <- NA_character_ }
      if (ext == "svg") {
        height <- NA_integer_
        width <- NA_integer_
      }

      logo_themes <- c(logo_themes, theme)
      logo_types <- c(logo_types, type)
      logo_urls <- c(logo_urls, url)
      logo_backgrounds <- c(logo_backgrounds, bg)
      logo_exts <- c(logo_exts, ext)
      logo_heights <- c(logo_heights, height)
      logo_widths <- c(logo_widths, width)
      logo_sizes <- c(logo_sizes, size)

    }
  }

  logos <- tibble::tibble(
    theme = logo_themes,
    type = logo_types,
    src = logo_urls,
    background = logo_backgrounds,
    ext = logo_exts,
    height = logo_heights,
    width = logo_widths,
    size = logo_sizes
  )

  # colors ------------------------------------------------------------------
  colors_hex <- content$colors |> purrr::map_chr(purrr::pluck, "hex")
  colors_type <- content$colors |> purrr::map_chr(purrr::pluck, "type")
  colors_brightness <- content$colors |> purrr::map_int(purrr::pluck, "brightness")

  hex2rgb <- function(hex) {
    hold <- grDevices::col2rgb(hex)
    r <- hold[1]
    g <- hold[2]
    b <- hold[3]
    out <- glue::glue(
      "rgb({r}, {g}, {b})"
    )
    out
  }

  colors <- tibble::tibble(
    hex = colors_hex,
    type = colors_type,
    brightness = colors_brightness
  ) |>
    dplyr::mutate(
      rgb = purrr::map_chr(hex, hex2rgb)
    )

  # fonts -------------------------------------------------------------------
  fonts_name <- content$fonts |> purrr::map_chr(purrr::pluck, "name")
  fonts_type <- content$fonts |> purrr::map_chr(purrr::pluck, "type")
  fonts_origin <- content$fonts |> purrr::map_chr(purrr::pluck, "origin")
  fonts_origin_id <- content$fonts |> purrr::map_chr(purrr::pluck, "originId")

  fonts <- tibble::tibble(
    name = fonts_name,
    type = fonts_type,
    origin = fonts_origin,
    origin_id = fonts_origin_id
  ) |>
    dplyr::mutate(
      gfonts_url = paste0(
        "https://fonts.google.com/specimen/",
        name
      ),
      import_css = paste0(
        "@import url(",
        stringr::str_c(
          "https://fonts.googleapis.com/css2?family=",
          name
        ),
        ");"
      )
    )

  # company -----------------------------------------------------------------
  company <- content$company |> purrr::compact()

  industries <- company$industries

  industry_names <- industries |> purrr::map_chr(purrr::pluck, "name")
  industry_emojis <- industries |> purrr::map_chr(purrr::pluck, "emoji")
  industry_slugs <- industries |> purrr::map_chr(purrr::pluck, "slug")
  industry_scores <- industries |> purrr::map_dbl(purrr::pluck, "score")

  company_industries <- tibble::tibble(
    name = industry_names,
    emoji = industry_emojis,
    slug = industry_slugs,
    score = industry_scores
  ) |>
    dplyr::arrange(
      desc(score)
    )

}

brand_fetch <- function(domain, api_key = Sys.getenv("BRANDFETCH_API_KEY"), ...) {

  req <- brand_request(domain = domain, api_key = api_key)
  resp <- httr2::req_perform(req)
  httr2::resp_check_status(resp)
  httr2::resp_check_content_type(resp, valid_types = "application/json")



}

brand_resp_



init_spec <- tibblify::tspec_row(
  tibblify::tib_chr("id"),
  tibblify::tib_chr("name"),
  tibblify::tib_chr("domain"),
  tag_line = tibblify::tib_chr("description"),
  description = tibblify::tib_chr("longDescription"),
  quality_score = tibblify::tib_dbl("qualityScore")
)

brand_init <- tibblify::tibblify(resp_json, init_spec)




# brand -------------------------------------------------------------------

brand <- brand_init |>
  dplyr::mutate(
    links = list(links),
    logos = list(logos),
    colors = list(colors),
    fonts = list(fonts),
    company = list(company_industries)
  )

return(brand)

}
