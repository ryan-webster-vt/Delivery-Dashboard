
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
    delivery_time VARCHAR(10),
    start_address VARCHAR(255),
    delivery_address VARCHAR(255),
    store_time VARCHAR(10),
    total_miles DOUBLE,
    meal_amount DOUBLE,
    tip_amount DOUBLE,
    gender TINYINT,
    race VARCHAR(50),
    returned_to_store BOOLEAN,
    sun BOOLEAN
  )
")


# Close -------------------------------------------------------------------

dbDisconnect(connection)




          
