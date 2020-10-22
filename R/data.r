#' Lake temperature data
#'
#' Example data containing one year (January 2017 to January 2018) of lake profile
#' temperature data.  Includes QC flag columns.
#'
#'@format
#'\describe{A data frame with 171,414 observations on the following 12 variables.
#'  \item{\code{DOWLKNUM}}{DOW Lake Number}
#'  \item{\code{SiteID}}{Site ID}
#'  \item{\code{Date_Time}}{Date and Time}
#'  \item{\code{Water_Temp_C}}{water temperature, degree C}
#'  \item{\code{Depth_m}}{depth, meters}
#'  \item{\code{Depth_std}}{a numeric vector}
#'  \item{\code{FlagG}}{QC flag, gross check}
#'  \item{\code{FlagS}}{QC flag, spike check}
#'  \item{\code{FlagR}}{QC flag, rate of change check}
#'  \item{\code{FlagF}}{QC flag, flat line check}
#'  \item{\code{String}}{a character vector}
#'  \item{\code{FlagV}}{Overall record level QC flag}
#'}
#'
"laketemp"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Lake temperature, daily depth means
#'
#' Lake profile temperature data created from `LakeMonitoR::laketemp` using
#' `LakeMonitoR::daily_depth_means`.
#'
#' @format A data frame with 9,639 observations on the following 3 variables.
#'  \describe{
#'    \item{\code{Date}}{a Date, January 2017 to January 2018}
#'    \item{\code{Depth}}{a numeric vector of depths (meters)}
#'    \item{\code{Measurement}}{a numeric vector of temperature (degrees C)}
#'  }
"laketemp_ddm"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Lake temperature, hypsography
#'
#' Lake profile depth (m) contour area (m2) for use with rLakeAnalyzer metrics.
#'
#' @format A data frame with 31 observations on the following 2 variables.
#'  \describe{
#'    \item{\code{Contour_Depth}}{contour depths (meters)}
#'    \item{\code{Area}}{a numeric vector of area (square meters)}
#'  }
"lakehypso"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
