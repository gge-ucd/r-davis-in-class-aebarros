surveys <- read.csv(file="data/portal_data_joined.csv") #read in data

surveys_subset<-surveys[1:400,c(1,5:8)] #subset the data

surveys_long_feet<-subset(surveys_subset, hindfoot_length>32) #use subset call to subset rows from database
hist(surveys_long_feet$hindfoot_length)

surveys_long_feet$hindfoot_length<-as.character(surveys_long_feet$hindfoot_length) #overwrite hindfoot_length as a character vector
hist(surveys_long_feet$hindfoot_length) #does not work, should be numeric
