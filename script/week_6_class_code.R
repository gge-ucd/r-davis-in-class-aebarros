library(tidyverse)

####finishing up data cleaning ====================
#creating the dataframe for working with ggplot
surveys<-read_csv("data/portal_data_joined.csv")

#our goal today is to create a plot showing how species abundances change through time
#so we want no NAs in weight, hindfood_length, sex
#remove rare species (those seen less than 50 times)

#removing all the NAs from weight, hindfoot_length, and sex
surveys_clean<- surveys %>%
  filter(!is.na(weight),!is.na(hindfoot_length),!is.na(sex)) #can use commas instead of lots of piping

#remove rare species (those seen less than 50 times)
species_counts<-surveys_clean %>% 
  group_by(species_id) %>% 
  tally() %>% 
  filter(n>50) #after R uses tally, it creates a new column called "n" that we use here
#now filter surveys_clean by those 14 species in species_count df
surveys_clean<-surveys_clean %>% 
  filter(species_id %in% species_counts$species_id)

#writing dataframe to a .csv
write_csv(surveys_clean, "dataoutput/surveys_clean_week6.csv")


####GGPLOT WORK===================================
# Tue Feb 12 14:31:22 2019 ------------------------------ (made using ts+tab)

#ggplot(data= DATA, mapping= aes(what is the x and y)) + GEOM_FUNCTION()

ggplot(data=surveys_clean) #gives a blank plot
surveys_plot<-ggplot(data=surveys_clean, aes(x=weight, y=hindfoot_length)) #we have mapped x and y-axis onto plot
ggplot(data=surveys_clean, aes(x=weight, y=hindfoot_length))+ #now we have actually plotted points
  geom_point()

#we have saved the canvas as surveys_plot, and we can add to it
surveys_plot+geom_point()

#challenge 1
surveys_plot+
  geom_hex() #this adds some interesting features

#building plots from the ground up
ggplot(surveys_clean, aes(x=weight, y=hindfoot_length))+
  geom_point(alpha=0.1) #changing transparency

ggplot(surveys_clean, aes(x=weight, y=hindfoot_length))+
  geom_point(alpha=0.1, color="tomato") #change point color to tomato

ggplot(surveys_clean, aes(x=weight, y=hindfoot_length))+
  geom_point(alpha=0.1, aes(color=species_id)) #colored points based on species_id (aes = aesthetic options)

ggplot(surveys_clean, aes(x=weight, y=hindfoot_length, color=species_id))+ #here we have applied color as a global aesthetic
  geom_point(alpha=0.1)

ggplot(surveys_clean, aes(x=weight, y=hindfoot_length, color=species_id))+
  geom_jitter(alpha=0.1) #even though we have changed the geom function, color is still based off of species_id because it was assigned in top row

#challenge 2
ggplot(surveys_clean, aes(x=species_id, y=weight, color=species_id))+ #this could probably be done better in box plots
  geom_point()

#box plots
ggplot(surveys_clean,aes(x=species_id,y=weight))+
  geom_boxplot()

#adding points to box plot
ggplot(surveys_clean,aes(x=species_id,y=weight))+
  geom_jitter(alpha=0.3,aes(color="tomato"))+
  geom_boxplot(alpha=0.0)

####Plotting time series=================

yearly_counts<-surveys_clean %>% 
  count(year, species_id) # a quick way to group_by and tally
yearly_counts %>% 
  ggplot(aes(x=year,y=n,group=species_id,color=species_id))+ #make sure to have group= to group up the line
  geom_line()

#Facetting
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)

#faceting with color for sex
yearly_sex_counts<-surveys_clean%>%
  count(year,species_id,sex)
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n,color=sex)) +
  geom_line() +
  facet_wrap(~ species_id)

ysx_plot<-ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n,color=sex)) +
  geom_line() +
  facet_wrap(~ species_id)+
  theme_bw() + #these two calls change the theme to black and white
  theme(panel.grid = element_blank()) #and make the background clear
ysx_plot+theme_minimal()

#challenge 3
#create plot of how average weight of each species changes over years
yearly_avg_weight<-surveys_clean%>%
  group_by(species_id,year,sex) %>% 
  summarise(avg_weight=mean(weight))

yearly_avg_weight %>% 
  ggplot(aes(x=year,y=avg_weight,color=species_id))+
  geom_line()+
  facet_grid(sex~.)+
  theme_bw()


