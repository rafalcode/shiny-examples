imfiles <- function() {
  return( list.files(pattern="png"))
}

arr <- list.files(pattern="png")

server <- function(input, output) {
  output$myImage <- renderImage({
    list(src = arr[input$n],
         contentType = 'image/png',
         width = 400,
         height = 400,
         alt = "This is alternate text")
  }, deleteFile = FALSE)
}
