library(tidyverse)

#2
surveys<-read_csv("data/portal_data_joined.csv") #reads in the csv as a tibble_df as opposed to a dataframe

#3
surveys_subset<-surveys%>% #subset surveys for weights below 60 and above 30
  filter(weight<60)%>%
  filter(weight>30)

head(surveys_subset) #print first six rows of surveys_suset

#4
biggest_critters<-surveys%>%
  group_by(species,sex)%>% #group by desired vectors
  summarise(max_weight=max(weight,na.rm=T))%>% #summarise using max
  arrange(desc(max_weight)) #arrange by vecor max weight in descending order

#5
#trying to figure out where all the NA values are
weight_missing_sex<-surveys%>% #here I group by sex and summarize the number of missing values
  group_by(sex)%>%
  summarize(sum_na=sum(is.na(weight)))
weight_missing_species<-surveys%>% #here I group by species and smmarize the number of missing values
  group_by(species) %>%
  summarize(sum_na=sum(is.na(weight)))

#it seems that when sex couldn't be identified, usually a weight couldn't be measured either
#also it seems that there are several species (roughly 10) with over a hundred na weight values each

#6
survey_avg_weight<-surveys[complete.cases(surveys$weight),] %>% #use complete cases to drop all rows with NA weights
  group_by(species,sex) %>% #group
  mutate(avg_weight=mean(weight)) #create new column based off of average weights of grouped values

survey_avg_weight<-select(survey_avg_weight, species,sex,weight, avg_weight)#select for desired vectors

nrow(survey_avg_weight) #count rows to compare with assignment

#7
#challenge
survey_avg_weight$above_average<-survey_avg_weight$weight>survey_avg_weight$avg_weight #create new column that tells me if weight is higher than the average for species_sex grouping

#8
#extra challenge is tricky, because scale only works on numeric, so have to change species into a numeric code
surveys$species_n<-as.factor(surveys$species) #change species into a factor
surveys$species_n<-as.numeric(surveys$species_n) #next change species_n into numeric
surveys$scaled_weight<-scale(cbind(surveys$weight,surveys$species_n)) #scale by both weight and speices number

#I believe I did the extra challege correctly, but I'm not sure how to interpret it
                             