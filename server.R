connection <- dbConnect(
  RMySQL::MySQL(),
  dbname = "deliveries",
  host = "localhost",
  user = "root",
  password = "password2357!"
)

server <- function(input, output, session) {

  onStop(function() {
    dbDisconnect(connection)
    message("Disconnected from database.")
  })
  
  observeEvent(input$submit, {
    query <- glue("
    INSERT INTO deliveries (
      date, start_address, delivery_address, returned_to_store,
      meal_amount, tip_amount, delivery_time, store_time,
      total_miles, gender, race, sun
    ) VALUES (
      '{input$date}', 
      '{input$start_address}', 
      '{input$delivery_address}', 
      {as.integer(input$returned_to_store)}, 
      {input$meal_amount}, 
      {input$tip_amount}, 
      '{input$delivery_time}', 
      '{input$store_time}', 
      {input$total_miles}, 
      {as.integer(input$gender)}, 
      '{input$race}', 
      {as.integer(input$sun)}
    )
  ")
    
    dbExecute(connection, query)
    
    showModal(modalDialog(
      title = "Success!",
      "Delivery data inserted into the database."
    ))
  })
  
  output$all_deliveries <- DT::renderDataTable({
    all_deliveries <- dbGetQuery(connection, "SELECT * FROM deliveries")
    all_deliveries
  })
  
  
}