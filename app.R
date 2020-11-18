source("R/packages.R")
source("R/functions_data.R")
source("R/functions_dropdown.R")
source("R/functions_map.R")

data <- read_data(
  raw_file = "data/raw/ships.csv",
  agg_file = "data/processed/ships_agg.rds"
)

ui <- semanticPage(
  title = "Marine Shiny App",
  dropdownUI("dropdown", data = data),
  mapOutput("map")
)

server <- shinyServer(function(input, output, session) {
  c(ship_type, ship_id) %<-% dropdownServer("dropdown", data = data)
  mapServer("map", data = data, ship_type = ship_type, ship_id = ship_id)
})

shinyApp(ui = ui, server = server)
