download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_daa_joined.csv")



surveys <- read.csv(file = "Data/portal_daa_joined.csv")
surveys

surveys[,-c(2:4)]
surveys[1:400,1]        
surveys[1:400,1:8]
col158 <- c(1,5,6,7,8)
surveys[1:400,col158]

surveys_subset <- c(surveys[1:400,col158])
surveys_subset

surveys_subset$hindfoot_length<- as.numeric(surveys_subset$hindfoot_length) #tried to do this because there are NA values and I think that was messing with my outputs 
surveys_subset$hindfoot_length
surveys_subset$hindfoot_length<- as.numeric(surveys_subset$hindfoot_length) #Tried to make tem numeric so I can do a histogram, did not seem to work 


surveys_long_feet<-subset(surveys_subset, hindfoot_length>32) 
surveys_long_feet #gave "$<NA>NULL" output because there are NA values

hist(surveys_long_feet$hindfoot_length) #"x must be numeric..."I thought I made it numeric above..did not work

surveys_long_feet$hindfoot_length<- as.character(surveys_long_feet$hindfoot_length)
hist(surveys_long_feet$hindfoot_length)
#gave same error as above because it is still a character...I give up, sorry Arthur! 

































