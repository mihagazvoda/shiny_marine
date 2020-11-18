mapOutput <- function(id) {
  tagList(leafletOutput(NS(id, "map")))
}

mapServer <- function(id, data, ship_type, ship_id) {
  stopifnot(is.reactive(ship_type))
  stopifnot(is.reactive(ship_id))

  moduleServer(id, function(input, output, session) {
    output$map <- renderLeaflet({
      data %>%
        filter(
          ship_type == ship_type(),
          ship_id == ship_id()
        ) %>%
        leaflet() %>%
        addTiles() %>%
        addMarkers(lng = ~ c(lon, lon_next), lat = ~ c(lat, lat_next))
    })
  })
}
