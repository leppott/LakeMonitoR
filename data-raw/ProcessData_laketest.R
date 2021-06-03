# Prepare data for examples for wind data
# Test Lake data
#
# Erik.Leppo@tetratech.com
# 2021-06-03
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory
#library(devtools)

# 1. Get data and process#####

# 1.1. Import Data
myFile <- "TestLake_wind_20180702_20181012.csv"
data_import <- read.csv(file.path(wd, "data-raw", myFile))

#View(data_import)
# QC check
dim(data_import)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Save as RDA for use in package####
#
laketest_wind <- data_import
usethis::use_data(laketest_wind, overwrite = TRUE)
