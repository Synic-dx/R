x=c(1,2,3,4,5)
y=c(1,2,4,6,30)
y2=c(2,3,5,7,25)

#cex is for size, pch is for point shape, type is for line type, lwd is for line width
plot(x, y, main="Main title", xlab="X-axis label", ylab="Y-axis label",
     col='blue', cex = 3, pch = 1, type = 'b', lwd= 2,
     )
# Add additional line (note: lines(), no type=)
lines(x, y2,
      lty = 2,        # dashed line
      lwd = 2,
      col = "red")

# types
# p : points only
# l : lines only
# b : both points and lines
# c : lines excluding endpoints
# o : overplotted points and lines
# h : histogram vertical lines
# s : staircase step
# S : other staircase step
# n : axes only, no plot

#lty is for line style
# 1: solid line
# 2: dashed line
# 3: dotted line
# 4: dotdash line
# 5: longdash line
# 6: twodash line



# pie-chart
p1 <- c(10,20,30,40)
myLabels <- c('A','B','C','D')
myColors <- c('blue','green','red','yellow')
pie(p1, init.angle = 90, label = myLabels, main='Main Title',
# init.angle rotates the start of the pie chart, positive means anti-clockwise
    col=myColors)
legend("bottomright", myLabels, fill = myColors)

# bar graphs
barplot(p1, names.arg = myLabels, col=myColors)
# horiz = TRUE for horizontal bars; density=10 for shading
barplot(p1, names.arg = myLabels, col=myColors, density=10, horiz=TRUE)


#ggplot2
#install.packages("ggplot2")   # only once
library(ggplot2)
# Check mpg dataset from ggplot2
head(mpg) # first six rows
summary(mpg) # summary statistics
structure(mpg) # structure of dataset
colnames(mpg) # column names
mpg

#Save the dataset as an xls file
install.packages("writexl")   # only once
library(writexl)              # every new session
write_xlsx(mpg, "xls/mpg_data.xlsx")

# three key components of every plot: data, aesthetics and geoms
# Data; Aesthetic mapping; Geom function {geom_point(), geom_histogram(), geom_line()}
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(mpg, aes(cty, hwy)) + geom_point()

ggplot(mpg, aes(cty)) + geom_histogram()
ggplot(mpg, aes(cty)) + geom_histogram(binwidth = 0.5) #binwidth: width of each bar

ggplot(mpg, aes(cty)) + geom_bar(stat = "count") # default for geom_bar(), works as a histogram, 
# stat = "identity" requires y-axis to be numeric as it sets the 'frequency' values directly from given y-axis data rather than count x-axis data
ggplot(mpg, aes(drv)) + geom_bar() 
ggplot(mpg, aes(cyl)) + geom_bar()

ggplot(mpg, aes(cyl, fill=drv)) + geom_bar() #fill bars by drv

cylF=as.factor(mpg$cyl) #as.factor() converts numeric to categorical variable
ggplot(mpg, aes(drv, fill=cylF)) + geom_bar() #fill bars by cylF

ggplot(mpg, aes(displ)) + 
  geom_histogram()
ggplot(mpg, aes(displ)) + 
  geom_freqpoly() # frequency polygon: line graph of histogram
ggplot(mpg, aes(displ, colour=drv)) + 
  geom_freqpoly(binwidth=1) # line graph of histogram colored by drv

ggplot(economics, aes(date, unemploy)) + geom_line()
ggplot(mpg, aes(drv, hwy)) + geom_point() #when x-axis is categorical, points stack up, creating problems
ggplot(mpg, aes(drv, hwy)) + geom_jitter() #hence this shifts the points marginally for visibility of density
ggplot(mpg, aes(drv, hwy)) + geom_boxplot() #classic box and whisker plot
ggplot(mpg, aes(drv, hwy)) + geom_violin() #more precise than boxplot, shows density

#Saving plots:
  ggplot(mpg, aes(cty, hwy)) + geom_point() + xlab("city (mpg)") + ylab("highway (mpg)")

p <- ggplot(mpg, aes(cty, hwy)) + geom_point() + xlab("city (mpg)") + ylab("highway (mpg)")
ggsave("plot1.png", p, width = 5, height = 5)

pdf("plot1.pdf", width = 4, height = 6)
ggplot(mpg, aes(cty, hwy)) + geom_point() + xlab("city (mpg)") + ylab("highway (mpg)")
dev.off()

ggplot(mpg, aes(displ, cty)) + geom_point()
ggsave("output.pdf")

p <- ggplot(mpg, aes(displ, cty)) + geom_point()
ggsave("output.pdf", plot = p, width = 8, height = 6, units = "in")
# ggsave() can produce .eps, .pdf, .svg, .wmf, .png, .jpg, .bmp, and .tiff
# size in in, cm, mm, px

#Size, shape, color:
  # aes(displ, hwy, colour/shape/size = ___)
  ggplot(mpg, aes(displ, hwy, colour=class, shape=drv, size=cyl)) + geom_point()
ggplot(mpg, aes(displ, hwy, colour=class, shape=drv)) + geom_point(size=2)
ggplot(mpg, aes(displ, hwy, shape=drv)) + geom_point(colour='blue', size=2)

#Categorical variables for separating plots:
  ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap(~class)

ggplot(mpg, aes(displ)) + geom_histogram()
ggplot(mpg, aes(displ)) + geom_freqpoly()
ggplot(mpg, aes(displ, fill=drv)) + geom_histogram()
ggplot(mpg, aes(displ, colour=drv)) + geom_freqpoly(binwidth=1)

+facet_wrap(~fl, ncol = 1)

ggplot(mpg, aes(displ, fill = drv)) + geom_histogram(binwidth = 0.5) +
  facet_wrap(~fl, ncol = 1)

ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth()
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method = "lm")

