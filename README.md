

# Hetzner Cloud API

<!-- badges: start -->
[![R-CMD-check](https://github.com/JosiahParry/hetzner/actions/workflows/R-CMD-check.yaml/badge.svghttps://github.com/JosiahParry/hetzner/actions/workflows/R-CMD-check.yaml/badge.svghttps://github.com/JosiahParry/hetzner/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/JosiahParry/hetzner/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

R bindings to the hetzner cloud console API. Inspired by need.

## Authentication

Create a new API key following [Hetzners
instruction’s](https://docs.hetzner.cloud/reference/hetzner).

Use `usethis::edit_r_environ()` to add it to your .Renviron as:

``` env
HETZNER_API_KEY=your-api-key-here
```

Restart your R session. All functions will use this `HETZNER_API_KEY`
environment variable to perform Bearer authentication via httr2.
