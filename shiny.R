library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)
library(shinyBS)
library(DT)

# Load the dataset
water <- read.csv("cleaned_water_data.csv")

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = tags$div(
    "Smart Water Quality Dashboard",
    style = "font-size: 28px; font-weight: bold; text-align: left;"
  ), titleWidth = 455),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("table"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Overview Tab
      tabItem(tabName = "overview",
              fluidRow(
                box(
                  title = div(
                    style = "font-weight: bold; font-size: 30px;", 
                    "Column Descriptions of Water Quality Data"
                  ),
                  width = 12,
                  actionButton("showGlossary", "Open Glossary", icon = icon("book"))
                )
              ),
              
              fluidRow(
                box(
                  title = "Explanation of Importance",
                  width = 12,
                  solidHeader = TRUE,
                  status = "primary",  
                  "The table below shows different measurements used to assess water quality. These include concentrations of nutrients, metals, and organic matter, which help determine the health of aquatic ecosystems and suitability for human use."
                )
              ),
              
              fluidRow(
                box(
                  title = "Column Descriptions",
                  tableOutput("columnDescriptions"), width = 12,
                  bsTooltip("columnDescriptions", "Hover over any term to see an explanation.", "right")
                )
              )
      )
    )
  )
)

# Define Server
server <- function(input, output, session) {
  output$columnDescriptions <- renderTable({
    column_names <- colnames(water)
    
    # Descriptions
    custom_descriptions <- c(
      "Unique identifier for the monitoring station",  
      "Name of the water body being monitored",  
      "Specific river basin where the monitoring station is located", 
      "Specific location of the monitoring station",  
      "Date of the sample collection",  
      "Time when the sample was collected", 
      "Concentration of dissolved oxygen in the water (mg/L)",  
      "Biochemical oxygen demand over 5 days (mg/L)",  
      "Chemical oxygen demand, measuring organic pollutants (mg/L)",  
      "Ammonium concentration in the water (mg/L)",  
      "Nitrite concentration in the water (mg/L)",  
      "Nitrate concentration in the water (mg/L)",  
      "Phosphate concentration in the water (mg/L)", 
      "Zinc concentration in the water (mg/L)",  
      "Copper concentration in the water (mg/L)",  
      "Chromium concentration in the water (mg/L)",  
      "Arsenic concentration in the water (mg/L)",  
      "Cadmium concentration in the water (mg/L)",  
      "Lead concentration in the water (mg/L)", 
      "Nickel concentration in the water (mg/L)",  
      "Molybdenum concentration in the water (mg/L)",  
      "Manganese concentration in the water (mg/L)",  
      "Vanadium concentration in the water (mg/L)",  
      "Cobalt concentration in the water (mg/L)",  
      "Iron concentration in the water (mg/L)",  
      "Calcium concentration in the water (mg/L)",  
      "Magnesium concentration in the water (mg/L)",  
      "Barium concentration in the water (mg/L)",  
      "Beryllium concentration in the water (mg/L)",  
      "Potassium concentration in the water (mg/L)",  
      "Sodium concentration in the water (mg/L)",  
      "Boron concentration in the water (mg/L)",  
      "Aluminum concentration in the water (mg/L)",  
      "Selenium concentration in the water (mg/L)",  
      "Antimony concentration in the water (mg/L)", 
      "Tin concentration in the water (mg/L)",  
      "Total inorganic nitrogen concentration (mg/L as N)",  
      "Phosphorus concentration in the water (mg/L)",  
      "Chloride concentration in the water (mg/L)",  
      "Sulfate concentration in the water (mg/L)",  
      "Silicon concentration in the water (mg/L)", 
      "Total Dissolved Solids, representing concentration of dissolved substances (mg/L)", 
      "Electrical conductivity of the water (microSiemens/cm)",  
      "Hardness of the water, indicating calcium and magnesium levels (mg/L)", 
      "Concentration of suspended solids in the water (mg/L)",  
      "Combined date and time of the sample collection"  
    )
    
    
    # Categories
    categories <- c(
      "General Information", "General Information", "Location", "Location", "General Information",
      "General Information", "Organic Matter", "Organic Matter", "Organic Matter", "Nutrients",
      "Nutrients", "Nutrients", "Nutrients", "Metals", "Metals", "Metals",
      "Metals", "Metals", "Metals", "Metals", "Metals", "Metals",
      "Metals", "Metals", "Metals", "Metals", "Metals", "Metals",
      "Metals", "Metals", "Metals", "Metals", "Metals", "Metals",
      "Metals", "Nutrients", "Nutrients", "Nutrients", "Nutrients",
      "Physical-Chemical Properties", "Physical-Chemical Properties", 
      "Physical-Chemical Properties", "Physical-Chemical Properties", 
      "Physical-Chemical Properties", "Physical-Chemical Properties", "General Information"
    )
    
    if (length(custom_descriptions) < length(column_names)) {
      custom_descriptions <- c(custom_descriptions, rep("No description available", length(column_names) - length(custom_descriptions)))
    } else if (length(custom_descriptions) > length(column_names)) {
      custom_descriptions <- custom_descriptions[1:length(column_names)]
    }
    
    if (length(categories) < length(column_names)) {
      categories <- c(categories, rep("General Information", length(column_names) - length(categories)))
    } else if (length(categories) > length(column_names)) {
      categories <- categories[1:length(column_names)]
    }
    
    data.frame(
      Column = column_names,
      Category = categories,
      Description = custom_descriptions
    )
  }, bordered = TRUE)
  
  # Glossary Modal
  observeEvent(input$showGlossary, {
    showModal(modalDialog(
      title = "Water Quality Glossary",
      p("Here you can find detailed information about each category:"),
      tags$ul(
        tags$li(tags$b("General Information:"), " Includes metadata such as station identifiers, water body names, and sample collection details. These variables help locate and identify the monitoring points and their associated data."),
        tags$li(tags$b("Location:"), " Specifies the geographic details of the sampling sites, such as the river basin and specific station locations, aiding in spatial analysis of water quality."),
        tags$li(tags$b("Organic Matter:"), "Includes measurements such as dissolved oxygen, biochemical oxygen demand (BOD5), and chemical oxygen demand (COD). These variables are critical indicators of organic pollution and the overall health of aquatic ecosystems."),
        tags$li(tags$b("Metals:"), "Covers concentrations of metals such as zinc, lead, arsenic, and others. These variables are monitored for their potential toxicity to aquatic life and humans, often stemming from industrial and mining activities."),
        tags$li(tags$b("Nutrients:"), "Encompasses variables like ammonium, nitrate, phosphate, and total inorganic nitrogen. Elevated nutrient levels are often associated with agricultural runoff and can lead to eutrophication and excessive algae growth."),
        tags$li(tags$b("Physical-Chemical Properties"), "Includes metrics like sulfate, silicon, total dissolved solids (TDS), electrical conductivity, and hardness. These variables describe the general physical and chemical characteristics of the water and its suitability for different uses.")
      ),
      easyClose = TRUE,
      footer = modalButton("Close")
    ))
  })
}

# Run the app
shinyApp(ui = ui, server = server)
