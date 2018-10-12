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
    # result <- reactive({
    #     pred.boff(input$read, input$slider)
    # })
    # library(ggplot2)
    # # Generate a bar plot about probabilities for each predicted words
    # output$plot <- renderPlot({
    #     ggplot(result, aes(Content, Frequency)) + 
    #         geom_bar(stat="identity") + 
    #         scale_x_discrete(limits= result()$Content) +
    #         xlab("Predicted Word") + 
    #         ylab("Probability") +             
    #         coord_flip() +
    #         theme_bw() +
    #         theme(plot.title = element_text(size=22)) +
    #         theme(axis.text.y=element_blank(),
    #               axis.text=element_text(size=12),
    #               axis.title=element_text(size=14,face="bold")) +
    #         geom_text(aes(label=predicted), hjust="inward", color="blue", size=7)  
    # })
}