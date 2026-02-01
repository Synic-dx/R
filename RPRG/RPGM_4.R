#  _________                    .__                   _____  
# /   _____/ ____   ______ _____|__| ____   ____     /  |  | 
# \_____  \_/ __ \ /  ___//  ___/  |/  _ \ /    \   /   |  |_
# /        \  ___/ \___ \ \___ \|  (  <_> )   |  \ /    ^   /
#/_______  /\___  >____  >____  >__|\____/|___|  / \____   | 
#        \/     \/     \/     \/               \/       |__| 

# clipboard data
library(tidyverse)
x1 <- readClipboard()

my_data <- read.table(file = "clipboard", sep = "\t", header = TRUE)
my_data


# de-limiters

# read_csv(): For comma-separated values (,)
# read_tsv(): For tab-separated values (\t)
# read_csv2(): For semicolon-separated values (;)
my_dat1 <- read_delim("RPRG/data/data_dat.txt", delim = "|", show_col_types = FALSE) # Custom delimited file
my_dat1

# read data from googlesheet
#install.packages("googlesheets4")
#install.packages('tidyverse')
library(googlesheets4)
library(tidyverse)

# world_population
gs4_deauth()
file_11 <- "1_CSUeJfZ_bmE6xdDu5vUFuQR_wwMhMKEXDcFyW3cJe4"
newDF_11 <- read_sheet(file_11, sheet = "Sheet1")
newDF_11

gs4_deauth()
file_url_11 <- "https://docs.google.com/spreadsheets/d/1_CSUeJfZ_bmE6xdDu5vUFuQR_wwMhMKEXDcFyW3cJe4"
newDF_22 <- read_sheet(file_url_11, sheet = "Sheet1")
newDF_22

# This is for files with restricted access, like our timetable
gs4_auth()
#gs4_auth(email = "i25ShinjanG@iimidr.ac.in")

timeTable <- read_sheet('16nszeC-D9AkZEdTkLmWsEtLXHJK3SP2EDkwREOsSVTw', sheet = "Time Table Term II ") 
#Use sheet_names('URL') to list out sheets in case of sheet not found error (typos)
timeTable
