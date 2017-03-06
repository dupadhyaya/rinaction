#Chapter - 4 : Basic Data Management ------------------------------------------

# Manipulating Dates and Missing Values
# Understanding Data Type Conversions
# Creating and Recoding Variables
# Sorting, Merging and Subsetting datasets
# Selecting and dropping values

# 4.1 Working Example
# table 4.1 Gender Difference : Ratings given to managers by their boss
# 5 statements  q1 to q5
# 99 shows missing data
manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)
leadership <- data.frame(manager, date, country, gender, age,
                         q1, q2, q3, q4, q5, stringsAsFactors=FALSE)
leadership

# Combine 5 ratings q1 to q5 


# Recode values like 99 for age to missing

# create new dataset with only variables of interest

# create new variable with age group to category based on age

# Study wrt to period... 


# 4.2 Creating New variables
mydata = data.frame(x1=c(2,2,6,4) , 
                    x2=c(3,4,2,8))
mydata
mydata$sumx = mydata$x1 + mydata$x2
mydata$meanx = (mydata$x1 + mydata$x2)/2
mydata

attach(mydata)
mydata$sumx2 = x1 + x2
mydata$meanx2 = (x1 + x2)/2

# best method
mydata = transform(mydata,
                   sumx3 = x1 + x2,
                   meanx3 = (x1 + x2)/2)
mydata

# Recoding Variables
