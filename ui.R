# Libraries ---------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(DBI)
library(DT)
library(glue)
library(RMySQL)
library(dotenv)

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
                column(4, textInput("date", "Date", value = Sys.Date())),
                column(4, textInput("start_address", "Start Address", value = "STORE")),
                column(4, textInput("delivery_address", "Delivery Address"))
              ),
              fluidRow(
                column(4, numericInput("delivery_time", "Delivery Time (Minutes)", value = 0)),
                column(4, numericInput("total_miles", "Total Miles", value = 0)),
                column(4, numericInput("hours_worked", "Hours Worked", value = 0))
              ),
              fluidRow(
                column(4, numericInput("meal_amount", "Meal Amount", value = 0)),
                column(4, numericInput("tip_amount", "Tip Amount", value = 0)),
                column(4, selectInput("gender", "Gender", choices = c("Male" = 0, "Female" = 1)))
              ),
              fluidRow(
                column(4, checkboxInput("cash", "Cash Order?", value = FALSE)),
                column(4, checkboxInput("returned_to_store", "Returned to Store?", value = FALSE)),
                column(4, checkboxInput("inclement_weather", "Inclement Weather?", value = FALSE))
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