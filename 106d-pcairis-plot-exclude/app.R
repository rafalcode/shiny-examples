library(ggplot2)
library(ggfortify)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux

ui <- fluidPage(
  titlePanel("Alternative to allow for repeated removals"),
  fluidRow(
    column(width = 6,
      plotOutput("plot1", height = 350,
        brush = brushOpts(
          id = "plot1_brush"
        )
      ),
      actionButton("exclude_toggle", "Exclude points"),
      actionButton("exclude_reset", "Reset")
    )
  ),
  fluidRow(
    column(width = 12,
      h4("Whatsleft"),
      verbatimTextOutput("whatsleft")
    )
  ),
  fluidRow(
    column(width = 4,
      h4("Projdf"),
      verbatimTextOutput("projdf")
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
  idxs <- reactiveValues(
    i = 1:nrow(df)
  )

  # Reactive expression: filtered data and PCA projection
  # so this is a worker, the recipe for the extra processing/work that is needed.
  # Note this always operates on the original df!
  dfpc <- reactive({
    # df2 <- df[vals$idxleft, , drop = FALSE]
    df2 <- df[idxs$i, , drop = FALSE]
    pca_res <- prcomp(df2[1:4], scale. = TRUE)
    percentVar <- pca_res$sdev^2 / sum( pca_res$sdev^2 )
    df_proj <- as.data.frame(pca_res$x)[1:2]
    colnames(df_proj) <- paste0(colnames(df_proj), " (", percentVar[1:2], "%)")
    df_proj$species <- df2$Species # this can be done, because thr prcomp retains the df2 order - not apparent but I checked and yes
    df_proj$index <- idxs$i # only need for labelling graph
    rownames(df_proj) <- 1:nrow(df_proj) # not really necessary, but it reminds us how brushPoints sees the reactive df.
    df_proj
  })

  output$plot1 <- renderPlot({
    keptpc1 <- dfpc() 
    ggplot(keptpc1, aes(x = .data[[1]], y = .data[[2]], label=index)) +
      geom_point(aes(col=keptpc1$species), size=3.5) +
      geom_text(vjust = -1, size = 4) +
      xlim(-3, 3) +
      ylim(-2.5, 2.5)
  })

  output$brush_info <- renderPrint({
    keptpc3 <- dfpc() 
    brushedPoints(keptpc3, input$plot1_brush)
  })

  output$projdf <- renderPrint({
    dfpc() 
  })

  output$whatsleft <- renderPrint({
    # vals$keeprows
    # idx$left
    # paste0(" We have ", n(), " left.") # cannot coerce closure to character, n is a closure! So you need n(). But n() doesn't update!
    # paste0(" We have ", sum(vals$keeprows), " left.") # this works ... as if observeEvent can only handle 1 rv
    idxs$i
  })

  # Toggle points by brush
  observeEvent(input$exclude_toggle, {
    keptpc4 <- dfpc()
    res <- brushedPoints(keptpc4, input$plot1_brush, allRows = TRUE)
    idxs$i <- setdiff(idxs$i, keptpc4$index[which(res$selected_)])
  })

  # Reset all points
  observeEvent(input$exclude_reset, {
    idxs$i <- 1:nrow(df)
  })
}

shinyApp(ui, server)
