
#  ------------------------------------------------------------------------
#
# Title : Package Docker
#    By : Jimmy Briggs
#  Date : 2026-10-24
#
#  ------------------------------------------------------------------------

# sysreqs -----------------------------------------------------------------

sysreqs <- pak::pkg_sysreqs("local::.", sysreqs_platform = "ubuntu")
sysreqs_pkgs <- purrr::pluck(sysreqs, "packages", "system_packages", .default = list()) |> unlist()
sysreqs_install_cmd <- paste0(
  "RUN apt-get update -y -qq && apt-get -y --no-install-recommends install \\\n",
  paste("  ", sysreqs_pkgs, collapse = " \\\n"), " \\\n",
  "  && apt-get clean \\\n",
  "  && rm -rf /var/lib/apt/lists/* \\\n",
  "  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds"
)
cat(sysreqs_install_cmd)


# docker ----------------------------------------------------------------------------------------------------------

shinydocker::sitrep_docker()
