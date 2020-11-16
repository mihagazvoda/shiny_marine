agg_ship_data <- function(df) {
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
