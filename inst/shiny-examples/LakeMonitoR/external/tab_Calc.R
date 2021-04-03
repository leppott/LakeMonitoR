# Calculate Panel

function(){
  tabPanel("2. Calculate"
           # SideBar ####
           , sidebarLayout(
             sidebarPanel(
               h4("2.A. Define Columns")
               , p("Define columns below for each box")
               , p("Displayed text is a hint not an actual value.")
               , p("Actual tables are displayed to the right.")
               , h4("2.A.1. Define Columns, Measured Values")
               # Future version use selectize input and use columns from file.
               , textInput("col_msr_datetime"
                           , label = "Input, Measurement, DateTime"
                           , placeholder = "Date_Time")
               , textInput("col_msr_depth"
                           , label = "Input, Measurement, Depth (m)"
                           , placeholder = "Depth_m")
               , textInput("col_msr_msr"
                           , label = "Input, Measurement, Measurement"
                           , placeholder = "Water_Temp_C")
               #
               , h4("2.A.2. Define Columns, Lake Areas")
               , textInput("col_area_depth"
                           , label = "Input, Area, Depth (m)"
                           , placeholder = "Contour_Depth")
               , textInput("col_area_area"
                           , label = "Input, Area, Area (m2)"
                           , placeholder = "Area")
               #
               , h4("2.B. Calculate")
               , numericInput("strat_min_days"
                              , label = "Stratification, minimum days"
                              , value = 20)
               , numericInput("minlimit"
                              , label = "Minimum DO (mg/L)"
                              , value = 2)
               , p("Data view must be visible to the right before clicking
                   calculate below.")
               , shinyjs::disabled(actionButton("b_Calc", "Calculate"))
               #
               , h4("2.C. Download Results")
               # Button
               , p("Select button to download zip file with input and results.")
               , p("Check 'results_log.txt' for any warnings or messages.")
               , useShinyjs()
               , shinyjs::disabled(downloadButton("b_downloadData", "Download"))
               #, downloadButton("b_downloadData", "Download")
               # for testing only

             )##sidebarPanel~END
             # Main Panel ####
             , mainPanel(
               tabsetPanel(type="tabs"
                           , tabPanel("Data, Import, Measured Values"
                                      , DT::dataTableOutput('df_import_DT')
                           )
                           , tabPanel("Data, Import, Lakes Areas"
                                      , DT::dataTableOutput('df_import2_DT')
                           )
               )##tabsetPanel~END
             )##mainPanel~END

           )##sidebarLayout~END
  )##tabPanel ~ END
}## FUNCTION ~ END
