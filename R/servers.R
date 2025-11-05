data_frame <- function(x, call = rlang::caller_call()) {
  structure(x, class = c("tbl", "data.frame"))
}

hetzner_req <- function(
  path,
  host = "https://api.hetzner.cloud/v1",
  token = Sys.getenv("HETZNER_API_KEY")
) {
  httr2::request(host) |>
    httr2::req_url_path_append(path) |>
    httr2::req_auth_bearer_token(token)
}


list_servers <- function() {
  res <- hetzner_req("servers") |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  # combine into tbl
  servers <- data_frame(
    vctrs::vec_rbind(!!!res$servers)
  )

  # fix list columns
  needlessly_nested <- c(
    "id",
    "name",
    "status",
    "primary_disk_size",
    "created",
    "included_traffic",
    "ingoing_traffic",
    "outgoing_traffic",
    "rescue_enabled",
    "locked"
  )
  for (col in needlessly_nested) {
    servers[[col]] <- unlist(servers[[col]], recursive = FALSE)
  }
  res[["servers"]] <- servers
  res
}


#' Server Actions
#'
#' These functions perform server related actions.
#'
#' @export
#' @rdname server
get_server <- function(id) {
  res <- hetzner_req(sprintf("servers/%s", id)) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  res
}

list_server_actions <- function() {
  # TODO paginate
  hetzner_req("/servers/actions") |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @export
#' @rdname server
server_poweron <- function(id) {
  hetzner_req(sprintf("servers/%s/actions/poweron", id)) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @export
#' @rdname server
server_poweroff <- function(id) {
  hetzner_req(sprintf("servers/%s/actions/poweroff", id)) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @export
#' @rdname server
server_reboot <- function(id) {
  hetzner_req(sprintf("servers/%s/actions/reboot", id)) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
