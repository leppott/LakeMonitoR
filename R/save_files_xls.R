#' @title Save data to multi-worksheet Excel file
#'
#' @description Saves multiple data frames to a single Excel file.
#'
#' @details Saves multiple data frames to a multiple worksheets in a single Excel
#' file.
#'
#' The data must be loaded into R.
#'
#' The `writexl` package is used so that Java is not necessary.
#'
#' @param data_names data frame or named list of data frames
#' @param path Path, including filename, for Excel file.
#' @param col_names Logical to include column names.  Default = TRUE
#' @param format_headers Logical to format headers (bold and centered).
#' Default = TRUE
#'
#' @return a saved Excel file with named data saved to individual worksheets.
#'
#' @examples
#' # Data (Test Lake)
#' data         <- laketest
#'
#'
#' path <- tempfile(fileext = ".xlsx")
#' data_names <- list
#'
#'
#' # Save to Excel
#' save_data_xls(path
#'               , data_names
#'               , col_names = TRUE
#'               , format_headers = TRUE)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @export
save_data_xls <- function(data_names
                          , path
                          , col_names = TRUE
                          , format_headers = TRUE) {


  # write
  writexl::write_xlsx(x = data_names
                      , path = path
                      , col_names = col_names
                      , format_headers = format_headers )


}## FUNCTION ~ END
