library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
mpg

#Some info functions
str(mpg)
summary(mpg)

# Number of datasets available in ggplot2
data(package = 'ggplot2')

# Basic scatter plot of engine displacement vs. highway miles per gallon
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
# aes stands for aesthetic mapping, geom_point() adds points to the plot

# Scatter plot of car models by manufacturer
ggplot(mpg, aes(model, manufacturer)) +
  geom_point()

# Line plot of unemployment over time using the economics dataset
ggplot(economics, aes(date, unemploy)) +
  geom_point() +
  geom_line()

# Histogram of city miles per gallon
ggplot(mpg, aes(cty)) + 
         geom_histogram()

# Scatter plot of engine displacement vs. city miles per gallon colored by vehicle class
ggplot(mpg, aes(displ, cty, colour = class)) +
  geom_point()
# Scatter plot of engine displacement vs. city miles per gallon with different shapes for drive type
ggplot(mpg, aes(displ, cty, shape = drv)) +
  geom_point()
# Scatter plot of engine displacement vs. city miles per gallon with point size representing number of cylinders
ggplot(mpg, aes(displ, cty, size = cyl)) +
  geom_point()

# Scatter plot of engine displacement vs. highway miles per gallon with fixed blue color
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = "blue"))
# Note: The above code maps the color aesthetic to a constant value, which is not the intended use.
# Correct way to set a fixed color for all points:
ggplot(mpg, aes(displ, hwy)) +
  geom_point(colour = "blue")


# Faceted scatter plot of engine displacement vs. highway miles per gallon by vehicle class
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~ class)

# smooth trend line
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(#se = FALSE
              #method = "lm"
              #method = "gam", formula = y ~ s(x, bs = "cs")
              #span = 0.2
              )

# Different geometric representations of engine displacement vs. highway miles per gallon
ggplot(mpg, aes(displ, hwy)) +
  geom_jitter()
ggplot(mpg, aes(displ, hwy)) +
  geom_boxplot()
ggplot(mpg, aes(displ, hwy)) +
  geom_violin()
ggplot(mpg, aes(manufacturer)) +
  geom_bar()

# Different ways to visualize the distribution of highway miles per gallon
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2)
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth = 1)
ggplot(mpg, aes(displ, hwy)) + geom_density2d()

# Histogram of engine displacement filled by drive type
ggplot(mpg, aes(displ, fill = drv)) +
  geom_histogram(binwidth =0.5) +
  facet_wrap(~ drv, ncol = 1)

# Line plots of various economics dataset variables over time
ggplot(economics, aes(date, unemploy / pop)) + geom_line()
ggplot(economics, aes(date, uempmed)) + geom_line()

# Path plots are lines traced through points in the order they appear in the data
ggplot(economics, aes(unemploy / pop,uempmed)) +
  geom_path() +
  geom_point()

# Alpha stands for transparency
ggplot(mpg, aes(cty, hwy)) + 
  geom_point(alpha = 8/9) +
  xlab(NULL) +
  ylab(NULL)

# Jittered scatter plot of drive type vs. highway miles per gallon with specified x and y limits
ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25) +
  xlim("f", "r") +
  ylim(20,30)

# Assigning a ggplot object to a variable and printing it
p <-  ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point()
print(p)
# Saving the plot to a file
ggsave("ggplot2_scatter.pdf", plot = p, width = 6, height = 4)

# Using qplot for quick plots
qplot(displ, hwy, data = mpg, colour = I("blue"))


df <- data.frame(
  x = c(3,1,5),
  y= c(2,4,6),
  label = c("a", "b", "c")
)

p <- ggplot(df, aes(x,y, label = label)) +
  labs(x = NULL, y= NULL) +
  theme(plot.title = element_text(size = 12))
  
#1,2,4,2,4,5,1,3,4
  p + geom_point() + ggtitle("point")
  p + geom_text() + ggtitle("text")
  p + geom_bar(stat= "identity") + ggtitle("bar")
  p + geom_tile() + ggtitle("raster")
  p + geom_line() + ggtitle("line")
  p + geom_area() + ggtitle("area")
  p + geom_step() + ggtitle("step")
  p + geom_path() + ggtitle("path")
  p + geom_polygon() + ggtitle("polygon")
  p + geom_boxplot() + ggtitle("boxplot")
  p + geom_violin() + ggtitle("violin")
  
