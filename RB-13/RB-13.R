#This is the RScript for our Group Project
#Team name: RB-13

# Loading Libraries
library(googlesheets4)
library(tidyverse)
library(ggplot2)


# Google Sheets IDs, saving it in variables to make things easier
PUBLIC_SHEET_ID <- "1K7SF0ElsZ85mVuZWmp1UJNGxgxeNSbcohkY7uuuifjo"
RESTRICTED_SHEET_ID <- "1cD61loCtXsFSx-v2ZW07RbpOzYWl5EoPPWxHjFna8T0"


# Public Sheet (De-authorised)
gs4_deauth()

public_df <- read_sheet(
  PUBLIC_SHEET_ID,
  sheet = "Sheet1"
)


# Restricted Sheet (Authorised)
gs4_auth()

restricted_df <- read_sheet(
  RESTRICTED_SHEET_ID,
  sheet = "Sheet1"
)


# Data preparation, ensuring everything is in desired format
public_df <- public_df %>%
  mutate(
    date = as.Date(date), #ensuring its in date format
    region = as.factor(region), #ensuring its in categorical format
    city_tier = as.factor(city_tier), #ensuring its in categorical format
    platform = as.factor(platform), #ensuring its in categorical format
    campaign_type = as.factor(campaign_type) #ensuring its in categorical format
  )


# PLOT 1 (IMAGE)
# ROI vs Ad Spend with regression + facets
p1 <- ggplot(
  public_df,
  aes(ad_spend, roi, colour = campaign_type) # Mapping ad_spend and roi to x and y axes, respectively
) +
  geom_point(alpha = 0.6) + #alpha means transparency
  geom_smooth(method = "lm", se = FALSE) + #linear model of regression - straight lines
  facet_wrap(~ region) + #create separate plots for each region
  labs(
    title = "ROI vs Ad Spend by Campaign and Region",
    x = "Ad Spend",
    y = "Return on Investment"
  ) +  theme_minimal() #minimal theme, removes the gray table background

ggsave(
  filename = "plots/RA-01_1.jpg",
  plot = p1,
  width = 8,
  height = 6,
  units = "in"
)


# PLOT 2 (IMAGE)
# CTR distribution by city tier and platform
p2 <- ggplot(
  public_df,
  aes(ctr, fill = platform) # Mapping ctr to x axis and showing platform stats via color coding
) +
  geom_histogram(binwidth = 0.005, alpha = 0.7) + # Histogram for CTR (Click Through Rate) distribution
  facet_wrap(~ city_tier, ncol = 1) + # create separate plots for each city tier
  labs(
    title = "CTR Distribution by City Tier and Platform",
    x = "Click Through Rate",
    y = "Frequency"
  ) +
  theme_minimal() # Minimal theme, removes the gray table background

ggsave(
  filename = "plots/RA-01_2.jpg",
  plot = p2,
  width = 7,
  height = 7,
  units = "in"
)


# PLOT 3 (PDF)
# Revenue time series faceted by campaign type
pdf("plots/RA-01_3.pdf", width = 9, height = 6)

ggplot(
  public_df,
  aes(date, revenue, colour = region) # Mapping date and revenue to x and y axes, respectively
) +
  geom_line() +
  facet_wrap(~ campaign_type) + # create separate plots for each campaign type
  labs(
    title = "Revenue Trend Over Time by Campaign Type",
    x = "Date",
    y = "Revenue"
  ) +
  theme_minimal()

dev.off()


# PLOT 4 (PDF)
# Satisfaction vs ROI (multivariate)
pdf("plots/RA-01_4.pdf", width = 7, height = 6)

ggplot(
  public_df,
  aes(
    customer_satisfaction,
    roi,
    size = conversions, # Bubble size represents the number of conversions
    colour = city_tier # Colour represents the city tier
  )
) +
  geom_point(alpha = 0.7) +
  labs(
    title = "Customer Satisfaction vs ROI",
    x = "Customer Satisfaction Score",
    y = "ROI",
    size = "Conversions"
  ) +
  theme_minimal()

dev.off()