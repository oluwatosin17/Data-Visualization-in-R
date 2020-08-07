---
  title: "Data Visualization in R"
author: "Tosin"
date: "08/03/2020"
output: html_document
---
#Goals 
  #Explore the principles of data visualization
  #Learn to write R code to visualize trends in the data in different ways
  #Build intution around when different types of visualizations will help yo understand your data
  
library(readr) 
life_expec <- read_csv("life_expec.csv")

head(life_expec,10)
library(ggplot2)

# Grammar of Graphics 
ggplot(data = life_expec)

#Mapping Variables to Axes
#aes "aesthetics"

ggplot(data = life_expec, aes(x = Year , y = Avg_Life_Expec ))

#Adding Geometric Objects to Visualize Data Points
# geom_line()
# Lines representing relationship

ggplot(data = life_expec, aes(x = Year , y = Avg_Life_Expec )) + geom_line()

#Selecting Data forVisualization
life_expec %>% filter(Year == 2000)

life_expec_filter <- life_expec %>% filter(Race == "All Races",Sex == "Both Sexes")
ggplot(data = life_expec_filter, aes(x= Year, y = Avg_Life_Expec))+geom_line()


#Adding Graph Titles and Changing Axis Labels

#The visualization f the relationship btween Avg_life_Exec and Year allows for the quick detection of some interesting patterns
#The average life expectancy of the US population has been increasing over time.
#Before the 1950s, lif expectancy fluctuated substantially from year to year
#In the 1920s, life expectancy dropped dramatically, and then increased again

ggplot(data = life_expec_filter, aes(x = Year, y = Avg_Life_Expec))+ geom_line()+labs(title = "United State Life Expectancy: 100 Years of Change", y = "Average Life Expectancy (Years)")

#Refining Graph Aesthetics 
#We can change the background colour

ggplot(data = life_expec_filter, aes(x = Year, y = Avg_Life_Expec))+geom_line()+labs(title = "United State Life Expectancy: 100 Years of Change", y = "Average Life Expectancy (Years)")+theme(panel.background = element_rect("White"))


#Creating Multiple Line Graphs
#Manipulating the Data for Visualization 

life_expec_sex <- life_expec %>% filter(Sex == "Male"| Sex == "Female",Race == "All Races")
view(life_expec_sex)

#Graphing Life Expectancies for Men and Women Multiple Panels
ggplot(data = life_expec_sex,aes(x = Year,y = Avg_Life_Expec))+geom_line()+facet_wrap(~Sex)
ggplot(data = life_expec_sex,aes(x = Year,y = Avg_Life_Expec))+geom_line()+facet_wrap(~Sex, ncol = 2)

#Graphing Life Expectancies for Men and Women on the same axes
#lty stands for line type
ggplot(data = life_expec_sex , aes(x = Year, y = Avg_Life_Expec, lty = Sex))+geom_line()
#Changing color
ggplot(data = life_expec_sex)+ aes(x = Year, y = Avg_Life_Expec, color = Sex)+geom_line()

#Graphing a Subset a Data
#Changing scale limit is just like zooming in

ggplot(data = life_expec_sex, aes(x = Year , y = Avg_Life_Expec, color = Sex, ))+ geom_line()+ xlim(1915,1920)+ylim(35,60)

ggplot(data = life_expec_sex, aes(x = Year , y = Avg_Life_Expec, color = Sex, ))+ geom_line()+ xlim(1900,1950)


#Exploring the Data Further
life_expec_sex_race <- life_expec %>% filter(Sex == "Male"| Sex == "Female", Race == "Black"| Race == "White")
view(life_expec_sex_race)

#Manipulating Multiple Line Graph Aesthetics
ggplot(data = life_expec_sex_race, aes(x = Year, y = Avg_Life_Expec, color = Sex, lty = Race))+ geom_line()

#Changing the color
ggplot(data = life_expec_sex_race, aes(x = Year, y = Avg_Life_Expec, color = Sex, lty = Race))+ geom_line() + scale_color_manual(values = c("magenta","green"))
#Changing the line types
ggplot(data = life_expec_sex_race, aes(x = Year, y = Avg_Life_Expec, color = Sex, lty = Race))+ geom_line() + scale_color_manual(values = c("magenta","green"))+scale_linetype_manual(values = c("longdash","dotdash"))

ggplot(data = life_expec_sex_race, aes(x = Year, y = Avg_Life_Expec, color = Sex, lty = Race))+geom_line() + scale_color_manual(values = c("darkgreen","darkorchid"))+scale_linetype_manual(values = c(1,4))


#Deciding How to Present the Data
ggplot(data = life_expec_sex_race, aes(x = Year, y = Avg_Life_Expec, color = Sex,))+geom_line()+facet_wrap(~Race, ncol = 1)

ggplot(data = life_expec_sex_race, aes(x = Year, y = Avg_Life_Expec, lty = Race))+geom_line()+labs(title = "United State Life Expectancy: 100 Years of Change", y = "Average Life Expentancy(Years)")+theme(panel.background = element_rect(fill = "white"))+facet_wrap(~Sex, ncol = 2)+scale_linetype_manual(values = c(1,4))




#Bar Charts, Histograms, And Box Plots
library(readr)
library(tidyverse)


reviews <- read_csv("movie_reviews.csv")
view(reviews)

review_avgs <- reviews %>% group_by(Rating_Site) %>% summarize(avg = mean(Rating))
review_avgs


#Visualizing Difference Among Groups Using Bar Charts
# Line graphs are useful for depicting changes in dependent variables 
ggplot(data = review_avgs, aes(x = Rating_Site, y = avg))+geom_bar(stat = "Identity")
#geom_bar(stat = "Identity")  overrides the default behavior and creates bars equal to the value of the y-variable  
#Fandango has a higher average movie rating than the other sites

#Using Histogram to understand distributions
ggplot(data = reviews, aes(x = Rating))+geom_histogram(binwidth = 1)
ggplot(data = reviews, aes(x = Rating))+geom_histogram(bins = 30)

#Comparing Distribution of Multiple Variables: Faceted Plots
ggplot(data = reviews, aes(x = Rating))+geom_histogram(bins = 30)+facet_wrap(~Rating_Site, nrow = 2)
#One way to compare Rating distributions for the four sites is to create a faceted pot.
#Use nrow = 2 to specify a two by two arrangement


#Comparing Distributions of Multiple Variables: Specifying Aesthetics
ggplot(data = reviews, aes(x = Rating, color = Rating_Site))+geom_histogram(bins = 30)
#The number of values of Rating for each value of Rating_Site are indicated by bars outlined by different colors
ggplot(data = reviews, aes(x = Rating, fill = Rating_Site))+geom_histogram(bins = 30)
#fill  depicts the bars filled in with different colors

#Visualizing Averages and Variation
#Visualizing the distributions of rankings for each rating site makes it clear that fandango is more likely to rate movies highly than other sites

#box plot provide summary of the data by group
ggplot(data = reviews, aes(x = Rating_Site, y = Rating))+geom_boxplot()
# Values of Rating for Rotten are spread out, indicating they give movies ratings that range from poor to excellent
# The range values of Rating for fandango and imdb are both quite narrow. Fandango's lowest reviews are around 2.5 , while outliers indicates that IMDB  has some reviews that are between 2 and 2.4
# Fandango's median for values of Rating is higher than the median of other sites, indicating Fandango tends to give higher ratings

ggplot(data = reviews, aes(x = Rating_Site, y = Rating))+geom_boxplot()+theme(panel.background = element_rect(fill="white"))+labs(title = "Comparison of Movie Ratings")

#Bar charts may be used for showing a quick summary of your data, such as averages or counts of the number of instances of a value that occur in a given variable
#Histograms are useful for visualizing distributions of data when you want to know the shape of a distribution
# in order words where most values are clustered

#Box plots provide an informative summary of the shape, spread and center of your data



#Scatter Plots for Exploratory Analysis
reviews_2 <- read_csv("movie_reviews_2.csv")
head(reviews_2, 4)
colnames(reviews_2)
view(reviews_2)

reviews_2 <- reviews_2 %>% select(c(FILM,RT_user_norm,Metacritic_user_nom,IMDB_norm,Fandango_Ratingvalue))
view(review2)

review_2 <- reviews_2 %>% rename(FILM = FILM,Rotten_Tomatoes =RT_user_norm , Metacritic = Metacritic_user_nom ,IMDB = IMDB_norm , Fandango = Fandango_Ratingvalue)
colnames(review_2)
head(review_2,3)


#Understanding Relationship between variables
# Strong positive relationship ; as variable one increases so do variable 2 . the points are clustered close together instead of spreading out
# while the values of variable 2 generally increase with the value of variable 1. The points are spread further apart - weak relationship

# relationship between variables in which one variable decrease as another increase is a negative relationship if they're clustered together it's a strong negative relationship else a weak negative relationship
#when points are arranged in a shapeless cloud , there's an indication of no relationship

ggplot(data = review_2, aes(x = Fandango, y = Rotten_Tomatoes))+geom_point()
# It's a weak positive relationship between Fandango and Rotten-Tomatoes
ggplot(data = review_2, aes(x = Fandango, y = Rotten_Tomatoes))+geom_point(alpha  = 0.3)+xlim(1,5)+ylim(1,5)+theme(panel.background = element_rect(fill = "white"))
#alpha specifies the opacity

#Creating Multiple Scatter Plots
ggplot(data = review_2, aes(x = Fandango, y = IMDB))+geom_point(alpha  = 0.3)+xlim(1,5)+ylim(1,5)+theme(panel.background = element_rect(fill = "white"))
ggplot(data = review_2, aes(x = Fandango, y = Metacritic))+geom_point(alpha  = 0.3)+xlim(1,5)+ylim(1,5)+theme(panel.background = element_rect(fill = "white"))


#Write a function to create multiple scatter plots '
library(purrr)
x <- "Fandango"
y <- c("Rotten_Tomatoes","IMDB","Metacritic")
create_scatter <- function(x,y){
  plot = ggplot(data = review_2, aes_string(x = x, y = y))+geom_point(alpha  = 0.3)+xlim(1,5)+ylim(1,5)+theme(panel.background = element_rect(fill = "white"))
  return(plot)
  }
map2(x,y,create_scatter)
create_scatter(x,y)


#The observation 
#the plots shows that rating for all three sites are weakly positively related to Fandango's ratings 
#This means Fandango and other sites agree on which movies were good and which were not despite Fandango assigning
#higher ratings overall.
#The rotten_tomatoes and imdb ratigs seem to be more strongly related to Fandango's than the Metacritic Ratings

