# Data processing
# Read SimpleData2
# load package: googlesheets4 and tidyverse
library(googlesheets4)
library(tidyverse)
gs4_deauth()
gsheet_123 <- "1BV9KgyHtfhmW5yMzxyLF7q4jGZ5fC4YI7gfFatP5zSA"
salesDF <- read_sheet(gsheet_123, sheet = "SalesData")


salesDF |>
  filter(Year == 2015)|> # Filter for the year 2015
  arrange(Year, Sales)|> # Arrange by Year and Sales
  arrange(Year, desc(Sales)) # Arrange by Year and descending Sales

salesDF |>
  filter(Year == 2015)|>
  relocate(City, Year)|> # Relocate City and Year columns
  relocate(ShippingCost, .before = Profit) # Relocate ShippingCost before Profit


salesDF |> 
  arrange(City, Year) |>
  relocate(City, Year,Sales, Profit) |>
  rename(ShipCost = ShippingCost)|>
  relocate(ShipCost, .before = Profit)|>
  mutate(
    Profit_Margin = (Profit / Sales)*100,
    .after = Profit
  )

  filter(City=="Mumbai")|>
  ggplot(aes(Year, Profit))  + geom_col()



filter(Year %in% c(2015, 2016))




# Read data_dat.txt

stocks <- read_delim("data_dat.txt", delim = "|")

stocks <- read_delim("data_dat.txt", delim = "|", col_types = cols(co_stkdate = col_date(format = "%d-%m-%Y")))

stocks <- rename(stocks, code=co_code, company=company_name, date=co_stkdate, price = nse_closing_price)

stocks1 <- stocks |>
  filter(year(date)==2025)

stocks2 <- stocks1 |>
  filter(month(date)==9)

stocks3 <- stocks2 |>
  filter(day(date)==29)
