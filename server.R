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
        #x <- reactiveValuesToList(input)
        #print(x)
        as.character(predict(r.fit, data[id,], type = "class"))
    })
    output$plot <- renderPlot({
        # Creating Time Series of Specified columns
        set.seed(12345)
        Date <- seq(as.Date("2010/1/1"), as.Date("2014/1/1"), "week")
        Y <- rnorm(n=length(Date), mean=100, sd=1)
        df <- data.frame(Date, Y)

        df$Year <- format(df$Date, "%Y")
        df$Month <- format(df$Date, "%b")
        df$Day <- format(df$Date, "%d")

        df$MonthDay <- format(df$Date, "%d-%b")

        p <- ggplot(data=df, mapping=aes(x=MonthDay, y=Y, shape=Year, color=Year)) + geom_point() +geom_line(aes(group = 1))
        p <- p + facet_grid(facets = Year ~ ., margins = FALSE) + theme_bw()
        p
    })
})




