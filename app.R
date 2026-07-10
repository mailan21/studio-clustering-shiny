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
      
      # ========================================================
      # Tempat menaruh kode "menuItem" masing-masing anggota:
      # ========================================================
      # [ANGGOTA 2 TARUH KODE MENUITEM DI SINI]
      menuItem("Eksplorasi Data Mentah", tabName = "menu_data", icon = icon("table")),
      menuItem("Optimasi Kluster (Elbow)", tabName = "menu_elbow", icon = icon("chart-line")),
      # [ANGGOTA 5 TARUH KODE MENUITEM DI SINI]
      # [ANGGOTA 6 TARUH KODE MENUITEM DI SINI]
      # ========================================================
      
      hr(),
      div(style = "padding: 15px; color: #000000;",
          fileInput("file", "1. Unggah Berkas (Excel/CSV)", accept = c(".xlsx", ".xls", ".csv")),
          uiOutput("year_select"),
          uiOutput("var_select"),
          numericInput("clusters", "4. Jumlah Kluster (k):", value = 3, min = 2, max = 10)
      )
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Comfortaa:wght=500;700&family=Poppins:wght=400;600;700&display=swap"),
      tags$style(HTML("
        body, .main-sidebar, .navbar, .logo, h3, h4, h5, p, label { font-family: 'Poppins', sans-serif !important; }
        .skin-blue .main-header .navbar, .skin-blue .main-header .logo { background: linear-gradient(135deg, #ffc0cb 0%, #e6e6fa 100%) !important; color: #4a4a4a !important; font-weight: 700 !important; font-family: 'Comfortaa', cursive !important; }
        .skin-blue .main-header .navbar .sidebar-toggle { color: #4a4a4a !important; }
        .skin-blue .main-sidebar { background-color: #f3effa !important; border-right: 1px solid #e1d8f5; }
        .skin-blue .wrapper, .skin-blue .main-sidebar, .left-side { background-color: #f3effa !important; }
        .skin-blue .main-sidebar .sidebar .sidebar-menu li a { color: #1a1a1a !important; font-weight: 600 !important; }
        .skin-blue .main-sidebar .sidebar .sidebar-menu li.active a, .skin-blue .main-sidebar .sidebar .sidebar-menu li a:hover { background: linear-gradient(90deg, #ffc0cb 0%, #e6e6fa 100%) !important; color: #000000 !important; border-left-color: #b19cd9 !important; }
        .skin-blue .main-sidebar .sidebar label, .skin-blue .main-sidebar .sidebar .control-label, .skin-blue .main-sidebar .sidebar .shiny-input-container { color: #000000 !important; font-weight: 700 !important; }
        .skin-blue .main-sidebar .sidebar input[type='number'] { color: #000000 !important; background-color: #ffffff !important; border: 1px solid #dcd1f0 !important; border-radius: 8px !important; }
        .box { border-radius: 16px !important; box-shadow: 0 8px 24px rgba(186, 164, 219, 0.15) !important; border: none !important; background: #ffffff !important; overflow: hidden; transition: transform 0.3s ease; }
        .box:hover { transform: translateY(-2px); }
        .box.box-solid.box-primary > .box-header { background: linear-gradient(135deg, #a7dbf5 0%, #c3e7fa 100%) !important; color: #4a4a4a !important; font-weight: bold; }
        .box.box-solid.box-info > .box-header { background: linear-gradient(135deg, #ffdfd3 0%, #ffedf2 100%) !important; color: #4a4a4a !important; }
        #download_data { background: linear-gradient(135deg, #a7dbf5 0%, #ffc0cb 100%) !important; color: #4a4a4a !important; border: none; font-weight: bold; border-radius: 20px; padding: 10px 25px; }
        .content-wrapper, .right-side { background-color: #fcfbfe !important; }
        .small-box { border-radius: 16px !important; color: #4a4a4a !important; box-shadow: 0 8px 20px rgba(186, 164, 219, 0.1) !important; }
        .small-box.bg-purple { background: linear-gradient(135deg, #e6e6fa 0%, #f3effa 100%) !important; }
        .small-box.bg-blue   { background: linear-gradient(135deg, #a7dbf5 0%, #c3e7fa 100%) !important; }
        .small-box.bg-maroon { background: linear-gradient(135deg, #ffdfd3 0%, #ffedf2 100%) !important; }
      "))
    ),
    tabItems(
      # ========================================================
      # Tempat menaruh kode "tabItem" masing-masing anggota:
      # ========================================================
      # [ANGGOTA 2 TARUH KODE TABITEM DI SINI]
      tabItem(tabName = "menu_data",
        uiOutput("dataset_title"),
        hr(),
        box(width = 12, DT::DTOutput("table_data"))
),
      tabItem(tabName = "menu_elbow",
        h3("📈 Metode Elbow (Penentuan Jumlah Kelompok Optimal)"),
        p("Grafik di bawah menunjukkan total jarak kuadrat dalam kelompok (WCSS). Titik di mana penurunan mulai melandai (seperti siku tangan) menandakan jumlah kluster terbaik."),
        br(),
        box(title = "Grafik Siku (Elbow Plot)", status = "primary", solidHeader = TRUE, width = 12,
            plotOutput("elbow_plot", height = "400px"))
),
      # [ANGGOTA 5 TARUH KODE TABITEM DI SINI]
      # [ANGGOTA 6 TARUH KODE TABITEM DI SINI]
      # ========================================================
    )
  )
)

server <- function(input, output, session) {
  # --- LOGIKA BACKEND UTAMA (ANGGOTA 1) ---
  raw_data <- reactive({
    req(input$file); ext <- tools::file_ext(input$file$name)
    if (ext %in% c("xlsx", "xls")) { df <- read_excel(input$file$datapath) } 
    else if (ext == "csv") { df <- read.csv(input$file$datapath, stringsAsFactors = FALSE, check.names = FALSE) } 
    else { showNotification("Format file salah!", type = "error"); return(NULL) }
    return(as.data.frame(df))
  })
  
  output$dataset_title <- renderUI({ req(input$file); h3(style = "font-family: 'Comfortaa', cursive; font-weight: bold; color: #5a5a5a;", paste("📂 Berkas Aktif:", input$file$name)) })
  
  output$year_select <- renderUI({
    req(raw_data()); df <- raw_data(); year_col <- grep("year|tahun|waktu|periode", colnames(df), ignore.case = TRUE, value = TRUE)[1]
    if(!is.na(year_col)) { years <- sort(unique(df[[year_col]]), decreasing = TRUE); selectInput("selected_year", "2. Pilih Periode Analisis:", choices = years, selected = years[1]) }
  })
  
  filtered_data <- reactive({
    req(raw_data()); df <- raw_data(); year_col <- grep("year|tahun|waktu|periode", colnames(df), ignore.case = TRUE, value = TRUE)[1]
    if(!is.na(year_col) && !is.null(input$selected_year)) { df_filtered <- df[df[[year_col]] == input$selected_year, ] } else { df_filtered <- df }
    num_cols <- names(df_filtered)[sapply(df_filtered, is.numeric)]
    ignore_cols <- grep("year|tahun|rank|index|id|whisker|kode|no", num_cols, ignore.case = TRUE, value = TRUE)
    cluster_cols <- setdiff(num_cols, ignore_cols)
    label_col <- grep("country|negara|name|nama|objek|id|produk", colnames(df_filtered), ignore.case = TRUE, value = TRUE)[1]
    if(is.na(label_col)) label_col <- colnames(df_filtered)[1]
    df_filtered <- df_filtered[complete.cases(df_filtered[, cluster_cols, drop = FALSE]), ]
    return(list(data = df_filtered, cols = cluster_cols, label = label_col))
  })

  output$var_select <- renderUI({ req(filtered_data()); cluster_cols <- filtered_data()$cols; checkboxGroupInput("selected_vars", "3. Pilih Komponen Indikator:", choices = cluster_cols, selected = cluster_cols[1:min(3, length(cluster_cols))]) })
  
  components_data <- reactive({
    req(filtered_data(), input$selected_vars, input$clusters); df_active <- filtered_data()$data; km_data <- df_active %>% select(all_of(input$selected_vars))
    if(nrow(km_data) < input$clusters || length(input$selected_vars) < 2) return(NULL)
    km_data_scaled <- scale(km_data); set.seed(123); km <- kmeans(km_data_scaled, centers = input$clusters, nstart = 25); pca_res <- prcomp(km_data_scaled, scale. = FALSE)
    plot_df <- as.data.frame(pca_res$x[, 1:2]); plot_df$Cluster <- as.factor(km$cluster); plot_df$ObjectLabel <- df_active[[filtered_data()$label]]
    return(list(km = km, plot_df = plot_df, vars = input$selected_vars, scaled_data = km_data_scaled))
  })
  
  # ========================================================
  # Tempat menaruh kode "output" masing-masing anggota:
  # ========================================================
  # [ANGGOTA 2 TARUH KODE SERVER DI SINI]
  output$table_data <- DT::renderDT({ req(raw_data()); datatable(raw_data(), options = list(pageLength = 5, scrollX = TRUE)) })
  output$elbow_plot <- renderPlot({
    req(components_data()); scaled_matrix <- components_data()$scaled_data
    wss <- sapply(1:10, function(k) { kmeans(scaled_matrix, centers = k, nstart = 10)$tot.withinss })
    elbow_df <- data.frame(k = 1:10, wss = wss)
    ggplot(elbow_df, aes(x = k, y = wss)) +
      geom_line(color = "#b19cd9", size = 1.2) + geom_point(color = "#a7dbf5", size = 4) +
      scale_x_continuous(breaks = 1:10) + theme_minimal(base_size = 14) +
      theme(text = element_text(family = "Poppins")) +
      labs(title = "Hasil Evaluasi Jarak WCSS Terhadap Nilai k", x = "Jumlah Kluster (k)", y = "Total Jarak Dalam Kelompok (WCSS)")
  })
  # [ANGGOTA 5 TARUH KODE SERVER DI SINI]
  # [ANGGOTA 6 TARUH KODE SERVER DI SINI]
  # ========================================================
}

shinyApp(ui, server)
