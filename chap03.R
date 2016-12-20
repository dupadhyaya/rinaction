#Chapter - 3 : Getting Started with Graphs ------------------------------------------

#3.1 Working with Graphs
# Attach mtcars dataset, plot wt vs mpg; draw abline and give title to graph; detach mtcar

attach(mtcars)
plot(wt,mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
detach(mtcars)

plot.new()
attach(mtcars)
layout(matrix(c(1,1,2,3),2,3,byrow=T))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)

# Listing 3.4 ----------------
boxplot(mtcars$wt)

