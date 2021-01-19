# daily_depth_means ####
test_that("daily_depth_means", {
  #
  # Packages
  library(xts)

  # Lake Data
  data <- laketemp

  # Filter by any QC fields
  data <- data[data$FlagV == "P", ]
  # Filter for single day (quicker test)
  data <- data[data$Date_Time <= as.Date("2017-01-19"), ]

  # name columns
  col_siteid   <- "SiteID"
  col_datetime <- "Date_Time"
  col_depth    <- "Depth_m"
  col_measure  <- "Water_Temp_C"

  # run function
  data_ddm <- daily_depth_means(data
                                , col_siteid
                                , col_datetime
                                , col_depth
                                , col_measure)

  df_calc <- data_ddm

  # QC data
  Date <- rep(as.Date("2017-01-19"), 27)
  Depth <- seq(2, 28)
  Measurement <- c(0.960705882
                   , 1.071
                   , 1.0985
                   , 1.1395
                   , 1.18447058823529
                   , 1.2525
                   , 1.33241176470588
                   , 1.39805882352941
                   , 1.44538235294118
                   , 1.48473529411765
                   , 1.55785294117647
                   , 1.64785294117647
                   , 1.71026470588235
                   , 1.74425
                   , 1.74980882352941
                   , 1.78554411764706
                   , 1.85145588235294
                   , 1.89830882352941
                   , 1.92610294117647
                   , 1.913
                   , 1.859
                   , 1.90758823529412
                   , 2.05876470588235
                   , 2.16205882352941
                   , 2.21747058823529
                   , 2.32988235294118
                   , 2.49929411764706
  )
  df_qc <- data.frame(Date, Depth, Measurement)

  # test
  testthat::expect_equal(df_calc, df_qc, tolerance = 0.01)

})## Test ~ daily_depth_means ~ END

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
