library(shiny)
library(ggplot2)
library(caret)
library(randomForest)

#
# Defines the Random Forest model and predictor for 'mpg' in the 'mtcars' dataset.
#
source(file = "modelBuilding.R")

#
# Setting up Shiny Server
#

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

shinyServer(

  function(input, output, session) {

    # To show new lines in the browser
    decoratedDataStructure <- paste0(dataStructure, collapse = "<br/>")
    output$dataStructure <- renderText({decoratedDataStructure})

    # Builds "reactively" the prediction.
    predictMpg <- reactive({

      carToPredict <- data.frame(
        cyl = input$cyl,
        disp = input$disp,
        hp = input$hp,
        drat = input$drat,
        wt = input$wt,
        qsec = input$qsec,
        vs = as.numeric(input$vs),
        am = as.numeric(input$am),
        gear = input$gear,
        carb = input$carb)

      randomForestPredictor(carsRandomForestModelBuilder(), carToPredict)

    })

    output$prediction <- renderTable({
      predictMpg()
    })

  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })

  formulaTextPoint <- reactive({
    paste("mpg ~", "as.integer(", input$variable, ")")
  })

  fit <- reactive({
    lm(as.formula(formulaTextPoint()), data=mpgData)
  })

  output$caption <- renderText({
    formulaText()
  })

  output$mpgBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData)
  })

  output$fit <- renderPrint({
    summary(fit())
  })

  output$mpgPlot <- renderPlot({
    with(mpgData, {
      plot(as.formula(formulaTextPoint()))
      abline(fit(), col=2)
    })

  })
  })
