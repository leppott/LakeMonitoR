#' @title Plot Heat Map
#'
#' @description Generates a heat map plot of measurements from depth profile
#' data
#'
#' @details Can be used with any parameter.  A plot is returned that can be
#' saved with ggsave(filename).
#'
#' Labels (and title) are function input parameters.  If they are not used
#' the plot will not be modified.
#'
#' The default theme is theme_bw().
#'
#' The plot is created with ggplot2::geom_tile().
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
#' @param contours Boolean to draw contours, Default = TRUE
#' @param line_val Measurement value at which to draw a line, Default = NA
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
#' line_val     <- 2
#'
#' # Create Plot
#' p_hm <- plot_heatmap(data = data
#'                         , col_datetime = col_datetime
#'                         , col_depth = col_depth
#'                         , col_measure = col_measure
#'                         , lab_datetime = lab_datetime
#'                         , lab_depth = lab_depth
#'                         , lab_measure = lab_measure
#'                         , lab_title = lab_title
#'                         , contours = FALSE)
#'
#' # Print Plot
#' print(p_hm)
#'
#' # Demo ability to tweak the plot
#' p_hm + ggplot2::labs(caption = "Example, LakeMonitoR::plot_heatmap()")
#'
#' # save plot to temp directory
#' tempdir() # show the temp directory
#' ggplot2::ggsave(file.path(tempdir(), "TestLake_tempF_plotHeatMap.png"))
#'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @export
plot_heatmap <- function(data
                      , col_datetime
                      , col_depth
                      , col_measure
                      , lab_datetime = NA
                      , lab_depth = NA
                      , lab_measure = NA
                      , lab_title = NA
                      , contours = FALSE
                      , line_val = NA) {
  # QC, testing
  boo_QC <- FALSE
  if(isTRUE(booQC)) {
    data = data
    col_datetime = col_datetime
    col_depth = col_depth
    col_measure = col_measure
    lab_datetime = lab_datetime
    lab_depth = lab_depth
    lab_measure = lab_measure
    lab_title = lab_title
    contours = FALSE
  }## IF ~ boo_QC

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
  # plot
  p <- ggplot2::ggplot(data = data
                , ggplot2::aes_string(x = col_datetime
                             , y = col_depth
                             , fill = col_measure)) +
    ggplot2::geom_tile(na.rm = TRUE) +
    ggplot2::scale_y_reverse() +
    ggplot2::scale_x_datetime(date_labels = "%Y-%m") +
    ggplot2::theme_bw()

  # Add Plot Elements ----

  ## Add Contours
  if(isTRUE(contours)){
    p <- p + ggplot2::stat_contour(ggplot2::aes_string(z = col_measure)
                          , color = "gray"
                          , na.rm = TRUE)

  }## IF ~ isTRUE(contours)

  # Add line
  if(is.numeric(line_val)){
    p <- p + ggplot2::geom_hline(yintercept = line_val, size = 1.25)
  }## IF ~ is.numeric(hline_val)

  ## Add Labels
  if(is.na(lab_datetime) == FALSE){
    p <- p + ggplot2::labs(x = lab_datetime)
  }## IF ~ is.na(lab_datetime)

  # add depth label
  if(is.na(lab_depth) == FALSE){
    p <- p + ggplot2::labs(y = lab_depth)
  }## IF ~ is.na(lab_depth)
  #

  # # color
  # if(is.na(lab_measure) == FALSE){
  #   p <- p + ggplot2::scale_fill_viridis_b(name = lab_measure)
  # } else {
  #   p <- p + ggplot2::scale_fill_viridis_b()
  # }## IF ~ is.na(lab_measure)

  p_fill_n <- 7
  # rainbow (need to reverse), terrain.colors, hcl.colors (viridis)
  p_fill_colors_LM <- rev(rainbow(p_fill_n))
  p_fill_colors_rLA <- c("violet"
                         , "blue"
                         , "cyan"
                         , "green3"
                         , "yellow"
                         , "orange"
                         , "red")
  p_fill_colors <- p_fill_colors_rLA

  if(is.na(lab_measure) == FALSE){
    p <- p + ggplot2::scale_fill_gradientn(colors = p_fill_colors
                                           , name = lab_measure)
  } else {
    p <- p + ggplot2::scale_fill_gradientn(colors = p_fill_colors)
  }## IF ~ is.na(lab_measure)


  # title
  if(is.na(lab_title) == FALSE){
    p <- p + ggplot2::labs(title = lab_title)
  }## IF ~ is.na(lab_measure)

  # Return ----
  return(p)

}## FUNCTION ~ END
