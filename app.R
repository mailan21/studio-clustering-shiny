library(shiny)
library(shinydashboard)
library(tidyverse)
library(cluster)
library(readxl)
library(DT)

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Clustering Studio 🌸"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      br(),
      div(style = "text-align: center; padding: 10px;",
          h4("✨ MENU STUDIO ✨", style = "color: #4a4a4a; font-family: 'Poppins', sans-serif; font-weight: 800;")),
      hr(),
      
      menuItem("Dashboard & Ringkasan", tabName = "menu_dashboard", icon = icon("th-large")),
      menuItem("Eksplorasi Data Mentah", tabName = "menu_data", icon = icon("table")),
      menuItem("Optimasi Kluster (Elbow)", tabName = "menu_elbow", icon = icon("chart-line")),
      menuItem("Studio Analisis K-Means", tabName = "menu_kmeans", icon = icon("chart-pie")),
      menuItem("Unduh Hasil Akhir", tabName = "menu_download", icon = icon("download")),
      
      hr(),
      div(style = "padding: 15px; color: #000000;",
          fileInput("file", "1. Unggah Berkas (Excel/CSV)", accept = c(".xlsx", ".xls", ".csv")),
          uiOutput("year_select"),
          uiOutput("var_select"),
          numericInput("clusters", "4. Jumlah Kluster (k):", value = 3, min = 2, max = 10)
      )
    )
  ),
