# Test, More
# Erik.Leppo@tetratech.com
# 2021-07-27
#
# Run example code from Shiny so don't have to run it in Shiny

# working directory = shiny app
setwd("C:/Users/Erik.Leppo/OneDrive - Tetra Tech, Inc/MyDocs_OneDrive/GitHub/LakeMonitoR/inst/shiny-examples/LakeMonitoR")

# rLA stuff
## Data
df_import <- read.csv(file.path("Examples", "example_laketemp.csv"))

# name columns
col_siteid   <- "SiteID"
col_datetime <- "Date_Time"
col_depth    <- "Depth_m"
col_measure  <- "Water_Temp_C"

# DDM
data_ddm <- daily_depth_means(df_import
                              , col_siteid
                              , col_datetime
                              , col_depth
                              , col_measure)

# rLA data format
col_depth <- "Depth"
col_data <- c("Date", "Measurement")
col_rLA  <- c("datetime", "wtr")
df_rLA_wtr <- export_rLakeAnalyzer(data_ddm, col_depth, col_data, col_rLA)


# rLA, bf
df_rLA_bf <- rLakeAnalyzer::ts.buoyancy.freq(df_rLA_wtr)
plot(df_rLA_bf, type='l', ylab='Buoyancy Frequency', xlab='Date')
