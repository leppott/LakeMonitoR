NEWS
================
<Erik.Leppo@tetratech.com> and <Tim.Martin@state.mn.us>

<!-- NEWS.md is generated from NEWS.Rmd. Please edit that file -->

    #> Last Update: 2023-08-17 16:57:21.743107

# LakeMonitoR 1.0.0.9013

Release - 2023-08-17

- fix: rLakeAnalyzer plot center buoyancy plot name incorrect

  - CSV instead of PNG so ggsave failed

- fix: rLakeAnalyzer layers if not defined

- refactor: Add hooks in Shiny for selectInput boxes for column
  selections to use data instead of free text, Issue \#11

# LakeMonitoR 1.0.0.9012

Release - 2023-02-10

- fix: Use `na.omit` for `tdox` calculation in Shiny, Issue \#24
  - Shiny would crash with too many mismatched DO and temperature
    measurements

# LakeMonitoR 1.0.0.9011

Release - 2022-11-14

- fix: Update handling of data to allow schmidt data and plot function
  to work

# LakeMonitoR 1.0.0.9010

Release - 2022-11-14

- refactor: Shiny heatmap display not working with all files as plotly
  - Change to static ggmap object

# LakeMonitoR 1.0.0.9009

Release - 2022-11-14

- fix: Update shiny display plots to work with non-standard dates

# LakeMonitoR 1.0.0.9008

Release - 2022-11-11

- fix: Update rLakeAnalyzer portion of Shiny app

# LakeMonitoR 1.0.0.9007

Release - 2022-11-04

- feat: Add function to aid in transforming date time fields
  - fun.DateTimeFormat
  - Update Vignette to show its use
  - Update Shiny app to use the new function on imported data

# LakeMonitoR 1.0.0.9006

Release - 2022-10-21

- fix: typo in plot_heatmap updates
- refactor: Change shiny to use rLA style heat map.

# LakeMonitoR 1.0.0.9005

Release - 2022-10-21

- refactor: Change heatmap
  - contours to FALSE
  - colors to rLakeAnalyzer colors

# LakeMonitoR 1.0.0.9004

Release - 2021-09-30

- refactor: Update Shiny calculate sidebar “No Date” to “No Depth”
- refactor: Update Shiny calculate sidebar to remove WSPD from label

# LakeMonitoR 1.0.0.9003

Release - 2021-08-24

- fix: Update tdox() from lm to glm for calculation

# LakeMonitoR 1.0.0.9002

Release - 2021-08-23

- fix: Update tdox() to use input value for DO instead of 3
- refactor: Update tdox() example for tdox_4

# LakeMonitoR 1.0.0.9001

Release - 2021-08-05

- fix: Update stratification() plot for julian day
  - %j starts with 1 so subtract 1 to keep Jan 1 as day 1 with origin
    date of “2004-01-01”.
- refactor: Update stratification() plot with range of data, Issue \#22
- refactor: Update stratification() plot with theme_bw() to match other
  plots

# LakeMonitoR 1.0.0

Release - 2021-08-02

- docs: Bump to version 1.0 for release

# LakeMonitoR 0.1.1.9016

Release - 2021-08-02

- fix: Update Shiny app folder for aggregate function
  - Needed the same fix as Calculation files

# LakeMonitoR 0.1.1.9015

Release - 2021-08-02

- fix: Update Shiny app order of operations for import/upload of files
  - Code was removing the Results/data-input folder and not recreating
    it
- refactor: Change default oxythermal temp from 30 to 20 in Shiny app

# LakeMonitoR 0.1.1.9014

Release - 2021-07-29

- refactor: Update Shiny Server.R
  - Rework directory exists code, make consistent
  - Update sink message for area file
  - Update file name for oxythermal plot output
  - Move DO plots inside of DO if statement with oxythermal and TDOx
  - Add error condition for oxythermal plot when no data to plot
    - For when have units (F) different than default threshold (30 C)
  - Change TDOx file output name
  - Update plots for measurement 2
    - heat map 2
    - depth profile 2

# LakeMonitoR 0.1.1.9013

Release - 2021-07-29

- refactor: Update Shiny rLA plot names to be consistent.
  - Use plot_rLA_x.png

# LakeMonitoR 0.1.1.9012

Release - 2021-07-29

- refactor: Update Shiny rLA plot names to be consistent.
  - Use plot_rLA_x.png

# LakeMonitoR 0.1.1.9011

Release - 2021-07-28

- refactor: Change default temp operator in plot_oxythermal
  - Update help text and function defaults to match example
- refactor: Update Shiny app
  - Calculation
    - Add Stratification method pull down
    - Add oxythermal inputs (temp and do)
    - Add TDOx value input
- function: Add Shiny app function to calculate stratification with
  different methods based on user input
- docs: Add tidyr package to DESCRIPTION

# LakeMonitoR 0.1.1.9010

Release - 2021-07-26

- docs: Update vignette examples

# LakeMonitoR 0.1.1.9009

Release - 2021-07-26

- docs: Rename vignette
- docs: Add plotting example for TDO3 to vignette, Issue \#21

# LakeMonitoR 0.1.1.9008

Release - 2021-07-16

- fix: Stratification, update column reference. Undo change in
  v0.1.1.9007
- feature: Add TDOx function, Issue \#21

# LakeMonitoR 0.1.1.9007

Release - 2021-07-16

- refactor: Stratification, update a hard coded column reference
- refactor: Stratification, update code to allow for only 2 depths,
  Issue \#20

# LakeMonitoR 0.1.1.9006

Release - 2021-07-16

- fix: Change Results folder reference in global to drop “.”
  - Fails in Linux with the “.” in file.path

# LakeMonitoR 0.1.1.9005

Release - 2021-07-16

- fix: Revert Shiny app to v0.1.1 and redo changes
  - Shiny app Help as HTML conflicts with file upload. Redesign as
    non-HTML
  - Remove semicolon as available delimiter for import files
  - Shiny Calculate tab labels ‘measurement’ to ‘value’
  - Ensure all uploaded data files going to Results/data_input
  - Add tooltips to tab_Calc
  - Add `ShinyBS` to global.R
- feat: Add missing function fun.write.log() to fun.Helper.R
- refactor: Rename log files with prefix “*log*”
- refactor: Use global “path_results” in server.R
- docs: Update Vignette with `plot_oxythermal()` function
- docs: Update oxythermal plots in function help and vignette
  - example to use \<= 68 rather than \>= 68
  - Combination plot; oxythermal, heat map temp, heat map DO

# LakeMonitoR 0.1.1.9004

Release - 2021-07-13

- fix: Unwind some changes to Shiny app. App won’t allow for upload of
  files
  - Combine files tab is now working.
- fix: `AggregateFiles()` to `agg_depth_files()` in server.R
- fix: Shiny, in Aggregate section replace “import” folder with
  “Results/data_input” folder

# LakeMonitoR 0.1.1.9003

Release - 2021-07-13

- refactor: Shiny app update.
- docs: Update README with example to run Shiny app.

# LakeMonitoR 0.1.1.9002

Release - 2021-07-09

- refactor: Shiny import remove semicolon as available delimiter
- docs: Add packages used in Shiny app to DESCRIPTION
- feature: Add tooltips to some inputs in Shiny app with shinyBS package
- docs: Add shinyBS to DESCRIPTION
- feature: Add plot_oxythermal function, Issue \#18

# LakeMonitoR 0.1.1.9001

Released - 2021-06-08

- refactor: Organize Results folder, Issue \#14
- refactor: Drop import files in new format
- docs: Add ggplot versions of plots to Vignette for rLakeAnalyzer
  examples

# LakeMonitoR 0.1.1

Released - 2021-06-04

- release: Update version for interim release

# LakeMonitoR 0.1.0.9039

Released - 2021-06-04

- feature: Shiny, add third file
  - Import
  - Display
  - Plot, screen
  - Plot, calculate
- refactor: Add new daily depth mean file with temp and DO from example
  lake

# LakeMonitoR 0.1.0.9038

Released - 2021-06-03

- refactor: Add gridExtra package to Shiny global.R and DESCRIPTION
- refactor: Add wind speed data to laketest dataset
- feature: Add plot_ts function for generic plotting by date (and not
  depth)
- feature: Add data `testlake_wind`

# LakeMonitoR 0.1.0.9037

Released - 2021-06-03

- refactor: Add example to plot_depth showing horizontal line
- feature: Remove minimum values outputs for startification()
- refactor: Add units as input for stratification(), Issue \#1

# LakeMonitoR 0.1.0.9036

Released - 2021-06-02

- refactor: Rename AggregateFiles to agg_depth_files
- refactor: Add sections to Vignettee for LakeMonitoR functions
- feature: Add minimum value outputs to stratification()
- refactor: Add minimum value to stratification plot

# LakeMonitoR 0.1.0.9035

Released - 2021-05-25

- refactor: Update Shiny app code to avoid error when upload to
  ShinyApps.io
  - Blank directories don’t upload.
    - Wrote code to ensure directories exist prior to using them.

# LakeMonitoR 0.1.0.9034

Released - 2021-05-24

- feature: Add ability to combine files to the Shiny app
- refactor: Add source column to AggregateDepthData function output

# LakeMonitoR 0.1.0.9033

Released - 2021-05-21

- feature: Add function to combine depth data files, Issue \#13
  - AggregateDepthData
  - Tweaked port of AggregateFile function from ContDataQC package
- docs: Update README to use remotes instead of devtools
- feature: Add internal function fun.Msg.Status for constructing user
  feedback
  - Port of same function from ContDataQC package
- feature: Example data files for use with AggregateDepthData function
  - Included in extdata as CSV files

# LakeMonitoR 0.1.0.9032

Released - 2021-05-03

- refactor: lake_summary_stats
  - Fix JulianDay stats. Conversion of TimeFrame_Value to character
    caused errors.

# LakeMonitoR 0.1.0.9031

Released - 2021-04-27

- refactor: lake_summary_stats
  - Fix calculation and grouping for output
- refactor: Remove RussWood_FixedID.csv from extdata folder
  - 66.9 MB
- style: Trim lines to 80 characters
  - stratification.R
- docs: Add to DESCRIPTION
  - URL
  - BugReports

# LakeMonitoR 0.1.0.9030

Released - 2021-04-16

- refactor: stratification
  - change default min_days from 20 to 1
  - add global variable bindings
- tests: Update plot_depth test for name change
- refactor: Add global variable bindings
  - stratification
  - daily_depth_means
  - lake_summary_stats

# LakeMonitoR 0.1.0.9029

Released - 2021-04-07

- refactor: Shiny, “min DO” to “min measurement”
- refactor: Shiny, Stratification, default from 20 to 1
- refactor: Shiny, plot_depth stratification, lines to polygon

# LakeMonitoR 0.1.0.9028

Released - 2021-04-02

- style: Fix spelling, devtools::spell_check()
  - NEWS
  - stratification.R
  - data.R
- style: Fix items from goodpractice::gp()
  - Trim lines to 80 characters
    - plot_heatmap.R
    - lake_summary_stats.R
    - tab_Calc.R
    - tab_Help.R
    - tab_Import.R
    - server.R
  - Replace ‘=’ with ‘\<-’
    - stratification.R

# LakeMonitoR 0.1.0.9027

Released - 2021-03-17

- refactor: lake_summary_stats, add missing %\>% in stats function,
  Issue \#12

# LakeMonitoR 0.1.0.9026

Released - 2021-03-17

- refactor: Remove lake_summary_stats from Shiny app
- refactor: Shiny, add plot_heatmap
- refactor: Shiny, rename rLakeAnalyzer heat map
- refactor: stratification, add events plot to output list, Issue \#7
- refactor: Shiny, add stratification plot to calculation
- refactor: Shiny, add stratification lines to depth profile plot in
  calculation

# LakeMonitoR 0.1.0.9025

Released - 2021-03-16

- refactor: Update version number in shiny UI

# LakeMonitoR 0.1.0.9024

Released - 2021-03-16

- refactor: Update maps in Shiny to use ggplotly dynamicTicks = TRUE
- refactor: Update heatmap in Shiny  
- refactor!: Rename depth_plot to plot_depth
- feature: Add plot_heatmap, Issues \#6 and \#10
- refactor: Update Shiny server with revised plot function names

# LakeMonitoR 0.1.0.9023

Released - 2021-03-05

- feature: Add lake_summary_stats
- refactor: Add dplyer to DESCRIPTION Imports

# LakeMonitoR 0.1.0.9022

Released - 2021-02-25

- docs: DESCRIPTION, remove ContDataQC, too many dependencies

# LakeMonitoR 0.1.0.9021

Released - 2021-02-25

- docs: DESCRIPTION, ContDataQC package, add remote rather then removing
  from Imports

# LakeMonitoR 0.1.0.9020

Released - 2021-02-25

- docs: DESCRIPTION, remove ContDataQC package, causes build failure

# LakeMonitoR 0.1.0.9019

Released - 2021-02-25

- docs: Updated README for example install code
- refactor: Update stratification() to handle data that is 100%
  stratified , Issue \#9
- refactor: Update stratification() to handle data that is 0% stratified
  , Issue \#9
- docs: DESCRIPTION, add ContDataQC package for date helper function

# LakeMonitoR 0.1.0.9018

Released - 2021-02-01

- refactor: Update temporary settings to inputs for depth_plot()
- feature: Add scatterplot depth profile and heatmap (Issues \#6) for
  Shiny input

# LakeMonitoR 0.1.0.9017

Released - 2021-01-28

- refactor: Update stop message for depth_plot() column QC

# LakeMonitoR 0.1.0.9016

Released - 2021-01-28

- refactor: Add internal QC for column headers for depth_plot(), Issue
  \#5
- tests: Add test for depth_plot() ggplot object, Issue \#5
- refactor: Add data-raw to create qc object for depth_plot() test,
  Issue \#5
- docs: Example file for depth_plot() saved as RDA forced DEPENDS on R
  \>= 3.5.0

# LakeMonitoR 0.1.0.9015

Released - 2021-01-28

- feature: Add depth_plot function to return a depth profile plot, Issue
  \#5
- feature: Add laketest data for use with depth_plot()

# LakeMonitoR 0.1.0.9014

Released - 2021-01-19

- docs: Update codecov badge in README

# LakeMonitoR 0.1.0.9013

Released - 2021-01-19

- refactor: Remove unneeded concatenation of a constant
  - export_rLakeAnalyzer
- refactor: Replace 1:foo(bar) with seq_len(foo(bar))
  - stratification

# LakeMonitoR 0.1.0.9012

Released - 2021-01-19

- refactor: Remove docs folder
  - Using GitHub Action to build pkgdown site

# LakeMonitoR 0.1.0.9011

Released - 2021-01-19

- style: Remove blank lines at end of script
  - daily_depth_means
  - data
  - export_rLakeAnalyzer
  - LakeMonitoR
  - runShiny
  - stratification
- style: Trim lines to 80 characters
  - runShiny
  - daily_depth_means
  - data
  - export_rLakeAnalyzer
  - stratification
- refactor: Add items to .Rbuildignore and .gitignore
  - \_other folder
  - NEWS.rmd
  - README.RMD
  - Switch setting to use gh-pages branch
- tests: Add two tests for stratification (dates and events)
- tests: Add test for export_rLakeAnalyzer
- docs: Add all extra export_rLakeAnalyzer examples to dontrun
  - Comment out failing schmidt.plot()
- refactor: Add missing parameters to function call
  - dir_export
  - fn_export
- docs: Update DESCRIPTION license

# LakeMonitoR 0.1.0.9010

Released - 2021-01-19

- tests: Add test for daily_depth_means

# LakeMonitoR 0.1.0.9009

Released - 2020-12-27

- docs: ReadMe, Add license badge
- docs: ReadMe, Add CodeFactor badge
- docs: ReadMe, Add lifecycle badge
- docs: ReadMe, Add maintenance badge
- docs: ReadMe, Add issues badge
- docs: ReadMe, Add release badge
- docs: ReadMe, Add download badge
- docs: ReadMe, Add codecov badge
- ci: Add GitHub Action, CI
- docs: ReadMe, Add CMD Check badge
- ci: Add GitHub Action, pkgdown
- docs: Remove docs folder from main branch
- docs: GitHub redirect web page to gh-pages branch
- ci: Add GitHub Action, test coverage
- docs: ReadMe, rework md as rmd

# LakeMonitoR 0.1.0.9008

Released - 2020-11-13 \* server.R + Add inputs to sink. + Min days input
wasn’t getting used. + Min days input to numeric. \* stratification.R +
Convert min_days to numeric as a QC check.

# LakeMonitoR 0.1.0.9007

Released - 2020-11-13 \* stratification.R + Add number of days to column
name in output, Issue \#3. \* check + Add and declare packages for
functions in DESCRIPTION and code.

# LakeMonitoR 0.1.0.9006

Released - 2020-11-10

- Add package help file.

# LakeMonitoR 0.1.0.9005

Released - 2020-10-27

- Shiny, ui.R
  - Update version number in header.

# LakeMonitoR 0.1.0.9004

Released - 2020-10-27

- Shiny, server.R
  - Add error checking for column names and upload files, Issue \#1

# LakeMonitoR 0.1.0.9003

Released - 2020-10-26

- Update Shiny app.
- Add example files for Shiny app.

# LakeMonitoR 0.1.0.9002

Released - 2020-10-22

- ReadMe.md
  - Fix typo in install_github example code.
- Add function export_rLakeAnalyzer
  - Convert data frame to rLakeAnalyzer input format.
- DESCRIPTION
  - Imports: reshape2
  - Suggests: rLakeAnalyzer and ggplot2
- Data.R
  - Add lakehypso

# LakeMonitoR 0.1.0.9001

Released - 2020-10-22

- Add Shiny app.
  - File upload only.
- runShiny.R
  - Add function to run shiny app.

# LakeMonitoR 0.1.0

Released - 2020-10-20

- Interim version.
  - Both functions fully operational.
- Update pkgdown.

# LakeMonitoR 0.0.1.9006

Released - 2020-10-20

- Remove docs (pkgdown) from gitignore

# LakeMonitoR 0.0.1.9005

Released - 2020-10-20

- Add pkgdown documentation.

# LakeMonitoR 0.0.1.9004

Released - 2020-10-20

- Update data-raw and data with full records.
  - Use full raw data.
  - Zip raw data file.
- Update data.R

# LakeMonitoR 0.0.1.9003

Released - 2020-10-19

- Add stratification function.

# LakeMonitoR 0.0.1.9002

Released - 2020-10-19

- Update daily_depth_means function.
- Add data file, laketemp_ddm (output of daily_depth_means function).

# LakeMonitoR 0.0.1.9001

Released - 2020-10-16

- Add laketemp data
- Add functions.
  - daily_depth_means
  - lake_strat

# LakeMonitoR 0.0.1.9001

Released - 2020-10-16

- Initial commit to GitHub
