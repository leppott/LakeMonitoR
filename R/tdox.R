#' @title Temperature Dissolved Oxygen x (TDOx)
#'
#' @description Calculates Temperature at Dissolved Oxygen Level X
#'
#' @details Using depth profiles for both temperature and dissolved oxygen
#' the temperature value at x DO is calculated.
#'
#' Values for min, mean, and max are calculated for daily and annual values.
#'
#' The calculation is the temperature at the depth where the value x of DO
#' occurs.  This is done by interpolating the DO value of x and associating the
#' temperature.
#'
#' The calculation is based on information in:
#'
#' P.C. Jacobson, H.G. Stefan, and D.L. Pereira.  2010. Coldwater fish
#' oxythermal habitat in Minnesota lakes: influence of total phosphorus, July
#' air temperature, and relative depth.  Canadian Journal of Fisheries and
#' Aquatic Sciences 67(12):2002-2013.  DOI 10.1139/F10-115
#'
#' The calculation is achieved in R by using the function `glm(temp ~ do)` for
#' each temperature and DO profile at each date and time.  Then `predict.glm()`
#' is used to generate the temperature at a DO value of x.
#'
#' From these calculations min, mean, and max is generated for each day and year
#' present in the data.
#'
#' @param data data frame
#' @param col_date Column name, Date
#' @param col_depth Column name, Depth
#' @param col_temp Column name, temperature
#' @param col_do Column name, Dissolved Oxygen
#' @param do_x_val DO value from which to generate temperature.  Default = 3
#'
#' @return A data frame with min, mean, and max for each year and day.
#'
#' @examples
#' ## Example 1, entire data set
#'
#' # data
#' data <- laketest
#'
#' # Columns
#' col_date  <- "Date.Time"
#' col_depth <- "Depth"
#' col_temp  <- "temp_F"
#' col_do    <- "DO_conc"
#' do_x_val  <- 3
#'
#' tdox_3 <- tdox(data = data
#'                , col_date = col_date
#'                , col_depth = col_depth
#'                , col_temp = col_temp
#'                , col_do = col_do
#'                , do_x_val = do_x_val)
#'
#' tdox_3
#'
#'
#' #~~~~~~~~~~~~~~~~~~~~
#'
#' ## Example 2, small dataset and different DO value
#'
#' do <- c(8.2, 8.2, 8.2, 8.2, 8, 7.5, 5.75, 4.4, 2.5)
#' temp <- c(26, 26, 26, 26, 25, 24.9, 24.8, 24.25, 23.5)
#' depth <- c(0.5, 1, 2, 3, 4, 5, 5.5, 6, 6.5)
#' date <- Sys.time()
#' data2 <- data.frame("datetime" = date
#'                    , "depth" = depth
#'                    , "temp" = temp
#'                    , "do" = do)
#'
#' tdox_4 <- tdox(data = data2
#'                , col_date = "datetime"
#'                , col_depth = "depth"
#'                , col_temp = "temp"
#'                , col_do = "do"
#'                , do_x_val = 4)
#'
#' tdox_4
#'
#' #~~~~~~~~~~~~~~~~~~~~
#'
#' ## Example 3, Single profile with plot
#'
#' # Data
#'data <- laketest
#'
#' # Columns
#' col_date  <- "Date.Time"
#' col_depth <- "Depth"
#' col_temp  <- "temp_F"
#' col_do    <- "DO_conc"
#' do_x_val  <- 3
#'
#' df_plot <- data[data[, "Date.Time"] == "2018-07-03 12:00", ]
#'
#' tdox_3_plot <- tdox(data = df_plot
#'                     , col_date = col_date
#'                     , col_depth = col_depth
#'                     , col_temp = col_temp
#'                     , col_do = col_do
#'                     , do_x_val = do_x_val)
#'
#' tdox_3_plot
#'
#' # Plot
#' ## Temp, x-bottom, circles
#' plot(df_plot$temp_F, df_plot$Depth, col = "black"
#'      , ylim = rev(range(df_plot$Depth))
#'      , xlab = "Temperature (F)", ylab = "Depth (m)")
#' lines(df_plot$temp_F, df_plot$Depth, col = "black")
#' abline(v = 53.66, col = "black", lty = 3, lwd = 2)
#' ## plot on top of existing plot
#' par(new=TRUE)
#' ## Add DO
#' plot(df_plot$DO_conc, df_plot$Depth, col = "blue", pch = 17
#'      , ylim = rev(range(df_plot$Depth))
#'      , xaxt = "n", yaxt = "n", xlab = NA, ylab = NA)
#' lines(df_plot$DO_conc, df_plot$Depth, col = "blue")
#' axis(side = 3, col.axis = "blue", col.lab = "blue")
#' mtext("Dissolved Oxygen (mg/L)", side = 3, line = 3, col = "blue")
#' abline(v = 3, col = "blue", lty = 3, lwd = 2)
#' ## Legend
#' legend("bottomright"
#'        , c("Temperature", "Temp = 53.66 @ DO = 3", "Dissolved Oxygen", "DO = 3")
#'        , col = c("black", "black", "blue", "blue")
#'        , pch = c(21, NA, 17, NA)
#'        , lty = c(1, 3, 1, 3)
#'        , lwd = c(1, 2, 1, 2))
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @export
tdox <- function(data
                 , col_date
                 , col_depth
                 , col_temp
                 , col_do
                 , do_x_val = 3) {

  # global variable bindings


  # Ensure proper formats
  # Convert to data frame (avoid use of tibble)
  data <- data.frame(data)
  data[, col_date]  <- as.Date(data[, col_date])
  data[, col_depth] <- as.numeric(data[,col_depth])
  data[, col_temp]  <- as.numeric(data[, col_temp])
  data[, col_do]    <- as.numeric(data[, col_do])

  # Dates
  Dates <- sort(unique(data[, col_date]))
  n_Dates <- length(Dates)

  # QC days to numeric
  n_Dates <- as.numeric(n_Dates)


  # for calculations
  # StratificationAnalysis <- NULL
  # meandata <- NULL

  # Calc, Predicted Value ----
  df_tdox_pred <- NULL
  #
  for (i in Dates){

    # filter for date
    calcdate <- data[data[, col_date] == i, ]
    # filter for NA
    #calcdate <- calcdate[!is.na(calcdate[, col_measure]), ]
    # Define DO and Temp for LM
    temp <- calcdate[, col_temp]
    do <- calcdate[, col_do]
    # Calc LM
    lm_tdox <- glm(temp ~ do)
    # Predict Value
    predict_tdox <- max(predict.glm(lm_tdox, data.frame("do" = do_x_val))
                        , na.rm = TRUE)


    singledate <- unique(calcdate[, col_date])
    stratrow <- data.frame("DateTime" = singledate, "TDOx" = predict_tdox)
    df_tdox_pred <- rbind(df_tdox_pred, stratrow)

  }## FOR ~ i ~ END
  df_tdox_pred <- df_tdox_pred[order(df_tdox_pred[, "DateTime"]), ]

  # Munge ----
  # Munge, Add Date and Year
  df_tdox_pred[, "Date"] <- format(df_tdox_pred[, "DateTime"], "%Y-%m-%d")
  df_tdox_pred[, "Year"] <- format(df_tdox_pred[, "DateTime"], "%Y")

  # Calc Stats, Year
  stats_year <- dplyr::summarise(dplyr::group_by(df_tdox_pred, Year)
                                 # Calculations
                                 , min = min(TDOx, na.rm = TRUE)
                                 , mean = mean(TDOx, na.rm = TRUE)
                                 , max = max(TDOx, na.rm = TRUE)
  )## summarise ~ Year ~ END
  #
  # Calc Stats, Date
  stats_date <- dplyr::summarise(dplyr::group_by(df_tdox_pred, Date)
                                 # Calculations
                                 , min = min(TDOx, na.rm = TRUE)
                                 , mean = mean(TDOx, na.rm = TRUE)
                                 , max = max(TDOx, na.rm = TRUE)
  )## summarise ~ Date ~ END


  # Combine Files
  names(stats_year)[1] <- "TimeFrame_Value"
  names(stats_date)[1] <- "TimeFrame_Value"
  stats_year[, "TimeFrame_Name"] <- "Year"
  stats_date[, "TimeFrame_Name"] <- "Date"

  stats_comb <- rbind(stats_year, stats_date)
  stats_comb[, "TDO_x_value"] <- do_x_val

  stats_comb <- stats_comb[, c("TimeFrame_Name"
                               , "TimeFrame_Value"
                               , "TDO_x_value"
                               , "min"
                               , "mean"
                               , "max")]


  # Results ----
  return(stats_comb)

}##FUNCTION ~ END

