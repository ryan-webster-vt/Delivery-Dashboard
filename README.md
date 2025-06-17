# Delivery Dashboard
## Summary
The Delivery Dashboard tool utilizes R's Shiny library for an UI for storing information about an individual delivery (address, tip amount, miles driven, etc.) into a MySQL database via a user-friendly interface. Using this database,
a live connection is established onto a Tableau workbook such that the user can visualize their data through a dashboard to show useful information including summary statistics about their deliveries and a more in-depth
look into which day of the week provides the best tips and will attempt to forecast future tips made on a certain day.

## Instructions
* Insure that R, Tableau, and MySQL are downloaded onto your machine.
* Clone the repository onto your machine
```bash
git clone https://github.com/ryan-webster-vt/Delivery-Dashboard/
```
* Open db_init.R. Either replace the user and password fields in the connection or create your own .env file with your MySQL login credentials.
* Execute the entire file, either by clicking Ctrl+A+Enter or Ctrl+Enter each line. With this, the deliveries table has been created.
* You'll most likely have to install the necessary libraries to run the application. Run this code into your console:
```R
install.packages(c("shiny", "shinydashboard", "DBI", "DT", "glue", "RMySQL", "dotenv"))
```
* In the ui.R file, click "Run App" to launch the application.
