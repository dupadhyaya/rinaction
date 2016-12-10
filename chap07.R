#Chapter - 7 : Basic Statistics ------------------------------------------
# Questions to answer
# What kind of mileage cars are getting these days
# Whats the distribution of miles per gallon ( Mean, SD, Median, Range)
# After a new drug trial, is there a improvement
# Does gender effect on drug outcome
# What is correlation between income and life expectancy.
# Are you likely to receive more punishment in some regions

.libPaths()
rm(list=ls())
# Descriptive Statistics --------------------------------------------------

#attach(cars) ;detach(cars)
vars = c('mpg','hp','wt')
head(mtcars[vars])
str(mtcars)
dim(mtcars)  # 32 cars

# Descriptive Statistics
summary(mtcars)
# use apply or sapply to provide Descriptive Stats
?sapply
sapply(mtcars,fivenum)
# Other functions - fivenum, sd,var,min,max, median, length, range, quantile (since all colns are numeric)

# Function for skewness and kurtosis
mystats = function(x,na.omit=F) { 
  if (na.omit)
    x = x[!is.na(x)]
    m = mean(x)
    n = length(x)
    s = sd(x)
    skew = sum((x-m)^3/s^3)/n
    kurt = sum((x-m)^4/s^4)/n - 3
    return(c(n=n,mean=m, stdev=s,skew=skew, kurtosis=kurt))
}

sapply(mtcars[vars],mystats)
rm(list=ls())
# Extensions
library(Hmisc)
describe(mtcars[vars])

library(pastecs)
stat.desc(mtcars[vars])

library(psych)
psych::describe(mtcars[vars])

Hmisc::describe(mtcars[vars]) # want to use Hmisc version of describe


# Descriptive Statistics by Group -----------------------------------------
aggregate(mtcars[vars],by=list(mtcars$am),mean)
aggregate(mtcars[vars],by=list(am=mtcars$am),mean)
aggregate(mtcars[vars],by=list(am=mtcars$am),sd)
# aggregate can use only singe grouping variables like, mean, sd, var
# list=(name1=groupvar2, name2=groupvar2...)

# Group using by --------------------------------------
dstats = function(x) (c(mean=mean(x),sd=sd(x))) # Not working
by(mtcars[vars],mtcars$am, dstats)
str(mtcars)

# Do By
library(doBy)
summaryBy(mpg+hp+wt~am,data=mtcars,FUN=mystats)
summaryBy(mpg~am,data=mtcars,FUN=mystats)
unique(mtcars$mpg)
