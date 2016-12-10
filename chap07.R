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

# Extensions
library(Hmisc)
describe(mtcars[vars])
vars
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
#summaryBy(mpg+wt~am+hp,data=mtcars,FUN=mystats)

unique(mtcars$mpg)

library(psych)
psych::describeBy(mtcars[vars],mtcars$am)
# cannot use arbitrary function


# reshape : melt and cast -----------------------------------------------------------

dfm = reshape::melt(mtcars,measure.vars=c('mpg','hp','wt'),id.vars=c('am','cyl'))
dfm
?melt

reshape::cast(mtcars, am + cyl  ~ ., mean)
reshape::cast(mtcars, am + cyl  ~ ., dstats)

# Distributions  of Quantitative Variables -----------------------------------------------------

# 7.2 Frequency and Contigency Tables ---------------------
library(vcd)
head(Arthritis)
str(Arthritis)
# Categorical Attributes - Treatment, Sex, Age
#  Commands - table, xtabs, prop.table, margin.table, addmargines, ftable
# 1 way tables
mytable = with(Arthritis, table(Improved))
mytable
table(Arthritis$Improved)
prop.table(mytable) # relative %
round(prop.table(mytable) * 100)

# 2 way table
str(Arthritis)
table(Arthritis$Treatment, Arthritis$Sex)
mytable = xtabs(~ Treatment + Improved,data=Arthritis)
xtabs
table(Arthritis$Treatment,Arthritis$Improved)
table(Arthritis$Improved, Arthritis$Treatment) # Rights side - Coln
margin.table(mytable,1) # Row Sum 1- 1st variable in the table
prop.table(mytable,1)  # Row Proportions
margin.table(mytable,2) # Col Sum 2- 2nd variable in the table
prop.table(mytable,2)  # ColProportions
round(prop.table(mytable)*100)  # Cell Proportions
addmargins(mytable) # add row and column rums
addmargins(prop.table(mytable,1),2) # add coln margins only
addmargins(prop.table(mytable,1),1) # add row margins only

library(gmodels)
gmodels::CrossTable(Arthritis$Treatment, Arthritis$Improved)

# Multidimensional Tables
#functions extend themselves - table, xtabs, margin.table, prop.table, addmargines, ftable(addl)
mytable2 = xtabs(~Treatment + Sex + Improved, data = Arthritis) # 3 way contingency table
mytable2

ftable(mytable2)

# Marginal Frequencies
margin.table(mytable2,1)
margin.table(mytable2,2) # 2nd factor
margin.table(mytable2,3)

margin.table(mytable2, c(1,3)) # 1st & 3rd Factor
margin.table(mytable2, c(1,2))

ftable(addmargins(prop.table(mytable2,c(1,2)),3))
ftable(round(addmargins(prop.table(mytable2,c(1,2)),3)*100))


# Tests of Independence -----------------------
# Chi Square, Fisher, Mantel 
# Chi Square Tests of Independence chisq.test() Ho- Independent -----------------
library(vcd)
mytable3 = xtabs(~Treatment+Improved, data =Arthritis)
chisq.test(mytable3) # p < .05 -> Ho reject : Not Independent
# 2X 2 table
mytable3 = xtabs(~Treatment+Sex, data =Arthritis)
chisq.test(mytable3) # p > .05 -> Ho accept: Independent

mytable3 = xtabs(~Improved+Sex, data =Arthritis)
chisq.test(mytable3) # p > .05 -> Ho accept: Independent
# Warning - some values may be less than 5


# Fisher Test fisher.test() Ho - Independent ---------------
mytable3 = xtabs(~Treatment+Improved, data =Arthritis)
fisher.test(mytable3) # p < .05 -> Ho Reject : Not Independent - Dependent
# any x * y table more than 2 x 2 table

# Mantel Tests 2 conditionally independent of 3rd variable-----------------
mytable3 = xtabs(~Treatment+Improved+Sex, data =Arthritis)
mantelhaen.test(mytable3) # Reject Ho : Not Indepedent
# Treatment & improved variable are idenpendent of each sex level
# Treated indls improved more than those receiving Placeo for sex

# Measures of Association -------------------
# if Ho is rejected ie. There is Dependency. Then find association
mytable4 = xtabs(~Treatment+Improved, data =Arthritis)
library(vcd)
vcd::assocstats(mytable4) # larger magnitude ? stronger association

# Converting Tables to flat files --------------
table2flat = function(mytable) {
  df = as.data.frame(mytable)
  rows = dim(df)[1]
  cols = dim(df)[2]
  x = NULL
  for (i in 1:rows) {
    for (j in 1:df$Freq[i]){
      row = df[i,c(i:cols-1)]
      x = rbind(x,row)
    }
  }
  row.names(x) = c(1:dim(x)[1])
  return(x)
}
# takes a R table with any no of rows & cols and retuns a Df in flat file

treatment = rep(c('Placebo','Treated'),times=3)
treatment
improved = rep(c('None','Some','Marked'),each=2)
improved
Freq = c(29,13,7,17,7,21)
mytable6 = as.data.frame(cbind(treatment,improved,Freq))
mytable6
str(mytable6)
mydata = table2flat(mytable6)  # NOT WORKING
#mydata

# 7.3 Correlations ------------------
# Strength 0 to 1; Direction +/-
# dataset state.x77 - population, income, illiteracy, life expectancy, murder rate, high school graduation
# packages - pysch, ggm
# Types - Pearson, Spearman(Rank), Kendall
help("state.x77") # matrix 50 rows & 8 colns
#cor(x - DF, use='everything' -missing data , method='person') person, spearman, kendall
states = state.x77[,1:6]
str(states)
dim(states)
head(states)
cov(states)   # Covariance
cor(states)   # Pearson Correlation
cor(states,method='spearman')   # Spearman  Correlation
# Strong + betw Income & HS Grad ; Strong - betw Illiteracy & life exp

x = states[,c('Population','Income','Illiteracy', 'HS Grad')]
y = states[,c('Life Exp', 'Murder')]
cor(x,y) # Relative relation between 2 sets

# Partial Correlation betn 2 Quantitative variables --------------
library(ggm)
ggm::pcor(c(1,5,2,3,6), cov(states))
# corr betw population & murder rate, others controlled(1,5,2,3,6)
head(states)
ggm::pcor(c(1,5,2,4,3,6), cov(states))

# Other type of Correlations -------------
#polycor::hetcor()  - hetergenous matrox

# Testing Correlations fo Significance Ho: No Relationship -----------
#cor.test(x,y,alternative='two.sided,..', method='pearson,....')
cor.test(states[,3],states[,5]) # Life Expectancy & Murder Rate is 0 : Reject, it is not 0
# only 1 correlation

psych::corr.test(states, use='complete') # Correlation & Sign levels for matrices for all corr tests
psych::corr.test(states, use='pairwise')

# Other Tests of Significance
#psych::pcor.test(r,q,n)

