# ui.R ####


# Libraries and options ####
library(shiny)
library(shinythemes)
library(shinydashboard)

# Define the app ####

header <- dashboardHeader(
    title = "Next Word Predictor"
)

shinyUI(fluidPage(
    theme = shinytheme("flatly"),
    titlePanel("Word Predictor"),
# Sidebar ####    
    sidebarLayout(
        sidebarPanel(


      selectInput("var", 
                  label = "Select a Language",
                  choices = c("English", 
                              "German",
                              "Finnish",
                              "Russian"),
                  selected = "English"),

        br(),
        # Number of words slider input
        sliderInput('slider',
                    'Number of predicted words',
                    min = 1,  max = 10,  value = 2
                    )
    ),
    mainPanel(
                # Text input
        textInput("text", label = ('Enter some text'), value = ''),
        submitButton("Predict", icon("refresh")),
        br(),
        tabsetPanel(type = "tabs",
                tabPanel("Predicted Words", plotOutput("plot")),
                tabPanel("Summary"),
                tabPanel("Table")
                )
            )
        )
    )
)