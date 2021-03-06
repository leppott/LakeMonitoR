% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_heatmap.R
\name{plot_heatmap}
\alias{plot_heatmap}
\title{Plot Heat Map}
\usage{
plot_heatmap(
  data,
  col_datetime,
  col_depth,
  col_measure,
  lab_datetime = NA,
  lab_depth = NA,
  lab_measure = NA,
  lab_title = NA,
  contours = TRUE,
  line_val = NA
)
}
\arguments{
\item{data}{data frame of site id (optional), data/time, depth
, and measurement (e.g., temperature).}

\item{col_datetime}{Column name, Date Time}

\item{col_depth}{Column name, Depth}

\item{col_measure}{Column name, measurement for plotting}

\item{lab_datetime}{Plot label for x-axis, Default = col_datetime}

\item{lab_depth}{Plot label for legend, Default = col_depth}

\item{lab_measure}{Plot label for y-axis, Default = col_measure}

\item{lab_title}{Plot title, Default = NA}

\item{contours}{Boolean to draw contours, Default = TRUE}

\item{line_val}{Measurement value at which to draw a line, Default = NA}
}
\value{
a ggplot object
}
\description{
Generates a heat map plot of measurements from depth profile
data
}
\details{
Can be used with any parameter.  A plot is returned that can be
saved with ggsave(filename).

Labels (and title) are function input parameters.  If they are not used
the plot will not be modified.

The default theme is theme_bw().

The plot is created with ggplot2::geom_tile().

The returned object is a ggplot object so it can be further manipulated.
}
\examples{
# Data (Test Lake)
data         <- laketest

# Column Names
col_datetime <- "Date.Time"
col_depth    <- "Depth"
col_measure  <- "temp_F"

# Plot Labels
lab_datetime <- "Date Time"
lab_depth    <- "Depth (m)"
lab_measure  <- "Temperature (F)"
lab_title    <- "Test Lake"
line_val     <- 2

# Create Plot
p_hm <- plot_heatmap(data = data
                        , col_datetime = col_datetime
                        , col_depth = col_depth
                        , col_measure = col_measure
                        , lab_datetime = lab_datetime
                        , lab_depth = lab_depth
                        , lab_measure = lab_measure
                        , lab_title = lab_title
                        , contours = TRUE)

# Print Plot
print(p_hm)

# Demo ability to tweak the plot
p_hm + ggplot2::labs(caption = "Example, LakeMonitoR::plot_heatmap()")

# save plot to temp directory
tempdir() # show the temp directory
ggplot2::ggsave(file.path(tempdir(), "TestLake_tempF_plotHeatMap.png"))
}
