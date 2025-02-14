library(png)
library(jpeg)

ui <- fluidPage(
  # Some custom CSS for a smaller font for preformatted text
  tags$head(
    tags$style(HTML("
      pre, table.table {
        font-size: smaller;
      }
    "))
  ),

  fluidRow(
    # column(width = 4),
    column(width = 4,
      br(),
      # In a imageOutput, passing values for click, dblclick, hover, or brush
      # will enable those interactions.
      imageOutput("image1", height = 700,
      # height was originally 350
        # Equivalent to: click = clickOpts(id = "image_click")
        click = "image_click",
        dblclick = dblclickOpts(
          id = "image_dblclick"
        ),
        hover = hoverOpts(
          id = "image_hover"
        ),
        brush = brushOpts(
          id = "image_brush"
        )
      ),
      br()
    )
  ),

  fluidRow(
    column(width = 3,
      verbatimTextOutput("click_info")
    ),
    column(width = 3,
      verbatimTextOutput("dblclick_info")
    ),
    column(width = 3,
      verbatimTextOutput("hover_info")
    ),
    column(width = 3,
      verbatimTextOutput("brush_info")
    )
  )
)

server <- function(input, output, session) {

  # Generate an image with black lines every 10 pixels
  output$image1 <- renderImage({
    # Get width and height of image output
    width  <- session$clientData$output_image1_width
    height <- session$clientData$output_image1_height
    npixels <- width * height

    # Return a list containing information about the image
    # as is R's wont, the last variable gets returned.
    list(
      src = "images/Angelsatmamre-trinity-rublev-1410.jpg",
      contentType = "image/jpeg",
      width = width,
      height = height,
      alt = "Rublev icon"
    )
  })

  # print 4 text boxes.l
  output$click_info <- renderPrint({
    cat("input$image_click:\n")
    str(input$image_click)
  })
  output$hover_info <- renderPrint({
    cat("input$image_hover:\n")
    str(input$image_hover)
  })
  output$dblclick_info <- renderPrint({
    cat("input$image_dblclick:\n")
    str(input$image_dblclick)
  })
  output$brush_info <- renderPrint({
    cat("input$image_brush:\n")
    str(input$image_brush)
  })
}

shinyApp(ui, server)
