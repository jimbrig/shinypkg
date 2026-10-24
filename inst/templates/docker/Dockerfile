# template variables: {{rver}}, {{sysreqs}}, {{port}}, {{envvars}}, {{pkgname}}

#syntax=docker/dockerfile:1.4

# base stage
ARG R_VERSION="{{rver}}"
FROM rocker/r-ver:${R_VERSION} AS base

# sysreqs (build & runtime)
{{sysreqs}}

# install pak
RUN Rscript -e 'install.packages("pak", repos = sprintf("https://r-lib.github.io/p/pak/stable/%s/%s/%s", .Platform$pkgType, R.Version()$os, R.Version()$arch))'

# build stage
FROM base As build

# copy source code into /build
WORKDIR /build
COPY . .

# install local package including dependencies (inject github pat as mounted secret)
RUN --mount=type=secret,id=github_pat \
  export GITHUB_PAT=$(cat /run/secrets/github_pat) && \
  Rscript -e "Sys.setenv(GITHUB_PAT = Sys.getenv('GITHUB_PAT')); pak::local_install('.', ask = FALSE)" && \
  unset GITHUB_PAT

# cleanup build stage
RUN rm -rf /build

# shiny stage
FROM base AS shiny

# copy package dependencies from build stage
COPY --from=build /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/

# port & host
ARG PORT="{{port}}"
ENV SHINY_PORT=${PORT}
ENV SHINY_HOST="0.0.0.0"
EXPOSE ${PORT}

# configuration
ARG CONFIG="default"
ENV R_CONFIG_ACTIVE=${CONFIG}
ENV R_CONFIG_FILE="/usr/local/lib/R/site-library/{{pkgname}}/config/config.yml"

# additional envvars
{{envvars}}

# healthcheck
HEALTHCHECK CMD curl --fail http://localhost:${SHINY_PORT}/health || exit 1

# Run the application
CMD ["R", "-e", "{{pkgname}}::run_app(host = Sys.getenv('SHINY_HOST'), port = as.integer(Sys.getenv('SHINY_PORT')))"]
