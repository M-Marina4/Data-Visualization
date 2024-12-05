# Water Quality Analysis and Visualization Project

## Project Description
This project involves the analysis and visualization of water quality data collected from various monitoring stations across Armenia. The goal is to understand the state of water quality, identify pollution trends, and communicate insights effectively using interactive tools such as Shiny apps, maps, and reports. The project covers various aspects of water quality, including dissolved oxygen levels, chemical oxygen demand, heavy metal concentrations, and nutrient pollution.

## Folder and File Structure

- **Shapefiles**: Contains geographic data files for mapping purposes, used to visualize the distribution of water quality monitoring stations and river basins.
- **Shiny**: Houses the files for the Shiny app, which allows interactive exploration of the water quality data.
- **Slides**: Contains presentation materials summarizing key insights and findings from the project.
- **data**: Contains datasets used in this project, including detailed measurements of water quality parameters and geographic coordinates of monitoring stations.
- **report**: Includes generated reports with in-depth analyses, visualizations, and insights related to water quality in Armenia.
- **rsconnect**: Contains deployment details for the Shiny app.
- **.gitignore**: Specifies files that are excluded from version control.
- **analysis.Rmd**: RMarkdown file used to perform analyses, create visualizations, and generate reports on water quality data.
- **project.Rproj**: R project configuration file to help organize and manage the project.

## Data Source
The datasets used in this project were obtained from various sources, including Armenian government agencies, environmental monitoring reports, and research studies. The primary dataset contains detailed water quality measurements such as dissolved oxygen, ammonium levels, chemical oxygen demand (COD), and heavy metal concentrations. An additional dataset includes geographic coordinates of the monitoring stations, enabling spatial analysis.

## Installation and Dependencies
- **R version 4.1 or higher**
- Required packages:
  - `ggplot2`
  - `dplyr`
  - `sf` (for mapping)
  - `shiny` (for the interactive app)
  - `corrplot`
  - `lubridate`
  - `networkD3`
  - `FactoMineR`
  - `factoextra`

## Usage Instructions
1. Clone this repository to your local machine.
2. Load the data files from the `data` folder.
3. Run the RMarkdown file (`report.Rmd`) to generate visualizations and perform analyses on water quality data.
4. To use the Shiny app, navigate to the `Shiny` folder and run the Shiny script in RStudio.

## Features
- **Interactive Shiny App**: Allows users to explore water quality data dynamically, including pollutant levels and monitoring station details.
- **Geospatial Visualizations**: Maps showing the distribution of monitoring stations and water quality indicators across different river basins.
- **Correlation Analysis**: Visualizes relationships between various water quality parameters to identify pollution patterns and potential sources.
- **Reports and Slides**: Summarizes findings in well-structured formats for easy presentation.


