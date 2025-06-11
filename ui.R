# Libraries ---------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(DBI)
library(DT)
library(glue)

source("server.R")

# UI ----------------------------------------------------------------------

ui <- dashboardPage(
  dashboardHeader(title = "Delivery Logger"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Insert Delivery", tabName = "insert", icon = icon("plus")),
      menuItem("All Deliveries", tabName = "all_deliveries")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "insert",
        fluidRow(
          box(title = "Enter Delivery", width = 12, solidHeader = TRUE, status = "primary",
              fluidRow(
                column(6, textInput("date", "Date", value = Sys.Date())),
                column(6, textInput("delivery_time", "Delivery Time"))
              ),
              fluidRow(
                column(6, textInput("start_address", "Start Address", value = "STORE")),
                column(6, textInput("delivery_address", "Delivery Address"))
              ),
              fluidRow(
                column(6, textInput("store_time", "Store Time")),
                column(6, numericInput("total_miles", "Total Miles", value = 0))
              ),
              fluidRow(
                column(6, numericInput("meal_amount", "Meal Amount", value = 0)),
                column(6, numericInput("tip_amount", "Tip Amount", value = 0))
              ),
              fluidRow(
                column(6, selectInput("gender", "Gender", choices = c("Male" = 0, "Female" = 1))),
                column(6, textInput("race", "Race"))
              ),
              fluidRow(
                column(6, checkboxInput("returned_to_store", "Returned to Store", value = TRUE)),
                column(6, checkboxInput("sun", "Inclement Weather?", value = FALSE))
              ),
              actionButton("submit", "Submit Delivery", class = "btn-primary")
          )
        )
      ),
      
      tabItem(
        tabName = "all_deliveries",
        fluidRow(
          box(
            title = "All Deliveries",
            width = 12,                
            solidHeader = TRUE,
            status = "primary",     
            DT::dataTableOutput("all_deliveries")
          )
        )
      )
      
    )
  )
)

shinyApp(ui, server)