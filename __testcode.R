# testing

# Packages
library(ggplot2)
library(rLakeAnalyzer)
library(LakeMonitoR)

# Data
path_data <- file.path(".", "inst", "shiny-examples", "LakeMonitoR", "Examples")
fn_1 <- "TestLake_Water_20180702_20181012.csv"
fn_2 <- "example_lakehypso.csv"
fn_3 <- "TestLake_wind_20180702_20181012.csv"

df_data <- read.csv(file.path(path_data, fn_1))
df_data2 <- read.csv(file.path(path_data, fn_2))
df_data3 <- read.csv(file.path(path_data, fn_3))


# Munge
## export for rLA
col_depth <- "Depth"
col_date <- "Date.Time"
col_measure <- "temp_F"
col_depth_rLA <- col_depth
col_data_rLA <- c(col_date, col_measure)
col_rLA_rLA <- c("datetime", "wtr")
dir_export_rLA <- file.path(path_results)
fn_export_rLA <- "rLA_export.csv"
df_rLA_wtr <- LakeMonitoR::export_rLakeAnalyzer(df_data
                                                , col_depth = col_depth_rLA
                                                , col_data = col_data_rLA
                                                , col_rLA = col_rLA_rLA)

# td ----
df_rLA_td <- ts.thermo.depth(df_rLA_wtr)

plot(t.d$datetime, t.d$thermo.depth, type='l', ylab='Thermocline Depth (m)', xlab='Date')

p_td <- ggplot(data = df_rLA_td, aes(x = datetime
                                     , y = thermo.depth
                                     , group = 1)) +
                 geom_point()

# bf -----
df_rLA_bf <- rLakeAnalyzer::ts.buoyancy.freq(df_rLA_wtr)

plot(df_rLA_bf, type='l', ylab='Buoyancy Frequency', xlab='Date')

p_td <- ggplot(N2, aes(x = datetime, y = n2)) +
  geom_line(na.rm = TRUE) +
  theme_bw() +
  labs(x = "Date", y = "Buoyancy Frequency")

# Schmidt ----
df_rLA_ss <- ts.schmidt.stability(df_rLA_wtr, df_data2)

#####


