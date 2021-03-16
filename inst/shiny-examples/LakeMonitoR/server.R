#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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
# # library(plotly)
# library(shinyjs)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Testing ####
  #runcodeServer() # for Testing

  # Misc Names ####
  output$fn_input_display <- renderText({input$fn_input})


  # df_import ####
  output$df_import_DT <- renderDT({
    # input$df_import will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.

    # disable 'calc' button
    shinyjs::disable("b_Calc")

    inFile <- input$fn_input

    # return null so screen is blank until upload file
    # if (is.null(inFile)){
    #   return(NULL)
    # }##IF~is.null~END
    shiny::validate(shiny::need(is.null(inFile) == FALSE
                                , message = "'Measured Values (1.A.)' file not uploaded yet."))


    # Disable download button if load a new file
    shinyjs::disable("b_downloadData")

    #message(getwd())

    # Add "Results" folder if missing
    boo_Results <- dir.exists(file.path(".", "Results"))
    if(boo_Results == FALSE){
      dir.create(file.path(".", "Results"))
    }

    # Remove all files in "Results" folder
    fn_results <- list.files(file.path(".", "Results"), full.names=TRUE)
    file.remove(fn_results)

    # Read user imported file
    df_input <- read.table(inFile$datapath
                           , header = TRUE
                           , sep = input$sep
                           , quote = "\""
                           , stringsAsFactors = FALSE)

    # Write to "Results" folder - Import as TSV
    fn_input <- file.path(".", "Results", "data_import_measure.tsv")
    write.table(df_input, fn_input, row.names=FALSE, col.names=TRUE, sep="\t")

    # Copy to "Results" folder - Import "as is"
    file.copy(input$fn_input$datapath, file.path(".", "Results", input$fn_input$name))

    # enable 'calc' button
    shinyjs::enable("b_Calc")

    return(df_input)

  }##expression~END
  , filter="top"
  , options=list(scrollX=TRUE
                 , pageLength = 5
                 , lengthMenu = c(5, 10, 25, 50, 100, 250, 500, 1000))
  , caption = "Measured Values"
  )##output$df_import_DT~END

  # df_import2 ####
  output$df_import2_DT <- renderDT({
    # input$df_import will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.

    inFile2 <- input$fn_input2

    # # return null so screen is blank until upload file
    # if (is.null(inFile2)){
    #   shinyjs::enable("b_Calc")
    #   return(NULL)
    # }##IF~is.null~END
    shiny::validate(shiny::need(is.null(inFile2) == FALSE
                                , message = "'Lakes Areas (1.B.)' file not uploaded yet."))

    # Disable download button if load a new file
    shinyjs::disable("b_downloadData")
    # only activates if try to display the file.

    #message(getwd())

    # Add "Results" folder if missing
    boo_Results <- dir.exists(file.path(".", "Results"))
    if(boo_Results == FALSE){
      dir.create(file.path(".", "Results"))
    }

    # will not remove files.

    # Read user imported file
    df_input2 <- read.table(inFile2$datapath
                           , header = TRUE
                           , sep = input$sep2
                           , quote = "\""
                           , stringsAsFactors = FALSE)

    # Write to "Results" folder - Import as TSV
    fn_input2 <- file.path(".", "Results", "data_import2_area.tsv")
    write.table(df_input2, fn_input2, row.names=FALSE, col.names=TRUE, sep="\t")

    # Copy to "Results" folder - Import "as is"
    file.copy(input$fn_input2$datapath, file.path(".", "Results", input$fn_input2$name))

    # disable 'calc' button
    shinyjs::enable("b_Calc")

    return(df_input2)

  }##expression~END
  , filter="top"
  , options=list(scrollX=TRUE
                 , pageLength = 5
                 , lengthMenu = c(5, 10, 25, 50, 100, 250, 500, 1000))
  , caption = "Lake Areas"
  )##output$df_import2_DT~END

  # b_Calc ####
  # Calculate metrics on imported data
  # add "sleep" so progress bar is readable
  observeEvent(input$b_Calc, {
     shiny::withProgress({
      #
      boo_DEBUG <- FALSE
      # Number of increments
      n_inc <- 7
      n_step <- 0
      sleep_time <- 0.25
      sleep_time_qc <- 5

      # b_Calc, Step 1, Initialize ####
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Initialize log file.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      # b_Calc, *sink* ####
      #fn_sink <- file.path(".", "Results", "results_log.txt")
      file_sink <- file(file.path(".", "Results", "results_log.txt"), open = "wt")
      sink(file_sink, type = c("output", "message"), append = TRUE)
      # Log
      message("Results Log from LakeMonitoR Shiny App")
      message(Sys.time())
      # appUser <- Sys.getenv('USERNAME')
      # message(paste0("Username = ", appUser))
      # Not meaningful when run online via Shiny.io
      inFile <- input$fn_input
      message(paste0("file, measurement = ", inFile$name))
      inFile2 <- input$fn_input2
      message(paste0("file, area = ", inFile$name))
      message("If area file is null then only stratification metrics are calculated.")
      # Input variables
      message("\nInput variables:")
      message(paste0("Measurement, Date Time: ", input$col_msr_datetime))
      message(paste0("Measurement, Depth (m): ", input$col_msr_depth))
      message(paste0("Measurement, Measurement: ", input$col_msr_msr))
      message(paste0("Area, Depth (m): ", input$col_area_depth))
      message(paste0("Area, Area (m2): ", input$col_area_area))
      message(paste0("Calculate, minimum days: ", input$strat_min_days))

      # b_Calc, Step 2, QC Measured Values ####
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; QC, Measured Values")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      #df_data <- 'df_import_DT'
      # Read in saved file (known format)
      df_data <- NULL  # set as null for IF QC check prior to import
      fn_input <- file.path(".", "Results", "data_import_measure.tsv")


      if(file.exists(fn_input)){
        df_data <- read.delim(fn_input, stringsAsFactors = FALSE, sep="\t")
      } else {
        # only happens if load area and not measurement data
        prog_detail <- "QC, No measurement data provided.'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
        #
        shiny::validate(shiny::need(is.null(input$fn_input) == FALSE, message = "Missing data file."))
      }## IF ~ file.exists ~ END

      # QC, FAIL if TRUE
      if (is.null(df_data)){
        message("No data file provided.")
        return(NULL)
      }
      # shiny::validate(shiny::need(is.null(input$fn_input) == FALSE, message = "Missing data file."))

      # Columns ("" if no user entry)
      col_date    <- input$col_msr_datetime #"Date_Time"
      col_depth   <- input$col_msr_depth #"Depth_m"
      col_measure <- input$col_msr_msr #"Water_Temp_C"

      if(col_date == ""){
        prog_detail <- "QC, Missing 'Input, Measurement, Date Time'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }
      if(col_depth == ""){
        prog_detail <- "QC, Missing 'Input, Measurement, Depth (m)'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }
      if(col_measure == ""){
        prog_detail <- "QC, Missing 'Input, Measurement, Measurement'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }

      # silent exit from routine, keeps app running, message above
      shiny::validate(shiny::need(col_date != "", message = "Missing 'Input, Measurement, Date Time'")
                      , shiny::need(col_depth != "", message = "Missing 'Input, Measurement, Depth (m)'")
                      , shiny::need(col_measure != "", message = "Missing 'Input, Measurement, Measurement'")
                      )## validate ~ END

      # Check for mispelled column names
      col_data <- c(col_date, col_depth, col_measure)
      sum_col_data_in <- sum(col_data %in% names(df_data))
      col_data_missing <- col_data[!(col_data %in% names(df_data))]
      msg_col_data_missing <- paste0("QC, Mismatched column name; "
                                     , paste(col_data_missing, collapse = ","))

      if(sum_col_data_in != 3){
        prog_detail <- msg_col_data_missing
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }

      shiny::validate(shiny::need(sum_col_data_in == 3
                                  , message = msg_col_data_missing))## validate ~ END


      # b_Calc, Step 3, Daily Depth Means and Stratification ####
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Stratification.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      # Calc Strat
      if(boo_DEBUG == FALSE){
        # data
        df_calc <- df_data
        #
        # QC, col names (match df)
        col_data <- c(col_date, col_depth, col_measure)
        sum_col_match_data <- sum(col_data %in% names(df_data))
        # if(sum_col_match_data != 3){
        #   stopApp("Column names not provided.")
        #   message("Column names do not match measurement data.")
        #   return(NULL)
        # }##IF ~ sum_col_match_data ~ END
        #
        # Ensure date time is POSIX
        dt_format <- "%Y-%m-%d %H:%M"
        tz_temp   <- "GMT"
        df_calc[, col_date] <- as.POSIXct(df_calc[, col_date]
                                          , format = dt_format
                                          , tz = tz_temp)
        # Add dummy site ID, assume all same site
        col_siteid <- "SiteID"
        df_calc[, col_siteid] <- "shiny"
      } else {
        # data
        df_calc <- laketemp_ddm
        # Columns
        col_siteid  <- "SiteID"
        col_date    <- "Date"
        col_depth   <- "Depth"
        col_measure <- "Measurement"

      }##IF ~ boo_DEBUG ~ END

      # show "data"
      print("Input Data")
      message(fn_input)
      print(head(df_calc))
      print(str(df_calc))



      # Calculate daily_depth_means
      # Otherwise stratification fails if have time.
      df_ddm <- LakeMonitoR::daily_depth_means(df_calc, "SiteID", col_date, col_depth, col_measure)
      print("QC, Calculate daily depth means")
      print(head(df_ddm))
      # save ddm
      fn_ddm <- file.path(".", "Results", "data_ddm.csv")
      write.csv(df_ddm, fn_ddm, row.names = FALSE)

      # Calculate Stratification
      col_strat_date    <- "Date"
      col_strat_depth   <- "Depth"
      col_strat_measure <- "Measurement"
      ls_strat <- LakeMonitoR::stratification(df_ddm
                                              , col_strat_date
                                              , col_strat_depth
                                              , col_strat_measure
                                              , min_days = input$strat_min_days)

      # Calc Stats
      df_lss <- LakeMonitoR::lake_summary_stats(df_ddm
                                              , col_strat_date
                                              , col_strat_depth
                                              , col_strat_measure
                                              , ndaysbelow = input$minlimit)


      # Save Results
      # Results, Stratification Dates
      fn_strat_dates <- file.path(".", "Results", "strat_dates.csv")
      write.csv(ls_strat$Stratification_Dates, fn_strat_dates, row.names = FALSE)
      # Results, Stratification Events
      fn_strat_events <- file.path(".", "Results", "strat_events.csv")
      write.csv(ls_strat$Stratification_Events, fn_strat_events, row.names = FALSE)

      # Results, lakes summary stats
      fn_lss <- file.path(".", "Results", "summary_stats.csv")
      write.csv(df_lss, fn_lss, row.names = FALSE)

      # Sink info
      print("Stratification, Dates (head)")
      print(head(ls_strat$Stratification_Dates))
      print("Stratification, Events (head)")
      print(head(ls_strat$Stratification_Events))

      # Clean up
      rm(df_calc)

      # b_Calc, Step 4, Plot ####
      # Increment the progress bar, and qc_taxa
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Plot Measured Data")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      # Plot original data in ggplot
      data_plot <- df_data
      data_plot[, col_date] <- as.POSIXct(data_plot[, col_date]
                                          , format = dt_format
                                          , tz = tz_temp)
      # col_date    <- "Date"
      # col_depth   <- "Depth"
      # col_measure <- "Measurement"

      # Plot, Create
      p <- ggplot2::ggplot(data_plot, ggplot2::aes_string(x=col_date, y=col_measure)) +
        ggplot2::geom_point(ggplot2::aes_string(color=col_depth)) +
        ggplot2::scale_color_continuous(trans="reverse") +
        ggplot2::labs(title = "Depth Profile"
                      , x = "Date"
                      , y = "Temperature (Celsius)"
                      , color = "Depth (m)") +
        ggplot2::theme_light()
      # Plot, Save
      fn_p <- file.path(".", "Results", "plot_depth_profile.png")
      ggplot2::ggsave(fn_p)
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      #  # could also do plot of events
      #  data_plot <- ls_strat$Stratification_Dates
      #  data_plot <- data_plot[data_plot$Stratified == TRUE, ]
      #  data_plot$Julian <- format(data_plot$Date, "%j")
      #  data_plot$Year <- format(data_plot$Date, "%Y")
      #  # data_plot$start_md <- format(data_plot$Start_Date, "%m-%d")
      #  # data_plot$end_md <- format(data_plot$End_Date, "%m-%d")
      #
      #  p_events <- ggplot(data_plot, aes(x = Date, y = Year)) +
      #              geom_line(size = 2) +
      #              scale_x_date(date_labels="%b"
      #                           , date_breaks  ="1 month"
      #                           , limits = c(as.Date("2017-01-01"), as.Date("2017-12-31"))) +
      #              labs(title = "Statification Events", x = "Month") +
      #              theme_light()
      #
      #  #a <- unique(data_plot$Year)
      # # b <- format(seq( as.Date("2020-01-01"), as.Date("2020-12-31"), by="+1 day"), "%m-%d")
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      # b_Calc, Step 5, QC Area ####
      # Increment the progress bar, and qc_taxa
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; QC, Area")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      #df_data2 <- 'df_import2_DT'
      # Read in saved file (known format)
      df_data2 <- NULL  # set as null for IF QC check prior to import
      fn_input2 <- file.path(".", "Results", "data_import2_area.tsv")

      # Possible to not load area file
      if(file.exists(fn_input2)){
        df_data2 <- read.delim(fn_input2, stringsAsFactors = FALSE, sep="\t")
      } else {
        # only happens if load area and not measurement data
        prog_detail <- "QC, No area data provided.'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
        #
        # warn only, don't stop with validate(need())
        #
      }## IF ~ file.exists ~ END

      # QC, FAIL if TRUE
      if (is.null(df_data2)){
        msg_noArea <-"No area data provided.  No rLakeAnalyzer analyses performed."
        message(msg_noArea)
        #return(NULL)
        shinyjs::enable("b_downloadData")
        #
        prog_detail <- "QC, No area data provided.  No rLakeAnalyzer analyses performed.'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
        #

        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # b_Calc, Step 7a, Zip Results ####
        # Increment the progress bar, and update the detail text.
        n_step <- n_step + 1
        prog_detail <- paste0("Step ", n_step, "; Create, Zip.")
        incProgress(1/n_inc, detail = prog_detail)
        Sys.sleep(sleep_time)

        # Create zip file
        fn_4zip <- list.files(path = file.path(".", "Results")
                              , pattern = "*"
                              , full.names = TRUE)
        zip(file.path(".", "Results", "results.zip"), fn_4zip)

        # enable download button
        shinyjs::enable("b_downloadData")

        # #
        # end sink
        #flush.console()
        sink() # console and message
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        shiny::validate(shiny::need(is.null(df_data2) != TRUE, message = msg_noArea))
        #
      }## IF ~ is.null(df_data2) ~ END



      # Columns ("" if no user entry)
      col_area_depth <- input$col_area_depth #"Depth"
      col_area_area <- input$col_area_area

      if(col_area_depth == ""){
        prog_detail <- "QC, Missing 'Input, Area, Depth (m)'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }
      if(col_area_area == ""){
        prog_detail <- "QC, Missing 'Input, Area, Area (m2)'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }

      # silent exit from routine, keeps app running, message above
      shiny::validate(shiny::need(col_area_depth != "", message = "Missing 'Input, Area, Depth (m)'")
                      , shiny::need(col_area_area != "", message = "Missing 'Input, Area, Area (m2)'")
      )## validate ~ END

      # Check for mispelled column names
      col_data2 <- c(col_area_depth, col_area_area)
      sum_col_data2_in <- sum(col_data2 %in% names(df_data2))
      col_data2_missing <- col_data2[!(col_data2 %in% names(df_data2))]
      msg_col_data2_missing <- paste0("QC, Mismatched column name; "
                                     , paste(col_data2_missing, collapse = ","))

      if(sum_col_data2_in != 2){
        prog_detail <- msg_col_data2_missing
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
      }

      shiny::validate(shiny::need(sum_col_data2_in == 2
                                  , message = msg_col_data2_missing))## validate ~ END




      # b_Calc, Step 6, Schmidt, rLA ####
      # Increment the progress bar, and qc_taxa
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; rLakeAnalyzer stats")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)



      # QC, FAIL if TRUE
      if (is.null(df_data2)){
        message("No area data provided.  No rLakeAnalyzer analyses performed.")
        #return(NULL)

      } else {
        print(fn_input2)
        print(head(df_data2))
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # Convert Data for use with rLakeAnalyzer
        if(boo_DEBUG == FALSE){
          # Data
          df_ddm <- df_ddm
          df_area <- df_data2
        } else{
          # Data
          df_ddm <- laketemp_ddm
          df_area <- data.frame(depths=c(3,6,9), areas=c(300,200,100))
        }## IF ~ boo_DEBUG ~ END

        # date to date format
        df_ddm[, "Date"] <- as.Date(df_ddm[, "Date"])
        # Run function
        col_rLA_depth <- "Depth"
        col_rLA_data <- c("Date", "Measurement")
        col_rLA  <- c("datetime", "wtr")
        df_rLA <- LakeMonitoR::export_rLakeAnalyzer(df_ddm
                                                    , col_rLA_depth
                                                    , col_rLA_data
                                                    , col_rLA)
        print("rLA export")
        print(head(df_rLA))
        # Save
        write.csv(df_rLA, "data_rLA.csv", row.names = FALSE)
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # use rLakeAnalyzer
        # Filter Data for only temperature
        col_wtr <- colnames(df_rLA)[grepl("wtr_", colnames(df_rLA))]
        df_rLA_wtr <- df_rLA[, c("datetime", col_wtr)]
        # Date format
        df_rLA_wtr$datetime <- as.POSIXct(df_rLA_wtr$datetime)

        # Bathymetry data frame
        df_rLA_bath <- df_area[, c(col_area_depth, col_area_area)]
        # rLA expected column names
        names(df_rLA_bath) <- c("depths", "areas")



        # Generate Heat Map
        fn_hm <- file.path(".", "Results", "rLA_plot_heatmap.png")
        grDevices::png(fn_hm)
          rLakeAnalyzer::wtr.heat.map(df_rLA_wtr)
        grDevices::dev.off()
        # Generate Schmidt Plot
        # fn_sp <- file.path(".", "Results", "rLA_plot_Schmidt.png")
        # grDevices::png(fn_sp)
        #   rLakeAnalyzer::schmidt.plot(df_rLA_wtr, df_rLA_bath)
        # grDevices::dev.off()
        # Generate Schmidt Stability Values
        # df_rLA_Schmidt <- rLakeAnalyzer::ts.schmidt.stability(df_rLA_wtr, df_rLA_bath)
        # fn_rLA_Schmidt <- file.path(".", "Results", "rLA_Schmidt.csv")
        # write.csv(df_rLA, "data_rLA.csv", row.names = FALSE)


        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # b_Calc, Step 7b, Zip Results ####
        # Increment the progress bar, and update the detail text.
        n_step <- n_step + 1
        prog_detail <- paste0("Step ", n_step, "; Create, Zip.")
        incProgress(1/n_inc, detail = prog_detail)
        Sys.sleep(sleep_time)

        # Create zip file
        fn_4zip <- list.files(path = file.path(".", "Results")
                              , pattern = "*"
                              , full.names = TRUE)
        zip(file.path(".", "Results", "results.zip"), fn_4zip)

        # enable download button
        shinyjs::enable("b_downloadData")

        # #
        # end sink
        #flush.console()
        sink() # console and message
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      }## IF ~ is.null(df_data2) ~ END



      #
     }##expr~withProgress~END
     , message = "Calculating:"
     )##withProgress~END
    }##expr~ObserveEvent~END
  )##observeEvent~b_Calc~END


  # b_downloadData ####
  # Download of results
  output$b_downloadData <- downloadHandler(
    # use index and date time as file name
    #myDateTime <- format(Sys.time(), "%Y%m%d_%H%M%S")

    filename = function() {
      paste("LakeMonitoR", "_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".zip", sep = "")
    },
    content = function(fname) {##content~START
     # tmpdir <- tempdir()
      #setwd(tempdir())
      # fs <- c("input.csv", "metval.csv", "metsc.csv")
      # file.copy(inFile$datapath, "input.csv")
      # file.copy(inFile$datapath, "metval.tsv")
      # file.copy(inFile$datapath, "metsc.tsv")
      # file.copy(inFile$datapath, "IBI_plot.jpg")
      # write.csv(datasetInput(), file="input.csv", row.names = FALSE)
      # write.csv(datasetInput(), file="metval.csv", row.names = FALSE)
      # write.csv(datasetInput(), file="metsc.csv", row.names = FALSE)
      #
      # Create Zip file
      #zip(zipfile = fname, files=fs)
      #if(file.exists(paste0(fname, ".zip"))) {file.rename(paste0(fname, ".zip"), fname)}

      file.copy(file.path(".", "Results", "results.zip"), fname)

      #
    }##content~END
    #, contentType = "application/zip"
  )##downloadData~END

  # Plots ----
  # _Plot, profile ----
  # output$p_depth <- renderPlot({
  # #output$p_depth <- renderPlotly({
  #   # if no data put in blank
  #
  #   inFile <- input$fn_input
  #   inCol_plot_datetime <- input$col_plot_datetime
  #   inCol_plot_depth <- input$col_plot_depth
  #   inCol_plot_msr <- input$col_plot_msr
  #
  #   lab_error_base <- "Missing: "
  #   lab_error <- lab_error_base
  #
  #   if(is.null(inFile)) {
  #     lab_error <- paste0(lab_error, "File")
  #   }
  #   if(inCol_plot_datetime == "") {
  #     lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
  #   }
  #   if(inCol_plot_depth == "") {
  #     lab_error <- paste(lab_error, "Column_Depth", collapse = ", ")
  #   }
  #   if(inCol_plot_msr == "") {
  #     lab_error <- paste(lab_error, "Column_Measurement", collapse = ", ")
  #   }
  #
  #
  #   if(lab_error == lab_error_base){
  #     # Read user imported file
  #     df_plot <- read.table(inFile$datapath
  #                           , header = TRUE
  #                           , sep = input$sep
  #                           , quote = "\""
  #                           , stringsAsFactors = FALSE)
  #     # plot
  #     p_depth <- depth_plot(data = df_plot
  #                           , col_datetime = input$col_plot_datetime
  #                           , col_depth = input$col_plot_depth
  #                           , col_measure = input$col_plot_msr
  #                           , lab_datetime = input$lab_plot_datetime
  #                           , lab_depth = input$lab_plot_depth
  #                           , lab_measure = input$lab_plot_msr
  #                           , lab_title = input$lab_plot_title)
  #   } else {
  #     p_depth <- ggplot() +
  #       theme_void() +
  #       geom_text(aes(0, 0, label = lab_error))
  #   }## IF ~ PLOT
  #
  #     p_depth
  #
  # })## output$p_depth ~ END

  # _Plot, profile, plotly ----
  output$p_depth_ly <- renderPlotly({
    # if no data put in blank

    inFile <- input$fn_input
    inCol_plot_datetime <- input$col_plot_datetime
    inCol_plot_depth <- input$col_plot_depth
    inCol_plot_msr <- input$col_plot_msr

    lab_error_base <- "Missing: "
    lab_error <- lab_error_base

    if(is.null(inFile)) {
      lab_error <- paste0(lab_error, "File")
    }
    if(inCol_plot_datetime == "") {
      lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
    }
    if(inCol_plot_depth == "") {
      lab_error <- paste(lab_error, "Column_Depth", collapse = ", ")
    }
    if(inCol_plot_msr == "") {
      lab_error <- paste(lab_error, "Column_Measurement", collapse = ", ")
    }


    if(lab_error == lab_error_base){
      # Read user imported file
      df_plot <- read.table(inFile$datapath
                            , header = TRUE
                            , sep = input$sep
                            , quote = "\""
                            , stringsAsFactors = FALSE)
      # plot
      p_depth <- depth_plot(data = df_plot
                            , col_datetime = input$col_plot_datetime
                            , col_depth = input$col_plot_depth
                            , col_measure = input$col_plot_msr
                            , lab_datetime = input$lab_plot_datetime
                            , lab_depth = input$lab_plot_depth
                            , lab_measure = input$lab_plot_msr
                            , lab_title = input$lab_plot_title)
    } else {
      p_depth <- ggplot() +
        theme_void() +
        geom_text(aes(0, 0, label = lab_error))
    }## IF ~ PLOT

    # Plotly
    partial_bundle(toWebGL(ggplotly(p = p_depth)))
    # faster but lots of warnings
    # but need for larger files (1 hr * 1 yr = 8k records * N depths)
    #ggplotly(p = p_depth)

  })## output$p_depth_ly ~ END


  # _Plot, heatmap, plotly ----
  output$p_hm_ly <- renderPlotly({
    # if no data put in blank

    inFile <- input$fn_input
    inCol_plot_datetime <- input$col_plot_datetime
    inCol_plot_depth <- input$col_plot_depth
    inCol_plot_msr <- input$col_plot_msr
    incol_plot_title <- input$lab_plot_title

    lab_error_base <- "Missing: "
    lab_error <- lab_error_base

    if(is.null(inFile)) {
      lab_error <- paste0(lab_error, "File")
    }
    if(inCol_plot_datetime == "") {
      lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
    }
    if(inCol_plot_depth == "") {
      lab_error <- paste(lab_error, "Column_Depth", collapse = ", ")
    }
    if(inCol_plot_msr == "") {
      lab_error <- paste(lab_error, "Column_Measurement", collapse = ", ")
    }


    if(lab_error == lab_error_base){
      # Read user imported file
      df_plot <- read.table(inFile$datapath
                            , header = TRUE
                            , sep = input$sep
                            , quote = "\""
                            , stringsAsFactors = FALSE)


      df_plot[, inCol_plot_datetime] <- as.POSIXct(df_plot[
                                                         , inCol_plot_datetime])

      # plot
      p_h <- ggplot(data = data
                    , aes_string(x = col_datetime
                                 , y = col_depth
                                 , fill = col_measure)) +
        geom_tile(na.rm = TRUE) +
        scale_fill_viridis_b() +
        scale_y_reverse() +
        ggplot2::scale_x_datetime(date_labels = "%Y-%m") +
        theme_bw() +
        stat_contour(aes_string(z = col_measure)
                     , color = "gray"
                     , na.rm = TRUE)

      # labels
      if(inCol_plot_datetime == ""){
        p_h <- p_h + ggplot2::labs(x = inCol_plot_datetime)
      }## IF ~ is.na(lab_datetime)
      #
      if(inCol_plot_depth == ""){
        p_h <- p_h + ggplot2::guides(color = ggplot2::guide_colourbar(title =
                                                            inCol_plot_depth))
      }## IF ~ is.na(lab_depth)
      # #
      if(inCol_plot_msr == ""){
        p_h <- p_h + ggplot2::labs(y = inCol_plot_msr)
      }## IF ~ is.na(lab_measure)
      #
      if(incol_plot_title == ""){
        p_h <- p_h + ggplot2::labs(title = incol_plot_title)
      }## IF ~ is.na(lab_measure)


    } else {
      p_h <- ggplot() +
        theme_void() +
        geom_text(aes(0, 0, label = lab_error))
    }## IF ~ PLOT

    # Plotly
    #partial_bundle(toWebGL(ggplotly(p = p_hm)))
    # faster but lots of warnings
    # but need for larger files (1 hr * 1 yr = 8k records * N depths)
    ggplotly(p = p_h)

  })## output$p_depth_ly ~ END


})##shinyServer~END
