dropdownUI <- function(id, data) {
  tagList(
    dropdown_input(NS(id, "ship_type"), choices = unique(data$ship_type)),
    dropdown_input(NS(id, "ship_id"), choices = NULL)
  )
}

dropdownServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ship_id_choices <- reactive({
      filter(data, ship_type == input$ship_type)$ship_id
    })

    observeEvent(input$ship_type, {
      update_dropdown_input(session, "ship_id", choices = ship_id_choices())
    })

    list(
      ship_type = reactive(input$ship_type),
      ship_id = reactive(input$ship_id)
    )
  })
}
