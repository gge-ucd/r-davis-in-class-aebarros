library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") #the assignment said this is saving the data to my computer, but it is not, instead it just saves it as a df?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() + #this line of code is almost certainly 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') + #geom_smooth line provides the line of best fit
  theme_bw()

#1c challenge! modify the code to size the points in proportion to the population of the country
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent,size=pop,alpha=.3)) + #changed the size in aes to = pop, also added transparency
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
