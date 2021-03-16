#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Packages
# library(shiny)
# library(LakeMonitoR)
# library(DT)
# library(ggplot2)
# #library(plotly)
# library(shinyjs) # used for togglestate of download button

# Sources Pages ####
tab_Help   <- source("external/tab_Help.R", local = TRUE)$value
tab_Import <- source("external/tab_Import.R", local = TRUE)$value
tab_Calc   <- source("external/tab_Calc.R", local = TRUE)$value
tab_Plot   <- source("external/tab_Plot.R", local = TRUE)$value

# Define UI
shinyUI(
  navbarPage("LakeMonitoR, v0.1.0.9023"
    , tab_Help()
    , tab_Import()
    , tab_Calc()
    , tab_Plot()
  )##navbarPage ~ END
)##shinyUI~END
