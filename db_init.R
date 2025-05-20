
# Libraries ---------------------------------------------------------------

library(DBI)
library(RSQLite)


# Create DB ---------------------------------------------------------------

connection <- dbConnect(RSQLite::SQLite(), "database.db")


# Create Deliveries Table -------------------------------------------------


