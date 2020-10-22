# Prepare data for examples for Shiny App
# Greenwood Temperature data for Feb 2017
#
# Erik.Leppo@tetratech.com
# 2020-10-16
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory
#library(devtools)

# 1. Get data and process#####

# 1.1. Import Data
myFile <- "Greenwood_Temperature_2019_07_03_Deploy5.csv"
data_import <- read.csv(file.path(wd, "data-raw", myFile))

# Alternative with zip file
# fn_csv <- "Greenwood_Temperature_2019_07_03_Deploy5.csv"
# fn_zip <- paste0(basename(fn_csv), ".zip")
# temp <- tempdir()
# utils::unzip(zipfile = file.path(".", "data-raw", fn_zip), exdir = temp)
# data_import <- read.csv(file.path(temp, fn_csv))


# 1.2. Process Data
# Remove "fails" for QC
# Filter by any QC fields
data_import <- data_import[data_import$FlagV == "P", ]
# Remove extra columns
col_keep <- c("SiteID", "Date_Time", "Water_Temp_C", "Depth_m")
data_import <- data_import[, col_keep]

#View(data_import)
# QC check
dim(data_import)


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # 2. Save as RDA for use in package####
# #
# laketemp <- data_import
# usethis::use_data(laketemp, overwrite = TRUE)
#~~~~~~
# Save as csv file rather than RDA
fn_out <- file.path(".", "inst", "shiny-examples", "LakeMonitoR", "Examples", "example_laketemp.csv")
write.csv(data_import, fn_out, row.names = FALSE)



