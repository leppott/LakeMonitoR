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

    inFile <- input$fn_input

    if (is.null(inFile)){
      return(NULL)
    }##IF~is.null~END

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
    fn_input <- file.path(".", "Results", "data_import.tsv")
    write.table(df_input, fn_input, row.names=FALSE, col.names=TRUE, sep="\t")

    # Copy to "Results" folder - Import "as is"
    file.copy(input$fn_input$datapath, file.path(".", "Results", input$fn_input$name))

    return(df_input)

  }##expression~END
  , filter="top", options=list(scrollX=TRUE)
  )##output$df_import_DT~END

  # b_Calc ####
  # Calculate IBI (metrics and scores) from df_import
  # add "sleep" so progress bar is readable
  observeEvent(input$b_Calc, {
     shiny::withProgress({
      #
      # Number of increments
      n_inc <- 6

      # sink output
      #fn_sink <- file.path(".", "Results", "results_log.txt")
      file_sink <- file(file.path(".", "Results", "results_log.txt"), open = "wt")
      sink(file_sink, type = "output", append = TRUE)
      sink(file_sink, type = "message", append = TRUE)
      # Log
      message("Results Log from MBSStools Shiny App")
      message(Sys.time())
      inFile <- input$fn_input
      message(paste0("file = ", inFile$name))


      # Increment the progress bar, and update the detail text.
      incProgress(1/n_inc, detail = "Data, Initialize")
      Sys.sleep(0.25)

      #df_data <- 'df_import_DT'
      # Read in saved file (known format)
      df_data <- NULL  # set as null for IF QC check prior to import
      fn_input <- file.path(".", "Results", "data_import.tsv")
      df_data <- read.delim(fn_input, stringsAsFactors = FALSE, sep="\t")

      # QC, FAIL if TRUE
      if (is.null(df_data)){
        return(NULL)
      }

      #appUser <- Sys.getenv('USERNAME')
      # Not meaningful when run online via Shiny.io

      # Increment the progress bar, and qc_taxa
      incProgress(1/n_inc, detail = "QC, Taxa")
      Sys.sleep(0.25)
      # qc_taxa
      myIndex <- input$MMI
      myCommunity <- Community[match(myIndex, MMIs)]
      # Log
      message(paste0("Community = ", myCommunity))
      message(paste0("QC taxa = ", input$QC_Type))

      if(myCommunity == "fish"){
        df_mt  <- df_mt_fish
      } else if (myCommunity == "bugs"){
        df_mt  <- df_mt_bugs
      } else {
        # Nothing
      }## IF ~ community ~ END

      df_data_qc <- qc_taxa(df_data, df_mt, myCommunity, input$QC_Type)
      # INDEX.NAME to Index.Name
      names(df_data_qc)[names(df_data_qc) %in% "INDEX.NAME"] <- "Index.Name"
      # QC
      # write.csv(df_data, file.path(".", "Results", "results_data.csv"))
      # write.csv(df_data_qc, file.path(".", "Results", "results_data_qc.csv"))

      # Increment the progress bar, and update the detail text.
      incProgress(1/n_inc, detail = "Calculate, Metrics")
      Sys.sleep(0.25)

      # calculate values and scores in a single step.
      #  and save each file

      #myIndex <- input$MMI
      thresh <- MBSStools::metrics_scoring
      myMetrics <- as.character(droplevels(unique(thresh[thresh[,"Index.Name"]==myIndex,"MetricName.Other"])))
      #
     # myCommunity <- Community[match(myIndex, MMIs)]
      myCol_Strata <- col_Strata[match(myIndex, MMIs)]

      # Log
      message(paste0("IBI = ", input$MMI))

      df_metval <- MBSStools::metric.values(df_data_qc, myCommunity, myMetrics)
      #
      # Save
      # fn_metval <- file.path(".", "Results", "results_metval.tsv")
      # write.table(df_metval, fn_metval, row.names = FALSE, col.names = TRUE, sep="\t")
      fn_metval <- file.path(".", "Results", "results_metval.csv")
      write.csv(df_metval, fn_metval, row.names = FALSE)
      #
      # QC - upper case Index.Name
      names(df_metval)[grepl("Index.Name", names(df_metval))] <- "INDEX.NAME"



      # Increment the progress bar, and update the detail text.
      incProgress(1/n_inc, detail = "Calculate, Scores")
      Sys.sleep(0.25)

      # Metric Scores
      #
      df_metsc <- MBSStools::metric.scores(df_metval, myMetrics, "INDEX.NAME"
                                           , myCol_Strata, thresh)
      # Add Narrative
      myBreaks <- c(1:5)
      myLabels <- c("Very Poor", "Poor", "Fair", "Good")
      df_metsc$IBI_Nar <- cut(df_metsc$IBI
                              , breaks=myBreaks
                              , labels=myLabels
                              , include.lowest=TRUE
                              , right=FALSE
                              , ordered_result=TRUE)
      # Save
      # fn_metsc <- file.path(".", "Results", "results_metsc.tsv")
      # write.table(df_metsc, fn_metsc, row.names = FALSE, col.names = TRUE, sep="\t")
      fn_metsc <- file.path(".", "Results", "results_metsc.csv")
      write.csv(df_metsc, fn_metsc, row.names = FALSE)



      # Increment the progress bar, and update the detail text.
      incProgress(1/n_inc, detail = "Create, Plot")
      Sys.sleep(0.25)

      # Plot
      p1 <- ggplot(df_metsc, aes(IBI), fill=myCol_Strata, shape=myCol_Strata) +
                  geom_dotplot(aes_string(fill=myCol_Strata), method="histodot", binwidth = 1/5) +
                  #geom_dotplot(aes_string(fill=myCol_Strata)) +
                  labs(x=myIndex) +
                  geom_vline(xintercept = 3) +
                  scale_x_continuous(limits = c(1, 5)) +
                  # scale_fill_discrete(name="STRATA"
                  #                     , breaks=c("COASTAL", "EPIEDMONT", "HIGHLAND")) +
                  theme(axis.title.y=element_blank()
                        , axis.ticks.y=element_blank()
                        , axis.text.y=element_blank())
      fn_p1 <- file.path(".", "Results", "results_plot_IBI.jpg")
      ggplot2::ggsave(fn_p1, p1)



      # Increment the progress bar, and update the detail text.
      incProgress(1/n_inc, detail = "Create, Zip")
      Sys.sleep(0.25)

      # Create zip file
      fn_4zip <- list.files(path = file.path(".", "Results")
                            , pattern = "^results_"
                            , full.names = TRUE)
      zip(file.path(".", "Results", "results.zip"), fn_4zip)

      # enable download button
      shinyjs::enable("b_downloadData")

      # #
      message(paste0("Working Directory = ", getwd()))
      # return(myMetric.Values)
      # end sink
      #flush.console()
      sink() # console
      sink() # message
      #
     }##expr~withProgress~END
     , message = "Calculating IBI"
     )##withProgress~END
    }##expr~ObserveEvent~END
  )##observeEvent~b_CalcIBI~END

  # df_metric_values ####
  # output$df_metric_values <- DT::renderDT({
  #   # input$df_metric_values will be NULL initially. After the user
  #   # calculates an IBI, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #
  #   # If haven't imported a file keep blank
  #   inFile <- input$fn_input
  #
  #   if (is.null(inFile)){
  #     return(NULL)
  #   }##IF~is.null~END
  #
  #   # Read in saved file (known format)
  #   df_met_val <- NULL
  #   fn_met_val <- file.path(".", "Results", "results_metval.tsv")
  #   df_met_val <- read.delim(fn_input, stringsAsFactors = FALSE, sep="\t")
  #
  #   boo_met_val <- file.exists(fn_met_val)
  #
  #   if (boo_met_val==FALSE){
  #     return(NULL)
  #   }
  #
  #   return(df_met_val)
  #
  # }##expr~END
  # , filter="top", options=list(scrollX=TRUE)
  # )##output$df_import~END

  # # df_metric_scores ####
  # output$df_metric_scores <- renderDT({
  #   # input$df_metric_scores will be NULL initially. After the user
  #   # calculates an IBI, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #
  #   # If haven't imported a file keep blank
  #   inFile <- input$fn_input
  #
  #   if (is.null(inFile)){
  #     return(NULL)
  #   }##IF~is.null~END
  #
  #   # Read in saved file (known format)
  #   df_met_sc <- NULL
  #   fn_met_sc <- file.path(".", "Results", "results_metsc.tsv")
  #   df_met_sc <- read.delim(fn_input, stringsAsFactors = FALSE, sep="\t")
  #   boo_met_sc <- file.exists(fn_met_sc)
  #
  #   if (boo_met_sc==FALSE){
  #     return(NULL)
  #   } else {
  #     return(df_met_sc)
  #   }
  #
  # }##expr~END
  # , filter="top", options=list(scrollX=TRUE)
  # )##output$df_import~END


  # # plot_IBI ####
  # #output$plot_IBI <- renderPlotly(ggplotly(plot_BIBI))
  # output$plot_IBI <- renderImage({
  #   #
  #   # If haven't imported a file keep blank
  #   inFile <- input$fn_input
  #
  #   fn_plot <- file.path(".", "Results", "plot_IBI.jpg")
  #   boo_plot <- file.exists(fn_plot)
  #
  #
  #   if (is.null(inFile)==TRUE){# || boo_plot==FALSE){
  #     return(NULL)
  #   }##IF~is.null~END
  #
  #   # if (boo_plot==FALSE){
  #   #   return(NULL)
  #   # }
  #
  #   return(list(src = fn_plot
  #               , filetype = "image/jpeg"
  #               , width = 800
  #               )
  #         )##return~END
  #
  # }##expr~END
  # , deleteFile=FALSE
  # )##renderImage~END


  # b_downloadData ####

  # disable button unless have zip file
  # Enable in b_Calc instead
  # observe({
  #   fn_zip_toggle <- paste0("results", ".zip")
  #   shinyjs::toggleState(id="b_downloadData", condition = file.exists(file.path(".", "Results", fn_zip_toggle)) == TRUE)
  # })##~toggleState~END


  # Downloadable csv of selected dataset
  output$b_downloadData <- downloadHandler(
    # use index and date time as file name
    #myDateTime <- format(Sys.time(), "%Y%m%d_%H%M%S")

    filename = function() {
      paste(input$MMI, "_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".zip", sep = "")
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





})##shinyServer~END
