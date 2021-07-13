# Combine Files Page

function(){
  tabPanel("0. Combine Depth Data Files"
    # SideBar ####
    , sidebarLayout(
        sidebarPanel(
          # 0. Progress
          #, tags$hr()
          h4("0.A. Load Files to Combine")
          , h5("Select file parameters")
          #, checkboxInput('header', 'Header', TRUE)
          , fileInput('fn_input_agg', 'Choose CSV files to upload and combine'
                      , accept = c('text/csv'
                                  , 'text/comma-separated-values'
                                  #, 'text/tab-separated-values'
                                  #, 'text/plain'
                                  , '.csv'
                                  #, '.tsv'
                                  #, '.txt'
                                  )
                      , multiple = TRUE
          )##fileInput~END

          , h4("0.B. Combine")
          #, shinyjs::disabled(actionButton("b_Agg", "Combine Files"))
          ,actionButton("b_Agg", "Combine Files")

          , h4("0.C. Download Combined File")
          # Button
          , p("Select button to download zip file with combined file.")
          , p("Check 'agg_log.txt' for any warnings or messages.")
          , useShinyjs()
          , shinyjs::disabled(downloadButton("b_downloadAgg", "Download"))
          #, downloadButton("b_downloadAgg", "Download")
          # for testing only

        )##sidebarPanel~END
      # Main Panel ####
      , mainPanel(
          p("Only CSV files are accepted at this time.")
          , p(paste0("File uploads (separately) are limited to a maximum of "
                     ,mb_limit
                     , " MB in size."))
          , p("Only click the 'Combine Files' button once all files are
              uploaded. Otherwise an error could occur.")
          , p("The combined file will be available for download.")
          , p("If want to use the combined file for calculations it will
              need to be uploaded.  At this time no cross talk between the
              combination and import for calculation steps.")
      )##mainPanel~END

    )##sidebarLayout~END
  )##tabPanel ~ END
}## FUNCTION ~ END
