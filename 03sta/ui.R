fluidPage(
  fluidRow(imageOutput("myImage")),
    wellPanel(
      sliderInput("n", "Image number", 1, 6, value = 1, step = 1, animate=animationOptions(interval=100, loop=TRUE))
    )
)
