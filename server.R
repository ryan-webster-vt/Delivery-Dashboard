load_dot_env()

connection <- dbConnect(
  RMySQL::MySQL(),
  dbname = "deliveries",
  host = "localhost",
  user = Sys.getenv("DB_USER"),
  password = Sys.getenv("DB_PASSWORD")
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
      meal_amount, tip_amount, delivery_time,
      total_miles, gender, cash, contactless, inclement_weather, hours_worked
    ) VALUES (
      '{input$date}', 
      '{input$start_address}', 
      '{input$delivery_address}', 
      {as.integer(input$returned_to_store)}, 
      {input$meal_amount}, 
      {input$tip_amount}, 
      {input$delivery_time}, 
      {input$total_miles}, 
      {as.integer(input$gender)}, 
      {as.integer(input$cash)}, 
      {as.integer(input$contactless)}, 
      {as.integer(input$inclement_weather)}, 
      {input$hours_worked}
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