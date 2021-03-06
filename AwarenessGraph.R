AwarenessGraph = function(data){
  ##Function that will graph the change of the brand attraction over time
  #Time divided in days
  
  #libraries
  data <- read.csv(file.choose())
  
  library(dplyr)
  library(data.table)
  
  #vector of unique dates
  vUniqueDates = as.vector(unique(substr(data$id_date, 1, 10)))
  #how many unique dates (int)
  iNoUniqueDates = length(vUniqueDates)

  iCount <- vector()
  for (i in 1:iNoUniqueDates){
    #count number of times each specific date appears
    iCount[i] = sum(substr(data$id_date, 1, 10)==vUniqueDates[i]) 
  }
  #take only the dates, not the time
  data$id_date <- substr(data$id_date, 1, 10)
  
  
  #Checking for Media Consumption trends (daily)
  ##'Digital Audio'###########################################################
  #sum 'Digital Audio' by date
  dSumOfDigAudio <- aggregate(data$mc_digitalaudio_all, by=list(Date=data$id_date), FUN=sum)
  dSumOfDigAudio = dSumOfDigAudio[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumDigAudio= dSumOfDigAudio/iCount
  #create df with the specific dates and weighted sums
  dfDataDigAud = data.frame(vUniqueDates, dWeightedSumDigAudio)
  dfDataDigAud$vUniqueDates = as.Date(dfDataDigAud$vUniqueDates)
  
  #plotting the mc_digital_audio_all versus time
  plot(dfDataDigAud, main = 'Weighted sum of mc_digital_audio_all versus time', 
       xlab = 'Survey (2019)', ylab = 'Weighted sum' )  #plot shows 3 outliers which makes the rest of the plot unreadable
  
  #remove outliers of the weighted sum of the mc_digital_audio_all rows and plot again
  dfDataDigAud <- dfDataDigAud[dfDataDigAud$x<200,]
  plot(dfDataDigAud, main = 'Weighted sum of mc_digitalaudio_all versus time', 
       xlab = 'Survey (2019)', ylab = 'Weighted sum' ) 
  
  ##'Online Display'###########################################################
  #sum 'Online Display' by date
  dSumOfOnlDisp <- aggregate(data$mc_onlinedisplay_all, by=list(Date=data$id_date), FUN=sum)
  dSumOfOnlDisp = dSumOfOnlDisp[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumOnlDisp = dSumOfOnlDisp/iCount
  #create df with the specific dates and weighted sums
  dfDataOnlDisp = data.frame(vUniqueDates, dWeightedSumOnlDisp)
  dfDataOnlDisp$vUniqueDates = as.Date(dfDataOnlDisp$vUniqueDates)
  
  #plotting the mc_digital_audio_all versus time
  plot(dfDataOnlDisp, main = 'Weighted sum of mc_onlinedisplay_all versus time', 
       xlab = 'Survey (2019)', ylab = 'Weighted sum' )  
  #plot shows 3 outliers which makes the rest of the plot unreadable
  
  #remove outliers of the weighted sum of the mc_onlinedisplay_all rows and plot again
  dfDataOnlDisp <- dfDataOnlDisp[dfDataOnlDisp$x<200,]
  plot(dfDataOnlDisp, main = 'Weighted sum of mc_onlinedisplay_all versus time', 
       xlab = 'Survey (2019)', ylab = 'Weighted sum') 
  
  ##'TV NBC'###########################################################
  #This variable is chosen because it has least zero-values
  #therefore might have more information
  #sum 'Online Display' by date
  dSumOfTvNBC <- aggregate(data$mc_tv_nbc, by=list(Date=data$id_date), FUN=sum)
  dSumOfTvNBC  = dSumOfTvNBC [2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumTvNBC  = dSumOfTvNBC /iCount
  #create df with the specific dates and weighted sums
  dfDataTvNBC  = data.frame(vUniqueDates, dWeightedSumTvNBC)
  dfDataTvNBC$vUniqueDates = as.Date(dfDataTvNBC$vUniqueDates)
  
  #plotting the mc_tv_nbc versus time
  plot(dfDataTvNBC, main = 'Weighted sum of mc_tv_nbc versus time', 
       xlab = 'Survey (2019)', ylab = 'Weighted sum' )  
  #plot shows 2 outliers which makes the rest of the plot unreadable
  
  #remove outliers of the weighted sum of the mc_onlinedisplay_all rows and plot again
  dfDataTvNBC <- dfDataTvNBC[dfDataTvNBC$x<10,]
  plot(dfDataTvNBC, main = 'Weighted sum of mc_tv_nbc versus time', 
       xlab = 'Survey (2019)', ylab = 'Weighted sum') 
  
  
  
  
  
  #Checking for KPI trends
  
  #Checking for KPI trends
  
  
  ##Checking for contact
  
  ##Checking for KPI Trends (daily)####
  ##'KPI Familiarity'#################################################
  #sum 'kpi_familiarity' by date
  dSumOfKpiFam <- aggregate(data$kpi_familiarity, by=list(Date=data$id_date), FUN=sum)
  dSumOfKpiFam = dSumOfKpiFam[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumKpiFam  = dSumOfKpiFam /iCount
  #*100 to get percentage because kpi_familiarity is binary
  dPercentageKpiFam = dWeightedSumKpiFam * 100
  
  #create df with the specific dates and percentages
  dfDataKpiFam  = data.frame(vUniqueDates, dPercentageKpiFam)
  dfDataKpiFam$vUniqueDates = as.Date(dfDataKpiFam$vUniqueDates)
  
  # #plotting the mc_tv_nbc versus time
  # plot(dfDataKpiFam, main = 'Percentage of KPI_familiarity versus time', 
  #      xlab = 'Survey (2019)', ylab = 'Percentage' )  
  # remove outliers of the weighted sum of the mc_onlinedisplay_all rows and plot again
  dfDataKpiFam <- dfDataKpiFam[dfDataKpiFam$x<100,]
  plot(dfDataKpiFam, main = 'Percentage of KPI_familiarity of versus time',
       xlab = 'Survey (2019)', ylab = 'Percentage')
  
  
  ##'KPI Awareness'#################################################
  #sum 'kpi_awareness' by date
  dSumOfKpiAwa <- aggregate(data$kpi_awareness, by=list(Date=data$id_date), FUN=sum)
  dSumOfKpiAwa = dSumOfKpiAwa[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumKpiAwa  = dSumOfKpiAwa /iCount
  #*100 to get percentage because kpi's are binary
  dPercentageKpiAwa = dWeightedSumKpiAwa * 100
  
  #create df with the specific dates and percentages
  dfDataKpiAwa = data.frame(vUniqueDates, dPercentageKpiAwa)
  dfDataKpiAwa$vUniqueDates = as.Date(dfDataKpiAwa$vUniqueDates)
  
  #plotting the mc_tv_nbc versus time
  plot(dfDataKpiAwa, main = 'Percentage of KPI_awareness versus time', 
       xlab = 'Survey (2019)', ylab = 'Percentage' ) 
  dfDataKpiAwa <- dfDataKpiAwa[dfDataKpiAwa$x<100,]
  plot(dfDataKpiAwa, main = 'Percentage of KPI_awareness versus time', 
       xlab = 'Survey (2019)', ylab = 'Percentage') 
  
  
  
  
  #(Downside outliers??)
  
  ##'KPI Consideration'#############################################
  #sum 'kpi_awareness' by date
  dSumOfKpiCon <- aggregate(data$kpi_consideration, by=list(Date=data$id_date), FUN=sum)
  dSumOfKpiCon = dSumOfKpiCon[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumKpiCon  = dSumOfKpiCon /iCount
  #*100 to get percentage because kpi's are binary
  dPercentageKpiCon = dWeightedSumKpiCon * 100
  
  #create df with the specific dates and percentages
  dfDataKpiCon = data.frame(vUniqueDates, dPercentageKpiCon)
  dfDataKpiCon$vUniqueDates = as.Date(dfDataKpiCon$vUniqueDates)
  
  # #plotting the mc_tv_nbc versus time
  # plot(dfDataKpiCon, main = 'Percentage of KPI_consideration versus time', 
  #      xlab = 'Survey (2019)', ylab = 'Percentage' ) 
  # 
  #remove outliers of the weighted sum of the mc_onlinedisplay_all rows and plot again
  dfDataKpiCon <- dfDataKpiCon[dfDataKpiCon$x<100,]
  plot(dfDataKpiCon, main = 'Percentage of KPI_consideration of versus time (outliers removed)',
       xlab = 'Survey (2019)', ylab = 'Percentage')
  
  #(Down and upside outliers??)
  
  ##Checking for KPI Trends (weekly)####
  
  #devide the time in weeks
  #vector of unique weeknumbers
  vUniqueWeeks <- as.vector(unique(week(data$id_date)))
  #how many unique weeks (int)
  iNoUniqueWeeks = length(vUniqueWeeks)
  
  data$id_week = week(data$id_date)
  iCountWeeks <- vector()
  for (i in 1:iNoUniqueWeeks){
    #count number of times each specific week appears
    iCountWeeks[i] = sum(data$id_week==vUniqueWeeks[i]) 
  }
  

  
  
  ##'KPI Familiarity'#################################################################
  #sum 'kpi_familiarity' by date
  dSumOfKpiFam <- aggregate(data$kpi_familiarity, by=list(Date=data$id_week), FUN=sum)
  dSumOfKpiFam = dSumOfKpiFam[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumKpiFam  = dSumOfKpiFam /iCountWeeks
  #*100 to get percentage because kpi_familiarity is binary
  dPercentageKpiFam = dWeightedSumKpiFam * 100
  
  #create df with the specific dates and percentages
  dfDataKpiFam  = data.frame(vUniqueWeeks, dPercentageKpiFam)
  
  #plotting the mc_tv_nbc versus time
  plot(dfDataKpiFam, main = 'Survey: Percentage of KPI_familiarity versus time', 
       xlab = 'Week number of 2019', ylab = 'Percentage' )  
  
  ##'KPI Awareness'##################################################################
  #sum 'kpi_awareness' by date
  dSumOfKpiAwa <- aggregate(data$kpi_awareness, by=list(Date=data$id_week), FUN=sum)
  dSumOfKpiAwa = dSumOfKpiAwa[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumKpiAwa  = dSumOfKpiAwa /iCountWeeks
  #*100 to get percentage because kpi's are binary
  dPercentageKpiAwa = dWeightedSumKpiAwa * 100
  
  #create df with the specific dates and percentages
  dfDataKpiAwa = data.frame(vUniqueWeeks, dPercentageKpiAwa)

  #plotting the mc_tv_nbc versus time
  plot(dfDataKpiAwa, main = 'Survey: Percentage of KPI_awareness versus time', 
       xlab = 'Week number of 2019', ylab = 'Percentage' )  
  
  ##'KPI Consideration'#################################################################
  #sum 'kpi_awareness' by date
  dSumOfKpiCon <- aggregate(data$kpi_consideration, by=list(Date=data$id_week), FUN=sum)
  dSumOfKpiCon = dSumOfKpiCon[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumKpiCon  = dSumOfKpiCon /iCountWeeks
  #*100 to get percentage because kpi's are binary
  dPercentageKpiCon = dWeightedSumKpiCon * 100
  
  #create df with the specific dates and percentages
  dfDataKpiCon = data.frame(vUniqueWeeks, dPercentageKpiCon)

  #plotting the mc_tv_nbc versus time
  plot(dfDataKpiCon, main = 'Survey: Percentage of KPI_consideration versus time', 
       xlab = 'Week number of 2019', ylab = 'Percentage' ) 
  
  
  
  
  
  ##Checking for Media trends (Weekly) ####
  ##'Digital Audio'###########################################################
  #sum 'Digital Audio' by week
  dSumOfDigAudio <- aggregate(data$mc_digitalaudio_all, by=list(Date=data$id_week), FUN=sum)
  dSumOfDigAudio = dSumOfDigAudio[2]
  
  #weight the sum over number of obs's in group (week)
  dWeightedSumDigAudio= dSumOfDigAudio/iCountWeeks
  #create df with the specific weeks and weighted sums
  dfDataDigAud = data.frame(vUniqueWeeks, dWeightedSumDigAudio)
  
  #plotting the mc_digital_audio_all versus time
  plot(dfDataDigAud, main = 'Weighted sum of mc_digital_audio_all versus time (weeks)', 
       xlab = 'Week number of 2019', ylab = 'Weighted sum' )  
  
  ##'Online Display'###########################################################
  #sum 'Online Display' by date
  dSumOfOnlDisp <- aggregate(data$mc_onlinedisplay_all, by=list(Date=data$id_week), FUN=sum)
  dSumOfOnlDisp = dSumOfOnlDisp[2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumOnlDisp = dSumOfOnlDisp/iCountWeeks
  #create df with the specific dates and weighted sums
  dfDataOnlDisp = data.frame(vUniqueWeeks, dWeightedSumOnlDisp)
  
  #plotting the mc_digital_audio_all versus time
  plot(dfDataOnlDisp, main = 'Weighted sum of mc_onlinedisplay_all versus time (weeks)', 
       xlab = 'Week number of 2019', ylab = 'Weighted sum' )  
  
  ##'TV NBC'###########################################################
  #This variable is chosen because it has least zero-values
  #therefore might have more information
  #sum 'Online Display' by date
  dSumOfTvNBC <- aggregate(data$mc_tv_nbc, by=list(Date=data$id_week), FUN=sum)
  dSumOfTvNBC  = dSumOfTvNBC [2]
  
  #weight the sum over number of obs's in group (date)
  dWeightedSumTvNBC  = dSumOfTvNBC /iCountWeeks
  #create df with the specific dates and weighted sums
  dfDataTvNBC  = data.frame(vUniqueWeeks, dWeightedSumTvNBC)
  
  #plotting the mc_tv_nbc versus time
  plot(dfDataTvNBC, main = 'Weighted sum of mc_tv_nbc versus time (weeks)', 
       xlab = 'Week number of 2019', ylab = 'Weighted sum' )  
 
   
  dfDataKPI = data.frame(vUniqueWeeks, x1 = dfDataKpiFam$x ,x2= dfDataKpiAwa$x, x3 = dfDataKpiCon$x)
  
  library(ggplot2)
  library(gridExtra)
  library(grid)
  plot <- ggplot(dfDataKPI, aes(x=vUniqueWeeks, y=x1)) +                    # basic graphical object
    geom_point(aes(y=dfDataKpiFam$x), colour="palegreen3", size=2, fill=dfDataKPI$x1) + # first layer
    geom_point(aes(y=dfDataKpiAwa$x), colour="coral1", shape=18, size =3) +  # second layer
    geom_point(aes(y=dfDataKpiCon$x), colour="royalblue2", shape= 17, size=2) +# third layer
    ylab("KPI Percentage") + xlab("Week number of 2019")+
    theme_bw()
  plot
  
  
  
}