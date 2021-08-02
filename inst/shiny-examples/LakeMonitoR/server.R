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

    # CALCULATE ----

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

    # Add folder, if missing, "Results"
    fn_folder <- file.path(path_results)
    boo_folder <- dir.exists(fn_folder)
    if(isFALSE(boo_folder)){
      dir.create(fn_folder)
    } else {
 #     fn_remove <- list.files(file.path(path_results), full.names=TRUE)
#      file.remove(fn_remove)
    }

    # Add folder, if missing, "Results/data_input"
    fn_folder <- file.path(path_results, "data_input")
    boo_folder <- dir.exists(fn_folder)
    if(isFALSE(boo_folder)){
      dir.create(fn_folder)
    } else {
   #   fn_remove <- list.files(file.path(path_results, "data_input"), full.names=TRUE)
   #   file.remove(fn_remove)
    }

    # Read user imported file
    df_input <- read.table(inFile$datapath
                           , header = TRUE
                           , sep = input$sep
                           , quote = "\""
                           , stringsAsFactors = FALSE)

    # Write to "Results" folder - Import as TSV
    fn_input <- file.path(path_results, "data_input", "data_import_measure.tsv")
    write.table(df_input, fn_input, row.names=FALSE, col.names=TRUE, sep="\t")

    # Copy to "Results" folder - Import "as is"
    file.copy(input$fn_input$datapath, file.path(path_results, "data_input"
                                                 , input$fn_input$name))

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

    # Add folder, if missing, "Results"
    fn_folder <- file.path(path_results)
    boo_folder <- dir.exists(fn_folder)
    if(isFALSE(boo_folder)){
      dir.create(fn_folder)
    } else {
  #    fn_remove <- list.files(file.path(path_results), full.names=TRUE)
  #    file.remove(fn_remove)
    }

    # Add folder, if missing, "Results/data_input"
    fn_folder <- file.path(path_results, "data_input")
    boo_folder <- dir.exists(fn_folder)
    if(isFALSE(boo_folder)){
      dir.create(fn_folder)
    } else {
   #   fn_remove <- list.files(file.path(path_results, "data_input"), full.names=TRUE)
  #    file.remove(fn_remove)
    }

    # will not remove files.

    # Read user imported file
    df_input2 <- read.table(inFile2$datapath
                           , header = TRUE
                           , sep = input$sep2
                           , quote = "\""
                           , stringsAsFactors = FALSE)

    # Write to "Results" folder - Import as TSV
    fn_input2 <- file.path(path_results, "data_input", "data_import2_area.tsv")
    write.table(df_input2, fn_input2, row.names=FALSE, col.names=TRUE, sep="\t")

    # Copy to "Results" folder - Import "as is"
    file.copy(input$fn_input2$datapath, file.path(path_results, "data_input"
                                                  , input$fn_input2$name))

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

  # df_import3 ####
  output$df_import3_DT <- renderDT({
    # input$df_import will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.

    inFile3 <- input$fn_input3

    # # return null so screen is blank until upload file
    # if (is.null(inFile2)){
    #   shinyjs::enable("b_Calc")
    #   return(NULL)
    # }##IF~is.null~END
    shiny::validate(shiny::need(is.null(inFile3) == FALSE
              , message = "'Measure, No Depth (1.C.)' file not uploaded yet."))

    # Disable download button if load a new file
    shinyjs::disable("b_downloadData")
    # only activates if try to display the file.

    #message(getwd())

    # Add folder, if missing, "Results"
    fn_folder <- file.path(path_results)
    boo_folder <- dir.exists(fn_folder)
    if(isFALSE(boo_folder)){
      dir.create(fn_folder)
    } else {
  #    fn_remove <- list.files(file.path(path_results, "data_input"), full.names=TRUE)
  #    file.remove(fn_remove)
    }

    # Add folder, if missing, "Results/data_input"
    fn_folder <- file.path(path_results, "data_input")
    boo_folder <- dir.exists(fn_folder)
    if(isFALSE(boo_folder)){
      dir.create(fn_folder)
    } else {
   #   fn_remove <- list.files(file.path(path_results, "data_input"), full.names=TRUE)
   #   file.remove(fn_remove)
    }

    # will not remove files.

    # Read user imported file
    df_input3 <- read.table(inFile3$datapath
                            , header = TRUE
                            , sep = input$sep3
                            , quote = "\""
                            , stringsAsFactors = FALSE)

    # Write to "Results" folder - Import as TSV
    fn_input3 <- file.path(path_results
                           , "data_input"
                           , "data_import3_nodepth.tsv")
    write.table(df_input3, fn_input3, row.names=FALSE, col.names=TRUE, sep="\t")

    # Copy to "Results" folder - Import "as is"
    file.copy(input$fn_input3$datapath, file.path(path_results
                                                  , "data_input"
                                                  , input$fn_input3$name))

    # disable 'calc' button
    shinyjs::enable("b_Calc")

    return(df_input3)

  }##expression~END
  , filter="top"
  , options=list(scrollX=TRUE
                 , pageLength = 5
                 , lengthMenu = c(5, 10, 25, 50, 100, 250, 500, 1000))
  , caption = "Measure, No Depth"
  )##output$df_import3_DT~END

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

      ## _b_Calc, Step 1, Initialize ####
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Initialize log file.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      ## Disable download button ----
      shinyjs::disable("b_downloadData")

      # _b_Calc, *sink* ####
      #fn_sink <- file.path(path_results, "_log_results.txt")
      file_sink <- file(file.path(path_results
                                  , "_log_results.txt")
                        , open = "wt")
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
      message(paste0("file, area = ", inFile2$name))
      message("If area file is null then only stratification metrics are
              calculated.")
      # Input variables
      message("\nInput variables:")
      message(paste0("Measurement, Date Time: ", input$col_msr_datetime))
      message(paste0("Measurement, Depth (m): ", input$col_msr_depth))
      message(paste0("Measurement, Value 1 (Temp): ", input$col_msr_msr))
      message(paste0("Measurement, Value 2 (DO): ", input$col_msr_ms2))
      message(paste0("Area, Depth (m): ", input$col_area_depth))
      message(paste0("Area, Area (m2): ", input$col_area_area))
      message(paste0("Calculate, minimum days: ", input$strat_min_days))
  message(paste0("Measurement No Date, Value 3 (WSPD): ", input$col_msrND_msr))

      # _b_Calc, Step 2, QC Measured Values ####
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; QC, Measured Values")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      #df_data <- 'df_import_DT'
      # Read in saved file (known format)
      df_data <- NULL  # set as null for IF QC check prior to import
      fn_input <- file.path(path_results
                            , "data_input"
                            , "data_import_measure.tsv")

      if(file.exists(fn_input)){
        df_data <- read.delim(fn_input, stringsAsFactors = FALSE, sep="\t")
      } else {
        # only happens if load area and not measurement data
        prog_detail <- "QC, No measurement data provided.'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
        #
        shiny::validate(shiny::need(is.null(input$fn_input) == FALSE
                                    , message = "Missing data file."))
      }## IF ~ file.exists ~ END

      # QC, FAIL if TRUE
      if (is.null(df_data)){
        message("No data file provided.")
        return(NULL)
      }
      # shiny::validate(shiny::need(is.null(input$fn_input) == FALSE
      # , message = "Missing data file."))

      # Columns ("" if no user entry)
      col_date    <- input$col_msr_datetime #"Date_Time"
      col_depth   <- input$col_msr_depth #"Depth_m"
      col_measure <- input$col_msr_msr #"Water_Temp_C"
      col_measure2 <- input$col_msr_msr2 # do
      col_measure3 <- input$col_msrND_msr # wind

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
      shiny::validate(shiny::need(col_date != ""
                          , message = "Missing 'Input, Measurement, Date Time'")
                      , shiny::need(col_depth != ""
                          , message = "Missing 'Input, Measurement, Depth (m)'")
                      , shiny::need(col_measure != ""
                        , message = "Missing 'Input, Measurement, Measurement'")
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
                                  , message = msg_col_data_missing))
      ## validate ~ END

      # _b_Calc, Step 3, DDM and Strat ####
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
      df_ddm <- LakeMonitoR::daily_depth_means(df_calc
                                               , "SiteID"
                                               , col_date
                                               , col_depth
                                               , col_measure)
      print("QC, Calculate daily depth means")
      print(head(df_ddm))
      # save ddm
      fn_ddm <- file.path(path_results, "data_ddm.csv")
      write.csv(df_ddm, fn_ddm, row.names = FALSE)
browser()
      # __Calc, Stratification ----
      col_strat_date    <- "Date"
      col_strat_depth   <- "Depth"
      col_strat_measure <- "Measurement"

      # method
      ## could extend to ddm vs raw
      if(input$strat_method == ">=1 deg C over 1-m") {
        df_strat_calc <- df_ddm
      } else if (input$strat_method == "top vs. bottom") {
        # basic filter
        # won't give expected results if min and max vary across time
        min_depth <- min(df_ddm[, col_strat_depth], na.rm = TRUE)
        max_depth <- max(df_ddm[, col_strat_depth], na.rm = TRUE)
        df_strat_calc <- df_ddm[df_ddm[, col_strat_depth] == min_depth |
                            df_ddm[, col_strat_depth] == max_depth, ]
      } ## IF ~ input$strat_method ~ END

      # Calc
      ls_strat <- LakeMonitoR::stratification(df_strat_calc
                                              , col_strat_date
                                              , col_strat_depth
                                              , col_strat_measure
                                              , min_days = input$strat_min_days)

      # __Calc, Lake Summary Stats ----
      df_lss <- LakeMonitoR::lake_summary_stats(df_ddm
                                              , col_strat_date
                                              , col_strat_depth
                                              , col_strat_measure
                                             , below_threshold = input$minlimit)

      # Add line to Strat plot for date range
      # data_strat <- ls_strat$Stratification_Dates
      # data_strat$Year <- x$Year <- format(x$Date, "%Y")
      # plot_strat <- ls_strat$Stratification_Plot
      # plot_strat <- ggplot2::ggplot(data_strat, ggplot2::aes(x = "Date"
      #                                                        , y = "Year")) +
      #                 ggplot2::geom_line()

      # Save Results
      # Results, Stratification Dates
      fn_strat_dates <- file.path(path_results, "strat_dates.csv")
      write.csv(ls_strat$Stratification_Dates
                , fn_strat_dates
                , row.names = FALSE)
      # Results, Stratification Events
      fn_strat_events <- file.path(path_results, "strat_events.csv")
      write.csv(ls_strat$Stratification_Events
                , fn_strat_events
                , row.names = FALSE)
      # __Results, Stratification Plot ----
      fn_strat_plot <- file.path(path_results, "plot_strat.png")
      ggplot2::ggsave(filename = fn_strat_plot
                      , plot = ls_strat$Stratification_Plot)

      # Results, lakes summary stats
      fn_lss <- file.path(path_results, "summary_stats.csv")
      write.csv(df_lss, fn_lss, row.names = FALSE)

      # Sink info
      print("Stratification, Dates (head)")
      print(head(ls_strat$Stratification_Dates))
      print("Stratification, Events (head)")
      print(head(ls_strat$Stratification_Events))

      # Clean up
      rm(df_calc)

      # _b_Calc, Step 4, Plot, depth ####
      # Increment the progress bar, and qc_taxa
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Plot Measured Data")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      # __Plot, Depth Profile ----
      # Plot original data in ggplot
      data_plot <- df_data
      data_plot[, col_date] <- as.POSIXct(data_plot[, col_date]
                                          , format = dt_format
                                          , tz = tz_temp)
      # col_date    <- "Date"
      # col_depth   <- "Depth"
      # col_measure <- "Measurement"
      lab_datetime <- "Date"
      lab_depth <- "Depth"
      lab_measure <- "Temperature"
      lab_title <- "Depth Profile"

      # Plot, Create
      # p <- ggplot2::ggplot(data_plot, ggplot2::aes_string(x=col_date
      # , y=col_measure)) +
      #   ggplot2::geom_point(ggplot2::aes_string(color=col_depth)) +
      #   ggplot2::scale_color_continuous(trans="reverse") +
      #   ggplot2::labs(title = "Depth Profile"
      #                 , x = "Date"
      #                 , y = "Temperature (Celsius)"
      #                 , color = "Depth (m)") +
      #   ggplot2::theme_light()

      p_depth <- plot_depth(data = data_plot
                         , col_datetime = col_date
                         , col_depth = col_depth
                         , col_measure = col_measure
                         , lab_datetime = lab_datetime
                         , lab_depth = lab_depth
                         , lab_measure = lab_measure
                         , lab_title = lab_title)

      # Plot, Save
      fn_p_depth <- file.path(path_results, "plot_depth_profile.png")
      ggplot2::ggsave(filename = fn_p_depth, plot = p_depth)

      # __Plot, Depth, StratEvents ----
      # Add to profile plot
      df_StratEvents <- as.data.frame(ls_strat$Stratification_Events)
     df_StratEvents$Start_Date <- as.POSIXct(as.Date(df_StratEvents$Start_Date))
      df_StratEvents$End_Date <- as.POSIXct(as.Date(df_StratEvents$End_Date))

      # Plot, Depth, StratEvents, lines
      p_profile_strat_line <- p_depth +
        labs(caption = "Stratification Events = red lines
       Start Date = solid
       End Date = dashed") +
        geom_vline(xintercept = df_StratEvents$Start_Date
                   , color = "red", linetype = "solid", size = 1.5) +
        geom_vline(xintercept = df_StratEvents$End_Date
                   , color = "red", linetype = "dashed", size = 2)

      # Plot, Depth, StratEvents, shading
      # annotate() easier than geom_rect()
      # Get plot limits
      # https://stackoverflow.com/questions/7705345/
      # how-can-i-extract-plot-axes-ranges-for-a-ggplot2-object
      p_depth_ylims <-
        ggplot_build(p_depth)$layout$panel_scales_y[[1]]$range$range
      p_profile_strat_shade <- p_depth +
        labs(caption = "Stratification Events = shaded area") +
        annotate("rect"
                 , xmin = df_StratEvents$Start_Date
                 , xmax = df_StratEvents$End_Date
                 , ymin = p_depth_ylims[1]
                 , ymax = p_depth_ylims[2]
                 , fill = "gray"
                 , alpha = 0.25)

      # Plot, Depth, StratEvents
      ## Pick plot
      p_profile_strat <- p_profile_strat_shade

      # Plot, Save (Depth, StratEvents)
      fn_p_depth_se <- file.path(path_results
                                 , "plot_depth_profile_strat_events.png")
      ggplot2::ggsave(filename = fn_p_depth_se, plot = p_profile_strat)


      # __Plot, heat map ----
      lab_title_hm <- NA
      p_hm <- plot_heatmap(data = data_plot
                           , col_datetime = col_date
                           , col_depth = col_depth
                           , col_measure = col_measure
                           , lab_datetime = lab_datetime
                           , lab_depth = lab_depth
                           , lab_measure = lab_measure
                           , lab_title = lab_title_hm
                           , contours = TRUE)
      fn_p_hm <- file.path(path_results, "plot_heatmap.png")
      ggplot2::ggsave(filename = fn_p_hm, plot = p_hm)


      # Move to DO section, only plot if have the data
      # # __Plot, Measure 2 (xx) ----
      # lab_error <- "No plot"
      # lab_title_2 <- NA
      # p_profile2 <- ggplot2::ggplot() +
      #   ggplot2::labs(title = "Plot, Measure 2") +
      #   ggplot2::theme_void() +
      #   ggplot2::geom_text(aes(0, 0, label = lab_error))
      # fn_p_profile2 <- file.path(path_results, "plot_depth_profile2.png")
      # ggplot2::ggsave(filename = fn_p_profile2, plot = p_profile2)

      # __Plot, time series----
      # **Needs different data source***
      # lab_title_ts <- NA
      # p_ts <- plot_ts(data = df_plot
      #                 , col_datetime = col_date
      #                 , col_measure = col_measure3
      #                 , lab_datetime = lab_datetime
      #                 , lab_measure = lab_measure3
      #                 , lab_title = lab_title_ts)
      # fn_p_ts <- file.path(path_results
      #                            , "plot_depth_profile2.png")
      # ggplot2::ggsave(filename = fn_p_ts, plot = p_ts)


      # __Plot, Combined 2 ----
      p_combo_2 <- gridExtra::grid.arrange(p_hm, p_depth)
      fn_p_combo_2 <- file.path(path_results, "plot_combo2.png")
      ggplot2::ggsave(filename = fn_p_combo_2, plot = p_combo_2)

      # __Plot, Combined 3 ----
      # p_combo_3 <- gridExtra::grid.arrange(p_hm, p_depth, p_ts)
      # fn_p_combo_3 <- file.path(path_results
      #                           , "plot_combo3.png")
      # ggplot2::ggsave(filename = fn_p_combo_3, plot = p_combo_3)

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
      #                           , limits = c(as.Date("2017-01-01")
      #, as.Date("2017-12-31"))) +
      #              labs(title = "Statification Events", x = "Month") +
      #              theme_light()
      #
      #  #a <- unique(data_plot$Year)
      # # b <- format(seq( as.Date("2020-01-01"), as.Date("2020-12-31")
      #, by="+1 day"), "%m-%d")
      #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      #_b_Calc_DO ----
      if(col_measure2 == "") {
        # do nothing
      } else {
        # __Plot, Oxythermal ----
        # Data values
        thresh_temp <- input$oxy_temp # 68
        operator_temp <- "<="
        thresh_do <- input$oxy_do
        operator_do <- ">="
        #
        # Plot Labels
        lab_datetime <- "Date Time"
        lab_depth    <- "Depth"
        lab_temp     <- "Temperature"

        # QC, Check if DO and Temp thresh are in data
        # range_temp <- range(data_plot[, col_measure], na.rm = TRUE)
        # range_do <- range(data_plot[, col_measure2], na.rm = TRUE)

        data_plot_test <- as.data.frame(data_plot)
        data_plot_test[, col_measure] <- ifelse(data_plot_test[, col_measure] <=
                                                                    thresh_temp
                                           , 1
                                           , 0)
        data_plot_test[, col_measure2] <- ifelse(data_plot_test[, col_measure2] >=
                                                                     thresh_do
                                           , 1
                                           , 0)
        data_plot_test[, "qc_test"] <- data_plot_test[, col_measure] *
                                                data_plot_test[, col_measure2]
        qc_data_rows <- sum(data_plot_test[, "qc_test"], na.rm = TRUE)
        rm(data_plot_test)

        # Plot
        fn_p_ot <- file.path(path_results, "plot_oxythermal.png")
        #
        if(qc_data_rows == 0) {
          # bad plot
          p_ot <- ggplot2::ggplot() +
            ggplot2::labs(title = "Oxythermal"
                          , subtitle = "No data to plot, check thresholds") +
            ggplot2::theme_void()
          #
          ggplot2::ggsave(filename = fn_p_ot, plot = p_ot)
        } else {
          # Create Plot
          p_ot <- plot_oxythermal(data = data_plot
                                  , col_datetime = col_date
                                  , col_depth = col_depth
                                  , col_temp = col_measure
                                  , col_do = col_measure2
                                  , thresh_temp = thresh_temp
                                  , operator_temp= operator_temp
                                  , thresh_do = thresh_do
                                  , operator_do = operator_do
                                  , lab_datetime = lab_datetime
                                  , lab_depth = lab_depth
                                  , lab_temp = lab_temp
                                  , lab_title = NA)
          #
          # Add subtitle and caption
          myST <- paste0("Temp ", operator_temp, " ", thresh_temp
                         , " and DO ", operator_do, " ", thresh_do)
          p_ot <- p_ot +
            ggplot2::labs(subtitle = myST) +
            ggplot2::labs(caption = paste0("Gray = Areas outside of given"
                                           , " temp and DO values."))
          # Save
          ggplot2::ggsave(filename = fn_p_ot, plot = p_ot)

        }## IF ~ nrow(data_plot_test) ~ END

        # __TDOx ----
        #
        # inputs
        do_x_val  <- input$tdox_val  #3
        #
        tdox_x <- tdox(data = data_plot
                       , col_date = col_date
                       , col_depth = col_depth
                       , col_temp = col_measure
                       , col_do = col_measure2
                       , do_x_val = do_x_val)
        # save
        fn_tdox <- file.path(path_results, paste0("tdox_", do_x_val, ".csv"))
        write.csv(tdox_x, fn_tdox, row.names = FALSE)

        # __ Plot, Depth Profile 2 ----
        lab_title_depth2 <- "Depth Profile"
        p_depth2 <- plot_depth(data = data_plot
                              , col_datetime = col_date
                              , col_depth = col_depth
                              , col_measure = col_measure2
                              , lab_datetime = lab_datetime
                              , lab_depth = lab_depth
                              , lab_measure = "Dissolved Oxygen"
                              , lab_title = lab_title_depth2)

        # Plot, Save
       fn_p_depth2 <- file.path(path_results, "plot_depth_profile_measure2.png")
        ggplot2::ggsave(filename = fn_p_depth2, plot = p_depth2)

        # __ Plot, Heat Map 2----
        lab_title_hm2 <- NA
        p_hm2 <- plot_heatmap(data = data_plot
                              , col_datetime = col_date
                              , col_depth = col_depth
                              , col_measure = col_measure2
                              , lab_datetime = lab_datetime
                              , lab_depth = lab_depth
                              , lab_measure = "DO"
                              , lab_title = lab_title_hm2
                              , contours = TRUE)
        fn_p_hm2 <- file.path(path_results, "plot_heatmap_measure2.png")
        ggplot2::ggsave(filename = fn_p_hm2, plot = p_hm2)


      } ## IF ~ is.null(col_measure2)



      # _b_Calc, Step 5, QC Area ####
      # Increment the progress bar, and qc_taxa
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; QC, Area")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      #df_data2 <- 'df_import2_DT'
      # Read in saved file (known format)
      df_data2 <- NULL  # set as null for IF QC check prior to import
      fn_input2 <- file.path(path_results, "data_input", "data_import2_area.tsv")

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
  prog_detail <- "QC
  , No area data provided.  No rLakeAnalyzer analyses performed.'"
        incProgress(0, detail = prog_detail)
        Sys.sleep(sleep_time_qc)
        #

        # _b_Calc, Save to XLS, A ----
        ls_x <- list("daily_depth_means" = df_ddm
                     , "strat_dates" = ls_strat$Stratification_Dates
                     , "strat_events" = ls_strat$Stratification_Events
                     , "summary_stats" = df_lss)
        writexl::write_xlsx(ls_x
                           , path = file.path(path_results, "Results.xlsx")
                           , col_names = TRUE
                           , format_headers = TRUE)


        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # _b_Calc, Step 7a, Zip Results ####
        # Increment the progress bar, and update the detail text.
        n_step <- n_step + 1
        prog_detail <- paste0("Step ", n_step, "; Create, Zip.")
        incProgress(1/n_inc, detail = prog_detail)
        Sys.sleep(sleep_time)

        # Create zip file
        fn_4zip <- list.files(path = file.path(path_results)
                              , pattern = "*"
                              , full.names = TRUE)
        zip(file.path(path_results, "results.zip"), fn_4zip)

        # enable download button
        shinyjs::enable("b_downloadData")

        # #
        # end sink
        #flush.console()
        sink() # console and message
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        shiny::validate(shiny::need(is.null(df_data2) != TRUE
                                    , message = msg_noArea))
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
      shiny::validate(shiny::need(col_area_depth != ""
                                 , message = "Missing 'Input, Area, Depth (m)'")
                      , shiny::need(col_area_area != ""
                                , message = "Missing 'Input, Area, Area (m2)'")
      )## validate ~ END

      # Check for misspelled column names
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
                                  , message = msg_col_data2_missing))
      ## validate ~ END

      ## _b_Calc, Step 6, rLA ####
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
        # write.csv(df_rLA
        #           , file.path(path_results, "data_rLA.csv")
        #           , row.names = FALSE)
        # Not sure why above section but keep for now, EWL, 20210716
        #
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


        ##__rLA, convert ----
        col_depth_rLA <- col_depth
        col_data_rLA <- c(col_date, col_measure)
        col_rLA_rLA <- c("datetime", "wtr")
        dir_export_rLA <- file.path(path_results)
        fn_export_rLA <- "rLA_export.csv"
        df_rLA_wtr <- LakeMonitoR::export_rLakeAnalyzer(df_data
                                                        , col_depth = col_depth_rLA
                                                        , col_data = col_data_rLA
                                                        , col_rLA = col_rLA_rLA)
        # save
        write.csv(df_rLA_wtr
                  , file.path(dir_export_rLA, fn_export_rLA)
                  , row.names = FALSE)


        ##__rLA, ts.bouyancy.freq ----
        ### Calc
        df_rLA_bf <- rLakeAnalyzer::ts.buoyancy.freq(df_rLA_wtr)
        ### Save, Data
        fn_rLA_bf <- file.path(path_results, "rLA_buoyancy_frequency.csv")
        write.csv(df_rLA_bf, file = fn_rLA_bf, row.names = FALSE)
        ### Plot (and Save)
        # munge date format
        # df_rLA_bf$datetime <- as.POSIXct(df_rLA_bf$datetime
        #                                  , format = "%Y-%m-%d %H:%M")

        fn_p_rLA_bf <- file.path(path_results, "plot_rLA_bf.png")

          tryCatch({
            grDevices::png(fn_p_rLA_bf)
              plot(df_rLA_bf, type='l', ylab='Buoyancy Frequency', xlab='Date')
            grDevices::dev.off()
          },
          error = function(err) {
            p_rLA_bf <- ggplot2::ggplot() +
            ggplot2::labs(title = "rLA, Buoyancy Frequency"
                         , subtitle = "ERROR") +
            ggplot2::theme_void()
            #
            ggplot2::ggsave(filename = fn_p_rLA_bf, plot = p_rLA_bf)
          } ## error ~ END
          )## tryCatch ~ END


        ##__rLA, ts.center.buoyancy ----
        #
        fn_rLA_cb <- file.path(path_results, "rLA_central_buoyancy.csv")
        #
        tryCatch({
          df_rLA_td <- rLakeAnalyzer::ts.thermo.depth(df_rLA_wtr)
          df_rLA_cb <- rLakeAnalyzer::ts.center.buoyancy(df_rLA_td)
          write.csv(df_rLA_cb, file = fn_rLA_cb, row.names = FALSE)
        },
        error = function(err) {
          df_rLA_cb <- data.frame(rLA_central.buoyancy = "ERROR")
          write.csv(df_rLA_cb, file = fn_rLA_cb, row.names = FALSE)
        } ## error ~ END
        )## tryCatch ~ END

        ## Plot (and Save)
        fn_p_rLA_cb <- file.path(path_results, "plot_rLA_cb.png")
        #
        if(exists("df_rLA_cb")) {
          tryCatch({
            plot_cb_y_max <- max(max(df_rLA_cb[, 2], na.rm = TRUE)
                                 , max(df_rLA_td[, 2], na.rm = TRUE)
                                 , na.rm = TRUE)
            grDevices::png(fn_p_rLA_cb)
              plot(df_rLA_cb
                   , type= 'l'
                   , ylab= 'Depth'
                   , xlab= 'Date'
                   , ylim= c(plot_cb_y_max, 0)
                   , lwd = 1.5)
              lines(df_rLA_td, type='l', col='red', lwd = 1.5)
              legend("topright",
                     c('center of buoyancy','thermocline depth'),
                     lty=c(1, 1),
                     lwd=c(1.5, 1.5), col=c("black","red"), bty = "n")
            grDevices::dev.off()
          },
          error = function(err) {
            p_rLA_cb <- ggplot2::ggplot() +
              ggplot2::labs(title = "rLA, center buoyancy"
                            , subtitle = "ERROR") +
              ggplot2::theme_void()
            #
            ggplot2::ggsave(filename = fn_rLA_cb, plot = p_rLA_cb)
          } ## error ~ END
          )## tryCatch ~ END


        }## IF ~ exists("df_rLA_cb") ~ END


        ##__rLA, ts.thermo.depth ----
        ### Calc (already calculated above)
        #df_rLA_td <- rLakeAnalyzer::ts.thermo.depth(df_rLA_wtr)
        ### Save
        fn_rLA_td <- file.path(path_results, "rLA_thermo_depth.csv")
        write.csv(df_rLA_td, file = fn_rLA_td, row.names = FALSE)
        ### Plot
        fn_p_rLA_td <- file.path(path_results, "plot_rLA_td.png")
        #
        tryCatch({
          p_rLA_td <- ggplot2::ggplot(data = df_rLA_td
                                      , ggplot2::aes(x = datetime
                                                     , y = thermo.depth)) +
            ggplot2::geom_line(na.rm = TRUE) +
            ggplot2::labs(x = "Date", y = "Thermocline Depth") +
            ggplot2::theme_bw()
        },
        error = function(err) {
          p_rLA_td <- ggplot2::ggplot() +
            ggplot2::labs(title = "rLA, thermo depth"
                          , subtitle = "ERROR") +
            ggplot2::theme_void()
          #
          ggplot2::ggsave(filename = fn_rLA_hm, plot = p_rLA_hm)
        } ## error ~ END
        )## tryCatch ~ END
        #
        ggplot2::ggsave(filename = fn_p_rLA_td, plot = p_rLA_td)


        ##__rLA, ts.schmidt.stability ----
        fn_rLA_ss <- file.path(path_results, "rLA_schmidt_stability.csv")
        #
        tryCatch({
          df_rLA_ss <- rLakeAnalyzer::ts.schmidt.stability(df_rLA_wtr
                                                           , bathy = df_data2)
          write.csv(df_rLA_ss, file = fn_rLA_ss, row.names = FALSE)
        },
        error = function(err) {
          df_rLA_ss <- data.frame(rLA_schmidt.stability = "ERROR")
          write.csv(df_rLA_ss, file = fn_rLA_ss, row.names = FALSE)
        } ## error ~ END
        )## tryCatch ~ END


        # two plots not working for all data
        # rLA functions crash hard when don't have the right data

        ## __rLA, wtr.heat.map----
        fn_rLA_hm <- file.path(path_results, "plot_rLA_heatmap.png")
        #
        tryCatch({
          grDevices::png(filename = fn_rLA_hm)
            rLakeAnalyzer::wtr.heat.map(df_rLA_wtr)
          grDevices::dev.off()
        },
        error = function(err) {
          p_rLA_hm <- ggplot2::ggplot() +
            ggplot2::labs(title = "rLA, heat map"
                          , subtitle = "ERROR") +
            ggplot2::theme_void()
          #
          ggplot2::ggsave(filename = fn_rLA_hm, plot = p_rLA_hm)
        } ## error ~ END
        )## tryCatch ~ END


        ## __rLA, schmidt.plot----
        fn_rLA_sp <- file.path(path_results, "plot_rLA_Schmidt.png")
        #
        tryCatch({
          grDevices::png(fn_rLA_sp)
            rLakeAnalyzer::schmidt.plot(df_rLA_wtr, df_rLA_bath)
          grDevices::dev.off()
        },
        error = function(err) {
          p_rLA_sp <- ggplot2::ggplot() +
            ggplot2::labs(title = "rLA, Schmidt Plot"
                          , subtitle = "ERROR") +
            ggplot2::theme_void()
          #
          ggplot2::ggsave(filename = fn_rLA_sp, plot = p_rLA_sp)
        } ## error ~ END
        )## tryCatch ~ END


        ## __rLA, meta depths ----
        ### Calc, meta depths
        df_rLA_md <- ts.meta.depths(df_rLA_wtr)
        df_rLA_md$thickness <- df_rLA_md$bottom - df_rLA_md$top
        ### Save
        fn_rLA_md <- file.path(path_results, "rLA_meta_depths.csv")
        write.csv(df_rLA_md, file = fn_rLA_md, row.names = FALSE)
        ### Plot
        # p_rLA_md <- ggplot2::ggplot(data = df_rLA_md
        #                             , ggplot2::aes(x = datetime, y = top)) +
        #   ggplot2::geom_line(color = "blue", na.rm = TRUE) +
        #   ggplot2::labs(x = "Date", y = "Meta Depths (m)") +
        #   ggplot2::theme_bw() +
        #   ggplot2::geom_line(data = df_rLA_md
        #                      , ggplot2::aes(x = datetime, y = bottom)
        #                      , color = "red"
        #                      , na.rm = TRUE) +
        #   ggplot2::scale_y_reverse()
        # #
        # fn_p_rLA_md <- file.path(path_results
        #                          , "plot_rLA_md.png")
        # ggplot2::ggsave(filename = fn_p_rLA_md, plot = p_rLA_md)

        ## Layer Calcs ----
        # (need rLA meta.depths above)
        # temp diff epi and hypo
        df_merge <- merge(df_data, df_rLA_md
                          , by.x = col_date, by.y = "datetime")

        df_merge[, "Epi"] <- ifelse(df_merge[, col_depth] < df_merge[,  "top"], TRUE, FALSE)
        df_merge[, "Meta"] <- NA
        df_merge[, "Hypo"] <- ifelse(df_merge[, col_depth] > df_merge[,  "bottom"], TRUE, FALSE)
        df_merge[, "Meta"] <- ifelse(df_merge[, "Epi"] + df_merge[, "Hypo"] == 0, TRUE, FALSE)
        df_merge[, "Layer"] <- ifelse(df_merge[, "Epi"] == TRUE
                                      , "Epi"
                                      , ifelse(df_merge[, "Meta"] ==  TRUE
                                               , "Meta"
                                               , ifelse(df_merge[, "Hypo"] ==  TRUE
                                                        , "Hypo", NA)))

        # col_datetime <- "Date"
        # col_depth <- "Depth"
        # col_measure <- "Measurement"
        col_layer <- "Layer"

        df_merge[, "Layer"] <- factor(df_merge[, "Layer"]
                                      , levels = c("Epi", "Meta", "Hypo", NA))


        stats_layers <- df_merge %>%
          dplyr::group_by(.data[[col_date]], .data[[col_layer]]) %>%
          dplyr::summarize(.groups = "keep"
                           #, groupname = col_date
                           , n = length(.data[[col_measure]])
                           , ndays = length(unique(.data[[col_date]]))
                           , mean = mean(.data[[col_measure]], na.rm = TRUE)
                           , median = stats::median(.data[[col_measure]]
                                                    , na.rm = TRUE)
                           , min = min(.data[[col_measure]], na.rm = TRUE)
                           , max = max(.data[[col_measure]], na.rm = TRUE)
                           , range = max - min
                           , sd = stats::sd(.data[[col_measure]], na.rm = TRUE)
                           , var = stats::var(.data[[col_measure]], na.rm = TRUE)
                           , cv = sd/mean
                           , q01 = stats::quantile(.data[[col_measure]]
                                                   , probs = .01
                                                   , na.rm = TRUE)
                           , q05 = stats::quantile(.data[[col_measure]]
                                                   , probs = .05
                                                   , na.rm = TRUE)
                           , q10 = stats::quantile(.data[[col_measure]]
                                                   , probs = .10
                                                   , na.rm = TRUE)
                           , q25 = stats::quantile(.data[[col_measure]]
                                                   , probs = .25
                                                   , na.rm = TRUE)
                           , q50 = stats::quantile(.data[[col_measure]]
                                                   , probs = .50
                                                   , na.rm = TRUE)
                           , q75 = stats::quantile(.data[[col_measure]]
                                                   , probs = .75
                                                   , na.rm = TRUE)
                           , q90 = stats::quantile(.data[[col_measure]]
                                                   , probs = .90
                                                   , na.rm = TRUE)
                           , q95 = stats::quantile(.data[[col_measure]]
                                                   , probs = .95
                                                   , na.rm = TRUE)
                           , q99 = stats::quantile(.data[[col_measure]]
                                                   , probs = .99
                                                   , na.rm = TRUE)
                           #, n_below = sum(.data[["below"]], na.rm = TRUE)
          )


        layers_min <- pivot_wider(stats_layers
                                  , id_cols = all_of(col_date)
                                  , names_from = "Layer"
                                  , names_sort = TRUE
                                  , values_from = "min")

        layers_min[, "diff_EH"] <- layers_min[, "Hypo"] - layers_min[, "Epi"]

        # Save
        fn_stats_layers <- file.path(path_results, "rLA_layers_stats.csv")
        write.csv(stats_layers, file = fn_stats_layers, row.names = FALSE)
        fn_layers_min <- file.path(path_results, "rLA_layers_min.csv")
        write.csv(layers_min, file = fn_layers_min, row.names = FALSE)

        # Plot
        # p_layers_diff <- ggplot2::ggplot(data = layers_min
        #                                 , ggplot2::aes_string(x = col_date, y = "diff_EH")) +
        #   ggplot2::geom_line(color = "black", na.rm = TRUE) +
        #   ggplot2::labs(x = "Date"
        #                 , y = "Temperature Difference"
        #                 , title = "Comparison of Epilimnion and Hypolimnion") +
        #   ggplot2::theme_bw()
        # #
        # fn_p_layers_diff <- file.path(path_results
        #                          , "plot_layers_diff.png")
        # ggplot2::ggsave(filename = fn_p_layers_diff, plot = p_layers_diff)


        # _b_Calc, Save to XLS, B ----
        # Add additional df to list
        # ls_x[["data_rLA"]] <- df_rLA
        # writexl::write_xlsx(ls_x
        #                    , path = file.path(path_results, "Results.xlsx")
        #                    , col_names = TRUE
        #                    , format_headers = TRUE
        #                    )

        # end sink
        #flush.console()
        sink() # console and message

        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # _b_Calc, Step 7b, Zip Results ####
        # Increment the progress bar, and update the detail text.
        n_step <- n_step + 1
        prog_detail <- paste0("Step ", n_step, "; Create, Zip.")
        incProgress(1/n_inc, detail = prog_detail)
        Sys.sleep(sleep_time)

        # Create zip file
        fn_4zip <- list.files(path = file.path(path_results)
                              , pattern = "*"
                              , full.names = TRUE)
        zip(file.path(path_results, "results.zip"), fn_4zip)

        # enable download button
        shinyjs::enable("b_downloadData")

        # #
        # # end sink
        # #flush.console()
        # sink() # console and message
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
      paste("LakeMonitoR_Calc"
            , "_"
            , format(Sys.time(), "%Y%m%d_%H%M%S")
            , ".zip"
            , sep = "")
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
      #if(file.exists(paste0(fname, ".zip"))) {file.rename(paste0(fname
      #, ".zip"), fname)}

      file.copy(file.path(path_results, "results.zip"), fname)

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

  ## _Plot, profile, plotly ----
  output$p_depth_ly <- renderPlotly({
    # if no data put in blank

    inFile <- input$fn_input
    inCol_plot_datetime <- input$col_plot_datetime
    inCol_plot_depth <- input$col_plot_depth
    inCol_plot_msr <- input$col_plot_msr

    # ensure column name is present before plot
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
      lab_error <- paste(lab_error, "Column_Measurement 1", collapse = ", ")
    }

    # Plot
    if(lab_error == lab_error_base){
      # Read user imported file
      df_plot <- read.table(inFile$datapath
                            , header = TRUE
                            , sep = input$sep
                            , quote = "\""
                            , stringsAsFactors = FALSE)

      #
      inFile_Cols <- names(df_plot)
      present_col_datetime <- inCol_plot_datetime %in% inFile_Cols
      present_col_depth    <- inCol_plot_depth %in% inFile_Cols
      present_col_msr      <- inCol_plot_msr %in% inFile_Cols

      # More checks to ensure plots correctly
      if(present_col_datetime == FALSE) {
        lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
      }
      if(present_col_depth == FALSE) {
        lab_error <- paste(lab_error, "Column_Depth", collapse = ", ")
      }
      if(present_col_msr == FALSE) {
        lab_error <- paste(lab_error, "Column_Measurement 1", collapse = ", ")
      }

      if(lab_error == lab_error_base){
      # plot
      p_depth <- plot_depth(data = df_plot
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
      }## 2nd lab_error check

    } else {
      p_depth <- ggplot() +
        theme_void() +
        geom_text(aes(0, 0, label = lab_error))
    }## IF ~ PLOT

    # Plotly
    partial_bundle(toWebGL(ggplotly(p = p_depth, dynamicTicks = TRUE)))
    # faster but lots of warnings
    # but need for larger files (1 hr * 1 yr = 8k records * N depths)
    #ggplotly(p = p_depth)

  })## output$p_depth_ly ~ END


  ## _Plot, heatmap, plotly ----
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
      lab_error <- paste(lab_error, "Column_Measurement 1", collapse = ", ")
    }

    # Plot
    if(lab_error == lab_error_base){
      # Read user imported file
      df_plot <- read.table(inFile$datapath
                            , header = TRUE
                            , sep = input$sep
                            , quote = "\""
                            , stringsAsFactors = FALSE)


      df_plot[, inCol_plot_datetime] <- as.POSIXct(df_plot[
                                                         , inCol_plot_datetime])


      #
      inFile_Cols <- names(df_plot)
      present_col_datetime <- inCol_plot_datetime %in% inFile_Cols
      present_col_depth    <- inCol_plot_depth %in% inFile_Cols
      present_col_msr      <- inCol_plot_msr %in% inFile_Cols

      # More checks to ensure plots correctly
      if(present_col_datetime == FALSE) {
        lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
      }
      if(present_col_depth == FALSE) {
        lab_error <- paste(lab_error, "Column_Depth", collapse = ", ")
      }
      if(present_col_msr == FALSE) {
        lab_error <- paste(lab_error, "Column_Measurement 1", collapse = ", ")
      }

      if(lab_error == lab_error_base){

        # plot
        p_h <- plot_heatmap(data = df_plot
                            , col_datetime = input$col_plot_datetime
                            , col_depth = input$col_plot_depth
                            , col_measure = input$col_plot_msr
                            , lab_datetime = input$lab_plot_datetime
                            , lab_depth = input$lab_plot_depth
                            , lab_measure = input$lab_plot_msr
                            , lab_title = input$lab_plot_title
                            , contours = TRUE
                            #, line_val = input$hline_val_plot_hm
                            )

        # # labels
        # if(inCol_plot_datetime == ""){
        #   p_h <- p_h + ggplot2::labs(x = inCol_plot_datetime)
        # }## IF ~ is.na(lab_datetime)
        # #
        # if(inCol_plot_depth == ""){
        #   p_h <- p_h + ggplot2::guides(
        #color = ggplot2::guide_colourbar(title =
        #                          inCol_plot_depth))
        # }## IF ~ is.na(lab_depth)
        # # #
        # if(inCol_plot_msr == ""){
        #   p_h <- p_h + ggplot2::labs(y = inCol_plot_msr)
        # }## IF ~ is.na(lab_measure)
        # #
        # if(incol_plot_title == ""){
        #   p_h <- p_h + ggplot2::labs(title = incol_plot_title)
        # }## IF ~ is.na(lab_measure)
      } else {
        p_depth <- ggplot() +
          theme_void() +
          geom_text(aes(0, 0, label = lab_error))
      }## 2nd lab_error check

    } else {
      p_h <- ggplot() +
        theme_void() +
        geom_text(aes(0, 0, label = lab_error))
    }## IF ~ PLOT

    # Plotly
    #partial_bundle(toWebGL(ggplotly(p = p_hm)))
    # faster but lots of warnings
    # but need for larger files (1 hr * 1 yr = 8k records * N depths)
    ggplotly(p = p_h, dynamicTicks = TRUE)

  })## output$p_depth_ly ~ END

  ## _Plot, Profile 2 ----
  output$p_profile2_ly <- renderPlotly({

    inFile <- input$fn_input
    inCol_plot_datetime <- input$col_plot_datetime
    inCol_plot_depth    <- input$col_plot_depth
    inCol_plot_msr2     <- input$col_plot_msr2
    incol_plot_title    <- input$lab_plot_title

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
    if(inCol_plot_msr2 == "") {
      lab_error <- paste(lab_error, "Column_Measurement 2", collapse = ", ")
    }

    # Plot
    if(lab_error == lab_error_base){
      # Read user imported file
      df_plot <- read.table(inFile$datapath
                            , header = TRUE
                            , sep = input$sep
                            , quote = "\""
                            , stringsAsFactors = FALSE)

      #
      inFile_Cols <- names(df_plot)
      present_col_datetime <- inCol_plot_datetime %in% inFile_Cols
      present_col_depth    <- inCol_plot_depth %in% inFile_Cols
      present_col_msr2     <- inCol_plot_msr2 %in% inFile_Cols

      # More checks to ensure plots correctly
      if(present_col_datetime == FALSE) {
        lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
      }
      if(present_col_depth == FALSE) {
        lab_error <- paste(lab_error, "Column_Depth", collapse = ", ")
      }
      if(present_col_msr2 == FALSE) {
        lab_error <- paste(lab_error, "Column_Measurement 2", collapse = ", ")
      }

      if(lab_error == lab_error_base){
        # plot
        p_profile2 <- plot_depth(data = df_plot
                              , col_datetime = input$col_plot_datetime
                              , col_depth = input$col_plot_depth
                              , col_measure = input$col_plot_msr2
                              , lab_datetime = input$lab_plot_datetime
                              , lab_depth = input$lab_plot_depth
                              , lab_measure = input$lab_plot_msr2
                              , lab_title = input$lab_plot_title)
      } else {
        p_profile2 <- ggplot() +
          theme_void() +
          geom_text(aes(0, 0, label = lab_error))
      }## 2nd lab_error check

    } else {
      p_profile2 <- ggplot() +
        theme_void() +
        geom_text(aes(0, 0, label = lab_error))
    }## IF ~ PLOT

    # Plotly
    partial_bundle(toWebGL(ggplotly(p = p_profile2, dynamicTicks = TRUE)))
    # faster but lots of warnings
    # but need for larger files (1 hr * 1 yr = 8k records * N depths)
    #ggplotly(p = p_depth)


  })## output$p_profile2_ly ~ END

  ## _Plot, Time Series ----
  output$p_ts_ly <- renderPlotly({

    inFile <- input$fn_input3
    inCol_plot_datetime <- input$col_plot_datetime
    inCol_plot_msr3     <- input$col_plot_msr3
    incol_plot_title    <- input$lab_plot_title

    lab_error_base <- "Missing: "
    lab_error <- lab_error_base

    if(is.null(inFile)) {
      lab_error <- paste0(lab_error, "File")
    }
    if(inCol_plot_datetime == "") {
      lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
    }
    if(inCol_plot_msr3 == "") {
      lab_error <- paste(lab_error, "Column_Measurement 3", collapse = ", ")
    }

    # Plot
    if(lab_error == lab_error_base){
      # Read user imported file
      df_plot <- read.table(inFile$datapath
                            , header = TRUE
                            , sep = input$sep
                            , quote = "\""
                            , stringsAsFactors = FALSE)

      #
      inFile_Cols <- names(df_plot)
      present_col_datetime <- inCol_plot_datetime %in% inFile_Cols
      present_col_msr3     <- inCol_plot_msr3 %in% inFile_Cols

      # More checks to ensure plots correctly
      if(present_col_datetime == FALSE) {
        lab_error <- paste(lab_error, "Column_DateTime", collapse = ", ")
      }
      if(present_col_msr3 == FALSE) {
        lab_error <- paste(lab_error, "Column_Measurement 3", collapse = ", ")
      }

      if(lab_error == lab_error_base){
        # plot
        p_ts <- plot_ts(data = df_plot
                        , col_datetime = input$col_plot_datetime
                        , col_measure = input$col_plot_msr3
                        , lab_datetime = input$lab_plot_datetime
                        , lab_measure = input$lab_plot_msr3
                        , lab_title = input$lab_plot_title)
      } else {
        p_ts <- ggplot() +
          theme_void() +
          geom_text(aes(0, 0, label = lab_error))
      }## 2nd lab_error check

    } else {
      p_ts <- ggplot() +
        theme_void() +
        geom_text(aes(0, 0, label = lab_error))
    }## IF ~ PLOT

    # Plotly
    partial_bundle(toWebGL(ggplotly(p = p_ts, dynamicTicks = TRUE)))
    # faster but lots of warnings
    # but need for larger files (1 hr * 1 yr = 8k records * N depths)
    #ggplotly(p = p_depth)


  })## output$p_ts_ly ~ END


  # AGGREGATE ----

  # b_ImportAgg ----

  # b_Agg ----
  observeEvent(input$b_Agg, {
    shiny::withProgress({
      #
      boo_DEBUG <- FALSE
      # Number of increments
      n_inc <- 5
      n_step <- 0
      sleep_time <- 0.5
      sleep_time_qc <- 5

      # _b_Agg, 1, Initialize ####
      #
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Initialize.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      # Ensure folders exist
      #
      if(isFALSE(dir.exists(file.path(path_results)))){
        dir.create(file.path(path_results))
      }## IF ~ Results ~ END
      #
      if(isFALSE(dir.exists(file.path("data_input")))){
        dir.create(file.path(path_results, "data_input"))
      }## IF ~ import ~ END

      #
      ## Empty Folder, Results ----
      fn_results <- list.files(file.path(path_results), full.names=TRUE)
      file.remove(fn_results)

      ## Empty Folder, import ----
      fn_import <- list.files(file.path(path_results, "data_input"), full.names=TRUE)
      file.remove(fn_import)

      ## Sink, start ----
      # create file, ok on Windows but not Linux
      #file.create(file.path(path_results, "_log_agg.txt"))
      file_sink <- file(file.path(path_results, "_log_agg.txt")
                        , open = "wt")
      #sink(file_sink, type = c("output", "message"), append = TRUE)
      # not working as a single line
      sink(file_sink, type = "output", append = TRUE)
      sink(file_sink, type = "message", append = TRUE)
      # Log
      message("Aggregate Log from LakeMonitoR Shiny App")
      message(paste0("Time, Start:  ", Sys.time()))
      # appUser <- Sys.getenv('USERNAME')
      # message(paste0("Username = ", appUser))
      # Not meaningful when run online via Shiny.io
      inFile <- input$fn_input_agg
      message(paste0("files to combine = \n"
                     , paste(paste0("  ", inFile$name), collapse = "\n")))

      # # TEST ----
      # # message("inFile$datapath")
      # # message(inFile$datapath)
      # # message("basename")
      # # message(paste(basename(inFile$datapath)), collapse = ",")
      # # message("dirname")
      # # message(dirname(inFile$datapath)[1])
      # # message("file.path('Results')")
      # # message(file.path(path_results))
      # # message("Files")
      # # message(as.vector(paste(inFile$name, collapse = ",")))
      #
      # _b_Agg, 2, Copy Files ----
      #
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Combine files.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)
      #
      # Copy Import "as is" to "Results" folder
      file.copy(inFile$datapath
                , file.path(path_results, "data_input", inFile$name))


      # _b_Agg, 3, Combine ----
      #
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Combine files.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)

      # Run aggregate function
      #myFile_import <- file.path(path_results, inFile$name)
      myFile_import <- list.files(file.path(path_results, "data_input"), "*")
      myFile_export <- paste0("CombinedFile_"
                              , format(Sys.time(), "%Y%m%d_%H%M%S")
                              , ".csv")
      myDir_import <- file.path(path_results, "data_input")
      myDir_export <- file.path(path_results)

      LakeMonitoR::agg_depth_files(filename_import = myFile_import
                                 , filename_export = myFile_export
                                 , dir_import = myDir_import
                                 , dir_export = myDir_export)

      ## Sink, End ----
      message(paste0("Combined file = ", myFile_export))
      message(paste0("Time, End:  ", Sys.time()))
      #flush.console()
      suppressWarnings(sink()) # console
      suppressWarnings(sink()) # message

      # _b_Agg, 4, Zip Results ####
      #
      # Increment the progress bar, and update the detail text.
      n_step <- n_step + 1
      prog_detail <- paste0("Step ", n_step, "; Create, Zip.")
      incProgress(1/n_inc, detail = prog_detail)
      Sys.sleep(sleep_time)
      #
      # Create zip file
      fn_4zip <- list.files(path = file.path(path_results)
                            , pattern = "*"
                            , full.names = TRUE)
      # fn_4zip <- normalizePath(file.path(path_results
      #                                    , c("_log_agg.txt")))
      #                                    #, c("_log_agg.txt", myFile_export)))
      zip(file.path(path_results, "agg.zip"), fn_4zip)


      # _b_Agg, 5, Clean Up ----
      ## Enable download button ----
      shinyjs::enable("b_downloadAgg")



      #
    }##expr~withProgress~END
    , message = "Combining:"
    )##withProgress~END
  }##expr~ObserveEvent~END
  )##observeEvent~b_Calc~END






  # b_downloadAgg ----
  # Download of Aggregated Files
  output$b_downloadAgg <- downloadHandler(
    #
    filename = function() {
      paste("LakeMonitoR_Agg"
            , "_"
            , format(Sys.time(), "%Y%m%d_%H%M%S")
            , ".zip"
            , sep = "")
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
      #if(file.exists(paste0(fname, ".zip"))) {file.rename(paste0(fname
      #, ".zip"), fname)}

      file.copy(file.path(path_results, "agg.zip"), fname)

      #
    }##content~END
    #, contentType = "application/zip"
  )##downloadData~END

  # Sidebar Toggles ----
  # https://stackoverflow.com/questions/42159804/how-to-collapse-sidebarpanel-in-shiny-app
  observeEvent(input$toggleSidebar_plot, {
    shinyjs::toggle(id = "Sidebar_Plot")
  })

})##shinyServer~END



