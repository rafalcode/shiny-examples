# I asked Claude:
# in R shiny, I want the user to be able to select rows via clicking an image
library(shiny)
library(dplyr)
library(htmltools)

# Sample data with image URLs
data <- data.frame(
  id = 1:5,
  name = c("Item A", "Item B", "Item C", "Item D", "Item E"),
  image_url = c(
    "https://shiny.dna.ovh/users/nutria/shiny-examples_rfannot/claude11/im1.jpg",
    "https://shiny.dna.ovh/users/nutria/shiny-examples_rfannot/claude11/im2.jpg",
    "https://shiny.dna.ovh/users/nutria/shiny-examples_rfannot/claude11/im3.jpg", 
    "https://shiny.dna.ovh/users/nutria/shiny-examples_rfannot/claude11/im4.jpg",
    "https://shiny.dna.ovh/users/nutria/shiny-examples_rfannot/claude11/im5.jpg"
  )
)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .clickable-image {
        cursor: pointer;
        border: 2px solid transparent;
        padding: 2px;
        margin: 5px;
        transition: all 0.3s;
      }
      .selected-image {
        border-color: #007bff;
        box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
      }
    "))
  ),
  
  titlePanel("Click Images to Select Rows"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Selected Item:"),
      verbatimTextOutput("selection_info")
    ),
    
    mainPanel(
      # This will contain our clickable images
      uiOutput("image_gallery"),
      
      # Show the data table
      h4("Data Table:"),
      tableOutput("data_table")
    )
  )
)

server <- function(input, output, session) {
  # Create reactive value to store selected row ID
  selected_row <- reactiveVal(NULL)
  
  # Render the clickable images
  output$image_gallery <- renderUI({
    image_tags <- lapply(1:nrow(data), function(i) {
      is_selected <- !is.null(selected_row()) && selected_row() == data$id[i]
      class_str <- if(is_selected) "clickable-image selected-image" else "clickable-image"
      
      tags$div(
        style = "display: inline-block; text-align: center;",
        tags$img(
          src = data$image_url[i],
          height = 100,
          class = class_str,
          onclick = sprintf("Shiny.setInputValue('selected_image', %d);", data$id[i])
        ),
        tags$div(data$name[i])
      )
    })
    
    do.call(tagList, image_tags)
  })
  
  # Update the selected row when an image is clicked
  observeEvent(input$selected_image, {
    selected_row(input$selected_image)
  })
  
  # Display information about the selected row
  output$selection_info <- renderPrint({
    if(is.null(selected_row())) {
      "No row selected"
    } else {
      selected_data <- data %>% filter(id == selected_row())
      cat("ID:", selected_data$id, "\n")
      cat("Name:", selected_data$name, "\n")
    }
  })
  
  # Show the data table
  output$data_table <- renderTable({
    data %>% 
      mutate(
        is_selected = (id == selected_row()),
        # Don't display full URLs in the table
        image_url = substr(image_url, 1, 20)
      )
  })
}

shinyApp(ui = ui, server = server)
