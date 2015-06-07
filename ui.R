library(shiny)
library(ggplot2)
source("fit.R")

data <- get.data()
name <- colnames(data)
n <- nrow(data)

slider.window <- function(index1) {
    slider1 <- list(name[index1], min(data[,index1]), max(data[,index1]), mean(data[,index1]))
      list(inputId = slider1[[1]], label = slider1[[1]],
           min=slider1[[2]], max=slider1[[3]], value = slider1[[4]], step = (slider1[[3]]-  slider1[[2]])/100, round = 0)
}

slider1 <- slider.window(1)
slider2 <- slider.window(2)
slider3 <- slider.window(3)
slider4 <- slider.window(4)

title = "Predicting Average Rent Spikes"

dataset <- diamonds
shinyUI(fluidPage(
  h1(title),
  #plot("plot1")
  verbatimTextOutput("summary"),
  fluidRow(
    column(3,
      h4("Header for Sliders"),
      do.call(sliderInput, slider1),
      do.call(sliderInput, slider2),
      do.call(sliderInput, slider3),
      do.call(sliderInput, slider4),
      br()
      #checkboxInput('jitter', 'Jitter'),
      #checkboxInput('smooth', 'Smooth')
    ),
    column(4, offset = 1,
      h4("Header for Drop Downs"),
      selectInput('x', 'X', names(dataset)),
      selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
      selectInput('color', 'Color', c('None', names(dataset)))
    ),
    column(4,
      h4("Header for Drop Downs"),
      selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
      selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
    )
  )
))
