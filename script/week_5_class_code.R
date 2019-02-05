#week 5 code

#install.packages("tidyverse")
library(tidyverse)

surveys<-read_csv("data/portal_data_joined.csv") #reads in the csv as a tibble_df as opposed to a dataframe

str(surveys)

#####dplyr functions

#'select' is used when we want to select columns
select(surveys, plot_id,species_id,weight)

#filter is used for selecting rows
filter(surveys, year==1995)

surveys2<-filter(surveys, weight < 5)
surveys_sml<-select(surveys2, species_id,sex,weight)

#pipes are the best and can be inserted with control-shift-M
surveys_sml2<-surveys %>%
  filter(weight<5) %>% 
  select(species_id,sex,weight)

#challenge! subset surveys for individuals collected before 1995, and only have columns year, sex and weight
surveys_challenge<-surveys%>%
  filter(year<1995) %>% 
  select(year,sex,weight)

#mutate (in this example we want to change weight from grams to kilograms)
surveys<-surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2=weight_kg*2)

#filter out NA values
surveys<-surveys %>%
  filter(!is.na(weight))

#challenge! Create a new data frame from the surveys data that meets the following criteria: contains only the  species_id column and a new column called hindfoot_half containing values that are half the  hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.

surveys_challenge2<-surveys %>%
  mutate(hindfoot_half=hindfoot_length/2) %>% 
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half<30) %>% 
  select(species_id,hindfoot_half)

#group_by function is a good for split-aply-combine-summarize

surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight=mean(weight,na.rm=FALSE))

#you can also group by multiple columns
surveys %>%
  group_by(sex,species) %>% 
  summarise(mean_weight=mean(weight,na.rm=T))

#can be combined with filters etc
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex,species) %>%
  summarize(mean_weight=mean(weight),
            min_weight=min(weight)) %>% 
  print(n=15)

#tallying, or counting numbers
surveys%>%
  group_by(sex) %>% 
  tally()

#CHallenge! How many individuals were caught in each plot_type surveyed? Use group_by() and summarize() to find the mean, min, and max hindfoot length for each species (using  species_id). What was the heaviest animal measured in each year? Return the columns year, genus, species_id, and  weight. You saw above how to count the number of individuals of each sex using a combination of group_by() and  tally(). How could you get the same result using group_by() and summarize()? Hint: see ?n.

plot_counts<-surveys %>% 
  group_by(plot_id) %>% 
  tally()
hindfoot_measurments<-surveys %>%
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>%
  summarize(mean_hindfoot=mean(hindfoot_length),
            min_hindfoot=min(hindfoot_length),
            max_hindfoot=max(hindfoot_length))
heaviest_ind<-surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight==max(weight)) %>%
  select(year,weight,genus,species_id)


#gathering and spreading

#spread is basically like reshape2 dcast
surveys_gw<-surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus,plot_id) %>%
  summarize(mean_weight=mean(weight))
surveys_spread<-surveys_gw %>% 
  spread(genus, mean_weight)

#gathering takes the spread data and brings it back
surveys_gather<-surveys_spread %>% 
  gather(genus,mean_weight,-plot_id)
