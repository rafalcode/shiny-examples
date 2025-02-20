function(input, output) {

  # You can access the values of the widget (as a vector)
  # with input$radio, e.g.
  # outp <- paste0("input_radio is ", input$radio, "\n")
  # outp <- paste0("input_radio is ", input$radio, "\n")
  # output$value <- renderPrint({ input$radio })
  str <- c("um", "dois", "tres")
  # output$value <- renderPrint({ paste0("input_radio is ", input$radio) })
  output$value <- renderPrint({ paste0("input_radio is ", str[as.integer(input$radio)]) })

}
