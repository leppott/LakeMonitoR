# stratification ####
test_that("stratification", {
  #
  # data
  data <- LakeMonitoR::laketemp_ddm

  # Columns
  #col_siteid  <- "SiteID"
  col_date    <- "Date"
  col_depth   <- "Depth"
  col_measure <- "Measurement"

  # Calculate Stratification
  ls_strat <- LakeMonitoR::stratification(data
                                          , col_date
                                          , col_depth
                                          , col_measure
                                          , min_days = 20 )

  # Results, Stratification Dates
  dates_calc <- ls_strat$Stratification_Dates

  date_total_start <- as.Date("2017-01-19")
  date_strat_start <- as.Date("2017-06-05")
  date_strat_end   <- as.Date("2017-10-16")
  date_total_end   <- as.Date("2018-01-10")

  days_F_start <- as.vector(date_strat_start - date_total_start)
  days_T_strat <- as.vector(date_strat_end - date_strat_start)
  days_F_end   <- as.vector(date_total_end - date_strat_end)


  dates_qc <- data.frame("Date" = seq.Date(date_total_start
                                           , date_total_end
                                           , by = "day")
                         , "Stratified_20" = c(rep(FALSE, days_F_start)
                                               , rep(TRUE, days_T_strat + 1)
                                               , rep(FALSE, days_F_end)))

  # test, events
  testthat::expect_equal(dates_calc, dates_qc)

  # Results, Stratification Events
  events_calc <- ls_strat$Stratification_Events

  events_qc <- data.frame("Start_Date" = date_strat_start
                          , "End_Date" = date_strat_end
                          , "Year" = "2017"
                          , "Time_Span" = (difftime(date_strat_start
                                                   , date_strat_end
                                                   , units = "days")*-1)
  )

  # test, events
  testthat::expect_equal(events_calc, events_qc)

})## Test ~ stratification ~ END

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
