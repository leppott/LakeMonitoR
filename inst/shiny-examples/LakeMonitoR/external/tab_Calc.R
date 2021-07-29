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
               #
               # _cols ----
               , h4("2.A.1. Define Columns, Measured Values")
               # Future version use selectize input and use columns from file.
               , textInput("col_msr_datetime"
                           , label = "Input, Measurement, DateTime"
                           , placeholder = "Date_Time")
               , textInput("col_msr_depth"
                           , label = "Input, Measurement, Depth (m)"
                           , placeholder = "Depth_m")
               , textInput("col_msr_msr"
                           , label = "Input, Measurement, Value 1 (Temp)"
                           , placeholder = "Water_Temp_C")
               , textInput("col_msr_msr2"
                           , label = "Input, Measurement, Value 2 (DO)"
                           , placeholder = "DO_conc")
               #
               , h4("2.A.2. Define Columns, Lake Areas")
               , textInput("col_area_depth"
                           , label = "Input, Area, Depth (m)"
                           , placeholder = "Contour_Depth")
               , textInput("col_area_area"
                           , label = "Input, Area, Area (m2)"
                           , placeholder = "Area")
               #
               , h4("2.A.3. Define Columns, Measure No Date")
               , textInput("col_msrND_datetime"
                           , label = "Input, Measure No Date, DateTime"
                           , placeholder = "Date_Time")
               , textInput("col_msrND_msr"
                           , label = "Input, Measure No Date, Value (WSPD)"
                           , placeholder = "Wind")
               # _calc ----
               , h4("2.B. Calculate")
               # _calc, Strat ----
               , selectInput("strat_method"
                           , label = "Stratification Calculation Method"
                           , choices = c(">=1 deg C over 1-m"
                                         , "top vs. bottom")
                           , selected = ">=1 deg C over 1-m")
               , numericInput("strat_min_days"
                              , label = "Stratification, minimum days"
                              , value = 1)
                , bsTooltip(id = "strat_min_days"
            , title = "Minimum number of days required to define stratification"
                           , placement = "top")
               # _calc, other ----
               , numericInput("minlimit"
                              , label = "Minimum Value 1 (Temp)"
                              , value = 2)
               , bsTooltip(id = "minlimit"
        , title = "Number below which to calculate in stats for Value 1 (Temp)"
                        , placement = "top")
            , numericInput("minlimit2"
                           , label = "Minimum Value 2 (DO)"
                           , value = 2)
            , bsTooltip(id = "minlimit2"
                        , title = "Number to include on plots for Value 2 (DO)"
                        , placement = "top")

              # _calc, Oxy ----
               , numericInput("oxy_temp"
                              , label = "Oxythermal Plot, Temperature"
                              , value = 30)
               , bsTooltip(id = "oxy_temp"
                    , title = "Oxythermal plot, Temp, <="
                    , placement = "top")
               , numericInput("oxy_do"
                              , label = "Oxythermal Plot, Dissolved Oxygen"
                              , value = 3)
              , bsTooltip(id = "oxy_do"
                          , title = "Oxythermal plot, DO, >="
                          , placement = "top")
               # _calc, TDOx ----

              , numericInput("tdox_val"
                             , label = "TDOx - Temp at DO value 'x'"
                             , value = 3)
              , bsTooltip(id = "tdox_val"
                          , title = "Value of 'x' in TDOx."
                          , placement = "top")

                # _calc, button ----
               , p("Data view must be visible to the right before clicking
                   calculate below.")
               , p("Statistics are generated from daily depth means calculation.
                   This process interpolates to integers.")

               , shinyjs::disabled(actionButton("b_Calc", "Calculate"))
               # _download ----
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
                           , tabPanel("Data, Import, Measured, No Depth"
                                      , DT::dataTableOutput('df_import3_DT')
                           )
               )##tabsetPanel~END
             )##mainPanel~END

           )##sidebarLayout~END
  )##tabPanel ~ END
}## FUNCTION ~ END
