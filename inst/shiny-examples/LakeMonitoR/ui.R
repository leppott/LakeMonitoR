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

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title ####
  titlePanel("LakeMonitoR, v0.1.0.9001"),

  # SideBar ####
  sidebarLayout(
    sidebarPanel(
      # 0. Progress
      h3("App Steps")
      # , htmlOutput("vig")
      #, p("1_LoadData, 2_CalcMetrics, 3_CalcIndex, 4_DownloadResults")
      , h4("1. Load File")
      , h5("Select file parameters")
      #, checkboxInput('header', 'Header', TRUE)
      , radioButtons('sep', 'Separator',
                     c(Comma=',',
                       Semicolon=';',
                       Tab='\t'),
                     ',')
      # , radioButtons('quote', 'Quote',
      #                c(None='',
      #                  'Double Quote'='"',
      #                  'Single Quote'="'"),
      #                '"')
      #, tags$hr()
      , fileInput('fn_input', 'Choose file to upload',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv',
                  '.txt'
                )
      )##fileInput~END
      #, tags$hr()
      , h4("2. QC Master Taxa")
      , selectInput("QC_Type", "Select how to handle new/different taxa:",
                    choices=QC_Type)
      , h4("3. Calculate IBI")
      , selectInput("MMI", "Select an IBI to calculate:",
                    choices=MMIs)
      , actionButton("b_Calc", "Calculate")
      , tags$hr()
      , h4("4. Download Results")

      # Button
      , p("Select button to download zip file with input and results.")
      , p("Check 'results_log.txt' for any warnings or messages.")
      , useShinyjs()
      , shinyjs::disabled(downloadButton("b_downloadData", "Download"))

    )##sidebarPanel~END
    # Main Panel ####
    , mainPanel(
        tabsetPanel(type="tabs"
                    # , tabPanel("TESTING"
                    #            , htmlOutput("vig")
                    #            , textOutput("fn_input")
                    #            , useShinyjs()
                    #            , runcodeUI(code="shinyjs::alert('Hello!')")
                    #            )
                    # , tabPanel("Directions"
                    #            , p("Import data file."))
                    , tabPanel("Data, Import"
                               #, tableOutput('df_import'))
                               , DT::dataTableOutput('df_import_DT'))
                    # , tabPanel("Data QC"
                    #            , h4("QC on the imported data")
                    #             , p("Future implementation."))
                    # , tabPanel("Results, Metric Values"
                    #            , DT::dataTableOutput('df_metric_values'))
                    # , tabPanel("Results, Metric Scores"
                    #            , DT::dataTableOutput('df_metric_scores'))
                    # , tabPanel("Results, Plot"
                    #            #, plotlyOutput("plot_IBI", , height = "90%")
                    #            , imageOutput("plot_IBI")
                    #            )
        )##tabsetPanel~END
    )##mainPanel~END

  )##sidebarLayout~END

))##shinyUI~END
