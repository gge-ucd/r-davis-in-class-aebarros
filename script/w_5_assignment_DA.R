#STEP 2:
library(tidyverse)
surveys<-read_csv("data/portal_data_joined.csv")

#STEP 3:
#subset surveys for weights below 60 and above 3
surveys_subset<-surveys%>% 
filter(weight < 60) %>% 
  filter(weight > 30)

#print the first 6 rows of the subsetted dataset
head (surveys_subset) 

#STEP 4: Make a tibble that shows the max (hint) weight for each species+sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble (use ?, tab-complete, or Google if you need help with arrange)

biggest_critters <- surveys %>% 
  group_by(species,sex) %>% 
  filter (!is.na(weight)) %>% 
  filter (!is.na(sex)) %>% 
  summarise(max_weight = max(weight)) %>% 
  arrange(desc(max_weight)) %>% 
  view()

#STEP 5: Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

#I used the group_by function to summarize NA's in various categories
weigh_NA_sex <-surveys%>% 
  group_by(sex)%>%
  summarize(sum_na=sum(is.na(weight))) %>% 
  arrange(desc(sum_na)) %>% view

weight_NA_species <-surveys %>% 
  group_by(species) %>% 
  summarize(sum_na=sum(is.na(weight))) %>% 
  arrange(desc(sum_na)) %>% view
  
weight_NA_record_id <-surveys %>%
  group_by(record_id) %>% 
  summarize(sum_na=sum(is.na(weight))) %>%
  arrange(desc(sum_na)) %>% view

weight_NA_month <-surveys %>%
  group_by(day) %>% 
  summarize(sum_na=sum(is.na(weight))) %>% 
  arrange(desc(sum_na)) %>% view

weight_NA_taxa <-surveys %>%
  group_by (taxa) %>% 
  summarize(sum_na=sum(is.na(weight))) %>% 
  arrange(desc(sum_na)) %>% view

surveys %>% 
  filter(taxa == "Rodent") %>% 
  tally()

surveys %>% 
  filter(taxa == "Bird") %>% 
  tally()

surveys %>% 
  filter(taxa == "Rabbit") %>% 
  tally()

surveys %>% 
  filter(taxa == "Reptile") %>% 
  tally()

# There are a disproportinate amount of NA's in the rodent taxa

#STEP 6: Within surveys: 
#- remove the rows where weight is NA 
#- add column containing the average weight of each species+sex comb. #- eliminate all columns except: sp., sex, weight, and average weight
#Save this tibble as surveys_avg_weight. 
#The resulting tibble should have 32,283 rows.

surveys_avg_weight <- surveys %>%
#!is.na - (filters out na's)
  filter(!is.na(weight)) %>% 
# group_by is an aggregation tool in the “dplyr” package
  group_by(species_id, sex) %>% 
# mutate adds new variables and preserves existing ones
  mutate(avg_weight=mean(weight)) %>% 
# select keeps all the variables you mention
  select(species_id, sex, weight, avg_weight) %>%
# nrow counts the number of rows (should be 32,283)
  nrow(surveys_avg_weight) %>% view

#STEP 7: Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).
  surveys_avg_weight %>% 
  mutate(above_avg=weight>avg_weight) %>%
  arrange(desc(above_avg)) %>% view
#Pondering aloud: how would I count the number of true and false answers?
  
  
#STEP 8: Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?

  surveys %>% 
    group_by(species_id) %>% 
    mutate(scaled_weight = scale(weight)) %>% 
    filter(!is.na(scaled_weight)) %>% 
    arrange(scaled_weight) %>% View
  
#The scale function determines how many standard deviations a data point is from the mean for the respective group (species ID in this case). The largest observed weight (relative to species) was Chaetodipus penicillatus and the smallest (relative to species) was Dipodomys merriami.
