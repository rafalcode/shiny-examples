library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Colored Squares Generator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("n_squares", 
                   "Enter number of squares:", 
                   value = 5, 
                   min = 1, 
                   max = 100),
      actionButton("generate", "Generate Squares")
    ),
    
    mainPanel(
      h4("Your Colored Squares:"),
      uiOutput("squares_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Generate squares when button is pressed
  observeEvent(input$generate, {
    n <- as.integer(input$n_squares)
    
    # Generate random colors for the squares
    colors <- sample(colors(), n, replace = TRUE)
    
    # Create the squares using CSS
    squares <- lapply(1:n, function(i) {
      div(
        style = paste0(
          "display: inline-block;",
          "width: 50px;",
          "height: 50px;", 
          "margin: 5px;",
          "background-color: ", colors[i], ";"
        )
      )
    })
    
    # Update the UI with the generated squares
    output$squares_output <- renderUI({
      div(squares)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
