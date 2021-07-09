# Prepare HTML for use in Shiny App
# tabHELP
#
# Erik.Leppo@tetratech.com
# 2021-07-02
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 0. Prep####
wd <- getwd() # assume is package directory
#library(devtools)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Save as RDA for use in  Shiny app ----
myRMD <- "Shiny_tabHelp.rmd"
rmarkdown::render(file.path(".", "data-raw", myRMD)
                  , output_file = "Help.html"
                  , output_dir = file.path("."
                                           , "inst"
                                           , "shiny-examples"
                                           , "LakeMonitoR"
                                           , "external")
                  )
