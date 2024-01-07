# R code to have minimal number of libraries and function
# so that it takes little time to restore on Renv


library("here")
library("ggplot2")


plot(c(1:100), c(11:110), main="plot a line", xlab="x", 
    ylab="y", type="b", col="red")
    
cat("done")

cat("added by feng on host before mount")
feng
