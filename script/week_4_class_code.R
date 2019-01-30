#intro to dataframes

#first we download the dataset from the web
download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv") #this is where the file will be saved and as what

surveys <- read.csv(file="data/portal_data_joined.csv") #read in the data from where we saved it

#exploring the data
head(surveys)
str(surveys)
View(surveys)
dim(surveys)
nrows(surveys)
ncol(surveys)
tail(surveys)
names(surveys)
rownames(surveys)
summary(surveys) #provides some sumamry stats for each column

#subsetting dataframes
#dataframes are 2D (vectors are 1D)! so we need two dimensions to subset dataframe[,]

surveys[1,1] #1
surveys[1,6] #NL
surveys[,1] #gives everything in first column as a vector (1D)
surveys[1] #gives everything in first column as a dataframe (2D)

surveys[1:3,6] #gives the first three obs of the 6th column

surveys[5,] #pulls out everything in the 5th row as a dataframe

#can use negative sign to exclude a column or row
surveys[1:5,-1] #get back first five observations without the 1st column

surveys[-10:34786,]#get an error: "Error in xj[i] : only 0's may be mixed with negative subscripts", because it doesn't like the negative value in the vector
surveys[-c(10:34786),] #so wrap it up! this gives all columns but drops every observation past 9

surveys[c(10,15,20:30),] #gives us specific rows, the 10th, 15th, and rows 20 through 30

#subsetting by column name
surveys["species_id"]
surveys[,"species_id"]
surveys[["species_id"]]
surveys$species_id

#challenge
surveys_200<-surveys[200,]#1
nrow(surveys) #34786
tail(surveys) #last row: 34786
surveys_last<-surveys[nrow(surveys),] #2 provides the last row
surveys_middle<-surveys[nrow(surveys)/2,] #3, provides the middle row
surveys[-c(7:nrow(surveys)),] #provides the first six rows, by subtracting the 7th row through nrow

#Finally, factors
surveys$sex

#creating our own factor
sex<-factor(c("male","female","female","male"))
sex
class(sex)
typeof(sex)
levels(sex)

concentration<-factor(c("high","medium","high","low"))
concentration #these aren't in the factor order we would want (low, medium, high)

concentration<-factor(concentration,levels = c("low","medium","high")) #this reorders the factors how we want
concentration

#lets add to a factor
concentration1<-c(concentration, "very high") #this doesn't work right, coerces to characters first, which doesn't work
concentration1

as.character(sex) #convertes characters to factors

#factors with numeric levels
year_factor<-factor(c(1990,1923,1965,2018))
as.numeric(year_factor) #this gives us the integer value of the labeled factors, which isn't what we want. instead we first want to turn into a character

as.character(year_factor)
as.numeric(as.character(year_factor))
as.numeric(levels(year_factor))#this also works

#why so many factors in our surveys dataframe?
?read.csv #has argument stringsAsFactors that defaults to True, turning all character strings to factors
surveys_no_factors<-read.csv(file="data/portal_data_joined.csv",stringsAsFactors = F)
str(surveys_no_factors) #loaded all strings vectors as columns

#renaming factors
sex<-surveys$sex
levels(sex)
#lets rename the blank value
levels(sex)[1]<-"undetermined"
levels(sex)


#Dates are the worst!!!!
library(lubridate)
my_date <- ymd("2015-01-01")
str(my_date)
# sep indicates the character to use to separate each component
my_date <- ymd(paste("2015", "1", "1", sep = "-")) 
str(my_date)

str(surveys)
paste(surveys$year, surveys$month, surveys$day, sep = "-")
ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
