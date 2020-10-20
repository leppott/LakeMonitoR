# Prepare data for examples
# Greenwood Temperature data for Feb 2017
#
# Erik.Leppo@tetratech.com
# 2020-10-19
#
# Use daily_depth_means() to generate
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory

library(xts)

## Example from daily_depth_means()

# 1. Get data and process#####
# 1.1. Import Data
# Lake Data
data <- laketemp

# 1.2. Process Data
 # Filter by any QC fields
data <- data[(data$FlagV=='P'), ]

# name columns
col_siteid   <- "SiteID"
col_datetime <- "Date_Time"
col_depth    <- "Depth_m"
col_measure  <- "Water_Temp_C"

# run function
data_ddm <- daily_depth_means(data, col_siteid, col_datetime, col_depth, col_measure)

#View(data.import)
# QC check
dim(data_ddm)
# Feb only
# 28 days * 27 depths = 756 rows
# Full data set
# 9639 rows

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Save as RDA for use in package####
#
laketemp_ddm <- data_ddm
usethis::use_data(laketemp_ddm, overwrite = TRUE)

