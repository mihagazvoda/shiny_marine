source("R/packages.R")
source("R/functions_data.R")
source("R/functions_dropdown.R")
source("R/functions_infographic.R")

data <- read_data(
  raw_file = "data/ships.csv",
  agg_file = "data/ships_agg.rds"
)

ui <- semanticPage(
  title = "Marine Shiny App",
  h2("Marine App"),
  dropdownUI("dropdown", data = data),
  infographicOutput("map")
)

server <- shinyServer(function(input, output, session) {
  c(ship_type, ship_id) %<-% dropdownServer("dropdown", data = data)
  infographicServer("map", data = data, ship_type = ship_type, ship_id = ship_id)
})

shinyApp(ui = ui, server = server)
