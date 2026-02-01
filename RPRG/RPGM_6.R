# Data types in R
# numeric, integer, complex, character, logical
# Use class() or typeof() to find type

x1 <- 3.1
class(x1)
typeof(x1)

x2 <- 3L
class(x2)
typeof(x2)

x3 <- 1+2i
class(x3)
typeof(x3)

x4 <- "abcd"
class(x4)
typeof(x4)

x5 <- TRUE
class(x5)
typeof(x5)

# digits to print; disable scientific notation with a high penalty of 999
options(digits = 16, scipen = 999)
options(digits = 7, scipen = 0) #default

# printing one-off case
1/3
sprintf("%.8f", 1/3)
sprintf("%.16f", 1/3)
sprintf("%.24f", 1/3)
sprintf("%.100f", 1/3)


# Typecasting
x6 <- 1/3
x6
class(x6)
typeof(x6)

x7 <- as.integer(x6)
class(x7)

x8 <- as.character(x6)
class(x8)



# Date Time
d1 <- as.Date("2025-8-15")
d1
as.numeric(d1)
d1+7

d2 <- as.Date("1970-01-01")
d2
as.numeric(d2)

Sys.Date()
Sys.time()
date()
timestamp()

# load package lubridate
library(lubridate)
today()
now()

ymd("2022-08-15")
ymd("2022-Aug-15")
ymd("2022-August-15")

iday1 <- dmy("15-August-1947")
iday1
as.numeric(iday1)

rday1 <- mdy("01-26-1950")
rday1
rday1 - iday1

ymd_hms("2025-12-31 23:59:59")
ymd_hms("2025-12-31 23:59:59", tz="Asia/Kolkata")

now()
now() + years(1) + months(5) + days (12)
now() + hours(2) + minutes(25) +seconds(45)

as.numeric(now())
as.numeric(today())


# check ymd(), dmy(), or mdy()

# Data structures in R
# Data structures in R:
# Vector, Matrix, Array (same type of atomic data)
# List, Data Frame (mixed data types)
# Factor (for categorical variables/levels)

v1 <- c(1,2,3)
v2 <- c("A","B","C")

l1 <- list("33","Raju", 75)
"Raju" %in% l1 # check if it is in list
  
m1 <- matrix(c(1:9), nrow=3)
m2 <- matrix(c(1:9), nrow=3, byrow=TRUE)

m3 <- matrix(c(1:9), nrow=3, ncol=4)
m3
m4 <- matrix(c(1:10), nrow=3, ncol=4)
nrow(m4); ncol(m4); dim(m4); length(m4)

10 %in% m4  # check if it is in matrix

m34 <- matrix(c(1:12), nrow=3)
m34
m34[2:3, 3:4]  # accessing part of a matrix
m34[-1,-(2:3)]  # accessing part of a matrix, excluding 1st row and 2nd-3rd columns
# rbind() or cbind() to combine two matrices

m34
for(x in m34){print(x)}
# print row wise
for (r in 1:nrow(m34)) {
  for (c in 1:ncol(m34)) { print(m34[r,c]) }
}

for(x in m34){print(x)}

arr1 <- array(c(1:24), dim=c(3,4,2))
arr1; dim(arr1) ; length(arr1)
for(x in arr1){print(x)}


roll_list <- data.frame(
  Roll_No = c(31,32,34),
  Name = c("Ajay", "Atul", "Aman"),
  Marks = c(55, 60, 70))


# head(), str(), structure(),summary()
# names(), colnames()
# nrow(), ncol(), dim(), length()
# apply(), lapply(), sapply()
head(roll_list)
str(roll_list)
structure(roll_list)
summary(roll_list)

l2 <- list("33","Raju", 75)
rbind(roll_list, l2)

m33 <- matrix(c(1:9), nrow=3)
m33
apply(m33,1,sum)
apply(m33,2,sum)

mtcars
apply(mtcars,2,mean)
lapply(mtcars,mean) # list apply
sapply(mtcars,mean) # simple apply
tapply(mtcars$mpg, mtcars$cyl, mean)
tapply(mtcars$disp, mtcars$cyl, mean)


# Operators and Control Structures
#  Operators:
#  +   -   *   /#    ^  or  **  exponent  
# #  %/%  integer division (quotient)
#  %%   modulus (remainder)

# Comparison: ==, !=, >, <, >=, <=


#  If-Else
#  if (a > b) { ... }
#  else if (a == b) { ... }
#  else { ... }

#  if (a > b & c > a) { ... }
#  if (a > b | a > c) { ... }

#  Looping
i <- 1
while (i < 10) { print(i) ;   i <- i + 1 }   # break and next

for (x in 1:10) { print(x) }   # break and next

list1 <- 1:4 ;  list2 <- c(10,100,1000) ;
for (x in list1) {   for (y in list2) { print(x+y) }   }

1:10
seq(from = 0, to = 100, by = 10)