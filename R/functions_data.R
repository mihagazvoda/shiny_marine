#' Reads ship data
#'
#' Reads aggregated data if available, otherwise raw that also gets aggregated and then saved.
#' Aggregated ship data includes one row per ship with the necessary metrics.
#'
#' @param raw_file Path to raw ship data
#' @param agg_file Path to aggregated ship data
#'
#' @return A tibble of aggregated ship data
read_data <- function(raw_file, agg_file) {
  if (file.exists(agg_file)) {
    agg_data <- read_rds(agg_file)
  } else {
    agg_data <- read_csv(raw_file, col_types = cols_only(
      ship_type = col_character(),
      SHIP_ID = col_character(),
      DATETIME = col_datetime(format = ""),
      LAT = col_double(),
      LON = col_double()
    )) %>%
      janitor::clean_names() %>%
      agg_ship_data()

    write_rds(agg_data, file = agg_file)
  }

  agg_data
}

#' Aggregates ship data
#'
#' Aggregates to one observation per vessel with the longest distance between 2 consecutive points.
#'
#' @param data Ship data in tibble (data frame) format
#'
#' @return A tibble
agg_ship_data <- function(data) {
  data %>%
    group_by(ship_type, ship_id) %>%
    mutate(
      lat_next = lead(lat, order_by = datetime),
      lon_next = lead(lon, order_by = datetime),
      dist = geosphere::distHaversine(
        cbind(lon, lat),
        cbind(lon_next, lat_next)
      ) # method assumes a spherical earth, ignoring ellipsoidal effects.
    ) %>%
    arrange(desc(dist, datetime)) %>%
    slice_head(n = 1) %>% # there are some ships that have only one observation - we keep them in
    ungroup() %>%
    select(-datetime)
}
