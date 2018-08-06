library(shiny)
library(ggplot2)

# Adds support for graphical tooltips and popovers, in order to enrich de UI.
library(shinyBS)
# Adds Bootstrap themes to a Shiny app.
library(shinythemes)

dataset <- diamonds

# 'mtcars' dataset, user for setting up limits in UI widgets.
data("mtcars")
minCylinders = min(mtcars$cyl)
maxCylinders = max(mtcars$cyl)

minDisp = min(mtcars$disp)
maxDisp = max(mtcars$disp)

minHp = min(mtcars$hp)
maxHp = max(mtcars$hp)

minDrat = min(mtcars$drat)
maxDrat = max(mtcars$drat)

minWt = min(mtcars$wt)
maxWt = max(mtcars$wt)

minQsec = min(mtcars$qsec)
maxQsec = max(mtcars$qsec)

minGear = min(mtcars$gear)
maxGear = max(mtcars$gear)

minCarb = min(mtcars$carb)
maxCarb = max(mtcars$carb)


# Default hypothetical car, in order to initialize th UI widgets.
defaultCar <- data.frame(
  cyl = 6,
  disp = 100,
  hp = 70,
  drat = 4.1,
  wt = 1.8,
  qsec = 24,
  vs = 1,
  am = 1,
  gear = 4,
  carb = 2)

shinyUI(

  navbarPage(

    "Cars Analysis",

    theme = shinytheme("cerulean"),

    tabPanel("Analysis",
                  sidebarPanel(
                    checkboxGroupInput("variable", "Variable:",
                                c("Number of cylinders" = "cyl",
                                  "Displacement (cu.in.)" = "disp",
                                  "Gross horsepower" = "hp",
                                  "Rear axle ratio" = "drat",
                                  "Weight (lb/1000)" = "wt",
                                  "1/4 mile time" = "qsec",
                                  "V/S" = "vs",
                                  "Transmission" = "am",
                                  "Number of forward gears" = "gear",
                                  "Number of carburetors" = "carb"
                                ), selected = "cyl")),

              mainPanel(
                h3(textOutput("caption")),

                tabsetPanel(type = "tabs",
                            tabPanel("BoxPlot", plotOutput("mpgBoxPlot")),
                            tabPanel("Regression model",
                                     plotOutput("mpgPlot"),
                                     verbatimTextOutput("fit")
                            )
                )
              )
		),

    tabPanel("Prediction",

      sidebarPanel(

        width = 4,

        sliderInput("cyl", "Cylinders", min = minCylinders, max = maxCylinders, value = defaultCar$cyl, step = 1),
        bsTooltip(id = "cyl", title = "Number of cylinders in the engine", placement = "right", options = list(container = "body")),

        sliderInput("disp", "Displacement", min = minDisp, max = maxDisp, value = defaultCar$disp, step = 1),
        bsTooltip(id = "disp", title = "Engine displacement (in cu.in.)", placement = "right", options = list(container = "body")),

        sliderInput("hp", "Power", min = minHp, max = maxHp, value = defaultCar$hp, step = 1),
        bsTooltip(id = "hp", title = "Engine's gross horsepower in HP", placement = "right", options = list(container = "body")),

        sliderInput("drat", "Rear axle ratio", min = minDrat, max = maxDrat, value = defaultCar$drat, step = 0.01),
        bsTooltip(id = "drat", title = "Rear axle ratio", placement = "right", options = list(container = "body")),

        sliderInput("wt", "Weight", min = minWt, max = maxWt, value = defaultCar$wt, step = 1),
        bsTooltip(id = "wt", title = "Weight in 1000 lbs", placement = "right", options = list(container = "body")),

        sliderInput("qsec", "1/4 mile time", min = minQsec, max = maxQsec, value = defaultCar$qsec, step = 0.1),
        bsTooltip(id = "qsec", title = "1/4 mile time in seconds", placement = "right", options = list(container = "body")),

        radioButtons("vs", label = "Engine shape", choices = list("V-Shape" = 0, "Straight" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "vs", title = "Engine cylinder configuration (V-shape or straight)", placement = "right", options = list(container = "body")),

        radioButtons("am", label = "Transmission", choices = list("Automatic" = 0, "Manual" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "am", title = "Transmission type (automatic or manual)", placement = "right", options = list(container = "body")),

        sliderInput("gear", "Gears", min = minGear, max = maxGear, value = defaultCar$gear, step = 1),
        bsTooltip(id = "gear", title = "Number of forward gears in the transmission", placement = "right", options = list(container = "body")),

        sliderInput("carb", "Carburetors", min = minCarb, max = maxCarb, value = defaultCar$carb, step = 1),
        bsTooltip(id = "carb", title = "Number of carburetor barrels", placement = "right", options = list(container = "body"))

      ),

      mainPanel(

        width = 8,

        h3("MPG Prediction"),

        br(),

        p("Your consumption will be: "),

        tableOutput("prediction")

      )

    )
  )
)
