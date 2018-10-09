# server.R ####
library(shiny)

# Define application ####

shinyServer(function(input, output, session) {

    # Predict Word
    result <- reactive({
        pred.backoff(freq.table, input$text)[1:input$nPred, ]
    })
    output$textOut <- renderText(
        paste(input$text)
    )
})