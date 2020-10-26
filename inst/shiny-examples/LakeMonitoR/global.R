# Shiny Global File

# Packages
library(shiny)
library(LakeMonitoR)
library(xts)  # used in LakeMonitoR::daily_depth_means
library(DT)
library(shinyjs) # used for download button enable
library(ggplot2)
library(rLakeAnalyzer)

# Drop-down boxes
Calc_Options <- c("daily depth means", "stratification", "both")

# File Size
# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 200 MB.
mb_limit <- 200
options(shiny.maxRequestSize = mb_limit * 1024^2)

