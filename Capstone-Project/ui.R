# ui.R ####


# Libraries and options ####
library(shiny)
library(shinythemes)
library(shinydashboard)

# Define the app ####

header <- dashboardHeader(title = "Next Word Predictor")

shinyUI(fluidPage(navbarPage(
  "Word Predictor",
  theme = shinytheme("cerulean"),
  tabPanel(
    icon("home"),
    titlePanel("Word Predictor"),
    # Si    debar ####
    sidebarLayout(
      sidebarPanel(
        br(),
        selectInput(
          "var",
          label = "Select a Language",
          choices = c("English"),
          selected = "English"
        ),
        
        br(),
        # Number of words slider input
        sliderInput(
          'slider',
          'Number of predicted words',
          min = 1,
          max = 10,
          value = 2
        )
      ),
      mainPanel(
        textInput("text", label = h3('Input your text'), value = ''),
        submitButton("Predict", icon("refresh")),
        br(),
        tabsetPanel(type = "tabs",
                    tabPanel(
                      "Predicted Words",
                      textOutput("Please wait while the app is loading"),
                      verbatimTextOutput("value")
                    ))
      )
    )
  )
)))