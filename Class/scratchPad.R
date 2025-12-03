x<-c(1,2,3,4,5)
y<-c(1,2,4,8,10)
plot(x,y)

z<-c(10,20,30,40,50)

plot(x,y)




jpeg("plots/plot2.jpeg", width = 600, height = 600, units = "px") 
plot(x, y)
dev.off()

source('file2.R')

Xs <- c(1, 2, 3, 4, 5)
Ys <- c(2, 4, 8, 16, 250)

pdf("plots/plot1.pdf", width = 4, height = 6)
plot(Xs, Ys)
dev.off()


system('open "plots/plot1.pdf"')

