#' @title Plot Depth Profile
#'
#' @description Generates a plot of measurements from depth profile data
#'
#' @details Can be used with any parameter.  A plot is returned that can be
#' saved with ggsave(filename).
#'
#' Labels (and title) are function input parameters.  If they are not used
#' the plot will not be modified.
#'
#' The default theme is black and white.
#'
#' The returned object is a ggplot object so it can be further manipulated.
#'
#' @param data data frame of site id (optional), data/time, depth
#' , and measurement (e.g., temperature).
#' @param col_datetime Column name, Date Time
#' @param col_depth Column name, Depth
#' @param col_measure Column name, measurement for plotting
#' @param lab_datetime Plot label for x-axis, Default = col_datetime
#' @param lab_depth Plot label for legend, Default = col_depth
#' @param lab_measure Plot label for y-axis, Default = col_measure
#' @param lab_title Plot title, Default = NA
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
#' col_measure  <- "temp_F"
#'
#' # Plot Labels
#' lab_datetime <- "Date Time"
#' lab_depth    <- "Depth (m)"
#' lab_measure  <- "Temperature (F)"
#' lab_title    <- "Test Lake"
#'
#' # Create Plot
#' p_profile <- plot_depth(data = data
#'                         , col_datetime = col_datetime
#'                         , col_depth = col_depth
#'                         , col_measure = col_measure
#'                         , lab_datetime = lab_datetime
#'                         , lab_depth = lab_depth
#'                         , lab_measure = lab_measure
#'                         , lab_title = lab_title)
#'
#' # Print Plot
#' print(p_profile)
#'
#' # Demo ability to tweak the plot
#' p_profile + ggplot2::labs(caption = "Example, LakeMonitoR::plot_depth()")
#'
#' # save plot to temp directory
#' tempdir() # show the temp directory
#' ggplot2::ggsave(file.path(tempdir(), "TestLake_tempF_plotDepth.png"))
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @export
plot_depth <- function(data
                      , col_datetime
                      , col_depth
                      , col_measure
                      , lab_datetime = NA
                      , lab_depth = NA
                      , lab_measure = NA
                      , lab_title = NA) {

  # QC ----
  col2check <- c(col_datetime, col_depth, col_measure)
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

  # Plot, Create ----
  p <- ggplot2::ggplot(data
                       , ggplot2::aes_string(x = col_datetime
                                             , y = col_measure)) +
    ggplot2::geom_point(ggplot2::aes_string(color = col_depth)
                        , na.rm = TRUE) +
    ggplot2::scale_color_continuous(trans = "reverse") +
    ggplot2::scale_x_datetime(date_labels = "%Y-%m") +
    ggplot2::theme_bw()

  # Add Labels ----
  # Add only if not NA
  #
  if(is.na(lab_datetime) == FALSE){
    p <- p + ggplot2::labs(x = lab_datetime)
  }## IF ~ is.na(lab_datetime)
  #
  if(is.na(lab_depth) == FALSE){
    p <- p + ggplot2::guides(color = ggplot2::guide_colourbar(title =
                                                                     lab_depth))
  }## IF ~ is.na(lab_depth)
  # #
  if(is.na(lab_measure) == FALSE){
    p <- p + ggplot2::labs(y = lab_measure)
  }## IF ~ is.na(lab_measure)
  #
  if(is.na(lab_title) == FALSE){
    p <- p + ggplot2::labs(title = lab_title)
  }## IF ~ is.na(lab_measure)

  # Return ----
  return(p)

}## FUNCTION ~ END
