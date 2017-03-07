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
(n=length(x) )
# another way 
(meanx = sum(x)/length(x))
(css  = sum((x - meanx)^2) )
(sdx = sqrt( css / (n-1) ) )

# Standardize Data  
# Scale
x = c(50:60, 70:80,95:99)
stdx = scale(x)   # std to mean of 0, SD=1
mean(stdx)  # almost 0
sd(stdx)

# Std to arbritary Mean
SD = 1.5 ; M = 65
stdx2 = scale(x) * SD + M  # Desired SD and M
stdx2
mean(stdx2)  # almost 65
sd(stdx2)    # to 1.5

sdf = read.csv(file='sdata.csv', header=T, stringsAsFactors = F)
sdf
# Data - Marks Range : sas(100), python(75), excel(200), rpgm(500)
sdf[,c(2:5)]
sdf2 = scale(sdf[,c(2:5)])
sdf2  # all are scaled with mean 0 and SD 1 wrt their column

# One column
sdf[,2]
mean(sdf[,2])
sd(sdf[,2])
scale(sdf[2])
scale(sdf[2]) * 10 + 60
normal = function(x){(x-min(x))/(max(x)-min(x))}
normal(sdf[2])

compare = data.frame(sdf[2], scale(sdf[2]),scale(sdf[2]) * 10 + 60, normal(sdf[2]) )
compare
summary(compare)

# Transform  1 by one
(newdata = transform(sdf, python1=scale(python)*10 + 50))
(newdata = transform(sdf, rpgm1=scale(rpgm)*10 + 50))


#library(clusterSIM) 
#normX = data.Normalization(x,type="n4") # Normalise between 0 and 1

# 5.2.3 Probability Functions ----------------------
# Used to generate simulated data with known characteristics & calc prob values
# [dpqr] distribution_abbreviation()
# d- density, p - distribution func, q - quantile, r - random generation

# Common Distributions
# beta, binom, cauchy, chisq, exp, f, gamma, geom, hyper
# lnorm, logis, multinom, nbinom, norm, pois, signrank, t, unif, weibull, wilcox

# Table 5.5
x = pretty(c(-3,3), 30)
#?pretty  sequence of about n+1 equally spaced ‘round’ values which cover the range of the values in x. 
#The values are chosen so that they are 1, 2 or 5 times a power of 10.
x
y = dnorm(x)
y
plot(x,y, type='l', xlab='Normal Deviate', ylab='Density', yaxs='i')

pnorm(1.96)

qnorm(.9, mean=500, sd=100)
rnorm(50, mean=50, sd=10)

# seed - each time random no, different results
# to make them reproducible, specify set.seed(value)

runif(5)  
runif(5)  # different nos

set.seed(1234)
runif(5)
set.seed(1234)
runif(5)  # same no series

# Generaing Multivariate Normal Data
# used in Monte Carlo Studies with given mean , covariance matrix
library(MASS)
mvrnorm(n, mean, sigma)
mvrnorm(5, 10,2)

options(digits=3)
set.seed(1234)
meanv = c(230.7, 146.7, 3.6)   # 3 Columns will have 3x3 covariance matrix
sigmav = matrix(c (15360.8, 6721.2, -47.1,
                   6721.2, 4700.9, -16.5,
                   -47.1, -16.5, 0.3), nrow=3, ncol=3)
mydata = mvrnorm(500, meanv, sigmav)
head(mydata)
summary(mydata)
mydata = as.data.frame(mydata)  # matrix to DF
names(mydata) = c('y', 'x1', 'x2')  # colnames
dim(mydata)
str(mydata)
head(mydata, n=10)
cor(mydata)
cov(mydata) # same as input 
plot(mydata)

# 5.2.4  Character Functions ------------------
# nchar, subst(x, start, stop), 
# grep(pattern, x, ignore.case=F, fixed=F)
# sub(pattern, replacement, x, ignore.case=F, fixed=F)
# strsplit(x, split, fixed=F)
# paste(..., sep='')
# toupper(x)  tolower(x)
x = c('ab', 'cde', 'fghij')
length(x)
nchar(x)

x= 'abcdef'
substr(x,2,4)  # want bcd
substr(x,2,4) = '222222'
x   # replace selected substr

grep('A', c('b','A','c'))
#2  # Matching indices

sub('\\s', '.', 'Hello There')
# replace space with dot .
sub('o', 'O', 'Hello There')
sub('e', 'E', 'Hello There')
?sub

stringr::str_replace_all(string, pattern, replacement)
stringr::str_replace_all('Hello There', 'e', 'E')

# split elements
strsplit('abc','')
strsplit('a bc def j','\\s')

y= strsplit('abc','')
unlist(y)[2]
sapply(y,"[",2)

paste('x', 1:3,sep='')  # x1 x2 x3
paste('x', 1:3,sep='M')  # xM1 xM2 xM3
paste('Todays date is ', date(), sep=' - ')  

toupper('AbC')
tolower('AbC')

# Regular Expression which is not mathematical
x


# ------ extras
with( sdf, {
  mean(sas)
  sd(sas) })

