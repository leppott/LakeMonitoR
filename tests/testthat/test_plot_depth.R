# depth_plot ####
test_that("depth_plot", {
  #
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

  # Create Plot
  p_profile <- depth_plot(data = data
                          , col_datetime = col_datetime
                          , col_depth = col_depth
                          , col_measure = col_measure
                          , lab_datetime = lab_datetime
                          , lab_depth = lab_depth
                          , lab_measure = lab_measure
                          , lab_title = lab_title)

  p_calc <- p_profile

  # QC
  load(system.file("extdata", "p_qc_plot_depth.rda", package = "LakeMonitoR"))
  # p_qc

  str_p_calc <- str(p_calc)
  str_p_qc <- str(p_qc)

  # test
  testthat::expect_equal(str_p_calc, str_p_qc)

  # if test directly get environment error
  #
  # Error: `p_calc` (`actual`) not equal to `p_qc` (`expected`).
  #
  # `actual$layers[[1]]` is <env:19924980>
  #   `expected$layers[[1]]` is <env:18BBA480>
  #
  #   `actual$scales` is <env:18C63660>
  #   `expected$scales` is <env:18BB98D0>
  #
  #   `attr(actual$mapping$x, '.Environment')` is <env:1A182DB0>
  #   `attr(expected$mapping$x, '.Environment')` is <env:18BBA520>
  #
  #   `attr(actual$mapping$y, '.Environment')` is <env:1A182DB0>
  #   `attr(expected$mapping$y, '.Environment')` is <env:18BBA520>
  #
  #   `actual$coordinates` is <env:19FAE8B8>
  #   `expected$coordinates` is <env:04E6CE90>
  #
  #   `actual$facet` is <env:19F792F0>
  #   `expected$facet` is <env:02CDCF08>
  #
  #   `actual$plot_env` is <env:1A182DB0>
  #   `expected$plot_env` is <env:18BBA520>

})## Test ~ depth_plot ~ END
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
