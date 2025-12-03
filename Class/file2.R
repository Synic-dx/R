Xs <- c(1, 2, 3, 4, 5)
Ys <- c(2, 4, 8, 16, 250)

pdf("plots/plot1.pdf", width = 4, height = 6)
plot(Xs, Ys)
dev.off()

jpeg("plots/plot2.jpeg", width = 600, height = 600, units = "px") 
plot(Xs, Ys)
dev.off()

png("plots/plot3.png", width = 600, height = 600, units = "px") 
plot(Xs, Ys)
dev.off()
