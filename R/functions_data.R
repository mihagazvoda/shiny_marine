#' Title
#'
#' @param raw_file
#' @param agg_file
#'
#' @return
#' @export
#'
#' @examples
read_data <- function(raw_file, agg_file) {
  if (file.exists(agg_file)) {
    agg_data <- read_rds(agg_file)
  } else {
    agg_data <- read_csv(raw_file) %>%
      janitor::clean_names() %>%
      agg_ship()

    write_rds(agg_data, file = agg_file)
  }

  agg_data
}

#' Title
#'
#' @param df
#'
#' @return
#' @export
#'
#' @examples
agg_ship <- function(df) {
  df %>%
    select(ship_type, ship_id, datetime, lat, lon) %>%
    group_by(ship_type, ship_id) %>%
    mutate(
      lat_next = lead(lat, order_by = datetime),
      lon_next = lead(lon, order_by = datetime),
      dist = distHaversine(cbind(lon, lat), cbind(lon_next, lat_next)) # method assumes a spherical earth, ignoring ellipsoidal effects.
    ) %>%
    arrange(desc(dist, datetime)) %>%
    slice_head(n = 1)
}

