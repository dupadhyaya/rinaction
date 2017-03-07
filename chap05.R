#Chapter - 5 : Advanced Data Management ------------------------------------------
# Mathematical and Statistical Functions
# Character Functions
# Looping and conditional Execution
# User Written Functions
# Ways to Aggregate and reshape data

# 5.1 Data Mgt challenge
# Transformation due to varied ranges of marks
# 5.2 Numerical and Character Functions

# 5.2.1 Mathematical Functions
# abs, sqrt, ceiling, floor, trunc, round, signif, cos, sin tan
# acos, asin, atan, Hyperbolic: cosh, sinh, tanh, acosh, asinh, atanh
# log(x,base=n), log(x): Natural Log, log10(x): common log, exp
sqrt(c(4,16,25))

# 5.2.2 Statistical Functions
x= 1:1000
y = mean(x)
y
x= c(1:5, 500:1000, 2000:2005)
mean(x)
z = mean(x, trim=0.05, na.rm=T)
z
# z trimmed mean; dropping highest & lowest trim% of scores and missing value
# mean, median, sd, var, mad, quantile, range, sum 
# diff(x, lag=n): lagged diff, min, max, 
# scale(x, center=T, scale=T):  column Center or standardise(center=T, scale=T)

x = c(1,2,3,4,5,6,7,8)
mean(x)
sd(x)
length(x)
# another way 
(meanx = sum(x)/length(x))
css  = sum((x - meanx)^2)
