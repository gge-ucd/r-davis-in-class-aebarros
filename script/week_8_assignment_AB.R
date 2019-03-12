library(tidyverse)
library(lubridate)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

#should have a data frame with 35,038 obs of 5 variables
str(am_riv)
am_riv$date_time<-paste(am_riv$Date," ",am_riv$Time,sep="")
am_riv$date_time<-ymd_hms(am_riv$date_time,tz="America/Los_Angeles") #warning, 4 failed to parse?
str(am_riv)

#plot weekly mean, max, and min for water temp
am_riv_weekly_temp<-am_riv%>%
  group_by(week=week(date_time))%>%
  summarise(weekly_min=min(Temperature),weekly_max=max(Temperature),weekly_avg=mean(Temperature))
str(am_riv_weekly_temp)
ggplot(data=am_riv_weekly_temp,aes(x=week))+
  geom_point(aes(y=weekly_min,color="red"))+
  geom_point(aes(y=weekly_max,color="blue"))+
  geom_point(aes(y=weekly_avg,color="green")) #how do I change names on the legend?

#calculate hourly mean level for April through June and make a line plot
am_riv_hourly_level<-am_riv%>%
  filter(month(date_time)>3)%>%
  filter(month(date_time)<7)%>%
  group_by(Date,hour=hour(date_time))%>%
  summarise(hourly_mean_level=mean(Level))
am_riv_hourly_level$date_hour<-paste(am_riv_hourly_level$Date," ",am_riv_hourly_level$hour,sep="")
am_riv_hourly_level$date_hour<-ymd_h(am_riv_hourly_level$date_hour)
ggplot(data=am_riv_hourly_level, aes(x=date_hour,y=hourly_mean_level))+
  geom_line()

#Part 2
load("data/mauna_loa_met_2001_minute.rda")

mloa_2001$datetime<-paste0(mloa_2001$year,"-",mloa_2001$month,"-",mloa_2001$day," ",mloa_2001$hour24,":",mloa_2001$min)
mloa_2001$datetime<-ymd_hm(mloa_2001$datetime)

mloa_2001<-mloa_2001%>%
  filter(rel_humid!=-99)%>%
  filter(temp_C_2m!=-99)%>%
  filter(windSpeed_m_s!=-99)%>%
  filter(rel_humid!=-999)%>%
  filter(temp_C_2m!=-999)%>%
  filter(windSpeed_m_s!=-999)

plot_temp<-function(m=0){
  mloa_2001_month<-mloa_2001%>%
    filter(month==m)
  plot<-ggplot(data=mloa_2001_month,aes(x=datetime,y=temp_C_2m))+
    geom_point()
  return(plot)
}  
plot_temp(2)
