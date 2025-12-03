
# ███████╗███████╗███████╗███████╗██╗ ██████╗ ███╗   ██╗     ██╗
# ██╔════╝██╔════╝██╔════╝██╔════╝██║██╔═══██╗████╗  ██║    ███║
# ███████╗█████╗  ███████╗███████╗██║██║   ██║██╔██╗ ██║    ╚██║
# ╚════██║██╔══╝  ╚════██║╚════██║██║██║   ██║██║╚██╗██║     ██║
# ███████║███████╗███████║███████║██║╚██████╔╝██║ ╚████║     ██║
# ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═╝

# The up arrow moves back the previous command used (in console)
# use 'setwd()' to set the root file path (working directory)
# use 'getwd()' to get the working directory
# 'q()' quits console
# CTRL + L wipes console
# the environment tab shows ALL stored variables in RStudio
# 'source()' is used to run an entire file

#basic plot where x and y are the corresponding x and y coords
#NOTE: lengths of x and y vectors MUST be same
# In case of 'figure margins too large' error, resize the plot pane
x=c(1,2,3,4,5)
y=c(1,2,4,6,30)
plot(x,y)

# The jpg() function creates an empty jpg image, with the subsequent plot()
# function giving the plot
# dev.off() releases the file, allowing other programs to access it
# units argument gives the measurement, in this case it's "px" or pixels
jpeg("plots/plot2.jpg", width=600, height=600, units="px")
plot(x,y)
dev.off()

# The pdf() function creates an empty pdf file, with the subsequent plot()
# function giving the plot
# dev.off() releases the file, allowing other programs to access it
pdf("plots/plot2.pdf", width=4, height=6)
plot(x,y)
dev.off()

# The first argument of the pdf() and jpg() functions take the filename and filepath
# in my case, it writes to the plots folder inside W.D.
# these functions save to the working directory

# this command opens the file at given path
system('open "plots/plot2.jpg"')

