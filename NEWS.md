NEWS
================
<Erik.Leppo@tetratech.com> and <Tim.Martin@state.mn.us>

<!-- NEWS.md is generated from NEWS.Rmd. Please edit that file -->

    #> Last Update: 2021-07-09 11:31:46

# LakeMonitoR 0.1.1.9002

Release - 2021-07-09

-   refactor: Shiny import remove semicolon as available delimiter
-   docs: Add packages used in Shiny app to DESCRIPTION
-   feature: Add tooltips to some inputs in Shiny app with shinyBS
    package
-   docs: Add shinyBS to DESCRIPTION
-   feature: Add plot\_oxythermal function, Issue \#18

# LakeMonitoR 0.1.1.9001

Released - 2021-06-08

-   refactor: Organize Results folder, Issue \#14
-   refactor: Drop import files in new format
-   docs: Add ggplot versions of plots to Vignette for rLakeAnalyzer
    examples

# LakeMonitoR 0.1.1

Released - 2021-06-04

-   release: Update version for interim release

# LakeMonitoR 0.1.0.9039

Released - 2021-06-04

-   feature: Shiny, add third file
    -   Import
    -   Display
    -   Plot, screen
    -   Plot, calculate
-   refactor: Add new daily depth mean file with temp and DO from
    example lake

# LakeMonitoR 0.1.0.9038

Released - 2021-06-03

-   refactor: Add gridExtra package to Shiny global.R and DESCRIPTION
-   refactor: Add wind speed data to laketest dataset
-   feature: Add plot\_ts function for generic plotting by date (and not
    depth)
-   feature: Add data `testlake_wind`

# LakeMonitoR 0.1.0.9037

Released - 2021-06-03

-   refactor: Add example to plot\_depth showing horizontal line
-   feature: Remove minimum values outputs for startification()
-   refactor: Add units as input for stratification(), Issue \#1

# LakeMonitoR 0.1.0.9036

Released - 2021-06-02

-   refactor: Rename AggregateFiles to agg\_depth\_files
-   refactor: Add sections to Vignettee for LakeMonitoR functions
-   feature: Add minimum value outputs to stratification()
-   refactor: Add minimum value to stratification plot

# LakeMonitoR 0.1.0.9035

Released - 2021-05-25

-   refactor: Update Shiny app code to avoid error when upload to
    ShinyApps.io
    -   Blank directories don’t upload.
        -   Wrote code to ensure directories exist prior to using them.

# LakeMonitoR 0.1.0.9034

Released - 2021-05-24

-   feature: Add ability to combine files to the Shiny app
-   refactor: Add source column to AggregateDepthData function output

# LakeMonitoR 0.1.0.9033

Released - 2021-05-21

-   feature: Add function to combine depth data files, Issue \#13
    -   AggregateDepthData
    -   Tweaked port of AggregateFile function from ContDataQC package
-   docs: Update README to use remotes instead of devtools
-   feature: Add internal function fun.Msg.Status for constructing user
    feedback
    -   Port of same function from ContDataQC package
-   feature: Example data files for use with AggregateDepthData function
    -   Included in extdata as CSV files

# LakeMonitoR 0.1.0.9032

Released - 2021-05-03

-   refactor: lake\_summary\_stats
    -   Fix JulianDay stats. Conversion of TimeFrame\_Value to character
        caused errors.

# LakeMonitoR 0.1.0.9031

Released - 2021-04-27

-   refactor: lake\_summary\_stats
    -   Fix calculation and grouping for output
-   refactor: Remove RussWood\_FixedID.csv from extdata folder
    -   66.9 MB
-   style: Trim lines to 80 characters
    -   stratification.R
-   docs: Add to DESCRIPTION
    -   URL
    -   BugReports

# LakeMonitoR 0.1.0.9030

Released - 2021-04-16

-   refactor: stratification
    -   change default min\_days from 20 to 1
    -   add global variable bindings
-   tests: Update plot\_depth test for name change
-   refactor: Add global variable bindings
    -   stratification
    -   daily\_depth\_means
    -   lake\_summary\_stats

# LakeMonitoR 0.1.0.9029

Released - 2021-04-07

-   refactor: Shiny, “min DO” to “min measurement”
-   refactor: Shiny, Stratification, default from 20 to 1
-   refactor: Shiny, plot\_depth stratification, lines to polygon

# LakeMonitoR 0.1.0.9028

Released - 2021-04-02

-   style: Fix spelling, devtools::spell\_check()
    -   NEWS
    -   stratification.R
    -   data.R
-   style: Fix items from goodpractice::gp()
    -   Trim lines to 80 characters
        -   plot\_heatmap.R
        -   lake\_summary\_stats.R
        -   tab\_Calc.R
        -   tab\_Help.R
        -   tab\_Import.R
        -   server.R
    -   Replace ‘=’ with ‘&lt;-’
        -   stratification.R

# LakeMonitoR 0.1.0.9027

Released - 2021-03-17

-   refactor: lake\_summary\_stats, add missing %&gt;% in stats
    function, Issue \#12

# LakeMonitoR 0.1.0.9026

Released - 2021-03-17

-   refactor: Remove lake\_summary\_stats from Shiny app
-   refactor: Shiny, add plot\_heatmap
-   refactor: Shiny, rename rLakeAnalyzer heat map
-   refactor: stratification, add events plot to output list, Issue \#7
-   refactor: Shiny, add stratification plot to calculation
-   refactor: Shiny, add stratification lines to depth profile plot in
    calculation

# LakeMonitoR 0.1.0.9025

Released - 2021-03-16

-   refactor: Update version number in shiny UI

# LakeMonitoR 0.1.0.9024

Released - 2021-03-16

-   refactor: Update maps in Shiny to use ggplotly dynamicTicks = TRUE
-   refactor: Update heatmap in Shiny  
-   refactor!: Rename depth\_plot to plot\_depth
-   feature: Add plot\_heatmap, Issues \#6 and \#10
-   refactor: Update Shiny server with revised plot function names

# LakeMonitoR 0.1.0.9023

Released - 2021-03-05

-   feature: Add lake\_summary\_stats
-   refactor: Add dplyer to DESCRIPTION Imports

# LakeMonitoR 0.1.0.9022

Released - 2021-02-25

-   docs: DESCRIPTION, remove ContDataQC, too many dependencies

# LakeMonitoR 0.1.0.9021

Released - 2021-02-25

-   docs: DESCRIPTION, ContDataQC package, add remote rather then
    removing from Imports

# LakeMonitoR 0.1.0.9020

Released - 2021-02-25

-   docs: DESCRIPTION, remove ContDataQC package, causes build failure

# LakeMonitoR 0.1.0.9019

Released - 2021-02-25

-   docs: Updated README for example install code
-   refactor: Update stratification() to handle data that is 100%
    stratified , Issue \#9
-   refactor: Update stratification() to handle data that is 0%
    stratified , Issue \#9
-   docs: DESCRIPTION, add ContDataQC package for date helper function

# LakeMonitoR 0.1.0.9018

Released - 2021-02-01

-   refactor: Update temporary settings to inputs for depth\_plot()
-   feature: Add scatterplot depth profile and heatmap (Issues \#6) for
    Shiny input

# LakeMonitoR 0.1.0.9017

Released - 2021-01-28

-   refactor: Update stop message for depth\_plot() column QC

# LakeMonitoR 0.1.0.9016

Released - 2021-01-28

-   refactor: Add internal QC for column headers for depth\_plot(),
    Issue \#5
-   tests: Add test for depth\_plot() ggplot object, Issue \#5
-   refactor: Add data-raw to create qc object for depth\_plot() test,
    Issue \#5
-   docs: Example file for depth\_plot() saved as RDA forced DEPENDS on
    R &gt;= 3.5.0

# LakeMonitoR 0.1.0.9015

Released - 2021-01-28

-   feature: Add depth\_plot function to return a depth profile plot,
    Issue \#5
-   feature: Add laketest data for use with depth\_plot()

# LakeMonitoR 0.1.0.9014

Released - 2021-01-19

-   docs: Update codecov badge in README

# LakeMonitoR 0.1.0.9013

Released - 2021-01-19

-   refactor: Remove unneeded concatenation of a constant
    -   export\_rLakeAnalyzer
-   refactor: Replace 1:foo(bar) with seq\_len(foo(bar))
    -   stratification

# LakeMonitoR 0.1.0.9012

Released - 2021-01-19

-   refactor: Remove docs folder
    -   Using GitHub Action to build pkgdown site

# LakeMonitoR 0.1.0.9011

Released - 2021-01-19

-   style: Remove blank lines at end of script
    -   daily\_depth\_means
    -   data
    -   export\_rLakeAnalyzer
    -   LakeMonitoR
    -   runShiny
    -   stratification
-   style: Trim lines to 80 characters
    -   runShiny
    -   daily\_depth\_means
    -   data
    -   export\_rLakeAnalyzer
    -   stratification
-   refactor: Add items to .Rbuildignore and .gitignore
    -   \_other folder
    -   NEWS.rmd
    -   README.RMD
    -   Switch setting to use gh-pages branch
-   tests: Add two tests for stratification (dates and events)
-   tests: Add test for export\_rLakeAnalyzer
-   docs: Add all extra export\_rLakeAnalyzer examples to dontrun
    -   Comment out failing schmidt.plot()
-   refactor: Add missing parameters to function call
    -   dir\_export
    -   fn\_export
-   docs: Update DESCRIPTION license

# LakeMonitoR 0.1.0.9010

Released - 2021-01-19

-   tests: Add test for daily\_depth\_means

# LakeMonitoR 0.1.0.9009

Released - 2020-12-27

-   docs: ReadMe, Add license badge
-   docs: ReadMe, Add CodeFactor badge
-   docs: ReadMe, Add lifecycle badge
-   docs: ReadMe, Add maintenance badge
-   docs: ReadMe, Add issues badge
-   docs: ReadMe, Add release badge
-   docs: ReadMe, Add download badge
-   docs: ReadMe, Add codecov badge
-   ci: Add GitHub Action, CI
-   docs: ReadMe, Add CMD Check badge
-   ci: Add GitHub Action, pkgdown
-   docs: Remove docs folder from main branch
-   docs: GitHub redirect web page to gh-pages branch
-   ci: Add GitHub Action, test coverage
-   docs: ReadMe, rework md as rmd

# LakeMonitoR 0.1.0.9008

Released - 2020-11-13 \* server.R + Add inputs to sink. + Min days input
wasn’t getting used. + Min days input to numeric. \* stratification.R +
Convert min\_days to numeric as a QC check.

# LakeMonitoR 0.1.0.9007

Released - 2020-11-13 \* stratification.R + Add number of days to column
name in output, Issue \#3. \* check + Add and declare packages for
functions in DESCRIPTION and code.

# LakeMonitoR 0.1.0.9006

Released - 2020-11-10

-   Add package help file.

# LakeMonitoR 0.1.0.9005

Released - 2020-10-27

-   Shiny, ui.R
    -   Update version number in header.

# LakeMonitoR 0.1.0.9004

Released - 2020-10-27

-   Shiny, server.R
    -   Add error checking for column names and upload files, Issue \#1

# LakeMonitoR 0.1.0.9003

Released - 2020-10-26

-   Update Shiny app.
-   Add example files for Shiny app.

# LakeMonitoR 0.1.0.9002

Released - 2020-10-22

-   ReadMe.md
    -   Fix typo in install\_github example code.
-   Add function export\_rLakeAnalyzer
    -   Convert data frame to rLakeAnalyzer input format.
-   DESCRIPTION
    -   Imports: reshape2
    -   Suggests: rLakeAnalyzer and ggplot2
-   Data.R
    -   Add lakehypso

# LakeMonitoR 0.1.0.9001

Released - 2020-10-22

-   Add Shiny app.
    -   File upload only.
-   runShiny.R
    -   Add function to run shiny app.

# LakeMonitoR 0.1.0

Released - 2020-10-20

-   Interim version.
    -   Both functions fully operational.
-   Update pkgdown.

# LakeMonitoR 0.0.1.9006

Released - 2020-10-20

-   Remove docs (pkgdown) from gitignore

# LakeMonitoR 0.0.1.9005

Released - 2020-10-20

-   Add pkgdown documentation.

# LakeMonitoR 0.0.1.9004

Released - 2020-10-20

-   Update data-raw and data with full records.
    -   Use full raw data.
    -   Zip raw data file.
-   Update data.R

# LakeMonitoR 0.0.1.9003

Released - 2020-10-19

-   Add stratification function.

# LakeMonitoR 0.0.1.9002

Released - 2020-10-19

-   Update daily\_depth\_means function.
-   Add data file, laketemp\_ddm (output of daily\_depth\_means
    function).

# LakeMonitoR 0.0.1.9001

Released - 2020-10-16

-   Add laketemp data
-   Add functions.
    -   daily\_depth\_means
    -   lake\_strat

# LakeMonitoR 0.0.1.9001

Released - 2020-10-16

-   Initial commit to GitHub
