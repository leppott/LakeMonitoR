# Prepare data for examples for depth_plot
# Test Lake data
#
# Erik.Leppo@tetratech.com
# 2021-01-28
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory
#library(devtools)

# 1. Get data and process#####

# 1.1. Import Data
myFile <- "TestLake_Water_20180702_20181012.csv"
data_import <- read.csv(file.path(wd, "data-raw", myFile))

#View(data_import)
# QC check
dim(data_import)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Save as RDA for use in package####
#
laketest <- data_import
usethis::use_data(laketest, overwrite = TRUE)
