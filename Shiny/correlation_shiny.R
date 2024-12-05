library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(reshape2)

water <- read.csv("../data/processed/cleaned_water_data.csv")

ui <- dashboardPage(
  dashboardHeader(disable = TRUE),  # Removed general title header
  
  dashboardSidebar(disable = TRUE),  # Removed sidebar
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
        .box.box-solid.box-warning>.box-header {
          background: #FFA500;
          color: white;
        }
        .box.box-solid.box-warning {
          border-color: #FFA500;
        }
      "))
    ),
    
    fluidRow(
      box(
        selectInput("corr_vars", "Select Variables for Correlation:", choices = colnames(water %>% select_if(is.numeric)), multiple = TRUE),
        width = 4
      ),
      box(
        plotlyOutput("correlationPlot"),
        width = 8,
        title = "Correlation Heatmap"
      )
    ),
    fluidRow(
      box(
        width = 12,
        title = "Guide to Prediction Values",
        solidHeader = TRUE,
        status = "warning",
        tags$p("The heatmap shows the correlation between different variables. Each cell represents a correlation coefficient ranging from -1 to 1:"),
        tags$p("1 means a perfect positive correlation (both variables increase together)."),
        tags$p("-1 means a perfect negative correlation (one variable increases as the other decreases)."),
        tags$p("0 means no linear relationship."),
        tags$p("The diagonal is always 1 because each variable is perfectly correlated with itself."),
        tags$p("Red indicates positive correlation, blue indicates negative correlation, and lighter colors indicate weak or no correlation."),
        tags$p("Use the heatmap to quickly identify strong positive or negative relationships between variables to understand their interconnections.")
      )
    )
  )
)

server <- function(input, output) {
  output$correlationPlot <- renderPlotly({
    req(input$corr_vars)
    corr_data <- water %>% select(all_of(input$corr_vars)) %>% select_if(is.numeric)
    corr_matrix <- round(cor(corr_data, use = "complete.obs"), 2)
    
    # Make the correlation matrix lower triangular by replacing upper triangular values with NA
    corr_matrix[upper.tri(corr_matrix)] <- NA
    
    # Melt the correlation matrix while removing NA values
    corr_melted <- reshape2::melt(corr_matrix, na.rm = TRUE)
    
    p <- ggplot(corr_melted, aes(Var1, Var2, fill = value)) +
      geom_tile() +
      geom_text(aes(label = value)) +
      labs(title = "Correlation Heatmap", x = "Variable", y = "Variable") +
      scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p)
  })
}

shinyApp(ui = ui, server = server)
