#' @title run LakeMonitoR Shiny Example
#'
#' @description Launches Shiny app for LakeMonitoR
#'
#' @details The Shiny app based on the R package LakeMonitoR is included in the
#' R package.
#' This function launches that app.
#'
#' The Shiny app is online at:
#' https://tetratech-wtr-wne.shinyapps.io/LakeMonitoR/
#'
#' @examples
#' \dontrun{
#' # Run Function
#' runShiny()
#' }
#
#' @export
runShiny <- function(){##FUNCTION.START
  #
  appDir <- system.file("shiny-examples"
                        , "LakeMonitoR"
                        , package = "LakeMonitoR")
  #
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `LakeMonitoR`."
         , call. = FALSE)
  }
  #
  shiny::runApp(appDir, display.mode = "normal")
  #
}##FUNCTION.END
