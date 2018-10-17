# server.R ####
library(shiny)

# Define application ####
source("predict.R")
source("functions.R")

function(input, output, session) {
    # Predict Word
    result <- observeEvent(input$Predict, {
        input$text
    })
    output$value <- renderPrint({
        pred.boff(input$text, input$slider)
    })
}
