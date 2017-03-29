# Practise
# 
batch = data.frame(course= c('bsc', 'msc', 'bba', 'ba', 'llb')
       ,students= c(10, 5, 20, 18, 20)
       ,school=c('ds', 'ds', 'law', 'law', 'law'), stringsAsFactors=T)
str(batch)
summary(batch)
batch
batch$school
summary(batch$students)
names(batch)
rownames(batch)
colnames(batch)
row.names(batch)
dimnames(batch)  # all R & C

batch2 = matrix(1:24,nrow=4)
batch2
max(batch2)
min(batch2)
sum(batch2)
fivenum(batch2)
length(batch2)
summary(batch2)
rowMeans(batch2)
apply(batch2, 1, median)[1:3]
batch2
apply(batch2, 1, median)[c(1,2)]

table(batch)
table(batch$course, batch$school)
table(batch$course, batch$school, dnn=c('course','school'))
