library(ggplot2)
library(ggfortify)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux

ui <- fluidPage(
  fluidRow(
    column(width = 6,
      plotOutput("plot1", height = 350,
        click = "plot1_click",
        brush = brushOpts(
          id = "plot1_brush"
        )
      ),
      actionButton("exclude_toggle", "Exclude points"),
      actionButton("exclude_reset", "Reset")
    )
  ),
  fluidRow(
    column(width = 4,
      h4("Projdf"),
      verbatimTextOutput("projdf")
    ),
    column(width = 4,
      h4("Points near click"),
      verbatimTextOutput("click_info")
    ),
    column(width = 4,
      h4("Brushed points"),
      verbatimTextOutput("brush_info")
    )
  )
)

server <- function(input, output) {
  # Original data
  # df <- iris[1:4]
  df <- iris[c(10:12, 60:62, 110:112),]
  row.names(df) <- 1:nrow(df) # restart row indexing.

  # Reactive values to store which rows are currently kept
  # so this is a declaration that "vals" has reactive dependencies
  # i fact, just one, which in long form is vals$keeprows.
  # below would appear to be the initial value.
  vals <- reactiveValues(
    keeprows = rep(TRUE, nrow(df))
  )

  # Reactive expression: filtered data and PCA projection
  # so this is a worker, the recipe for the extr aprocessing/work that is needed.
  dfpc <- reactive({
    df2 <- df[vals$keeprows, , drop = FALSE]
    pca_res <- prcomp(df2[1:4], scale. = TRUE)
    df_proj <- as.data.frame(pca_res$x)[1:2]
    df_proj$species <- df2$Species
    df_proj$index <- which(vals$keeprows)  # add original row indices
    df_proj
  })

  output$plot1 <- renderPlot({
    keptpc1 <- dfpc() 
    ggplot(keptpc1, aes(x = PC1, y = PC2, label=index)) +
      geom_point(aes(col=keptpc1$species), size=3.5) +
      geom_text(vjust = -1, size = 3)
  })

  output$click_info <- renderPrint({
    # Because it's a ggplot2, we don't need to supply xvar or yvar; if this
    # were a base graphics plot, we'd need those.
    keptpc2 <- dfpc() 
    nearPoints(keptpc2, input$plot1_click, addDist = TRUE)
  })

  output$brush_info <- renderPrint({
    keptpc3 <- dfpc() 
    brushedPoints(keptpc3, input$plot1_brush)
  })

  output$projdf <- renderPrint({
    dfpc() 
  })

  # Toggle points by click
  observeEvent(input$plot1_click, {
    keptpc4 <- dfpc() 
    res <- nearPoints(keptpc4, input$plot1_click, allRows = TRUE)
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })

  # Toggle points by brush
  observeEvent(input$exclude_toggle, {
    res <- brushedPoints(dfpc(), input$plot1_brush, allRows = TRUE)
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })

  # Reset all points
  observeEvent(input$exclude_reset, {
    vals$keeprows <- rep(TRUE, nrow(df))
  })
}

shinyApp(ui, server)
