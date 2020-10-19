#' @title Depth Profile Daily Means
#'
#' @description Calculates daily means from depth profile data
#'
#' @details Interpolates at integer depths.
#' Daily means with interpolation.
#'
#' Utilizes the `xts` package.
#'
#' @param data data frame of (list columns)
#' @param col_siteid Column name, SiteID
#' @param col_datetime Column name, Date and Time
#' @param col_depth Column name, Depth
#' @param col_measure Column name, measurement for calculation
#'
#' @return data frame of daily means by depth
#'
#' @examples
#' # Packages
#' library(xts)
#'
#' # Lake Data
#' data <- laketemp
#'
#' # Filter by any QC fields
#' data <- data[(data$FlagV=='P'), ]
#'
#' # name columns
#' col_siteid   <- "SiteID"
#' col_datetime <- "Date_Time"
#' col_depth    <- "Depth_m"
#' col_measure  <- "Water_Temp_C"
#'
#' # run function
#' data_ddm <- daily_depth_means(data, col_siteid, col_datetime, col_depth, col_measure)
#'
#' # summary
#' summary(data_ddm)
#'
#' @export
daily_depth_means <- function(data, col_siteid, col_datetime, col_depth, col_measure){

  # new column
  col_fun_date    <- "Date"
  col_fun_depth   <- "Depth"
  col_fun_measure <- "Measurement"

  # drop unused columns & convert to data frame if a tibble
  data <- data.frame(data[, c(col_siteid, col_datetime, col_depth, col_measure)])

  # na.omit, just in case
  data <- na.omit(data[, c(col_siteid, col_datetime, col_depth, col_measure)])

  #Find the maximum and minimum depths in the dataset and round them to the nearest whole number
  #Create a list with each whole number in between those two numbers (including the max and min)
  MaxDepth <- round(max(data[, col_depth]), digits=0)
  MinDepth <- round(min(data[, col_depth]), digits=0)
  Standard_Depths <- c(MinDepth:MaxDepth)

  #Format Date Field to UNIX time
  data[, col_datetime] <- as.POSIXct(data[, col_datetime], format="%Y-%m-%d %H:%M", tz="GMT")

  #Get the list of depths in the dataset
  laketempdepths <- as.list(sort(unique(data[, col_depth])))
  #Create empty variable for data frame
  meandepths <- NULL

  #Calculate daily mean temps
  for (i in laketempdepths){
    depth <- subset(data, data[, col_depth] == i)
    #this creates an xts time series. The inputs will be the temperature and date/time fields
    #as.xts(Temperature,Date_Time)
    depth.xts <- xts::as.xts(depth[, col_measure], order.by = as.Date(depth[, col_datetime], format = '%Y-%m-%d %H:%M'))
    depth.mean.xts <- xts::apply.daily(depth.xts, mean)
    depthmean <- data.frame(col_fun_date = index(depth.mean.xts)
                            , col_fun_depth = i
                            , col_fun_measure = coredata(depth.mean.xts))
    meandepths <- rbind(meandepths, depthmean)
  }## FOR ~ i ~ END

  # rename columns since can't use variables in data.frame as col names
  names(meandepths) <- c(col_fun_date, col_fun_depth, col_fun_measure)

  #Get the list of dates in the new mean date data frame
  meandays <- unique(meandepths[, col_fun_date])
  Standardized.msr.data <- NULL

  #This interpolates the measurement (temperatures)
  # It use the whole number depth list created earlier for each date
  for (j in meandays){
    Daysubset <- meandepths[meandepths[, col_fun_date] == j, ]
    rowcount <- as.numeric(nrow(Daysubset))
    if (rowcount > 1){
      interpolated <- approx(Daysubset[, col_fun_depth], Daysubset[, col_fun_measure]
                             , method = "linear"
                             , xout = Standard_Depths)
      Standardized.row <- data.frame(col_fun_date = unique(Daysubset[, col_fun_date])
                                     , col_fun_depth = interpolated$x
                                     , col_fun_measure = interpolated$y)

    }else{
      Standardized.row <- data.frame(col_fun_date = unique(Daysubset[, col_fun_date])
                                     , col_fun_depth = round(Daysubset[, col_fun_depth], digits = 0)
                                     , col_fun_measure = Daysubset[, col_fun_measure])
    }## IF ~ rowcount ~ END
    Standardized.msr.data <- rbind(Standardized.msr.data, Standardized.row)
  }## FOR ~ j ~ END

  # rename columns since can't use variables in data.frame as col names
  names(Standardized.msr.data) <- c(col_fun_date, col_fun_depth, col_fun_measure)

  Standardized.msr.data[, col_fun_date] <- as.Date(Standardized.msr.data[, col_fun_date])
  Standardized.msr.data <- Standardized.msr.data[order(Standardized.msr.data[, col_fun_date]), ]

  # Return
  return(Standardized.msr.data)

}## FUNCTION ~ END
















