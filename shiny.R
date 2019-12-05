library(shiny); 
library(shinydashboard);
library(ggplot2);
library(dplyr);
library(lubridate)

setwd("C:\\Users\\kenne\\OneDrive\\Desktop\\Bx Ubiqum\\workshops\\Shiny")
data <- readRDS("data_ready.rds")
# Dashboard 
ui <- dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    sliderInput(
      inputId = "slider1",
        label = "Choose the number of breaks in the histogram:",
        min = 10,
        max = 50,
        value = 25),
    selectInput(                    
      inputId = "input1",
      label= "Choose the year you like to look at ",
      choices = list("2007", "2008", "2009", "2010"))),
  dashboardBody(
      box(plotOutput(outputId = "box1")),
      box(plotOutput(outputId = "hist1"))
  ))
server <- function(input, output) { 
  output$box1 <- renderPlot({ 
    ggplot(data = data %>% filter(year(date) == input$input1))+ 
      geom_line(aes(x = date, y = ActiveEnergy_avg))})
# breaks coorespond to input
  output$hist1<- renderPlot(
    {hist(data$ActiveEnergy_avg, breaks = input$slider1)})
}

shinyApp(ui, server)

