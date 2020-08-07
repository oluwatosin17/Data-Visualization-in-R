---
  title: "Guided Project: Analysing Forest Fire Data"
author: "Tosin"
date: "08/06/2020"
output: html_document
---
library(readr)
library(tidyverse)
forestfires <- read_csv("forestfires.csv")
head(forestfires, 5)

#When do most fires occur
fire_count_month <- forestfires %>% group_by(month) %>% summarise(count = n()) 
fire_count_month

ggplot(data = fire_count_month, aes(x = month, y = count))+ geom_bar(stat = "identity")+theme(panel.background = element_rect(fill = "white"))
# From the bar chart we can state that the number of forest fire occured most during August and September

fire_count_days <- forestfires %>% group_by(day) %>% summarise(count = n())
fire_count_days

ggplot(data = fire_count_days, aes(x = day, y = count))+ geom_bar(stat = "identity")+theme(panel.background = element_rect(fill = "white"))

# from this plot we can see that fire mostly occured on sunday


#Working with Factor data
# specifying a certain order for values of these variables on the x-axis
#ordering the days and months in a chronological manner

forestfires <- forestfires %>% mutate(month = factor(month, levels = c("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec")))
view(forestfires)
fire_count_month <- forestfires %>% group_by(month) %>% summarise(count = n()) %>% arrange(match(month,month))
fire_count_month
ggplot(data = fire_count_month, aes(x = month, y = count))+ geom_bar(stat = "identity")+theme(panel.background = element_rect(fill = "white"))

forestfires <- forestfires %>% mutate(day = factor(day, levels = c("sun","mon","tue","wed","thu","fri","sat")))

fire_count_days <- forestfires %>% group_by(day) %>% summarise(count = n()) %>% arrange(match(day,day))
fire_count_days

ggplot(data = fire_count_days, aes(x = day, y = count))+ geom_bar(stat = "identity")+theme(panel.background = element_rect(fill = "white"))


#Why do forest fires occur when they do
#Creating a function

create_boxplot_month <- function(x ,y){
  plot = ggplot(data = forestfires, aes_string(x = x, y = y))+geom_boxplot()+theme(panel.background = element_rect(fill = "white"))
}
y = names(forestfires)[5:12]
x = "month"
map2(x,y,create_boxplot_month)


create_boxplot_day <- function(x ,y){
   ggplot(data = forestfires, aes_string(x = x , y = y))+geom_boxplot()+theme(panel.background = element_rect(fill = "white"))
}
y = names(forestfires)[5:12]
x = "day"
map2(x,y,create_boxplot_day)
#Day of the week
#It is clear that the solid black lines in the centers of the box plots are quite to be cosistent 
# across the day of the week, The size sizes of the vboxes are also consistent across days of the week
# suggesting the ranges of data values are similar. The number of outlier points and length of the box whiskers 
# representing high and low points vary from day to day , However, theredo not seem to be any patterns that sugest that the variables
# differ by day of the week, despite the fact that the number of forest fire appears to be higher on weekends 
#It's interesting to look at plot of the the rain variable. 
# A few very high values make it so the y-axis range is large enough to make the
# rest of the data appear to be close to zero.

#Month
# Unlike the variable distributions by days of the week, almost all the variables display clear differences among months.
# The temp variable shows a pattern of being higher during the summer months. We can also see
# that the DC variable, which stands for "drought code" and is a measure of how dry conditions 
# are, is high during the late summer months. 


# WHAT VARIABLES ARE RELATED TO FOREST FIRE SEVERITY
library(purrr)
y <- "area"
x <- names(forestfires)[5:12]

create_scatter <- function(x,y){
  plot = ggplot(data = forestfires, aes_string(x = x, y = y))+geom_point()+theme(panel.background = element_rect(fill = "white"))
  return(plot)
}
map2(x,y,create_scatter)
#many points representing the values of area that are zero or close to zero. As a result most points are clustered around the bottom of the plots

#Deciding on Subset of Data for scatter plot

ggplot(data = forestfires , aes(x = area))+geom_histogram()+theme(panel.background = element_rect(fill = "white"))
#A histogram of the area  variable values clearly illustrates the distribution and why scatter plot look the way they do

