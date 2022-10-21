# Shiny Global File

# Packages
library(shiny)
library(LakeMonitoR)
library(xts)  # needed for LakeMonitoR::daily_depth_means
library(DT)
library(shinyjs) # used for download button enable
library(ggplot2)
library(rLakeAnalyzer)
library(plotly)
library(gridExtra)
library(shinyBS) # for bsTooltip()
library(writexl)
library(tidyr)  # meta layer calcs

# heatmap style
hm_style1 <- "ggplot"
hm_style2 <- "rLA"
hm_style <- hm_style1

# Drop-down boxes
Calc_Options <- c("daily depth means", "stratification", "both")
Strat_Method_Options <- c(">=1 deg C over 1-m", "top vs. bottom")

# File Size
# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 200 MB.
mb_limit <- 200
options(shiny.maxRequestSize = mb_limit * 1024^2)

# "Results" folder, NAMES ----
path_results <- file.path("Results")
## Result Folder Subfolders
dn_results_data_input     <- "data_input"
# dn_results_data_output    <- "data_output"
# dn_results_plots          <- "plots"
# dn_results_rLA            <- "rLakeAnalyzer"
# dn_results_stratification <- "stratification"
# dn_results_stats          <- "summary_stats"
#
dn_results_sub <- dn_results_data_input

path_results_sub <- file.path(path_results, dn_results_sub)

# "Results" folder, dirs ----
sleep_time_dirs <- 0.75
## Remove then Add
#path_results <- file.path(".", "Results)
boo_Results <- dir.exists(path_results)
if(isTRUE(boo_Results)){
  unlink(path_results, recursive = TRUE)
}
# Create Results, Dir
Sys.sleep(sleep_time_dirs)
dir.create(path_results)
#
# Create Results, subfolders
Sys.sleep(sleep_time_dirs) # pause to ensure Results dir is created
for (i in path_results_sub){
  if(isFALSE(dir.exists(i))) {
    dir.create(i)
  }## IF ~ dir.exists(i) ~ END
}## FOR ~ i ~ END
