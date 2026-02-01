# RPRG individual assignment - 2025IPM128

library(ggplot2)
library(dplyr)
library(lubridate)
library(googlesheets4)

roll_no <- "2025IPM128"
sheet_id <- "1yt9IQEo0CeKE3wdtjYR4pDFX53EitOHoUrjzMpiaLZI"

# -------- getting assigned company + year from sheet --------

assignment <- tryCatch({
  gs4_deauth()
  read_sheet(sheet_id, sheet = 1)
}, error = function(e) {
  message("google sheets not working, using local csv instead")
  read.csv("roll_assignment.csv", stringsAsFactors = FALSE)
})

my_info <- assignment %>%
  dplyr::filter(`Roll Number` == roll_no)

my_co_code   <- my_info$co_code
year_assigned <- my_info$Year

print(my_co_code)
print(year_assigned)

# -------- loading stock file + filtering my data --------

stocks <- read.csv("stocks25.txt", sep = "|", stringsAsFactors = FALSE)

my_stocks <- stocks %>%
  dplyr::filter(co_code == my_co_code) %>%
  dplyr::mutate(
    date = as.Date(co_stkdate, format = "%d-%m-%Y"),
    year = year(date)
  ) %>%
  dplyr::filter(year == year_assigned) %>%
  dplyr::arrange(date)

# extracting correct company name safely
company_name <- unique(my_stocks$company_name)

# -------- plotting the graph --------

my_stocks

p <- ggplot(my_stocks, aes(date, nse_closing_price)) +
  geom_line(size = 0.8) +
  geom_point(size = 1.3, alpha = 0.6) +
  geom_smooth(method = "loess", se = TRUE, alpha = 0.2) +
  labs(
    title = paste("NSE Stock Price Movement -", company_name),
    subtitle = paste("Year:", year_assigned, "| Company Code:", my_co_code),
    x = "Date",
    y = "NSE Closing Price (₹)",
    caption = paste(
      "Roll:", roll_no
    )
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

print(p)

# -------- saving the output file --------

ggsave(
  filename = paste0(roll_no, ".jpg"),
  plot = p,
  width = 12,
  height = 7,
  dpi = 300 # Dots per inch
)
