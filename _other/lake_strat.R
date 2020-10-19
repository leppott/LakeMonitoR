#' @title Lake Stratification
#' 
#' @description Calculates daily means from depth profile data
#' 
#' @details Interpolates at integer depths.
#' Daily means with interpolation.
#' 
#' 
#' @param df data frame of (list columns)
#' @param col_depth Column name for depth
#' @param col_msr Column name for measurement for calculation
#' @param col_keep Column names to keep in the output.
#' 
#' @example 
#' #Import Lake Data
#' filelocation=paste(directory,"/",Lake_Name,".csv",sep="")
#' Laketemp=read.csv(filelocation,header=T)
#' 
#' #Filter by any QC fields
#' Laketemp=Laketemp[(Laketemp$FlagV=='P'),]
#' 
#' 
#' @export
depth_means <- function(df, col_depth, col_msr, ){
  
  #Find the maximum and minimum depths in the dataset and round them to the nearest whole number
  #Create a list with each whole number in between those two numbers (including the max and min)
  MaxDepth=round(max(df$Depth_m),digits=0)
  MinDepth=round(min(df$Depth_m),digits=0)
  Standard_Depths=c(MinDepth:MaxDepth)
  
  #Format Date Field to UNIX time
  df$Date_Time=as.POSIXct(df$Date_Time,format="%m/%d/%Y %H:%M",tz="GMT")
  
  #Get the list of depths in the dataset
  laketempdepths=as.list(sort(unique(df$Depth_m)))
  #Create empty variable for data frame
  meandepths=NULL
  
  #Calculate daily mean temps
  for (i in laketempdepths){
    depth=subset(df, df$Depth_m==i)
    #this creates an xts time series. The inputs will be the temperature and date/time fields
    #as.xts(Temperature,Date_Time)
    depth.xts=xts::as.xts(depth[,3],order.by=as.Date(depth[,2], format='%Y-%m-%d %H:%M'))
    depth.mean.xts=apply.daily(depth.xts,mean)
    depthmean=data.frame("datetime"=index(depth.mean.xts),"Depth"=i,"Temp"=coredata(depth.mean.xts))
    meandepths=rbind(meandepths,depthmean)
  }
  
  #Get the list of dates in the new mean date data frame
  meandays=unique(meandepths$datetime)
  Standardized.temp.data=NULL
  
  #This interpolates the temperatures using the whole number depth list created earlier for each date
  for (j in meandays){
    Daysubset=meandepths[meandepths$datetime==j,]
    rowcount=as.numeric(nrow(Daysubset))
    if (rowcount>1){
      interpolated=approx(Daysubset$Depth,Daysubset$Temp,method="linear",xout=Standard_Depths)
      Standardized.row=data.frame("datetime"=unique(Daysubset$datetime),"Depth"=interpolated$x,"Temperature"=interpolated$y)
      
    }else{
      Standardized.row=data.frame("datetime"=unique(Daysubset$datetime),"Depth"=round(Daysubset$Depth,digits=0),"Temperature"=Daysubset$Temp)
    }
    Standardized.temp.data=rbind(Standardized.temp.data,Standardized.row)
  }
  Standardized.temp.data$datetime=as.Date(Standardized.temp.data$datetime)
  Standardized.temp.data=Standardized.temp.data[order(Standardized.temp.data$datetime),]
  
  
  
  
}## FUNCTION ~ END

library(rLakeAnalyzer)
library(lubridate)
library(readxl)
library(plyr)
library(dplyr)
library(xts)


#Remove any unneccessary fields
Laketemp$ID=NULL
Laketemp$DOWLKNUM=NULL
Laketemp$FlagG=NULL
Laketemp$FlagS=NULL
Laketemp$FlagR=NULL
Laketemp$FlagF=NULL
Laketemp$FlagV=NULL

# specify fields to keep



#Export the csv
write.csv(Standardized.temp.data,paste0(directory,"/",Lake_Name,"_interpolated.csv"),row.names=F)











