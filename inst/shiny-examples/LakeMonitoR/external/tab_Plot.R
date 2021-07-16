# Plot Panel

function(){
  tabPanel("3. Plot Data"
           # SideBar ####
           #, sidebarLayout(
           , div(id = "Sidebar_Plot",
             sidebarPanel(
               h4("3.A. Define Columns")
               , p("Define columns below for each box")
               , p("Displayed text is a hint not an actual value.")
               # Future version use selectize input and use columns from file.
               , textInput("col_plot_datetime"
                           , label = "Plot, Measurement, DateTime"
                           , value = NULL
                           , placeholder = "Date_Time")
               # , selectInput("col_plot_datetime"
               #               , label = "Plot, Measurement, DateTime"
               #               , choices = c("A", "B", "C"))
               , textInput("col_plot_depth"
                           , label = "Plot, Measurement, Depth (m)"
                           , placeholder = "Depth_m")
               , textInput("col_plot_msr"
                           , label = "Plot, Measurement, Value 1 (Temp)"
                           , placeholder = "Water_Temp_C")
               , textInput("col_plot_msr2"
                           , label = "Plot, Measurement, Value 2 (DO)"
                           , placeholder = "DO")
               , textInput("col_plot_msr3"
                           , label = "Plot, Measurement, Value 3 (WSPD)"
                           , placeholder = "WSPD")
               #
               , h4("3.B. Define Plot Labels")
               , textInput("lab_plot_datetime"
                           , label = "Plot, DateTime"
                           , placeholder = "Date Time"
                           , value = "Date Time")
               , textInput("lab_plot_depth"
                           , label = "Plot, Depth"
                           , placeholder = "Depth (m)"
                           , value = "Depth (m)")
               , textInput("lab_plot_msr"
                           , label = "Plot, Value 1 (Temp)"
                           , placeholder = "Water Temperature (C)")
               , textInput("lab_plot_msr2"
                           , label = "Plot, Value 2 (DO)"
                           , placeholder = "Dissolved Oxygen (mg/L)")
               , textInput("lab_plot_msr3"
                           , label = "Plot, Value 3 (WSPD)"
                           , placeholder = "Wind Speed (m/s)")
               , textInput("lab_plot_title"
                           , label = "Plot, Title"
                           , value = NA
                           , placeholder = "Title")
               , numericInput("line_val_plot_hm"
                              , label = "heat map line value"
                              , value = NA)

               , h4("3.C. Create Plots")
               , p("Plots are interactive and will be created when data are
                   loaded.")
               #
               , h4("3.D. Download Plots")
               # Button
               , p("Select button to download zip file with plots.")
               , p("Check 'results_log.txt' for any warnings or messages.")
               , useShinyjs()
               , shinyjs::disabled(downloadButton("b_downloadPlots"
                                                  , "Download Plots"))


             )##sidebarPanel~END

             # Main Panel ####
             , mainPanel(
              # actionButton("toggleSidebar_plot", "Toggle sidebar"),
                p("Larger files take longer to plot and change labels.")
               , h4("Plot, Depth Profile, Measurement 1")
               #, plotOutput("p_depth")
               , plotlyOutput("p_depth_ly")
               , h4("Plot, Heat Map")
               , plotlyOutput("p_hm_ly")
               , h4("Plot, Depth Profile, Measurement 2")
               , plotlyOutput("p_profile2_ly")
               , h4("Plot, Time Series, Measurement 3")
               , plotlyOutput("p_ts_ly")
             )##mainPanel~END

           )##sidebarLayout~END  (div ~ END)
  )##tabPanel ~ END
}## FUNCTION ~ END
