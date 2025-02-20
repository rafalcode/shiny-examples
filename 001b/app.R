library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  titlePanel("Choose between various \"old Faithful\" style datasets"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

  radioButtons("radio", label = h3("Choose a dataset"),
    choices = list("faith0" = 1, "faith1" = 2), selected = 1)
  ),

    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot

  # faithful is the embedded R dset, version "0" is a locally sourced one.

  # infile <- paste0("faithful_rf", input$radio, ".csv")  
  # dset <- read.csv(paste0("faithful_rf", input$radio, ".csv")  )
  dsets <- list( read.csv("faithful_rf0.csv") , read.csv("faithful_rf1.csv"))
  output$distPlot <- renderPlot({

    dset <- dsets[[as.integer(input$radio)]]
    # x    <- dsets[[as.integer(input$radio)]]$waiting
    x    <- dset$waiting
    bins <- seq(min(x), max(x), length.out=31)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    })
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
