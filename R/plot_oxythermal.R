#' @title Plot Oxythermal
#'
#' @description Generates a heat map of temperature from depth profile data.
#' The data is filtered for temperature and dissolved oxygen levels prior to
#' plotting.
#'
#' @details Can be used with any parameters.  A plot is returned that can be
#' saved with ggsave(filename).
#'
#' Labels (and title) are function input parameters.  If they are not used
#' the plot will not be modified.
#'
#' The default theme is theme_bw().
#'
#' The plot is created with ggplot2::geom_raster().  Interpolation is possible
#' with boo_interpolate (default is FALSE).
#'
#' The returned object is a ggplot object so it can be further manipulated.
#'
#' @param data data frame of site id (optional), data/time, depth
#' , and measurement (e.g., temperature).
#' @param col_datetime Column name, Date Time
#' @param col_depth Column name, Depth
#' @param col_temp Column name, Temperature
#' @param col_do Column name, Dissolved Oxygen
#' @param thresh_temp Threshold for temperature, Default = 30
#' @param operator_temp Operator for temperature, Default is >=
#' Valid values of >=, >, <=, <
#' @param thresh_do Threshold for dissolved oxygen, Default is 3
#' @param operator_do Operator for dissolved oxygen, Default is <=
#' Valid values of >=, >, <=, <
#' @param lab_datetime Plot label date time (x-axis), Default = col_datetime
#' @param lab_depth Plot label for depth (y-axis), Default = col_depth
#' @param lab_temp Plot label for temperatue (legend), Default = col_measure
#' @param lab_title Plot title, Default = NA
#' @param boo_interpolate Boolean as to use interpolate in geom_raster,
#' Default = FALSE
#' @param boo_contours Boolean to draw contours, Default = FALSE
#'
#' @return a ggplot object
#'
#' @examples
#' # Data (Test Lake)
#' data         <- laketest
#'
#' # Column Names
#' col_datetime <- "Date.Time"
#' col_depth    <- "Depth"
#' col_temp     <- "temp_F"
#' col_do       <- "DO_conc"
#'
#' # Data values
#' thresh_temp <- 68
#' operator_temp <- "<="
#' thresh_do <- 3
#' operator_do <- ">="
#'
#' # Plot Labels
#' lab_datetime <- "Date Time"
#' lab_depth    <- "Depth (m)"
#' lab_temp     <- "Temp (F)"
#' lab_title    <- "Test Lake"
#'
#' # Create Plot
#' p_ot <- plot_oxythermal(data = data
#'                         , col_datetime = col_datetime
#'                         , col_depth = col_depth
#'                         , col_temp = col_temp
#'                         , col_do = col_do
#'                         , thresh_temp = thresh_temp
#'                         , operator_temp= operator_temp
#'                         , thresh_do = thresh_do
#'                         , operator_do = operator_do
#'                         , lab_datetime = lab_datetime
#'                         , lab_depth = lab_depth
#'                         , lab_temp = lab_temp
#'                         , lab_title = lab_title)
#'
#' # Print Plot
#' print(p_ot)
#'
#' # Demo ability to tweak the plot
#' ## move gridlines on top of plot
#' p_ot + ggplot2::theme(panel.ontop = TRUE
#'                , panel.background = ggplot2::element_rect(color = NA
#'                                                           , fill = NA))
#' ## Add subtitle and caption
#' myST <- paste0("Temp ", operator_temp, " ", thresh_temp
#'              , " and DO ", operator_do, " ", thresh_do)
#' p_ot <- p_ot +
#'   ggplot2::labs(subtitle = myST) +
#'   ggplot2::labs(caption = paste0("Gray = Areas outside of given"
#'                              , " temp and DO values."))
#'
#' # save plot to temp directory
#' tempdir() # show the temp directory
#' ggplot2::ggsave(file.path(tempdir(), "TestLake_plotOxythermal.png")
#'                 , plot = p_ot)
#'
#' # For Comparison, heatmaps of Temperature and DO
#'
#' # heat map, Temp
#' p_hm_temp <- plot_heatmap(data = data
#'                      , col_datetime = col_datetime
#'                      , col_depth = col_depth
#'                      , col_measure = col_temp
#'                      , lab_datetime = lab_datetime
#'                      , lab_depth = lab_depth
#'                      , lab_measure = lab_temp
#'                      , lab_title = lab_title
#'                      , contours = FALSE)
#'
#' # heat map, DO
#' p_hm_do <- plot_heatmap(data = data
#'                           , col_datetime = col_datetime
#'                           , col_depth = col_depth
#'                           , col_measure = col_do
#'                           , lab_datetime = lab_datetime
#'                           , lab_depth = lab_depth
#'                           , lab_measure = "DO (mg/L)"
#'                           , lab_title = lab_title
#'                           , contours = FALSE)
#'
#' # Plot, Combine all 3
#' p_oxy3 <- gridExtra::grid.arrange(p_ot, p_hm_temp, p_hm_do)
#' p_oxy3
#'
#' # save plot to temp directory
#' tempdir() # show the temp directory
#' ggplot2::ggsave(file.path(tempdir(), "TestLake_plotOxythermal_3.png")
#'                           , plot = p_oxy3)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @export
plot_oxythermal <- function(data
                            , col_datetime
                            , col_depth
                            , col_temp
                            , col_do
                            , thresh_temp = 30
                            , operator_temp = ">="
                            , thresh_do = 3
                            , operator_do = ">="
                            , lab_datetime = NA
                            , lab_depth = NA
                            , lab_temp = NA
                            , lab_title = NA
                            , boo_interpolate = FALSE
                            , boo_contours = FALSE) {

  # QC ----
  col2check <- c(col_datetime, col_depth, col_temp, col_do)
  col_missing <- col2check[col2check %in% col(data)]
  if(length(col_missing) != 0){
    msg <- paste0("Columns are missing from data:\n "
                  , paste(col_missing, collapse = ", "))
    stop(msg)
  }## IF ~ length(col_missing) != 0

  # Date, Conversion ----
  # from factor to POSIXct (make it a date and time field in R)
  data[, col_datetime] <- as.POSIXct(data[, col_datetime])

  # use date format helper function to ensure get right format.

  # Munge ----
  ## Test Operators
  if(operator_temp == "<="){
    `%op_temp%` <- `<=`
  } else if(operator_temp == ">=") {
    `%op_temp%` <- `>=`
  } else if(operator_temp == "<") {
    `%op_temp%` <- `<`
  } else if(operator_temp == ">") {
    `%op_temp%` <- `>`
  } else {
    msg <- paste0("Invalid 'operator_temp', ", operator_temp)
    stop(msg)
  }## IF ~ operator_temp
  #
  if(operator_do == "<="){
    `%op_do%` <- `<=`
  } else if(operator_do == ">=") {
    `%op_do%` <- `>=`
  } else if(operator_do == "<") {
    `%op_do%` <- `<`
  } else if(operator_do == ">") {
    `%op_do%` <- `>`
  } else {
    msg <- paste0("Invalid 'operator_do', ", operator_do)
    stop(msg)
  }## IF ~ operator_temp

  ## filter data
  data$plot_temp <- ifelse(data[, col_temp] %op_temp% thresh_temp
                           , data[, col_temp], NA)
  data$plot_temp <- ifelse(data[, col_do] %op_do% thresh_do
                           , data[, "plot_temp"], NA)

  # Plot, Create ----
  # plot
  p <- ggplot2::ggplot(data = data
                , ggplot2::aes_string(x = col_datetime
                             , y = col_depth
                             , fill = "plot_temp")) +
    ggplot2::geom_raster(na.rm = TRUE, interpolate = boo_interpolate) +
    ggplot2::scale_y_reverse() +
    ggplot2::scale_x_datetime(date_labels = "%Y-%m") +
    ggplot2::theme_bw()

  # Add Plot Elements ----
  #
  ## Add Contours
  if(isTRUE(boo_contours)){
    p <- p + ggplot2::stat_contour(ggplot2::aes_string(z = "plot_temp")
                          , color = "gray"
                          , na.rm = TRUE)

  }## IF ~ isTRUE(contours)
  #
  #
  ## Add Labels
  if(is.na(lab_datetime) == FALSE){
    p <- p + ggplot2::labs(x = lab_datetime)
  }## IF ~ is.na(lab_datetime)
  #
  if(is.na(lab_depth) == FALSE){
    p <- p + ggplot2::labs(y = lab_depth)
  }## IF ~ is.na(lab_depth)
  # #
  if(is.na(lab_temp) == FALSE){
    p <- p + ggplot2::scale_fill_viridis_b(name = lab_temp)
  } else {
    p <- p + ggplot2::scale_fill_viridis_b()
  }## IF ~ is.na(lab_measure)
  # Can set na.value = boo
  #
  if(is.na(lab_title) == FALSE){
    p <- p + ggplot2::labs(title = lab_title)
  }## IF ~ is.na(lab_measure)

  # Return ----
  return(p)

}## FUNCTION ~ END
