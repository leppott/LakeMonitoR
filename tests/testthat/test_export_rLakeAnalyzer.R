# export_rLakeAnalyzer ####
test_that("export_rLakeAnalyzer", {
  #
  # Data
  data <- LakeMonitoR::laketemp_ddm

  # Columns, date listed first
  col_depth <- "Depth"
  col_data <- c("Date", "Measurement")
  col_rLA  <- c("datetime", "wtr")

  # Run function
  df_rLA <- LakeMonitoR::export_rLakeAnalyzer(data
                                              , col_depth
                                              , col_data
                                              , col_rLA)
  sum_calc <- sum(df_rLA[, 2:28])

  sum_qc <- 59292.04

  # test
  testthat::expect_equal(sum_calc, sum_qc, tolerance = 0.01)

})## Test ~ export_rLakeAnalyzer ~ END

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
