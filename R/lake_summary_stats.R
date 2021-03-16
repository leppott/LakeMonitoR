#' @title Lake Summary Statistics
#'
#' @description Calculates summary statistics on daily depth means.
#'
#' @details Input data is assumed to be a single lake location depth profile
#' with one measurement per day and depth.  The function daily_depth_means can
#' be used to generate this type of data from continuous data with multiple
#' measurements per day for each depth.
#'
#' Calculated statistics are:
#'
#' * minimum
#'
#' * maximum
#'
#' * range
#'
#' * mean
#'
#' * median
#'
#' * quantiles (1, 5, 10, 25, 50, 75, 90, 95, 99)
#'
#' Statistics are calculated for multiple time periods:
#'
#' * entire dataset
#'
#' * year
#'
#' * month
#'
#' * year month
#'
#' A data frame is returned in a hybrid long format.  Statistics will be columns
#' and time periods will also be a column with the values for each row.  That is,
#' if time period is month then each month will be a row with each statistic in
#' a column.
#'
#' @param data data frame
#' @param col_date Column name, Date
#' @param col_depth Column name, Depth
#' @param col_measure Column name, measurement for calculation
#' @param below_threshold Threshold below which to count number of days for
#' measured value.  Default = 2
#'
#' @return data frame in long format.
#'
#' @examples
#' # data
#' data <- laketemp_ddm
#'
#' # Columns
#' col_date    <- "Date"
#' col_depth   <- "Depth"
#' col_measure <- "Measurement"
#' below_threshold <- 2
#'
#' # Calculate Stratification
#' df_lss <- lake_summary_stats(data
#'                             , col_date
#'                             , col_depth
#'                             , col_measure
#'                             , below_threshold)
#'
#' # Results
#' head(df_lss)
#
#' @export
lake_summary_stats <- function(data
                               , col_date
                               , col_depth
                               , col_measure
                               , below_threshold = 2
                               ) {

  # Add pipe
  `%>%` <- dplyr::`%>%`

  # Ensure proper formats
  # Convert to data frame (avoid use of tibble)
  data <- data.frame(data)
  data[, col_date]    <- as.Date(data[, col_date])
  data[, col_depth]   <- as.numeric(data[,col_depth])
  data[, col_measure] <- as.numeric(data[, col_measure])

  # QC days to numeric
  #min_days <- as.numeric(min_days)

  # # Check total days
  # days_total <- as.numeric(max(data[, col_date]) - min(data[, col_date]))
  # if(days_total < min_days) {
  #   # do something
  # }## IF ~ days_total < min_days ~ END

  # Calc, time period fields
  str_AllData <- "AllData"
  data[, str_AllData]  <- str_AllData
  data[, "Year"]       <- format(as.Date(data[, col_date]), format="%Y")
  data[, "Month"]      <- format(as.Date(data[, col_date]), format="%m")
  data[, "Year_Month"] <- format(as.Date(data[, col_date]), format="%Y%m")
  data[, "Month_Day"]  <- format(as.Date(data[, col_date]), format="%m%d")
  data[, "JulianDay"]  <- as.POSIXlt(data[, col_date]
                                     , format = dateformat)$yday + 1

  # Calc, days below
  data[, "below"] <- ifelse(data[, col_measure] < below_threshold
                            , 1
                            , 0)

  # Calc Stats
  #q_probs <- c(1, 5, 10, 25, 50, 75, 90, 95, 99) * .01



  # Calc Function
  calc_stats_depth_timeframe <- function(data_calc
                                         , col_depth
                                         , col_measure
                                         , timeframe) {
    # Group by Depth

    # Group by TimeFrame
    # if(timeframe == str_AllData) {
    #   # no grouping for all data
    #   data_calc <- data_calc %>%
    #     dplyr::group_by(.data[[col_depth]])
    # } else {
    #   data_calc <- data_calc %>%
    #     dplyr::group_by(.data[[timeframe]]) %>%
    #     dplyr::group_by(.data[[col_depth]])
    # }## IF ~ timeframe
    csdt <- data_calc %>%
      dplyr::group_by(.data[[timeframe]]) %>%
      dplyr::group_by(.data[[col_depth]])
      dplyr::summarize(.groups = "drop_last"
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
    # TimeFrame_Value
    # if(timeframe == str_AllData) {
    #   csdt <- data.frame("TimeFrame_Value" = timeframe, as.data.frame(csdt))
    # } else {
    #   names(csdt)[1] <- "TimeFrame_Value"
    # }## IF ~ timeframe
    names(csdt)[1] <- "TimeFrame_Value"
    # TimeFrame_Name
    csdt <- data.frame("TimeFrame_Name" = timeframe, as.data.frame(csdt))
    #
    # Return df
    return(csdt)
  }## FUNCTION ~ calc_stats_depth_period

  # Calc
  stats_AllData   <- calc_stats_depth_timeframe(data
                                                , col_depth
                                                , col_measure
                                                , str_AllData)
  stats_Year      <- calc_stats_depth_timeframe(data
                                                , col_depth
                                                , col_measure
                                                , "Year")
  stats_Month     <- calc_stats_depth_timeframe(data
                                                , col_depth
                                                , col_measure
                                                , "Month")
  stats_YearMonth <- calc_stats_depth_timeframe(data
                                                , col_depth
                                                , col_measure
                                                , "Year_Month")
  stats_MonthDay  <- calc_stats_depth_timeframe(data
                                                , col_depth
                                                , col_measure
                                                , "Month_Day")
  stats_JulianDay <- calc_stats_depth_timeframe(data
                                                , col_depth
                                                , col_measure
                                                , "JulianDay")

  # Combine
  stats_all <- rbind(stats_AllData
                     , stats_Year
                     , stats_Month
                     , stats_YearMonth
                     , stats_MonthDay
                     , stats_JulianDay)

  # Return results
  return(stats_all)

}##FUNCTION ~ END
