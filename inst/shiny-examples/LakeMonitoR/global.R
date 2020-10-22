# Shiny Global File

# Packages
library(shiny)
library(LakeMonitoR)
library(DT)
library(ggplot2)
# library(plotly)
library(shinyjs) # used for download button enable

# Drop-down boxes
Calc_Options <- c("daily depth means", "stratification", "both")

# File Size
# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 25MB.
options(shiny.maxRequestSize = 25*1024^2)

