#' @title Lake Stratification
#'
#' @description Calculates stratification on daily depth means.
#'
#' @details Uses the output of `daily_depth_means` and assumes units are
#' degree Celcius and meters.
#'
#' Calculation is defined as greater than a 1 degree (C) difference over
#' 1 meter anywhere in the water column.
#'
#' A list is returned with two data frames.  The first has the dates and
#' TRUE or FALSE for stratification  The second has the start and end dates and
#' time span for each stratification event.
#'
#' Input data is assumed to be a single lake location depth profile.
#'
#' @param data data frame
# @param col_siteid Column name, SiteID
#' @param col_date Column name, Date
#' @param col_depth Column name, Depth
#' @param col_measure Column name, measurement for calculation
#' @param min_days Minimum number of consecutive days to be classified as
#' stratification.  Default = 20.
# @param df_hypso Data frame of hypsometry for lake.
# Column names of Contour_Depth and Area.
# Default = NULL
#'
#'
#' @return List with 3 elements, 2 data frames and a ggplot
#' Stratification_Dates includes dates and T/F for Stratified.
#' Stratification_Events includes a row for each stratified event along with
#' start and end dates and number of days.
#' Stratifcation_Plot is a ggplot with lines for each event by date (x)
#' and year (y).
#'
#' @examples
#' # data
#' data <- laketemp_ddm
#'
#' # Columns
#' #col_siteid  <- "SiteID"
#' col_date    <- "Date"
#' col_depth   <- "Depth"
#' col_measure <- "Measurement"
#'
#' # Calculate Stratification
#' ls_strat <- stratification(data
#'                            , col_date
#'                            , col_depth
#'                            , col_measure
#'                            , min_days = 20 )
#'
#' # Results, Stratification Dates
#' head(ls_strat$Stratification_Dates)
#'
#' # Results, Stratification Events
#' ls_strat$Stratification_Events
#'
#' # Results, Stratification Plot
#' p <- ls_strat$Stratification_Plot
#' print(p)
#
#' @export
stratification <- function(data
                           #, col_siteid
                           , col_date
                           , col_depth
                           , col_measure
                           , min_days = 20
                           #, df_hypso = NULL
                           ){

  # Ensure proper formats
  # Convert to data frame (avoid use of tibble)
  data <- data.frame(data)
  data[, col_date]    <- as.Date(data[, col_date])
  data[, col_depth]   <- as.numeric(data[,col_depth])
  data[, col_measure] <- as.numeric(data[, col_measure])

  Dates <- sort(unique(data[, col_date]))

  # QC days to numeric
  min_days <- as.numeric(min_days)

  # # Check total days
  # days_total <- as.numeric(max(data[, col_date]) - min(data[, col_date]))
  # if(days_total < min_days) {
  #   # do something
  # }## IF ~ days_total < min_days ~ END

  # for calculations
  StratificationAnalysis <- NULL
  meandata <- NULL

  # Calc, Stratification ####
  Stratification <- NULL
  for (i in Dates){
    stratdate <- data[data[, col_date] == i, ]
    stratdate <- stratdate[!is.na(stratdate[, col_measure]), ]
    if (nrow(stratdate) > 1){
      strat <- diff(stratdate[, col_measure])/diff(stratdate$Depth)

      #Determine if depth range is stratified
      if (any(strat*-1 >= 1)){
        stratified <- TRUE
      }else{
        stratified <- FALSE
      }## IF ~ any ~ END
      singledate <- unique(stratdate[, col_date])
      stratrow <- data.frame("Date" = singledate, "stratified" = stratified)
      Stratification <- rbind(Stratification, stratrow)
    }## IF ~ nrow ~ END
  }## FOR ~ i ~ END
  Stratification <- Stratification[order(Stratification[, col_date]),]

  # Calc, Start/End Dates ####
  #Determine the Start and End dates of lake stratification
  stratrows <- as.numeric(nrow(Stratification))

  stratdates <- NULL
  if (min_days == 0){
    min_days <- 1
  }else{
    min_days <- min_days
  }## IF ~ min_days ~ END

  for (i in (min_days + 1):(stratrows - (min_days))){
    starttest <- NULL
    endtest <- NULL
    for (j in 1:min_days){
      startdaytest <- as.logical(Stratification[i, 2] == TRUE
                                 & Stratification[i-1, 2] == FALSE
                                 & Stratification[i+j, 2] == TRUE)
      startdayanalysis <- data.frame("min_days_level" = j
                                     , "starttest" = startdaytest)
      starttest <- rbind(starttest,startdayanalysis)

      enddaytest <- as.logical(Stratification[i, 2] == TRUE
                               & Stratification[i+1, 2] == FALSE
                               & Stratification[i-j, 2] == TRUE)
      enddayanalysis <- data.frame("min_days_level" = j
                                   ,"endtest" = enddaytest)
      endtest <- rbind(endtest,enddayanalysis)
    }## FOR ~ j ~ END
    if (all(starttest$starttest) == TRUE){
      stratdatesrowstart <- data.frame("Date" = Stratification[i, 1]
                                       ,"Event" = "Start")
      stratdates <- rbind(stratdates,stratdatesrowstart)
    }
    if (all(endtest$endtest) == TRUE){
      stratdatesrowend <- data.frame("Date" = Stratification[i, 1]
                                     ,"Event" = "End")
      stratdates <- rbind(stratdates,stratdatesrowend)
    }
  }## FOR ~ i ~ END

  if (!is.null(stratdates)){
    #Determine the number of days after stratification
    stratdates <- stratdates[order(stratdates[, col_date]), ]
    startdates <- stratdates[stratdates$Event == "Start", ]
    enddates <- stratdates[stratdates$Event == "End", ]
    if(nrow(startdates)>0){
      startdates["Seq"] <- seq(seq_len(nrow(startdates)))
    }
    if(nrow(enddates) > 0){
      if (stratdates[1, 2] == "Start"){
        enddates["Seq"] <- seq_len(nrow(enddates))
      }else{
        erows <- nrow(enddates) - 1
        enddates["Seq"] <- c(0:erows)
        startdatesnew <- data.frame("Date" = min(data[, col_date])
                                    , "Event" = "Start"
                                    , "Seq" = 0)
        startdates <- rbind(startdates,startdatesnew)
        startdates <- startdates[order(startdates$Seq), ]
      }
    }
    if (stratdates[nrow(stratdates), 2] == "Start"){
      srows <- as.numeric(nrow(stratdates[stratdates$Event == "Start", ]))
      enddatesnew <- data.frame("Date" = max(data[, col_date])
                                , "Event" = "End"
                                , "Seq" = srows)
      enddates <- rbind(enddates ,enddatesnew)
      enddates <- enddates[order(enddates$Seq), ]
    }
    stratspan <- NULL
    for (i in (0:nrow(startdates))){
      startstrat <- startdates[startdates$Seq == i, ]
      endstrat <- enddates[enddates$Seq == i, ]
      timespan <- difftime(startstrat[, col_date]
                           , endstrat[, col_date]
                           , units = "days")
      stratspanrow <- data.frame("Start_Date" = startstrat[, col_date]
                                 ,"End_Date" = endstrat[, col_date]
                            #,"Year" = lubridate::year(startstrat[, col_date])
                                 ,"Year" = format(startstrat[, col_date], "%Y")
                                 ,"Time_Span" = (timespan*-1))
      stratspan <- rbind(stratspan, stratspanrow)
      # message(paste("stratification calculated"))
    }## FOR ~ i ~ END
  }## IF ~ !is.null(stratdates) ~ END


  # QC ----
  # Error if all stratified some things not generated
  if(exists("stratspan") == FALSE){
    if(sum(Stratification$stratified) == nrow(Stratification)) {
      startstrat <- min(Stratification$Date)
      endstrat <- max(Stratification$Date)
      timespan <- difftime(startstrat
                           , endstrat
                           , units = "days")
      stratspan <- data.frame(Start_Date = startstrat
                              , End_Date = endstrat
                              , Year = format(startstrat, "%Y")
                              , Time_Span = abs(timespan))
    } else {
      stratspan <- data.frame(Start_Date = NA
                              , End_Date = NA
                              , Year = NA_character_
                              , Time_Span = NA)
    }## IF ~ sum == nrow
  }## IF ~ exists("stratspan")




  # stratificationdates not exported
  if(exists("startdates") ==  TRUE) {
    startdates["Date2"] <- startdates[, col_date]
    enddates["Date2"] <- enddates[, col_date]

    stratificationdates <- rbind(startdates, enddates)
    stratificationdates <- stratificationdates[order(stratificationdates[
      , col_date]), ]
  }## IF ~ exists("startdates")



  # ERIK ####
  # short cut rest of code and output this information

  # Results 1
  # Rename Stratification
  names(Stratification) <- c(col_date, paste0("Stratified_", min_days))

  # Results 2
  # reshape

  # Results 3, plot ----
  # plot, strat events
  df_plot <- stratspan

  # julian dates
  df_plot$Start_j <- as.numeric(format(df_plot$Start_Date, "%j"))
  df_plot$End_j <- as.numeric(format(df_plot$End_Date, "%j"))

  # Use a leap year (2004) to put julian dates in the same scale
  df_plot$Start_j2 <- as.Date(df_plot$Start_j
                                     , origin = as.Date("2004-01-01"))
  df_plot$End_j2 <- as.Date(df_plot$End_j
                                   , origin = as.Date("2004-01-01"))

  #
  p_se <- ggplot2::ggplot(data = df_plot
                          , ggplot2::aes(y = Year)) +
    ggplot2::scale_x_date(date_labels = "%b%d"
                          , limits = as.Date(c("2004-01-01", "2004-12-31"))
                          , date_breaks = "1 month"
                          , expand = c(0, 0)) +
    ggplot2::labs(x = "Date"
                  , y = "Year"
                  , title = "Stratification Events") +
    ggplot2::geom_segment(ggplot2::aes(x = Start_j2
                                       , xend = End_j2
                                       , y = Year
                                       , yend = Year)
                          , size = 3)
  # # segments
  # https://stackoverflow.com/questions/34124599/r-plot-julian-day-in-x-axis-using-ggplot2


  # Results, List
  list_results <- list(Stratification_Dates = Stratification
                      , Stratification_Events = stratspan
                      , Stratification_Plot = p_se)

  return(list_results)

}##FUNCTION ~ END

#
#
#
#   #This begins the calculation of the various Lake Analyzer metrics
#   #some of these calculations require a hypsometric curve for the lake,
#   # which consists of a table with Contour_Depth and Area fields
#
#   # Calc, Layers ####
#   if(is.null(df_hypso)){
#     # do nothing
#   } else {
#     layercalcs <- NULL
#     for (i in stratificationdates$Date2){
#       analysisdate <- data[data$Date == i,]
#       analysisdate <- analysisdate[!is.na(analysisdate[, col_measure]), ]
#
#       if (nrow(analysisdate) > 1){
#         #Read in hypsography data. Currently it is looking for a csv file for
# each Lake, named Lake_Hypso_Profile.csv
#         hypsodir <- paste0("D:/Users/timarti1/Desktop/"
# ,L,"_Hypso_Profile.csv")
#         hypso <- read.csv(hypsodir,header=TRUE)
#         hypso$Contour_Depth <- as.numeric(hypso$Contour_Depth)
#         hypso$Area <- as.numeric(hypso$Area)
#         hypso <- hypso[order(hypso$Contour_Depth), ]
#
#         thermo <- thermo.depth(wtr = analysisdate[, col_measure]
#                                ,depths = analysisdate$Depth)
#         print(paste(L, i, "thermocline depth calculated:", thermo))
#         meta <- meta.depths(wtr = analysisdate[, col_measure]
#                             , depths = analysisdate$Depth)
#         print(paste(L,i,"metalimnion depth calculated:", meta[1], meta[2]))
#         epitemp <- epi.temperature(wtr = analysisdate[, col_measure]
#                                    , depths = analysisdate$Depth
#                                    , bthA = hypso$Area
#                                    , bthD = hypso$Contour_Depth)
#         print(paste(L,i,"epilmnion temp calculated:", epitemp))
#         hypotemp <- hypo.temperature(wtr = analysisdate[, col_measure]
#                                      , depths = analysisdate$Depth
#                                      , bthA = hypso$Area
#                                      , bthD = hypso$Contour_Depth)
#         print(paste(L,i,"hypolmnion temp calculated:",hypotemp))
#         schmidt <- schmidt.stability(wtr = analysisdate[, col_measure]
#                                      , depths = analysisdate$Depth
#                                      , bthA = hypso$Area
#                                      , bthD = hypso$Contour_Depth)
#         print(paste(L,i,"schmidt stability calculated:",schmidt))
#         centbuoy <- center.buoyancy(wtr=analysisdate[, col_measure]
#                                     , depths = analysisdate$Depth)
#         print(paste(L, i, "center buoyancy calculated:", centbuoy))
#         layercalcsrow <- data.frame("Lake" = L
#                                     , "Date" = unique(analysisdate$Date)
#                                     , "Year" = year(analysisdate$Date)
#                                     , "Epi_Temp" = epitemp
#                                     , "Hypo_Temp" = hypotemp,"Thermo_Depth"=
# thermo
#                                     , "Meta_Top_Depth" = meta[1]
#                                     , "Meta_Bottom_Depth" = meta[2]
#                                     , "Schmidt" = schmidt
#                                     , "Center_Buoy" = centbuoy)
#
#         layercalcs <- rbind(layercalcs,layercalcsrow)
#       }
#     }## FOR ~ i ~ END
#     combined <- NULL
#     combined <- left_join(layercalcs, stratspan)
#     StratificationAnalysis <- rbind(StratificationAnalysis, combined)
#     StratificationAnalysis <- StratificationAnalysis[!duplicated(
# StratificationAnalysis$Date), ]
#
#   }## IF ~ is.null(hypso) ~ END
#
#   # Calc, Lake Date ####
#   lakedata <- NULL
#   lakedates <- unique(data$Date)
#   for (i in lakedates){
#     lakedate <- data[data$Date==i, ]
#     message(paste("Calculating data for", lakedate$Date))
#     lakedate <- lakedate[!is.na(lakedate[, col_measure]), ]
#     if (nrow(lakedate) > 1){
#       thermocalc <- thermo.depth(wtr = lakedate[, col_measure]
#                                  , depths = lakedate$Depth)
#       metacalc <- meta.depths(wtr = lakedate[, col_measure]
#                               , depths = lakedate$Depth)
#       epitempcalc <- epi.temperature(wtr = lakedate[, col_measure]
#                                      , depths = lakedate$Depth
#                                      , bthA = hypso$Area
#                                      , bthD = hypso$Contour_Depth)
#       hypotempcalc <- hypo.temperature(wtr = lakedate[, col_measure]
#                                        , depths = lakedate$Depth
#                                        , bthA = hypso$Area
#                                        , bthD = hypso$Contour_Depth)
#       schmidtcalc <- schmidt.stability(wtr = lakedate[, col_measure]
#                                        , depths = lakedate$Depth
#                                        , bthA = hypso$Area
#                                        , bthD = hypso$Contour_Depth)
#       centbuoycalc <- center.buoyancy(wtr = lakedate[, col_measure]
#                                       , depths = lakedate$Depth)
#       #centbuoycalc <- NA
#       if (!is.na(thermocalc) & !is.na(metacalc[1])){
#         if (thermocalc==metacalc[1] | metacalc[1] == metacalc[2]){
#           metacalc[1] <- NA
#           metacalc[2] <- NA
#         }
#       }
#
#       lakedatarow <- data.frame("Date" = lakedate$Date
#                                 , "Year" = year(lakedate$Date)
#                                 , "Thermo" = thermocalc
#                                 , "Meta_Top" = metacalc[1]
#                                 , "Meta_Bottom" = metacalc[2]
#                                 , "Epi_Temp" = epitempcalc
#                                 , "Hypo_Temp" = hypotempcalc
#                                 , "Schmidt" = schmidtcalc
#                                 , "Central_Buoy"=centbuoycalc)
#       lakedata <- rbind(lakedata,lakedatarow)
#     }
#   }
#
#   # Calc, Lake Means ####
#   lakemeans <- NULL
#   lakeyears <- unique(lakedata$Year)
#   for (j in lakeyears){
#     message(paste("Calculating means for", L, j))
#     lakeyear <- lakedata[lakedata$Year == j, ]
#
#     yearthermo <- lakeyear[!is.na(lakeyear$Thermo),]
#     meanthermo <- mean(yearthermo$Thermo)
#
#     yearmeta <- yearthermo[!is.na(yearthermo$Meta_Bottom),]
#     meanmetatop <- mean(yearmeta$Meta_Top)
#     meanmetabottom <- mean(yearmeta$Meta_Bottom)
#
#     yearepi <- lakeyear[!is.na(lakeyear$Epi_Temp),]
#     meanepi <- mean(yearepi$Epi_Temp)
#
#     yearhypo <- lakeyear[!is.na(lakeyear$Hypo_Temp),]
#     meanhypo <- mean(yearhypo$Hypo_Temp)
#
#     yearschmidt <- lakeyear[!is.na(lakeyear$Schmidt),]
#     meanschmidt <- mean(yearschmidt$Schmidt)
#
#     yearcentbuoy <- lakeyear[!is.na(lakeyear$Central_Buoy),]
#     meancentbuoy <- mean(yearcentbuoy$Central_Buoy)
#
#     lakemeansrow <- data.frame("Lake" = L
#                                , "Year" = j
#                                , "Mean_Thermo" = meanthermo
#                                , "Mean_Meta_Top" = meanmetatop
#                                , "Mean_Meta_Bottom" = meanmetabottom
#                                , "Mean_Epi_Temp" = meanepi
#                                , "Mean_Hypo_Temp" = meanhypo
#                                , "Mean_Schmidt" = meanschmidt
#                                , "Mean_Central_Buoy" = meancentbuoy)
#     lakemeans <- rbind(lakemeans, lakemeansrow)
#
#   }## FOR ~ j ~ END
#
#
#   # in L loop
#   meandata <- rbind(meandata, lakemeans)
#
#   StratificationAnalysis$Start_Date <- NULL
#   StratificationAnalysis$End_Date <- NULL
#   StratificationAnalysis <- left_join(StratificationAnalysis, meandata,by =
# c("Lake","Year"))
#
#   # RETURN ####
#   #Change output location
#   #write.csv(StratificationAnalysis
# ,"D:/Users/timarti1/Desktop/Sparkling_Calc.csv",row.names = F)
#   return(StratificationAnalysis)
#
#
#
# }## FUNCTION ~ END
