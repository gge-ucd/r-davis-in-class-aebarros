library(readr)
tidy <- read.csv("data/tidy.csv")

#vector lesson
x<-4 #a vector of length 1

weight_g<-c(50, 60, 31, 89)
weight_g

animals<-c("mouse","rat","dog","cat")
animals

#vector exploration tools
length(weight_g) #4
length(animals) #4

class(weight_g) #numeric
class(animals) #character

#str is got to first tool for examining an object
str(weight_g) #provides structure of object
str(animals)

#add on to a vector
weight_g<-c(weight_g, 105)
weight_g
weight_g<-c(25, weight_g)
weight_g

#6 types of atomic vectors: numeric (double), character, logical, integer, complex, raw    (first four are main ones)

typeof(weight_g) #double


#data challenge

#what happens below is known as "coersion?", R forces all values in a vector into one type, with character being the one to rule them all
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

str(num_char)
str(num_logical) #interesting "TRUE" became a "1"
str(char_logical)
str(tricky)

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)
str(combined_logical)

#subsetting vectors
animals
animals[2] #rat

animals[c(3,2)]#dog,rat

moreanimals<-animals[c(1,2,3,4,4,3,2,2,1)]
moreanimals #"mouse" "rat"   "dog"   "cat"   "cat"   "dog"   "rat"   "rat"   "mouse"

#conditional subsetting
weight_g
weight_g[c(T,F,T,T,F,T,T)] #I'm telling it what I want

weight_g>50
#FALSE FALSE  TRUE FALSE  TRUE  TRUE  TRUE

weight_g[weight_g<30|weight_g>50]
#25  60  89 105 105

weight_g[weight_g>30 & weight_g==21]
#numeric(0)

animals %in% c("cat","ant","frog")
animals [animals %in% c("cat","ant","frog")]

#missing data
heights<-c(4,5,3,4,NA,6)
mean(heights) #NA
mean(heights,na.rm=T) #4.4

#remove NAs
heights[!is.na(heights)] #removes NA values
