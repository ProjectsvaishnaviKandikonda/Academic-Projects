# Load necessary libraries
library(dplyr)
library(ggplot2)
library(lubridate)
library(RColorBrewer)
library(viridis)

# Set working directory
setwd("~/desktop") # Change this to your desired path

# Safely read the datasets
listings <- tryCatch(read.csv("listings_cleaned.csv"), error = function(e) stop("Error loading listings_cleaned.csv"))
reviews <- tryCatch(read.csv("reviews.csv"), error = function(e) stop("Error loading reviews.csv"))

# Ensure 'date' is in Date format
if ("date" %in% colnames(reviews)) {
  reviews$date <- tryCatch(as.Date(reviews$date, format = "%Y-%m-%d"), error = function(e) stop("Invalid date format in 'date' column."))
} else {
  stop("No 'date' column found in reviews.csv.")
}

# Convert 'date' column in reviews to Date format
reviews <- reviews %>%
  mutate(
    year = year(date),
    month = month(date, label = TRUE, abbr = TRUE) # Extract month as abbreviated name
  )

# Join reviews with listings to include neighbourhood information
reviews_with_neighbourhood <- reviews %>%
  inner_join(select(listings, id, neighbourhood), by = c("listing_id" = "id"))

# ---- 1. Seasonal Trends Analysis ----
reviews <- reviews %>%
  mutate(year_month = format(date, "%Y-%m"))

seasonal_trends <- reviews %>%
  group_by(year_month) %>%
  summarise(total_reviews = n(), .groups = 'drop') %>%
  mutate(year_month = as.Date(paste0(year_month, "-01")))

top_n <- 5
top_months <- seasonal_trends %>%
  arrange(desc(total_reviews)) %>%
  slice(1:top_n)

ggplot(seasonal_trends, aes(x = year_month, y = total_reviews)) +
  geom_line(linewidth = 1, color = "blue") +
  geom_point(size = 2, color = "blue") +
  geom_point(data = top_months, aes(x = year_month, y = total_reviews), color = "red", size = 4) +
  geom_text(data = top_months, aes(x = year_month, y = total_reviews, label = format(year_month, "%b %Y")), vjust = -1, size = 4, color = "red") +
  labs(title = "Seasonal Trends in Review Frequency", x = "Time (Year-Month)", y = "Total Reviews") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_date(date_labels = "%b %Y", date_breaks = "6 months")
ggsave("seasonal_trends.png", width = 10, height = 6)

# ---- 2. Yearly Growth Analysis ----
yearly_trends <- reviews %>%
  mutate(year = year(date)) %>%
  group_by(year) %>%
  summarise(total_reviews = n(), .groups = 'drop')

ggplot(yearly_trends, aes(x = year, y = total_reviews)) +
  geom_line(linewidth = 1, color = "blue") +
  geom_point(size = 4, color = "blue") +
  geom_text(aes(label = total_reviews), vjust = -0.5, size = 3, color = "blue") +
  labs(title = "Yearly Growth in Reviews", x = "Year", y = "Total Reviews") +
  theme_minimal(base_size = 14) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  annotate("text", x = 2021, y = 2000, label = "Trend line", color = "red", size = 4, angle = 45)
ggsave("yearly_growth.png", width = 8, height = 6)

# ---- 3. Review Frequency by Day of the Week ----
reviews <- reviews %>%
  mutate(day_of_week = wday(date, label = TRUE))

reviews_day_of_week <- reviews %>%
  group_by(day_of_week) %>%
  summarise(total_reviews = n(), .groups = 'drop')

ggplot(reviews_day_of_week, aes(x = day_of_week, y = total_reviews, fill = day_of_week)) +
  geom_bar(stat = "identity") +
  labs(title = "Review Frequency by Day of the Week", x = "Day of the Week", y = "Total Reviews") +
  theme_minimal(base_size = 14) +
  scale_fill_viridis(discrete = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("review_frequency_by_day.png", width = 8, height = 6)

# ---- 4. Monthly Average Review Counts for Top Neighborhoods ----
# Calculate average review counts per month across all years for each neighbourhood
monthly_avg_reviews <- reviews_with_neighbourhood %>%
  group_by(neighbourhood, month) %>%
  summarise(avg_reviews = mean(n(), na.rm = TRUE), .groups = 'drop')

# ---- 5. Filter top 5 neighbourhoods by total reviews -----
top_neighbourhoods <- reviews_with_neighbourhood %>%
  group_by(neighbourhood) %>%
  summarise(total_reviews = n(), .groups = 'drop') %>%
  top_n(5, total_reviews) %>%
  pull(neighbourhood)

filtered_data <- monthly_avg_reviews %>%
  filter(neighbourhood %in% top_neighbourhoods)

# Plot the monthly average review counts for top neighbourhoods
ggplot(filtered_data, aes(x = month, y = avg_reviews, color = neighbourhood, group = neighbourhood)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Average Monthly Review Counts for Top Neighbourhoods in Dublin",
    x = "Month",
    y = "Average Number of Reviews",
    color = "Neighbourhood"
  ) +
  theme_minimal() +
  theme(
    text = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
ggsave("monthly_avg_reviews_neighbourhood.png", width = 12, height = 8)
