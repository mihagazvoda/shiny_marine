infographicOutput <- function(id) {
  tagList(
    textOutput(NS(id, "text")),
    leafletOutput(NS(id, "map"))
  )
}

infographicServer <- function(id, data, ship_type, ship_id) {
  stopifnot(is.reactive(ship_type))
  stopifnot(is.reactive(ship_id))

  moduleServer(id, function(input, output, session) {
    selected_ship <- reactive({
      data %>%
        filter(
          ship_type == ship_type(),
          ship_id == ship_id()
        )
    })

    output$text <- renderText({
      distance <- glue::glue("Distance: { as.integer(round(selected_ship()$dist)) } meters.")
    })

    output$map <- renderLeaflet({
      selected_ship() %>%
        leaflet() %>%
        addTiles() %>%
        addMarkers(lng = ~ c(lon, lon_next), lat = ~ c(lat, lat_next))
    })
  })
}
