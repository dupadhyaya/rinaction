#Chapter - 6 : Basic Graphs ------------------------------------------
# Bar, Box, Dot Plots
# Pie and Fan Charts
# Histograms and Kernel Density Plots


# 6.1  Barplot
height = seq(4,7,.25)
barplot(height)
barplot(height, horiz = T)

library(vcd)
head(Arthritis)
str(Arthritis)
counts = table(Arthritis$Improved)
counts

# Listing 6.1 Simple Bar Plots
barplot(counts, main='Simple Bar Plot', xlab='Improvement', ylab=' Frequency')
barplot(counts, main='Simple Bar Plot', horiz = T, 
        xlab='Improvement', ylab=' Frequency')

# if cat variable is (ordered) FACTOR - vertical plot 
str(Arthritis)
plot(Arthritis$Treatment)
str(Arthritis$Improved)
plot(Arthritis$Improved)  # see the order of display
plot(Arthritis$Improved, horiz=T)

# 6.1.2  Stacked and Grouped bar Plots
# if height is a matrix instead of vector, we can create stacked or gp bar plot
height = matrix(1:20, nrow=5)
height
barplot(height)
barplot(height, horiz = T)
barplot(height, beside=T) # side by side
barplot(height, beside=T,legend.text = ' Heights')

#colnames(height) = c('C1','C2', 'C3', 'C4')
#rownames(height) = c('A','B','C','D','E')
#height
#barplot(height, beside=T, legend=rownames(height), legend.text = ' Heights')


library(vcd)
counts= table(Arthritis$Improved, Arthritis$Treatment)  # X tab
counts
barplot(counts)
barplot(counts, col=c('red', 'green', 'blue'))
barplot(counts, col=c('red', 'green', 'blue'), legend=rownames(counts))

barplot(counts, beside=T)
barplot(counts, beside=T, col=c('red', 'green', 'blue')
        , legend=rownames(counts))
barplot(counts, beside=T, col=c('red', 'green', 'blue')
        , legend=rownames(counts))
