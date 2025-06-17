
# Libraries ---------------------------------------------------------------

library(DBI)
library(RMySQL)


# Create DB ---------------------------------------------------------------

connection <- dbConnect(
  RMySQL::MySQL(),
  host = "localhost",
  user = "root",
  password = "password2357!"
)


# Create Deliveries Table -------------------------------------------------

dbExecute(connection, "CREATE DATABASE IF NOT EXISTS deliveries")
dbExecute(connection, "USE deliveries")

dbExecute(connection, "
  CREATE TABLE IF NOT EXISTS deliveries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    delivery_time DOUBLE,
    start_address VARCHAR(255),
    delivery_address VARCHAR(255),
    total_miles DOUBLE,
    meal_amount DOUBLE,
    tip_amount DOUBLE,
    gender TINYINT,
    returned_to_store BOOLEAN,
    cash BOOLEAN,
    contactless BOOLEAN,
    inclement_weather BOOLEAN,
    hours_worked DOUBLE
  )
")


# Close -------------------------------------------------------------------

dbDisconnect(connection)




          
