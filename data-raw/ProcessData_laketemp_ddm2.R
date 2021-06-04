# Prepare data for examples
# Greenwood Temperature data for Feb 2017
#
# Erik.Leppo@tetratech.com
# 2021-06-04
#
# Use daily_depth_means() to generate 2 column file (temp and DO)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory

library(xts)

## Example from daily_depth_means()

# 1. Get data and process#####
# 1.1. Import Data
# Lake Data
data <- read.csv(file.path("data-raw", "TestLake_Water_20180702_20181012.csv"))

# 1.2. Process Data


# name columns
col_siteid   <- "SiteID"
col_datetime <- "Date.Time"
col_depth    <- "Depth"
col_measure  <- "temp_F"
col_measure2 <- "DO_conc"

# run function
data_ddm_temp <- daily_depth_means(data
                                   , col_siteid
                                   , col_datetime
                                   , col_depth
                                   , col_measure)
#
data_ddm_do <- daily_depth_means(data
                                 , col_siteid
                                 , col_datetime
                                 , col_depth
                                 , col_measure2)

# Merge
names(data_ddm_temp)[3] <- col_measure
names(data_ddm_do)[3] <- col_measure2
data_ddm2 <- merge(data_ddm_temp, data_ddm_do)

#View(data.import)
# QC check
dim(data_ddm2)


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Save as RDA for use in package####
#
laketempdo_ddm <- data_ddm2
usethis::use_data(laketempdo_ddm, overwrite = TRUE)

# Save to Shiny example folder
fn_out <- file.path("inst", "shiny-examples", "LakeMonitoR", "Examples"
                    , "example_laketempdo_ddm.csv")
write.table(data_ddm2, fn_out, row.names = FALSE, sep = ",")
