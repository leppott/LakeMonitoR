#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Packages
# library(shiny)
# library(LakeMonitoR)
# library(DT)
# library(ggplot2)
# #library(plotly)
# library(shinyjs) # used for togglestate of download button

# Sources Pages ####
tab_Help    <- source("external/tab_Help.R", local = TRUE)$value
tab_Combine <- source("external/tab_Combine.R", local = TRUE)$value
tab_Import  <- source("external/tab_Import.R", local = TRUE)$value
tab_Calc    <- source("external/tab_Calc.R", local = TRUE)$value
tab_Plot    <- source("external/tab_Plot.R", local = TRUE)$value

# Define UI
shinyUI(
  navbarPage("LakeMonitoR, v0.1.1.9004"
    # tabPanel, Help ----
    , tab_Help()
    , tab_Combine()
    , tab_Import()
    #, tab_Calc()
    # , tab_Plot()
    # tabPanel, Combine ----
    # , tabPanel("0. Combine Depth Data Files"
    #            # _SideBar, Combine ----
    #            , sidebarLayout(
    #              sidebarPanel(
    #                # 0. Progress
    #                #, tags$hr()
    #                h4("0.A. Load Files to Combine")
    #                , h5("Select file parameters")
    #                #, checkboxInput('header', 'Header', TRUE)
    #                , fileInput('fn_input_agg', 'Choose CSV files to upload and combine'
    #                            , accept = c('text/csv'
    #                                         , 'text/comma-separated-values'
    #                                         #, 'text/tab-separated-values'
    #                                         #, 'text/plain'
    #                                         , '.csv'
    #                                         #, '.tsv'
    #                                         #, '.txt'
    #                            )
    #                            , multiple = TRUE
    #                )##fileInput~END
    #
    #                , h4("0.B. Combine")
    #                #, shinyjs::disabled(actionButton("b_Agg", "Combine Files"))
    #                ,actionButton("b_Agg", "Combine Files")
    #
    #                , h4("0.C. Download Combined File")
    #                # Button
    #                , p("Select button to download zip file with combined file.")
    #                , p("Check 'agg_log.txt' for any warnings or messages.")
    #                , useShinyjs()
    #                , shinyjs::disabled(downloadButton("b_downloadAgg", "Download"))
    #                #, downloadButton("b_downloadAgg", "Download")
    #                # for testing only
    #
    #              )##sidebarPanel~END
    #              # _MainPanel, Combine ----
    #              , mainPanel(
    #                p("Only CSV files are accepted at this time.")
    #                , p(paste0("File uploads (separately) are limited to a maximum of "
    #                           ,mb_limit
    #                           , " MB in size."))
    #                , p("Only click the 'Combine Files' button once all files are
    #           uploaded. Otherwise an error could occur.")
    #                , p("The combined file will be available for download.")
    #                , p("If want to use the combined file for calculations it will
    #           need to be uploaded.  At this time no cross talk between the
    #           combination and import for calculation steps.")
    #              )##mainPanel~END
    #
    #            )##sidebarLayout~END
    # )##tabPanel ~ Combine ~ END
    # tabPanel, Import ----
  #   , tabPanel("1. Import Data"
  #   # _SideBar, Import ----
  #   , sidebarLayout(
  #     sidebarPanel(
  #       # 0. Progress
  #       #, tags$hr()
  #       h4("1.A. Load File, Measured Values")
  #       , h5("Select file parameters")
  #       #, checkboxInput('header', 'Header', TRUE)
  #       , radioButtons('sep', 'Separator',
  #                      c(Comma=',',
  #                        #Semicolon=';',
  #                        Tab='\t'),
  #                      ',')
  #       , fileInput('fn_input', 'Choose file to upload',
  #                   accept = c(
  #                     'text/csv',
  #                     'text/comma-separated-values',
  #                     'text/tab-separated-values',
  #                     'text/plain',
  #                     '.csv',
  #                     '.tsv',
  #                     '.txt'
  #                   )
  #       )##fileInput~END
  #       #, tags$hr()
  #       , h4("1.B. Load File, Lake Areas")
  #       , radioButtons('sep2', 'Separator',
  #                      c(Comma=',',
  #                        #Semicolon=';',
  #                        Tab='\t'),
  #                      ',')
  #       , fileInput('fn_input2', 'Choose file to upload',
  #                   accept = c(
  #                     'text/csv',
  #                     'text/comma-separated-values',
  #                     'text/tab-separated-values',
  #                     'text/plain',
  #                     '.csv',
  #                     '.tsv',
  #                     '.txt'
  #                   )
  #       )##fileInput~END
  #
  #       , h4("1.C. Load File, Measure, No Depth")
  #       , radioButtons('sep3', 'Separator',
  #                      c(Comma=',',
  #                        Semicolon=';',
  #                        Tab='\t'),
  #                      ',')
  #       , fileInput('fn_input3', 'Choose file to upload',
  #                   accept = c(
  #                     'text/csv',
  #                     'text/comma-separated-values',
  #                     'text/tab-separated-values',
  #                     'text/plain',
  #                     '.csv',
  #                     '.tsv',
  #                     '.txt'
  #                   )
  #       )##fileInput~END
  #
  #     )##sidebarPanel~END
  #     # _MainPanel, Import ----
  #     , mainPanel(
  #       p("The 'separator' allows the user to upload different file formats
  #           (csv, tsv, or txt).")
  #       , p("A measured values file is required.")
  #       , p("If an area file is not uploaded then only stratification will be
  #             calculated.")
  #       , p("Imported data files are displayed in step 2.")
  #       , p(paste0("File uploads (separately) are limited to a maximum of "
  #                  ,mb_limit
  #                  , " MB in size."))
  #     )##mainPanel~END
  #
  #   )##sidebarLayout~END
  # )##tabPanel ~ END
  # tabPanel, Calc ----
  # , tabPanel("2. Calculate"
  #             # _SideBar, Calc ----
  #             , sidebarLayout(
  #               sidebarPanel(
  #                 h4("2.A. Define Columns")
  #                 , p("Define columns below for each box")
  #                 , p("Displayed text is a hint not an actual value.")
  #                 , p("Actual tables are displayed to the right.")
  #                 , h4("2.A.1. Define Columns, Measured Values")
  #                 # Future version use selectize input and use columns from file.
  #                 , textInput("col_msr_datetime"
  #                             , label = "Input, Measurement, DateTime"
  #                             , placeholder = "Date_Time")
  #                 , textInput("col_msr_depth"
  #                             , label = "Input, Measurement, Depth (m)"
  #                             , placeholder = "Depth_m")
  #                 , textInput("col_msr_msr"
  #                             , label = "Input, Measurement, Value 1"
  #                             , placeholder = "Water_Temp_C")
  #                 , textInput("col_msr_msr2"
  #                             , label = "Input, Measurement, Value 2"
  #                             , placeholder = "DO_conc")
  #                 #
  #                 , h4("2.A.2. Define Columns, Lake Areas")
  #                 , textInput("col_area_depth"
  #                             , label = "Input, Area, Depth (m)"
  #                             , placeholder = "Contour_Depth")
  #                 , textInput("col_area_area"
  #                             , label = "Input, Area, Area (m2)"
  #                             , placeholder = "Area")
  #                 #
  #                 , h4("2.A.3. Define Columns, Measure No Date")
  #                 , textInput("col_msrND_datetime"
  #                             , label = "Input, Measure No Date, DateTime"
  #                             , placeholder = "Date_Time")
  #                 , textInput("col_msrND_msr"
  #                             , label = "Input, Measure No Date, Value"
  #                             , placeholder = "Wind")
  #                 #
  #                 , h4("2.B. Calculate")
  #                 , numericInput("strat_min_days"
  #                                , label = "Stratification, minimum days"
  #                                , value = 1)
  #                 , bsTooltip(id = "strat_min_days"
  #                             , title = "Stratification based on 1degC change over 1-meter"
  #                             , placement = "top")
  #                 , numericInput("minlimit"
  #                                , label = "Minimum Value"
  #                                , value = 2)
  #                 , bsTooltip(id = "minlimit"
  #                             , title = "Number below to calculate in stats for Value 1"
  #                             , placement = "top")
  #                 , numericInput("minlimit2"
  #                                , label = "Minimum Value 2"
  #                                , value = 2)
  #                 , bsTooltip(id = "minlimit2"
  #                             , title = "Number to include on plots for Value 2"
  #                             , placement = "top")
  #                 , p("Data view must be visible to the right before clicking
  #                  calculate below.")
  #                 , p("Statistics are generated from daily depth means calculation.
  #                  This process interpolates to integers.")
  #                 , shinyjs::disabled(actionButton("b_Calc", "Calculate"))
  #                 #
  #                 , h4("2.C. Download Results")
  #                 # Button
  #                 , p("Select button to download zip file with input and results.")
  #                 , p("Check 'results_log.txt' for any warnings or messages.")
  #                 , useShinyjs()
  #                 , shinyjs::disabled(downloadButton("b_downloadData", "Download"))
  #                 #, downloadButton("b_downloadData", "Download")
  #                 # for testing only
  #
  #               )##sidebarPanel~END
  #               # _MainPanel, Calc ----
  #               , mainPanel(
  #                 tabsetPanel(type="tabs"
  #                             , tabPanel("Data, Import, Measured Values"
  #                                        , DT::dataTableOutput('df_import_DT')
  #                             )
  #                             , tabPanel("Data, Import, Lakes Areas"
  #                                        , DT::dataTableOutput('df_import2_DT')
  #                             )
  #                             , tabPanel("Data, Import, Measured, No Depth"
  #                                        , DT::dataTableOutput('df_import3_DT')
  #                             )
  #                 )##tabsetPanel~END
  #               )##mainPanel~END
  #
  #             )##sidebarLayout~END
  # )##tabPanel ~ Calc ~ END
  # tabPanel, Plot ----
  # , tabPanel("3. Plot Data"
  #            # _SideBar, Plot ----
  #            #, sidebarLayout(
  #            , div(id = "Sidebar_Plot",
  #                  sidebarPanel(
  #                    h4("3.A. Define Columns")
  #                    , p("Define columns below for each box")
  #                    , p("Displayed text is a hint not an actual value.")
  #                    # Future version use selectize input and use columns from file.
  #                    , textInput("col_plot_datetime"
  #                                , label = "Plot, Measurement, DateTime"
  #                                , value = NULL
  #                                , placeholder = "Date_Time")
  #                    # , selectInput("col_plot_datetime"
  #                    #               , label = "Plot, Measurement, DateTime"
  #                    #               , choices = c("A", "B", "C"))
  #                    , textInput("col_plot_depth"
  #                                , label = "Plot, Measurement, Depth (m)"
  #                                , placeholder = "Depth_m")
  #                    , textInput("col_plot_msr"
  #                                , label = "Plot, Measurement, Measurement 1"
  #                                , placeholder = "Water_Temp_C")
  #                    , textInput("col_plot_msr2"
  #                                , label = "Plot, Measurement, Measurement 2"
  #                                , placeholder = "DO")
  #                    , textInput("col_plot_msr3"
  #                                , label = "Plot, Measurement, Measurement 3"
  #                                , placeholder = "WSPD")
  #                    #
  #                    , h4("3.B. Define Plot Labels")
  #                    , textInput("lab_plot_datetime"
  #                                , label = "Plot, DateTime"
  #                                , placeholder = "Date Time"
  #                                , value = "Date Time")
  #                    , textInput("lab_plot_depth"
  #                                , label = "Plot, Depth"
  #                                , placeholder = "Depth (m)"
  #                                , value = "Depth (m)")
  #                    , textInput("lab_plot_msr"
  #                                , label = "Plot, Measurement 1"
  #                                , placeholder = "Water Temperature (C)")
  #                    , textInput("lab_plot_msr2"
  #                                , label = "Plot, Measurement 2"
  #                                , placeholder = "Dissolved Oxygen (mg/L)")
  #                    , textInput("lab_plot_msr3"
  #                                , label = "Plot, Measurement 3"
  #                                , placeholder = "Wind Speed (m/s)")
  #                    , textInput("lab_plot_title"
  #                                , label = "Plot, Measurement, Measurement"
  #                                , value = NA
  #                                , placeholder = "Title")
  #                    , numericInput("line_val_plot_hm"
  #                                   , label = "heat map line value"
  #                                   , value = NA)
  #
  #                    , h4("3.C. Create Plots")
  #                    , p("Plots are interactive and will be created when data are
  #                  loaded.")
  #                    #
  #                    , h4("3.D. Download Plots")
  #                    # Button
  #                    , p("Select button to download zip file with plots.")
  #                    , p("Check 'results_log.txt' for any warnings or messages.")
  #                    , useShinyjs()
  #                    , shinyjs::disabled(downloadButton("b_downloadPlots"
  #                                                       , "Download Plots"))
  #
  #
  #                  )##sidebarPanel~END
  #            ) ## div ~ END
  #
  #            # _MainPanel, Plot----
  #            , mainPanel(
  #              actionButton("toggleSidebar_plot", "Toggle sidebar")
  #              , p("Larger files take longer to plot and change labels.")
  #              , h4("Plot, Depth Profile, Measurement 1")
  #              #, plotOutput("p_depth")
  #              , plotlyOutput("p_depth_ly")
  #              , h4("Plot, Heat Map")
  #              , plotlyOutput("p_hm_ly")
  #              , h4("Plot, Depth Profile, Measurement 2")
  #              , plotlyOutput("p_profile2_ly")
  #              , h4("Plot, Time Series, Measurement 3")
  #              , plotlyOutput("p_ts_ly")
  #            )##mainPanel~END
  #
  #            #)##sidebarLayout~END
  #   )##tabPanel ~ Plot ~ END
  )##navbarPage ~ END
)##shinyUI~END
