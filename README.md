README-LakeMonitoR
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

    #> Last Update: 2021-05-21 15:50:51

# LakeMonitoR

Suite of functions and tools for lake monitoring.

# Badges

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/leppott/LakeMonitoR/graphs/commit-activity)
[![lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://www.tidyverse.org/lifecycle/#stable)

[![License:
GPL-3](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://cran.r-project.org/web/licenses/GPL-3)

[![CodeFactor](https://www.codefactor.io/repository/github/leppott/LakeMonitoR/badge)](https://www.codefactor.io/repository/github/leppott/LakeMonitoR)
[![codecov](https://codecov.io/gh/leppott/LakeMonitoR/branch/main/graph/badge.svg?token=C2MPX70BAL)](https://codecov.io/gh/leppott/LakeMonitoR)
[![R-CMD-check](https://github.com/leppott/LakeMonitoR/workflows/R-CMD-check/badge.svg)](https://github.com/leppott/LakeMonitoR/actions)

[![GitHub
issues](https://img.shields.io/github/issues/leppott/LakeMonitoR.svg)](https://GitHub.com/leppott/LakeMonitoR/issues/)

[![GitHub
release](https://img.shields.io/github/release/leppott/LakeMonitoR.svg)](https://GitHub.com/leppott/LakeMonitoR/releases/)
[![Github all
releases](https://img.shields.io/github/downloads/leppott/LakeMonitoR/total.svg)](https://GitHub.com/leppott/LakeMonitoR/releases/)

# Installation

To install the current version of the code from GitHub use the example
below.

``` r
if(!require(remotes)){install.packages("remotes")}  #install if needed
remotes::install_github("leppott/LakeMonitoR")
```

The vignette (big help file) isn’t created when installing from GitHub
with the above command. If you want the vignette download the compressed
file from GitHub and install from that file or install with the command
below. The “force = TRUE” command is used to ensure the package will
install over and existing install of the same version (e.g., the same
version without the vignettes).

``` r
if(!require(remotes)){install.packages("remotes")}  #install if needed
remotes::install_github("leppott/LakeMonitoR", force = TRUE, build_vignettes = TRUE)
```

# Purpose

Aid analysis of temperature and dissolved oxygen depth profiles from
lakes.

# Issues

<https://github.com/leppott/LakeMonitoR/issues>

# Documentation

Included Vignette and install guide.
