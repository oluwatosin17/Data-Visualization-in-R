# Data-Visualization-in-R

## Creating Multiple Line Graphs

In Creating Multiple Line Graphs;
1. I've learned methods for creating multiple line graphs to visualize data in different ways. 
2. I also about techniques to maximize the clarity of visuals and how these techniques will vary depending on the questions asked about the data.


> Splitting data into subplots based on values of a variable:

`ggplot(data = data_frame,
  aes(x = variable_1, y = variable_2)) +
  geom_line() +
  facet_wrap(~variable_3)`

> Creating a line graph with different values of a variable using different styles of lines:

`ggplot(data = data_frame,
  aes(x = variable_1, y = variable_2, lty = variable_3)) +
  geom_line()`

> Creating a line graph with different values of a variable using different colors:

`ggplot(data = data_frame, 
  aes(x = variable_1, y = variable_2, color = variable_3)) +
  geom_line()`

> Viewing a specific part of a graph:

`ggplot(data = data_frame, 
  aes(x = variable_1, y = variable_2, color = variable_3)) +
  geom_line() +
  xlim(1915, 1920) +
  ylim(35, 60)`

> Changing the color and line types of a line:

`ggplot(data = life_expec_sex_race, 
  aes(x = Year, y = Avg_Life_Expec, color = Sex, lty = Race)) +
  geom_line() +
  scale_color_manual(values = c("magenta", "orange")) +
  scale_linetype_manual(values = c("longdash", "dotdash"))`

- The `facet_wrap()` function splits data into subplots based on values of a variable in your dataset. By default, this creates two panels side by side. You can specify arrangements of the panels using the `ncol` and `nrow` arguments.

- Chart legends contain a list of variables that appear in a graph and an example of their appearance. Legends help the person looking at your graph understand it.
- Changing the scale limits changes the range of your axes so you can display only a portion of your data.
- The way you choose to graph your data ultimately depends on the question you're trying to answer and requires some trial and error.
- The consistent, systematic syntax of `ggplot2 will allow you to create multiple graphs as part of your workflow without taking too much of your time.


## Bar Charts, Histograms, And Box Plots

I investigated possible movie rating bias, I learned to represent the same data in three different ways:

1. **Bar charts** 
- It may be used for showing a quick summary of your data, such as averages or counts of the number of instances of a value that occur for a given variable.
- Using `stat = "identity"` overrides the default behavior of the height of the bars corresponding to the number of values, and instead creates bars equal to the value of the y-variable.
> Creating a bar chart:

 - `ggplot(data = data_frame,
  aes(x = variable_1, y = variable_2)) + 
  geom_bar(stat='identity')`

2. **Histograms**
- Are useful for visualizing distributions of data when you want to know the shape of a distribution (in other words, where most values are clustered).

- You can specify two different arguments in the geom_histogram() layer to specify the number of categories for binning the independent variable:
- **binwidth** = allows you to specify the size of the bins, and is useful for instances, such as this example, where you want categories to span specific intervals.
- **bins** = allows you to specify the number of bins, which can be useful to experiment with when deciding how much detail you want to use to display your data.

> Creating a histogram:

 - `ggplot(data = reviews, 
  aes(x = Rating)) +
  geom_histogram(bins = 30)`


> Creating a faceted plot for categories of a variable:

 - `ggplot(data = reviews, 
  aes(x = Rating)) +
  geom_histogram(bins = 30) +
  facet_wrap(~Rating_Site, nrow= 2)`

> Adding color to distinguish between variables:

 - `ggplot(data = reviews, 
  aes(x = Rating, fill= Rating_Site)) +
  geom_histogram(bins = 30)`

3. **Box plots** 
  - provides an informative summary of the shape, spread, and center of your data.
   - Box plots present the following data:
     - ***The largest value***: Represented by the top of the black line extending from the top of the box. These lines are also known as `"whiskers".`
     - ***The third quartile (Q3)***: Represented by the top of the box. Seventy-five percent of the values are smaller than the third `quartile.`
     - ***The median***: Represented by the `thick black line`. The median is the value that falls in the middle of the data.
     - ***The first quartile (Q1)***: Represented by the bottom of the box. Twenty-five percent of the values are smaller than the `third quartile.`
     - ***The smallest value***: Represented by the bottom of the black line extending from the bottom of the box.

## Scatter Plots for Exploratory Analysis

> Creating a scatter plot using ggplot2:

`ggplot(data = Example_Data,
  aes(x = Variable_1, y = Variable_2)) +
  geom_point()`

> Specifying axes ranges:

`ggplot(data = reviews_2,
  aes(x = Fandango, y = Rotten_Tomatoes)) +
  xlim(1,5) +
  ylim(1,5)`

>×Changing the transparency of the points:

`ggplot(data = reviews_2,
 aes(x = Fandango, y = Rotten_Tomatoes)) +
 geom_point(alpha = 0.3) +
 xlim(1,5) +
 ylim(1,5)`

> Altering the plot background:

`ggplot(data = reviews_2,
 aes(x = Fandango, y = Rotten_Tomatoes)) +
 geom_point(alpha = 0.3) +
 xlim(1,5) +
 ylim(1,5) +
 theme(panel.background = element_rect(fill = "white"))`

> Using a functional to create multiple scatter plots:

`create_scatter = function(x, y) {
ggplot(data = reviews_2) + 
   aes_string(x = x, y = y) +
   geom_point(alpha = 0.3) +
   xlim(1,5) +
   ylim(1,5) +
   theme(panel.background = element_rect(fill = "white"))
}
x_var <- names(reviews_2)[5]
y_var <- names(reviews_2)[2:4]
ratings_comparisons <- map2(x_var, y_var, create_scatter)`

**Types of relationships between variables:**
- Variables are said to have a positive relationship if both variables increase in value while the other one increases in value.
- Variables are said to have a negative relationship if one variable increases in value while the other one decreases in value.
- Variables are said to have a strong relationship if points are clustered together as opposed to being spread out.
- Variables are said to have a weak relationship if points are spread out as opposed to being clustered together.
- Variables are said to have no relationship if it appears the points are arranged in a shapeless cloud.



Using `aes_string()` allows you to pass vectors of variable names into your function for efficiency.
`gridExtra` is a package useful for organizing plots created using `ggplot2` in a grid on a single page.
