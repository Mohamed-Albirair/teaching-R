# Read practice data:
# (Source: https://www.kaggle.com/datasets/harishyadav0506/impact-of-social-media-on-life)
sm_impact <- read.csv("C:/Users/da_di/Documents/R/GitHub/teaching_R/data/Social_media_impact_on_life.csv")

# Check the class of variables
#---always important to check and not rely on assumed or seen values
class(sm_impact$Age)
class(sm_impact$Gender)

# as we demonstrated, the number 19 looks like a number, but could be a character
# value in R.
x <- 19; class(x)
y <- "19"; class(y)
identical(x, y) # what does that tell you?

# R has a phenomenon called "coersion", which ensures that a vector would ALWAYS
# have a single class. Character values dominate numeric values:
# A quick demonstration of the coersion in R
vec <- c(1, 2, 3)
class(vec)
vec <- c(1, 2, 3, "a")
class(vec)

### Quick tabulations and explorations #########################################

table(sm_impact$Gender) # counts by gender category
prop.table(table(sm_impact$Gender)) # proportions
names(sm_impact) # names of the columns
colnames(sm_impact) # another option

table(sm_impact$Academic_Level)

# The table() command can be applied to a single, two or three variables...
# (Also, to more, but it then becomes difficult to communicate)
table(sm_impact$Device_Type)
table(sm_impact$Gender, sm_impact$Academic_Level)
table(sm_impact$Gender, sm_impact$Academic_Level, sm_impact$Device_Type)




### Visualizations #############################################################

hist(sm_impact$Age) # simple histogram using base R (no additional package)
plot(sm_impact$Daily_Usage_Hours, sm_impact$Sleep_Duration_Hours) # simple scatterplot

# Install tidyverse package
install.packages("tidyverse") # Only needs to run once in your machine, 
# (unless you update R without the already installed packages)
library(tidyverse) # Always remember to load packages

# Visualization in "ggplot2"
# Classical ggplot script:
# ggplot(dataset, aes(x = ..., y = ...)) + geom_type_of_visualization + more specifications
# dataset %>% ggplot(aes(x = ..., y = ...)) + geom_type_of_visualization + more specifications

## Visualize a single numerical variable---------------------------------------#
# Basic, not visually appealing
sm_impact %>% 
      ggplot(aes(x = Age)) + 
      geom_histogram() +
      theme_minimal()

sm_impact %>% 
      ggplot(aes(x = Age)) + 
      geom_histogram(bins = 10, # you can pick any value here
                     fill = "lightblue", # colors are specified either by name or hex code
                     colour = "darkblue") +
      theme_minimal()

sm_impact %>% 
      ggplot(aes(x = Age)) + 
      geom_bar() + # looks the same, but technically, not the correct viz type! Should be reserved for categorical
      theme_minimal()

## Visualize a single categorical variable-------------------------------------#
sm_impact %>% 
      ggplot(aes(x = Gender)) + 
      geom_bar(fill = "lightblue", color = "darkblue") +
      theme_minimal()

## Visualize two categorical variables-----------------------------------------#
sm_impact %>% 
      ggplot(aes(x = Device_Type, fill = Primary_Platform)) +
      geom_bar() +
      theme_minimal()

# Different orientation (percentages, not counts)
sm_impact %>% 
      ggplot(aes(x = Device_Type, fill = Primary_Platform)) +
      geom_bar(position = "fill") +
      theme_minimal()

# Correct the y-axis label
sm_impact %>% 
      ggplot(aes(x = Device_Type, fill = Primary_Platform)) +
      geom_bar(position = "fill") +
      labs(y = "Proportion") +
      theme_minimal()

# Different orientation (switch the x axis and fill variables)
sm_impact %>% 
      ggplot(aes(x = Primary_Platform, fill = Device_Type)) +
      geom_bar() +
      theme_minimal()

## Visualize 3 categorical variables-------------------------------------------#
sm_impact %>% 
      ggplot(aes(x = Device_Type, fill = Primary_Platform)) +
      geom_bar() +
      facet_wrap(. ~ Academic_Level) +
      theme_minimal()

# Proportions
sm_impact %>% 
      ggplot(aes(x = Device_Type, fill = Primary_Platform)) +
      geom_bar(position = "fill") +
      facet_wrap(. ~ Academic_Level) +
      labs(y = "Proportion") +
      theme_minimal()

## Wrangle/modify the data set before sending it to ggplot for visualization
sm_impact %>% 
      filter(Academic_Level == "Postgraduate") %>% # only examining postgrad group
      ggplot(aes(x = Daily_Usage_Hours,
                 y = Sleep_Duration_Hours,
                 colour = Primary_Platform)) +
      geom_point(alpha = 0.2) + # scatterplot
      theme_minimal()













