library(shiny)

# Define UI for displaying current time ----
ui <- fluidPage(

  h2(textOutput("currentTime"))
  # so, you can see a bit more clearly how the ui gets its variable
  # it assumes output$ and then currentTime is var itself.
  # (or so it would appear).

)

# Define server logic to show current time, update every second ----
server <- function(input, output, session) {

  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste("The current time is", Sys.time())
  })

}

# Create Shiny app ----
shinyApp(ui, server)
