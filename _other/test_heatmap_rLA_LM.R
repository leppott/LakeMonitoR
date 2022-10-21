# tests
# rLakeAnalyzer heatmap vs. the one in LakeMonitoR
# 2022-10-22
# Erik.Leppo@tetratech.com
# use the rLA data
#~~~~~~~~~~~~~~~~~~~~


# Packages----
library(rLakeAnalyzer)
library(tidyr)
library(ggplot2)

# Data----
## get data from rLakeAnalyzer::wtr.heat.map()
#Load data for example lake, Sparkilng Lake, Wisconsin.
sp.wtr <- load.ts(system.file('extdata'
                             , 'Sparkling.daily.wtr'
                             , package="rLakeAnalyzer"))

# Munge ----
# wide to long
df_long <- pivot_longer(sp.wtr
                        , cols = names(sp.wtr)[-1]
                        , names_prefix = "wtr_"
                        , names_to = "depth"
                        , names_transform = list(depth = as.double)
                        , values_to = "temp")

# Plot ----
## Plot, rLA, function ----
wtr.heat.map(sp.wtr)

## Plot, rLA, code ----
# https://github.com/GLEON/rLakeAnalyzer/blob/master/R/wtr.plotting.R
wtr <- sp.wtr
depths = get.offsets(wtr)
n = nrow(wtr)
#wtr.dates = get.datetime(wtr, error=TRUE)
wtr.dates <- wtr$datetime
wtr.mat = as.matrix(wtr[,-1])
y = depths
graphics::filled.contour(wtr.dates
                         , y
                         , wtr.mat
                         , ylim=c(max(depths),0)
                         , nlevels=100
                         , color.palette=grDevices::colorRampPalette(c("violet"
                                                                       ,"blue"
                                                                       ,"cyan"
                                                                       , "green3"
                                                                       , "yellow"
                                                                       , "orange"
                                                                       , "red")
                                                                     , bias = 1
                                                                     , space = "rgb")
                         , ylab='Depths (m)'
                         )

## Plot, ggplot ----
col_datetime <- "datetime"
col_depth <- "depth"
col_measure <- "temp"
p_fill_n <- 7
p_fill_colors_LM <- rev(rainbow(p_fill_n))
p_fill_colors_rLA <- c("violet", "blue", "cyan", "green3", "yellow", "orange", "red")
p_fill_colors <- p_fill_colors_rLA

p <- ggplot2::ggplot(data = df_long
                     , ggplot2::aes_string(x = col_datetime
                                           , y = col_depth
                                           , fill = col_measure)) +
  ggplot2::geom_tile(na.rm = TRUE) +
  ggplot2::scale_y_reverse() +
  ggplot2::scale_x_datetime(date_labels = "%b") +
  ggplot2::theme_bw() +
  ggplot2::scale_fill_gradientn(colors = p_fill_colors) +
  ggplot2::labs(y = "Depths (m)")

# original LakeMonitoR heatmap
p + ggplot2::scale_fill_viridis_b()


## Plot, alt, interpolat with approx

## Plot, geom_grid(interpolate = TRUE)
# very blurry and doesn't fill in gaps
p + geom_raster(interpolate = TRUE)

## Plot, alternate, akima pkg ----
# interpolation, maybe IDW from gstat::idw()
# inverse distance weighting
# Akima package but blocky and dates screwy
# or converts to 16M points from 4k points
# df_interp <- df_long
# names(df_interp) <- c("x", "y", "z")
df_interp <- with(df_long, akima::interp(datetime, depth, temp), linear = FALSE)
df_interp2 <- akima::interp2xyz(df_interp)
p2 <- ggplot(df_interp2, aes(x = x, y = y, z = z, fill = z)) +
  geom_tile() +
  scale_y_reverse() +
  scale_fill_gradientn(colors = p_fill_colors)

## Plot, alt, interp pkg ----
# not sure, seems to trim data

# Check colors ----
plot(1:7, col = p_fill_colors, pch = 16, cex = 5, main = "rainbow")
col_rLA <- c("violet", "blue", "cyan", "green3", "yellow", "orange", "red")
plot(1:7, col = col_rLA, pch = 16, cex = 5, main = "rLA")

