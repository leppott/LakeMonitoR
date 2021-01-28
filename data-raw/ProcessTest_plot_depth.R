# Prepare test object for plot_depth()
#
# Erik.Leppo@tetratech.com
# 2021-01-28
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory
#library(devtools)

# 1. Get data and process#####

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

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # 2. Save as RDA for use in test####
# #
p_qc <- p_profile
#usethis::use_data(p_qc, overwrite = TRUE)
save(p_qc, file = file.path("inst", "extdata", "p_qc_plot_depth.rda"))
