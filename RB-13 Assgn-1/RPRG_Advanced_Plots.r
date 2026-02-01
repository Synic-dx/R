# ==============================================================================
# R SCRIPT: Financial & Macro Analysis with ggplot2
# ==============================================================================

library(googlesheets4)
library(ggplot2)
library(dplyr)
library(scales)
library(lubridate)
library(stringr)

# ==============================================================================
# READ DATA
# ==============================================================================

gs4_deauth()
macro_df <- read_sheet(
  ss = "1a9W63opiU4WQvWWVAeOeHd3wjZQDogpnUHK2ktrSjJc",
  sheet = 1
)

gs4_auth()
fin_df <- read_sheet(
  ss = "187wWCQXWHSR1AkGyDfcPRLKcPS0MZc9PnrNxQW-9EUQ",
  sheet = 1
)

# ==============================================================================
# DATA PREPARATION
# ==============================================================================

# ---- Financial ----
fin_df <- fin_df %>%
  mutate(
    Date = as.Date(Date),
    Year = year(Date),
    Asset_Name = as.factor(Asset_Name),
    Volatility_Percent = as.numeric(Volatility_Percent),
    Monthly_Return_Percent = as.numeric(Monthly_Return_Percent),
    Trading_Volume_Billions = as.numeric(Trading_Volume_Billions),
    Price_Close = as.numeric(Price_Close)
  )

# ---- Macro ----
macro_df <- macro_df %>%
  mutate(
    Year = as.numeric(Year),
    Country = as.factor(Country),
    Region = as.factor(Region),
    Income_Group = as.factor(Income_Group),

    gov_clean = Government_Type %>%
      str_trim() %>%
      str_to_lower() %>%
      str_replace_all("center", "centre"),

    Government_Ideology = case_when(
      str_detect(gov_clean, "centre") &
        !str_detect(gov_clean, "left|right") ~ "Centre",
      str_detect(gov_clean, "left") ~ "Left",
      str_detect(gov_clean, "centre-right") ~ "Centre-Right",
      str_detect(gov_clean, "right") ~ "Right",
      TRUE ~ "Mixed"
    ),

    Government_Ideology = factor(
      Government_Ideology,
      levels = c("Left", "Centre", "Centre-Right", "Right", "Mixed")
    ),

    Inflation_Rate_Percent = as.numeric(Inflation_Rate_Percent),
    Growth_YoY_Percent = as.numeric(Growth_YoY_Percent),
    Economic_Stability_Score = as.numeric(Economic_Stability_Score)
  )

# ==============================================================================
# FILTER FINANCIAL DATA TO LAST 5 YEARS
# ==============================================================================

fin_recent <- fin_df %>%
  filter(Date >= max(Date, na.rm = TRUE) - years(5))

# ==============================================================================
# PLOT 1 (MACRO): INFLATION OVER TIME BY CONTINENT
# ==============================================================================

plot1 <- ggplot(
  macro_df,
  aes(Year, Inflation_Rate_Percent, color = Income_Group)
) +
  geom_jitter(alpha = 0.35, width = 0.25, height = 0) +
  geom_smooth(method = "loess", se = FALSE, linewidth = 1) +
  facet_wrap(~Region) +
  theme_minimal() +
  labs(
    title = "Inflation Trends Over Time Across Continents",
    x = "Year",
    y = "Inflation Rate (%)",
    color = "Income Group"
  )

# ==============================================================================
# PLOT 2 (FINANCIAL): ASSET PRICE TRENDS (ABSOLUTE SCALE)
# ==============================================================================

plot2 <- ggplot(fin_recent, aes(Date, Price_Close)) +
  geom_line(aes(color = Asset_Name), linewidth = 1) +
  facet_wrap(~Asset_Name, scales = "free_y", ncol = 3) +
  scale_y_continuous(labels = comma) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Asset Price Trends (Last 5 Years)",
    x = "Date",
    y = "Price (Absolute Scale)"
  )

# ==============================================================================
# PLOT 3 (MACRO): ECONOMIC STABILITY — VIOLIN + BOX + POINTS
# ==============================================================================

violin_df <- macro_df %>%
  filter(Government_Ideology != "Mixed")

mixed_df <- macro_df %>%
  filter(Government_Ideology == "Mixed")

plot3 <- ggplot() +
  geom_violin(
    data = violin_df,
    aes(Government_Ideology, Economic_Stability_Score,
        fill = Government_Ideology),
    trim = FALSE,
    alpha = 0.5
  ) +
  geom_boxplot(
    data = violin_df,
    aes(Government_Ideology, Economic_Stability_Score),
    width = 0.15,
    outlier.shape = NA,
    color = "black"
  ) +
  geom_jitter(
    data = violin_df,
    aes(Government_Ideology, Economic_Stability_Score),
    width = 0.08,
    size = 1.8,
    alpha = 0.6
  ) +
  geom_jitter(
    data = mixed_df,
    aes(Government_Ideology, Economic_Stability_Score),
    width = 0.08,
    size = 2.5,
    color = "black"
  ) +
  scale_x_discrete(drop = FALSE) +
  scale_fill_brewer(palette = "Set2") +
  theme_classic() +
  theme(legend.position = "none") +
  labs(
    title = "Economic Stability Across Government Ideologies",
    x = "Government Ideology",
    y = "Economic Stability Score"
  )

# ==============================================================================
# PLOT 4 (FINANCIAL): RISK–RETURN TRADEOFF
# ==============================================================================

plot4 <- ggplot(
  fin_df,
  aes(Volatility_Percent, Monthly_Return_Percent)
) +
  geom_point(
    aes(size = Trading_Volume_Billions, color = Asset_Name),
    alpha = 0.7
  ) +
  geom_smooth(method = "loess", se = FALSE, color = "black") +
  coord_cartesian(ylim = c(0, 200)) +
  scale_size_continuous(range = c(2, 8), labels = comma) +
  theme_classic() +
  labs(
    title = "Risk–Return Tradeoff Across Assets",
    x = "Volatility (%)",
    y = "Monthly Return (%)"
  )

# ==============================================================================
# SAVE PLOTS
# ==============================================================================

if (!dir.exists("plots")) dir.create("plots")

ggsave("plots/RB-13_1.jpg", plot1, width = 8, height = 6, dpi = 300)
ggsave("plots/RB-13_2.jpg", plot2, width = 8, height = 6, dpi = 300)
ggsave("plots/RB-13_3.pdf", plot3, width = 8, height = 6)
ggsave("plots/RB-13_4.pdf", plot4, width = 8, height = 6)

cat("✅ FIXED: ABSOLUTE PRICE SCALE USED — FINAL VERSION READY\n")
