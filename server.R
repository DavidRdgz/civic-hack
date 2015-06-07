library(shiny)
library(randomForest)
library(nnet)
source("fit.R")

data   <- get.data()
r.fit  <-fit.model(randomForest, formula("Species ~ ."), data)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$summary <- renderPrint({
        id <- sample(150,1)
       # print(attributes(input)) 
        as.character(predict(r.fit, data[id,], type = "class"))
    })
})
