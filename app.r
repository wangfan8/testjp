library(shiny)

ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hiragana & Katakana ひらがな & カタカナ" ),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h1(textOutput("question")),
      textInput("answer", "answer", value = "a"),
      actionButton("nextOne", "Next!"),
      radioButtons("HorK", "H or K:", c("H","K")),
      radioButtons("showAnswer", "Show Answer?", c("N","Y"))
    ),
    
    mainPanel(
      textOutput("isCorrect"),
      textOutput("answer")
    )
  )
))


server <- shinyServer(function(input, output) {
  
  data <- read.table("data.txt", header = TRUE
                     , sep=",", colClasses = c("character", "character", "character"))
  
  index <- reactiveValues(index = 1)
  
  observeEvent(input$nextOne, {
    index$index <- runif(1,1,72)
  })
  
  output$answer <- reactive({
    if (input$showAnswer == "N") 
      return("?")
    else 
      return(data$Romaji[index$index])
  })  
  
  output$question <- renderText(
      if (input$HorK == "H")
        data$Hiragana[index$index]
      else 
        data$Katakana[index$index]
      )
  
  output$isCorrect <- reactive({
    if (tolower(input$answer) == data$Romaji[index$index])
    {result <- "TRUE"}
    else 
    {result <- "FALSE"}
    return(result)
  })
  
  
})


shinyApp(ui = ui, server = server)
