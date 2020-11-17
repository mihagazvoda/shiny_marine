source("R/packages.R")
source("R/functions.R")

df_agg <- read_data(
  raw_file = "data/raw/ships.csv",
  agg_file = "data/processed/ships_agg.rds"
)

ui <- semanticPage(
  title = "Dropdown example",
  dropdown_input(
    "ship_type_dropdown",
    choices = unique(df_agg$ship_type),
    type = "selection fluid"
  ),
  dropdown_input(
    "ship_id_dropdown",
    choices = NULL,
    type = "selection fluid"
  ),
  leafletOutput("map")
)


server <- shinyServer(function(input, output, session) {
  ship_id_choices <- reactive({
    filter(df_agg, ship_type == input$ship_type_dropdown)$ship_id
  })

  selected_ship <- reactive({
    filter(
      df_agg,
      ship_type == input$ship_type_dropdown,
      ship_id == input$ship_id_dropdown
    )
  })

  observeEvent(input$ship_type_dropdown, {
    update_dropdown_input(session, "ship_id_dropdown", choices = ship_id_choices())
  })

  output$map <- renderLeaflet({
    leaflet(selected_ship()) %>%
      addTiles() %>%
      addMarkers(lng = ~ c(lon, lon_next), lat = ~ c(lat, lat_next))
  })
})

shinyApp(ui = ui, server = server)
