#' @title Export data for rLakeAnalyzer package
#'
#' @description Creates a date frame (and file export) from depth profile data
#' in the format used by the rLakeAnalyzer package.
#'
#' @details The rLakeAnalyzer package is not included in the LakeMonitoR
#' package.  But an example is provided.
#'
#' To run the example rLakeAnalyzer calculations you will need the rLakeAnalyzer
#' package (from CRAN).
#'
#' The rLakeAnalyzer format is "datetime" in the format of "yyyy-mm-dd HH:MM:SS"
#' followed by columns of data.  The header of these data columns is
#' "Param_Depth"; e.g., wtr_0.5 is water temperature (deg C) at 0.5 meters.
#'
#' * doobs = Dissolved Oxygen Concentration (mg/L)
#'
#' * wtr = Water Temperature (degrees C)
#'
#' * wnd = Wind Speed (m/s)
#'
#' * airT = Air Temperature (degrees C)
#'
#' * rh = Relative Humidity (%)
#'
#' Files will be saved, if desired, as csv.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Erik.Leppo@tetratech.com (EWL)
# 2018-02-12, wrote for ContDataQC package
# 2020-10-22, borrowed from ContDataQC package and repurposed for LakeMonitoR
# remove "saving" of csv.  Leave that to the user.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @param df_data Data frame to be converted for use with rLakeAnalyzer.
#' @param col_depth Column name for "depth" in df_data.  Default = "Depth"
#' @param col_data Column names in df_data to transform for use with
#' rLakeAnalyzer.  Date time must be the first entry.
#' @param col_rLA Column names to use with rLakeAnalyzer.  See details for
#' accepted entries.  datetime must be the first entry.
#'
#' @return Returns a data frame formatted (wide) for use with the rLakeAnalyzer
#' package suite of functions.
#'
#' @examples
#' # Convert Data for use with rLakeAnalyzer
#'
#' # Data
#' data <- laketemp_ddm
#'
#' # Columns, date listed first
#' col_depth <- "Depth"
#' col_data <- c("Date", "Measurement")
#' col_rLA  <- c("datetime", "wtr")
#'
#' # Run function
#' df_rLA <- export_rLakeAnalyzer(data, col_depth, col_data, col_rLA)
#'
#' \dontrun{
#' # Save
#' write.csv(df_rLA, "example_rLA.csv", row.names = FALSE)
#'
#' #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' # use rLakeAnalyzer - heat map
#' library(rLakeAnalyzer)
#'
#' # Filter Data for only temperature
#' col_wtr <- colnames(df_rLA)[grepl("wtr_", colnames(df_rLA))]
#' df_rLA_wtr <- df_rLA[, c("datetime", col_wtr)]
#'
#' # Create bathymetry data frame
#' df_rLA_bath <- data.frame(depths=c(3,6,9), areas=c(300,200,100))
#'
#' # Generate Heat Map
#' wtr.heat.map(df_rLA_wtr)
#'
#' # Generate Schmidt Plot
#' #schmidt.plot(df_rLA_wtr, df_rLA_bath)
#'
#' # Generate Schmidt Stability Values
#' df_rLA_Schmidt <- ts.schmidt.stability(df_rLA_wtr, df_rLA_bath)
#'
#' #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' # Plot original data in ggplot
#' library(ggplot2)
#'
#' # Plot, Create
#' p <- ggplot(data, aes(x=Date, y=Measurement)) +
#'        geom_point(aes(color=Depth)) +
#'        scale_color_continuous(trans="reverse") +
#'        labs(title = "Example depth profile data"
#'             , y = "Temperature (Celsius)"
#'             , color = "Depth (m)") +
#'        theme_light()
#'
#' # Plot, Show
#' p
#' }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @export
export_rLakeAnalyzer <- function(df_data
                                 , col_depth = "Depth"
                                 , col_data
                                 , col_rLA
                      ) {
  #
  boo_DEBUG <- FALSE
  # QC
  ## Ensure have data frame and not tibble
  df_data <- as.data.frame(df_data)
  ## QC, equal columns
  if(length(col_data)!=length(col_rLA)){
    msg <- "Number of columns not equal."
    stop(msg)
  }
  ## QC, cols_data
  if(sum(col_data %in% colnames(df_data))!=length(col_data)){
    msg <- "The data frame (df_data) does not contain all specified columns
    (col_data)."
    stop(msg)
  }

  #
  myParams <- col_data[-1]

  #
  if(boo_DEBUG==TRUE){
    i <- myParams[1]
    #fn_export <- NULL
  }

  #
  for (i in myParams){
    #
    i_num <- match(i, myParams)

    # long to wide for parameter i
    #df_i <- dcast(df_data, col_data[1] ~ col_depth, value.var=i, fun=mean)
    df_i <- reshape2::dcast(df_data, df_data[, col_data[1]] ~ df_data[
                                           , col_depth], value.var=i, fun=mean)
    names(df_i)[1] <- "datetime"
    names(df_i)[-1] <- paste(col_rLA[i_num+1], names(df_i)[-1], sep="_")

    if(i_num==1){
      df_rLA <- df_i
    } else {
      df_rLA <- merge(df_rLA, df_i)
    }
  }## IF ~ i ~ END

  # Return
  return(df_rLA)

}##FUNCTION~Export.rLakeAnalyzer~END
