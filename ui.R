library(shiny)
library(ggplot2)
require(reshape2)
source("fit.R")

# Generating Mock Data until Irwin, Ryan, and Marc are done
x <- sample( LETTERS[1:4], 20, replace=TRUE, prob=c(0.1, 0.2, 0.65, 0.05) )
y <- sample( LETTERS[5:8], 20, replace=TRUE, prob=c(0.1, 0.2, 0.65, 0.05) )
z <- sample( LETTERS[1:4], 20, replace=TRUE, prob=c(0.1, 0.2, 0.65, 0.05) )
time <- 1:20
data <- as.data.frame(replicate(16, rnorm(20)) )
d.time<- as.data.frame(replicate(16, rnorm(20)) )
data <- cbind(time,data, x, y, z)

colnames(d.time) <- 1:16
colnames(data) <- c(1:19)
c.names <- colnames(data)
n <- nrow(data)

# Creating Time Series of Specified columns
sub <- melt(data, id = time, 1:8)
#sub <- melt(d.time)
p <- ggplot(sub, aes(x=time, y=value, colour=variable)) + geom_line()

# Creating slider properties function
slider.window <- function(index1) {
    slider1 <- list(c.names[index1], 
                    min(data[,index1]), 
                    max(data[,index1]), 
                    mean(data[,index1]))

    list(inputId = slider1[[1]], 
         label = slider1[[1]],
         min=slider1[[2]], 
         max=slider1[[3]],
         value = slider1[[4]], 
         step = (slider1[[3]]-  slider1[[2]])/100, 
         round = 0)
}

cols <- as.list(1:16)
sliders <- lapply(cols, function(x) slider.window(x))

title = "Predicting Average Rent Spikes"

shinyUI(fluidPage(
  h1(title),
      h4("Historic Avg Home Prices with Specified Parameters"),
  plotOutput("plot"),
      h4("Predicted Home Price"),
  verbatimTextOutput("summary"),
  fluidRow(
    column(3,
      h4("Header for Sliders"),
      do.call(sliderInput, sliders[[1]]),
      do.call(sliderInput, sliders[[2]]),
      do.call(sliderInput, sliders[[3]]),
      do.call(sliderInput, sliders[[4]]),
      do.call(sliderInput, sliders[[5]]),
      do.call(sliderInput, sliders[[6]]),
      do.call(sliderInput, sliders[[7]]),
      do.call(sliderInput, sliders[[8]]),
      br()
    ),
    column(4, offset = 1,
      h4("Header for Drop Downs"),
      selectInput('tract', 'Census-Tract',unique(data[,17])),
      selectInput('year', 'Census-Year', unique(data[,18])),
      selectInput('month', 'Census-Month',unique(data[,19])),
      br()
    ),
    column(4,
      h4("Header for Sliders"),
      do.call(sliderInput, sliders[[9]]),
      do.call(sliderInput, sliders[[10]]),
      do.call(sliderInput, sliders[[11]]),
      do.call(sliderInput, sliders[[12]]),
      do.call(sliderInput, sliders[[13]]),
      do.call(sliderInput, sliders[[14]]),
      do.call(sliderInput, sliders[[15]]),
      do.call(sliderInput, sliders[[16]]),
      br()
    )
  )
))
