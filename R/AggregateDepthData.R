#' @title Aggregate Depth Data Files
#'
#' @description  Function for combining high frequency data with depth.
#'
#' @details Assumes files have the same column names.
#' The files are merged with all=TRUE.
#'
#' One new field (AggFile_Source) is added with the name of the source file.
#' No other manipulation of the data is performed.
#'
#' If any columns in the output have the ".x" or ".y" suffix when have duplicate
#' column names in a file.
#'
#' @param filename_import Vector of file names.
#' @param filename_export File name for combined file.
#' @param dir_import Directory for import data.
#' Default is current working directory.
#' @param dir_export Directory for export data.
#' Default is current working directory.
#'
#' @return Returns a csv into the specified export directory of each file
#' appended into a single file.
#'
#' @examples
#' # Data Files
#' myFile_import <- c("Ellis--1.0m_Water_20180524_20180918.csv"
#'                   , "Ellis--3.0m_Water_20180524_20180918.csv")
#' myFile_export <- "Ellis--Combined_Water_20180524_20180918.csv"
#' myDir_import <- file.path(system.file("extdata", package = "LakeMonitoR"))
#' myDir_export <- tempdir()
#' AggregateFiles(filename_import = myFile_import
#'                , filename_export = myFile_export
#'                , dir_import = myDir_import
#'                , dir_export = myDir_export)
#
#' @export
AggregateFiles <- function(filename_import
                           , filename_export
                           , dir_import
                           , dir_export
                           ) {
  #
  # QC ----
  boo_QC <- FALSE
  if(isTRUE(boo_QC)){
    filename_import <- c("Ellis--1.0m_Water_20180524_20180918.csv"
                , "Ellis--3.0m_Water_20180524_20180918.csv")
    filename_export <- "Ellis--Combined_Water_20180524_20180918.csv"
    dir_import <- file.path(system.file("extdata", package = "LakeMonitoR"))
    dir_export <- tempdir()
    #
  }## IF ~ isTRUE(boo_QC) ~ END

  # Error Checking - only 1 SiteID and 1 DataType
  if(length(filename_import) == 1){
    myMsg <- "Only 1 file selected.  No action performed."
    stop(myMsg)
  }
  #

  myDir.data.import <- dir_import
  myDir.data.export <- dir_export
  strFile.Out <- filename_export
  #
  myDate <- format(Sys.Date(),"%Y%m%d")
  myTime <- format(Sys.time(),"%H%M%S")
  #

  #files2process = list.files(path=myDir.data.import, pattern=" *.csv")
  files2process <- filename_import
  #utils::head(files2process)
  #
  #
  # Define Counters for the Loop
  intCounter <- 0
  intCounter.Stop <- length(files2process)
  intItems.Total <- intCounter.Stop
  print(paste("Total files to process = ", intItems.Total, sep=""))
  utils::flush.console()
  myItems.Complete  <- 0
  myItems.Skipped   <- 0
  # myFileTypeNum.Air <- 0
  # myFileTypeNum.Water <- 0
  # myFileTypeNum.AW <- 0
  # myFileTypeNum.Gage <- 0
  #strFile.SiteID.Previous <- ""
  #
  # Create Log file
  # ##  List of all items (files)
  # myItems.ALL <- as.vector(unique(files2process))
  # # create log file for processing results of items
  # #myItems.Log <- data.frame(cbind(myItems.ALL,NA),stringsAsFactors=FALSE)
  # myItems.Log <- data.frame(ItemID = seq_len(intItems.Total)
  #                           , Status = NA
  #                           , ItemName = myItems.ALL)
  #


  # Error if no files to process or no files in dir

  # Start Time (used to determine run time at end)
  myTime.Start <- Sys.time()
  #

  # Loop Files ----
  # Perform a data manipulation on the data as a new file
  # Could use for (n in files2process) but prefer the control of a counter
  while (intCounter < intCounter.Stop)
  {
    #
    # 0. Increase the Counter
    intCounter <- intCounter+1
    #
    # 1.0. File Name, Define ---
    strFile <- files2process[intCounter]
    #strFile.Base <- substr(strFile,1,nchar(strFile)-nchar(".csv"))

    #QC, make sure file exists
    if(strFile %in% list.files(path=myDir.data.import) == FALSE) {
      #
      print("ERROR; no such file exits.  Cannot QC the data.")
      print(paste("PATH = ",myDir.data.import,sep=""))
      print(paste("FILE = ",strFile,sep=""))
      utils::flush.console()
      #
      # maybe print similar files
      #
      stop("Bad file.")
      #
    }##IF.file.END

    #
    # 2.1. Check File Size----
    #if(file.info(paste(myDir.data.import,"/",strFile,sep=""))$size==0){
    if(file.info(file.path(myDir.data.import,strFile))$size==0){
      # inform user of progress and update LOG
      myMsg <- "SKIPPED (file blank)"
      myItems.Skipped <- myItems.Skipped + 1
      myItems.Log[intCounter,2] <- myMsg
      fun.write.log(myItems.Log,myDate,myTime)
      fun.Msg.Status(myMsg, intCounter, intItems.Total, strFile)
      utils::flush.console()
      # go to next Item
      next
    }

    #
    # 3.0. Import the data ----
    #data.import=read.table(strFile,header=F,varSep)
    #varSep = "\t" (use read.delim instead of read.table)
    # as.is = T so dates come in as text rather than factor
    #data.import <- utils::read.delim(strFile,as.is=TRUE,na.strings=c("","NA"))
    data.import <- utils::read.csv(file.path(myDir.data.import, strFile)
                                   ,as.is=TRUE
                                   ,na.strings=c("","NA"))
    #

    # 3.5, Add SourceFile Name ----
    data.import[, "AggFile_Source"] <- strFile

    # File, 20170607
    if(intCounter == 1) {
      # Create empty data frame for Append file
      data.append <- data.frame(matrix(nrow=0, ncol=ncol(data.import)))
      names(data.append) <- names(data.import)
    }
    #
    # 7.3. Append Subset to Append
    #data.append <- rbind(data.append,data.subset)
    # change to merge
    data.append <- merge(data.append, data.import, all=TRUE, sort=FALSE)
    #

    # 8. Write File ----
    utils::write.csv(data.append
                     , file = file.path(myDir.data.export, strFile.Out)
                     , quote = FALSE
                     , row.names = FALSE)

    # 9. Clean up ----
    # set previous SiteID for QC check near top
    #strFile.SiteID.Previous <- strFile.SiteID
    # 9.1. Inform user of progress and update LOG
    myMsg <- "COMPLETE"
    myItems.Complete <- myItems.Complete + 1
    #myItems.Log[intCounter,2] <- myMsg
    #fun.write.log(myItems.Log,myDate,myTime)
    fun.Msg.Status(myMsg, intCounter, intItems.Total, strFile)
    utils::flush.console()
    # 9.2. Remove data (import and subset)
    rm(data.import)
    #
  }##while.END
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  rm(data.append)


  #
}##FUN.Aggregate.END


