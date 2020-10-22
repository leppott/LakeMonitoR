# Prepare data for rLakeAnalyzer
# Greenwood hypsography data
#
# Erik.Leppo@tetratech.com
# 2020-10-22
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory
#library(devtools)

# 1. Get data and process#####

# 1.1. Import Data
myFile <- "greenwoodhypso.csv"
data_import <- read.csv(file.path(wd, "data-raw", myFile))

# 1.2. Process Data
# positive not negative values
data_import$Contour_Depth <- -1 * data_import$Contour_Depth
# Order by depth
data_import <- data_import[order(data_import$Contour_Depth), ]
head(data_import)
# QC check
dim(data_import)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # 2. Save as RDA for use in package####
# #
lakehypso <- data_import
usethis::use_data(lakehypso, overwrite = TRUE)



