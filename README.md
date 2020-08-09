# Data-Visualization-in-R

## Creating Multiple Line Graphs

In Creating Multiple Line Graphs;
1. I've learned methods for creating multiple line graphs to visualize data in different ways. 
2. I also about techniques to maximize the clarity of visuals and how these techniques will vary depending on the questions asked about the data.



## Bar Charts, Histograms, And Box Plots

I investigated possible movie rating bias, I learned to represent the same data in three different ways:

1. **Bar charts** 
- It may be used for showing a quick summary of your data, such as averages or counts of the number of instances of a value that occur for a given variable.
- Using stat = "identity" overrides the default behavior of the height of the bars corresponding to the number of values, and instead creates bars equal to the value of the y-variable.
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

3. Box plots provide an informative summary of the shape, spread, and center of your data.
