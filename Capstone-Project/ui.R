# ui.R ####


# Libraries and options ####
library(shiny)
library(shinythemes)

# Define the app ####

shinyUI(fluidPage(
    theme = shinytheme("flatly"),
    titlePanel("Word Predictor"),
# Sidebar ####    
    sidebarLayout(
        sidebarPanel(
        # Text input
        textInput("text", label = ('Please enter some text'), value = ''),
        # Number of words slider input
        sliderInput('slider',
                    'Maximum number of predicted words',
                    min = 1,  max = 10,  value = 2
                    )
    ),


    mainPanel(
        paste("You are entering"),
        textOutput("textOut")

    )
    )
))