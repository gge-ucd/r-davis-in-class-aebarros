library(tidyverse)
library(lubridate)
load("data/mauna_loa_met_2001_minute.rda")

as.Date("02-01-1998",format="%m/-%d-%Y") #we went over dates last session
mdy("02-01-1998") #lubridate shortcut!

tm1<-as.POSIXct("2016-07-24 23:55:26 PDT") #useful way of setting up date times
tm1

tm2<-as.POSIXct("25072016 08:32:07", format="%d%m%Y %H:%M:%S") #use the format call to tell R whats up if the date is formated weird
tm2

tm3<-as.POSIXct("2010-12-01 11:42:03", tz= "GMT") #tz call assigns time zone
tm3

tm4<-as.POSIXct(strptime("2016/04/04 14:47",format="%Y/%m/%d %H:%M"),tz="America/Los_Angeles") #for specifying time zone and date format
tz(tm4) #tells us the timezone of tm4

#do the same thing with lubridate

ymd_hms("2016/04/04 14:47:16", tz= "America/Los_Angeles")
ymd_hms("2016-05-4 22:14:11")

nfy<-read_csv("data/2015_NFY_solinst.csv", skip=12)
#using lubridate on this dataframe
nfy2<-read_csv("data/2015_NFY_solinst.csv", skip=12, col_types="ccidd") #typed in first letter of each data type we want for the first columns
nfy2

#pasting the date and time columns together
nfy2$datetime<-paste(nfy2$Date," ",nfy2$Time,sep="") #the quotes sepearte the strings by a space
#but now we want to change datetime from a character into the proper datetime format
nfy2$datetime<-ymd_hms(nfy2$datetime,tz="America/Los_Angeles")

#CHALLENGE!#!

summary(mloa_2001)
#need to join up everything in a datetime column
mloa_2001$datetime<-paste0(mloa_2001$year,"-",mloa_2001$month,"-",mloa_2001$day," ",mloa_2001$hour24,":",mloa_2001$min)
mloa_2001$datetime<-ymd_hm(mloa_2001$datetime)

mloa_2001_monthly_temp<-mloa_2001%>%
  filter(rel_humid!=-99.9)%>%
  filter(temp_C_2m!=-99.9)%>%
  filter(windSpeed_m_s!=-99.9)%>%
  filter(rel_humid!=-999.9)%>%
  filter(temp_C_2m!=-999.9)%>%
  filter(windSpeed_m_s!=-999.9)%>%
  group_by(month=month(datetime))%>%
  summarise(month_avg_temp=mean(temp_C_2m))
ggplot(data=mloa_2001_monthly_temp,aes(x=month,y=month_avg_temp))+
  geom_point()
mloa_2001_july<-mloa_2001%>%
  filter(rel_humid!=-99.9)%>%
  filter(temp_C_2m!=-99.9)%>%
  filter(windSpeed_m_s!=-99.9)%>%
  filter(rel_humid!=-999.9)%>%
  filter(temp_C_2m!=-999.9)%>%
  filter(windSpeed_m_s!=-999.9)%>%
  group_by(day=day(datetime))%>%
  summarise(day_avg_temp=mean(temp_C_2m))
ggplot(data=mloa_2001_july,aes(x=day,y=day_avg_temp))+
  geom_point()



#FUN-CTIONS### any operation you want to perform more than once

log(5)

my_sum<-function(a=1,b=2){ #this creates the function, can assign default values
  sum<-a + b
  return(sum)
}
my_sum(3,7) #this is using the funcion for 3 and 7 for a and b respectivly
my_sum() #this runs with defaut values
my_sum(b=5) #this runs and overwrites the default for b

kelvin_to_celsius<-function(a=0){
 celsius<-a-273.15
 return(celsius)
}
kelvin_to_celsius(500)


#For LOOPS!!
#ITERATION
x<-1:10
log(x)

for(i in 1:10){
  print(i)
  print(i^2)
}

for(i in 1:10){
  print(letters[i])
  print(mtcars$wt[i])
}

#can store results from the for loop in a vector made ahead of time

results<-rep(NA,10)
for(i in 1:10){
  results[i]<-letters[i]
}
