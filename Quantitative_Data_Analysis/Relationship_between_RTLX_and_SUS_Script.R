setwd("/Users/kandikondavaishnavi/Desktop/QDA/")

# Load data
data <- read.csv("SusRtlx.csv")

# Remove rows with invalid SUS scores (less than 0 or greater than 100)
data.clean <- data[(data$SUS.Score >= 0 & data$SUS.Score <= 100), ]

# Check the cleaned data
summary(data.clean)

# o/p 
#       ID           SUS.Score        RTLX.Score   
# Min.   :  1.00   Min.   :  0.00   Min.   :20.00  
# 1st Qu.: 25.25   1st Qu.: 35.62   1st Qu.:37.25  
# Median : 49.50   Median : 52.50   Median :42.50  
# Mean   : 49.69   Mean   : 53.70   Mean   :42.59  
# 3rd Qu.: 73.75   3rd Qu.: 70.00   3rd Qu.:50.00  
# Max.   :100.00   Max.   :100.00   Max.   :62.00 

# SUS Score Descriptive Statistics
sus_mean <- mean(data.clean$SUS.Score)
sus_sd <- sd(data.clean$SUS.Score)
sus_median <- median(data.clean$SUS.Score)
sus_iqr <- IQR(data.clean$SUS.Score)

# RTLX Score Descriptive Statistics
rtlx_mean <- mean(data.clean$RTLX.Score)
rtlx_sd <- sd(data.clean$RTLX.Score)
rtlx_median <- median(data.clean$RTLX.Score)
rtlx_iqr <- IQR(data.clean$RTLX.Score)

# Print descriptive stats
cat("SUS Mean:", sus_mean, "\nSUS SD:", sus_sd, "\nSUS Median:", sus_median, "\nSUS IQR:", sus_iqr, "\n")
cat("RTLX Mean:", rtlx_mean, "\nRTLX SD:", rtlx_sd, "\nRTLX Median:", rtlx_median, "\nRTLX IQR:", rtlx_iqr, "\n")
# Load necessary libraries
library(ggplot2)

# Boxplot and Histogram for SUS Score
ggplot(data.clean, aes(y = SUS.Score)) +
  geom_boxplot(fill = "lightblue") +
  ggtitle("Boxplot of SUSScore") +
  theme_minimal()

ggplot(data.clean, aes(x = SUS.Score)) +
  geom_histogram(fill = "lightblue", color = "black", bins = 10) +
  ggtitle("Histogram of SUSScore") +
  theme_minimal()

# Boxplot and Histogram for RTLX Score
ggplot(data.clean, aes(y = RTLX.Score)) +
  geom_boxplot(fill = "lightcoral") +
  ggtitle("Boxplot of RTLXScore") +
  theme_minimal()

ggplot(data.clean, aes(x = RTLX.Score)) +
  geom_histogram(fill = "lightcoral", color = "black", bins = 10) +
  ggtitle("Histogram of RTLXScore") +
  theme_minimal()
  
# Scatter Plot of SUS vs RTLX Score
ggplot(data.clean, aes(x = SUS.Score, y = RTLX.Score)) +
  geom_point(color = "lightblue", size = 2) +
  geom_smooth(method = "lm", color = "blue", linetype = "dashed") +
  ggtitle("Scatter Plot: SUSScore vs RTLXScore") +
  theme_bw()

# Pearson correlation test
correlation_test <- cor.test(data.clean$SUS.Score, data.clean$RTLX.Score)
correlation_test
ggsave("sus_rtlx.png", width = 10, height = 8, dpi = 100)
