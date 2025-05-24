connection <- dbConnect(RSQLite::SQLite(), "database.db")

server <- function(input, output, session) {

  onStop(function() {
    dbDisconnect(connection)
    message("Disconnected from database.")
  })
  
  observeEvent(input$submit, {
    query <- "
    INSERT INTO deliveries (
      date, start_address, delivery_address, returned_to_store,
      meal_amount, tip_amout, delivery_time, store_time,
      total_miles, gender, race, sun ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    
    dbExecute(connection, query, params = list(
      input$date,
      input$start_address,
      input$delivery_address,
      as.integer(isTRUE(input$returned_to_store)),
      input$meal_amount,
      input$tip_amount,
      input$delivery_time,
      input$store_time,
      input$total_miles,
      as.integer(input$gender),
      input$race,
      as.integer(isTRUE(input$sun))
    ))
    
    showModal(modalDialog(
      title = "Success!",
      "Delivery data inserted into the database."
    ))
  })
  
  output$total_tip <- renderValueBox({
    total_tip <- dbGetQuery(connection, "SELECT SUM(tip_amount) AS total FROM deliveries")$total
    valueBox(
      value = sprintf("$%.2f", total_tip),
      subtitle = "Total Tips",
      icon = icon("dollar-sign"),
      color = "blue"
    )
  })
  
  output$total_miles <- renderValueBox({
    total_miles <- dbGetQuery(connection, "SELECT SUM(total_miles) AS total FROM deliveries")$total
    valueBox(
      value = sprintf("%.2f mi", total_miles),
      subtitle = "Total Miles",
      icon = icon("road"),
      color = "green"
    )
  })
  
  output$total_deliveries <- renderValueBox({
    total_deliveries <- dbGetQuery(connection, "SELECT COUNT(*) AS count FROM deliveries")$count
    valueBox(
      value = sprintf("%d", total_deliveries),
      subtitle = "Total Deliveries",
      icon = icon("truck"),
      color = "yellow"
    )
  })
  
  output$avg_tip <- renderValueBox({
    avg_tip <- dbGetQuery(connection, "SELECT AVG(tip_amount) AS average FROM deliveries")$average
    valueBox(
      value = sprintf("$%.2f", avg_tip),
      subtitle = "Tip per Delivery"
    )
  })
  
  output$avg_miles <- renderValueBox({
    avg_miles <- dbGetQuery(connection, "SELECT AVG(total_miles) AS average FROM deliveries")$average
    valueBox(
      value = sprintf("%.2f mi.", avg_miles),
      subtitle = "Miles per Delivery"
    )
  })
  
  output$tip_per_minute <- renderValueBox({
    tip_per_minute <- dbGetQuery(connection, "SELECT SUM(tip_amount) / (SUM(CAST(delivery_time AS INTEGER)) + SUM(CAST(store_time AS INTEGER)) AS average FROM deliveries")$average
    valueBox(
      value = sprintf("$%.2f/min.", tip_per_minute),
      subtitle = "Tip per Minute"
    )
  })
  
  output$tip_per_mile <- renderValueBox({
    tip_per_mile <- dbGetQuery(connection, "SELECT SUM(tip_amount) / SUM(total_miles) AS avearge FROM deliveries")$average
    valueBox(
      value = sprintf("$%.2f/mi.", tip_per_mile),
      subtitle = "Tip per Mile"
    )
  })
}