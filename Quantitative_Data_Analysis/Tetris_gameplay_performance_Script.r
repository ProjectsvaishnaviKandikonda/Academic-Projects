# Importing required libraries for data analysis and visualization
library(ggplot2)
library(dplyr)

# Setting the working directory to access the data file
setwd("~/Downloads")

# Step 1: Data Exploration and Preprocessing
# Reading the dataset
game_data <- read.csv("tetris.csv")

# Displaying a summary of the dataset
summary(game_data)
str(game_data)
head(game_data)

# Checking for any missing values in the dataset
sum(is.na(game_data))

# Step 2: Calculating Summary Statistics
# Grouping the data by condition and calculating statistics
summary_statistics <- game_data %>%
  group_by(condition) %>%
  summarise(
    average_score = mean(score),
    score_sd = sd(score),
    median_score = median(score),
    min_score = min(score),
    max_score = max(score)
  )
print(summary_statistics)

# Step 3: Data Visualization
# Generating a boxplot to compare scores by condition
ggplot(game_data, aes(x = condition, y = score, fill = condition)) +
  geom_boxplot() +
  labs(title = "Comparison of Tetris Scores by Interruption Type", x = "Interruption Type", y = "Game Score") +
  theme_minimal()

# Creating a histogram to visualize the distribution of scores
ggplot(game_data, aes(x = score, fill = condition)) +
  geom_histogram(binwidth = 5, alpha = 0.7, position = "identity") +
  labs(title = "Distribution of Scores", x = "Game Score", y = "Frequency") +
  theme_minimal()
