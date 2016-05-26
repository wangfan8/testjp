library(shiny)

ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hiragana ひらがな"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h1(textOutput("question")),
      textInput("answer", "answer", value = "a"),
      actionButton("nextOne", "Next!")
    ),
    
    mainPanel(
      textOutput("isCorrect")
      
    )
  )
))


server <- shinyServer(function(input, output) {
  
  data <- read.table("data.txt", header = TRUE
                     , sep=",", colClasses = c("character", "character"))
  
  index <- reactiveValues(index = 1)
  
  observeEvent(input$nextOne, {
    index$index <- runif(1,1,72)
  })
  
  output$question <- renderText(data$Hiragana[index$index])
  
  output$isCorrect <- reactive({
    if (tolower(input$answer) == data$Romaji[index$index])
    {result <- "TRUE"}
    else 
    {result <- "FALSE"}
    return(result)
  })
  
  
})


shinyApp(ui = ui, server = server)