
# Libraries ---------------------------------------------------------------

library(DBI)
library(RSQLite)


# Create DB ---------------------------------------------------------------

connection <- dbConnect(RSQLite::SQLite(), "database.db")


# Create Deliveries Table -------------------------------------------------

dbExecute(connection, "
  CREATE TABLE IF NOT EXISTS deliveries (
    id INTEGER PRIMARY KEY,
    date TEXT,  -- Format: 'YYYY-MM-DD'
    start_address TEXT,
    delivery_address TEXT,
    returned_to_store INTEGER,  -- 1 = Yes, 0 = No
    meal_amount REAL,
    tip_amount REAL,
    delivery_time TEXT,  -- Format: 'HH:MM:SS'
    store_time TEXT,     -- Format: 'HH:MM:SS'
    total_miles REAL,
    gender INTEGER,      -- 0 = Male, 1 = Female
    race TEXT,
    sun INTEGER          -- 1 = Incliment Weather, 0 = Otherwise
  );
")


# Close -------------------------------------------------------------------

dbDisconnect(connection)




          
