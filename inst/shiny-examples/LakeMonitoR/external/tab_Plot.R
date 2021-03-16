# Plot Panel

function(){
  tabPanel("3. Plot Data"
           # SideBar ####
           , sidebarLayout(
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
                           , label = "Plot, Measurement, Measurement"
                           , placeholder = "Water_Temp_C")
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
                           , label = "Plot, Measurement"
                           , placeholder = "Water Temperature (C)")
               , textInput("lab_plot_title"
                           , label = "Plot, Measurement, Measurement"
                           , value = NA
                           , placeholder = "Title")
               , numericInput("line_val_plot_hm"
                              , label = "heat map line value"
                              , value = NA)

               , h4("3.C. Create Plots")

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
               p("Larger files take longer to plot and change labels.")
               , h4("Plot, Scatterplot")
               #, plotOutput("p_depth")
               , plotlyOutput("p_depth_ly")
               , h4("Plot, Heat Map")
               , plotlyOutput("p_hm_ly")
             )##mainPanel~END

           )##sidebarLayout~END
  )##tabPanel ~ END
}## FUNCTION ~ END
