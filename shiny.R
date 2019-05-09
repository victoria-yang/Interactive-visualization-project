# title: "Interactive_dashboard"
# author: "Chieh-An Yang"
# date: "4/4/2019"

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)

Q1 <- read.csv("quiz-categories.csv", header = TRUE)
M1 <- read.csv("midterm-results.csv", header = TRUE)

S1<-M1[,1:32]
S1$total<-rowSums(S1[,2:32], na.rm=TRUE)
S2<-as.matrix(S1[,3:32])
Q2<-as.matrix(Q1[,2:12])
R1<- S2 %*% Q2

S3 <-matrix(1, nrow=1, ncol=30)
R2 <- S3 %*% Q2
R2 <- R2[rep(1, times = 26), ]
P1 <- R1/ R2

S1$total_p <- S1$total/30
R1<- data.frame(R1)
P1<- data.frame(P1)
colnames(P1) <- c("wrangling_p","coding_p","d.trees_p","sna_p","nlp_p","viz_p","n.nets_p",
                  "googleable_p","non.googleable_p","jitl_p","substantive_p")
DF<-cbind(S1,R1,P1)
DF<-rbind(DF,colMeans(DF))
S1<-data.frame(S1)



ui <- navbarPage("My Application",
                 tabPanel("Correlation",
                          fluidPage(                      
                              fluidRow(       
                                  column(4,
                                         "Please select the variables for comparison",
                                         #helpText("Instructions here."),
                                         #Input
                                         selectInput(inputId ="y",
                                                     label = "Y-axis:",
                                                     choices = c("total","wrangling","coding","d.trees","sna","nlp","viz","n.nets",
                                                                 "googleable","non.googleable","jitl","substantive"),
                                                     selected = "wrangling"),
                                         selectInput(inputId ="x",
                                                     label = "X-axis:",
                                                     choices = c("total","wrangling","coding","d.trees","sna","nlp","viz","n.nets",
                                                                 "googleable","non.googleable","jitl","substantive"),
                                                     selected = "total")  
                                  ),
                                  column(8,
                                         "Scatterplot",
                                         textOutput("selected_y"),
                                         textOutput("selected_x"),
                                         plotOutput(outputId ="scatterplot")
                                  )
                              )
                          )
                 ),
                 tabPanel("Test Items"),
                 tabPanel("Individual"),
                 navbarMenu("More",
                            tabPanel("Dataset",
                                     fluidPage(
                                         
                                         # App title ----
                                         titlePanel("Dataset"),
                                         
                                         # Sidebar layout with a input and output definitions ----
                                         sidebarLayout(
                                             
                                             # Sidebar panel for inputs ----
                                             sidebarPanel(
                                                 
                                                 # Input: Selector for choosing dataset ----
                                                 selectInput(inputId = "dataset",
                                                             label = "Choose a dataset:",
                                                             choices = c("Students", "Test Items")),
                                                 
                                                 # Input: Numeric entry for number of obs to view ----
                                                 numericInput(inputId = "obs",
                                                              label = "Number of observations to view:",
                                                              value = 10)
                                             ),
                                             
                                             # Main panel for displaying outputs ----
                                             mainPanel(
                                                 
                                                 # Output: Verbatim text for data summary ----
                                                 #verbatimTextOutput("summary"),
                                                 
                                                 # Output: HTML table with requested number of observations ----
                                                 tableOutput("view")
                                                 
                                             )
                                         )
                                     )
                            ),
                            tabPanel("tabPanel"))
)



server <- function(input, output) {
    
    data <- reactive({
        switch(input$y,
               total = DF$total,
               wrangling = DF$wrangling,
               coding = DF$coding,
               d.trees = DF$d.trees,
               sna = DF$sna,
               nlp = DF$nlp,
               viz = DF$viz,
               n.net = DF$n.nets,
               googleable = DF$googleable,
               non.googleable = DF$non.googleable,
               jitl = DF$jitl,
               substantive = DF$substantive
        )
        
    })
    
    datasetInput <- reactive({
        switch(input$dataset,
               "Students" = S1,
               "Test Items" = Q1)
    })
    
    output$selected_y <- renderText({
        paste("Y-axis: ", input$y)
    }) 
    output$selected_x <- renderText({
        paste("X-axis: ", input$x)
    }) 
    
    output$scatterplot <- renderPlot({
        ggplot(data = DF, aes_string(x = input$x, y = input$y, col="total")) +
            geom_point(size=4)+
            scale_colour_gradient(low = "skyblue1", high = "navyblue")+
            theme(axis.text=element_text(size=12),
                   axis.title=element_text(size=14,face="bold"))+
            geom_hline(yintercept = mean(input$y), linetype="dashed", color="grey24")
            # why this doesn't work?
            # regression line
    })
    
    # output$summary <- renderPrint({
    #     dataset <- datasetInput()
    #     summary(dataset)
    # })
    
    # Show the first "n" observations ----
    output$view <- renderTable({
        head(datasetInput(), n = input$obs)
    })
}
shinyApp(ui = ui, server = server)