
#░██████╗███████╗░██████╗░██████╗██╗░█████╗░███╗░░██╗  ██████╗░
#██╔════╝██╔════╝██╔════╝██╔════╝██║██╔══██╗████╗░██║  ╚════██╗
#╚█████╗░█████╗░░╚█████╗░╚█████╗░██║██║░░██║██╔██╗██║  ░█████╔╝
#░╚═══██╗██╔══╝░░░╚═══██╗░╚═══██╗██║██║░░██║██║╚████║  ░╚═══██╗
#██████╔╝███████╗██████╔╝██████╔╝██║╚█████╔╝██║░╚███║  ██████╔╝
#╚═════╝░╚══════╝╚═════╝░╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝  ╚═════╝░

library(ggplot2)

g <- ggplot(mpg, aes(displ, hwy)) + geom_point()
g #saves this plot in variable g
g1 <- g + geom_smooth(method = "lm")
g1 #adds a linear regression line

# Examples of common geom_smooth methods:
# - "auto"  : default (loess for small n, gam for large n if mgcv present)
# - "loess" : local regression (span tunable: lesser the span, more flexible or wigglier the fit)
# - "lm"    : linear model (can pass formula for polynomials)
#Advanced (not required)
# - "glm"   : generalized linear model (pass family via method.args)
# - "gam"   : generalized additive model (needs mgcv::gam)
# - "rlm"   : robust linear model (MASS::rlm)

p1 <- ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method = "loess")
p1
p1 <- p1 + coord_cartesian(xlim = c(0, 5), ylim = c(0, 30))
p1
p1 <-  p1 + xlim(0, 5) + ylim(0, 30)
p1

# both of these (coord_cartesian & xlim/ylim) achieve similar effects of zooming in
# but xlim/ylim removes data outside the limits, and recomputes the regression line
# whereas coord_cartesian keeps all data and just changes the visible area

p1 <- p1 + coord_cartesian(xlim = c(0, 10), ylim = c(0, 50)) #just zooms in
p1
p1 <- p1 + scale_y_continuous(breaks = seq(0, 50, by = 5)) #sets the y-axis breaks
p1
p1 <- p1 + scale_x_continuous(breaks = seq(0, 10, by = 1)) #sets the x-axis breaks
p1
p1 <- p1 + scale_x_continuous(breaks = c(2, 3, 4, 6))  #sets the x-axis breaks manually
p1

# Data Import Export

# Data importing and exporting in various formats including csv, excel, text, etc formats
# Data cleaning and filtering using tidyverse

# import and export xls, xlsx data
# Install packages (only need to run this once); else through R-Studio
install.packages("readxl") # for reading xlsx files
install.packages("writexl") # for writing xlsx files
install.packages("readr")   # for reading csv files

# Load packages (run this at the beginning of each session or script); check-box in R-Studio
library(readxl)
library(writexl)
library(readr)

# Read the Excel file as DF, and save a DF as xls
newDF <- read_excel("RPRG/data/mpg_data.xlsx", sheet = "Sheet1")
write_xlsx(newDF, "RPRG/data/new_file.xlsx")

# import and export csv data
newData <- read.csv("data123.csv", na = c("N/A", ""))
write.csv(mpg, file = "output_file.csv", row.names = FALSE) #row.names False stands for not including row names

# install.packages("tidyverse")
# library(tidyverse)
read_csv("data123.csv", col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"), skip = 1, show_col_types = FALSE)

write_csv(mpg, file = "output_file_2.csv")