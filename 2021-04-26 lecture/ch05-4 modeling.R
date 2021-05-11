# 모델링을 위한 가공
library(dplyr)

# Wine 데이터
wine <- read.table('data/wine.data.txt',sep=',')
head(wine)
names <- readLines('data/wine.name.txt')
names
colums <- readLines('data/wine.name.txt')
colums

names(wine)[2:14] <- colums
names(wine)

# substr 함수
a <- "A quick brown fox jumps over the lazy dog."
nchar(a)
substr(a, 3,7)
substr(a, 3,nchar(a))
substr(a, nchar(a)-3, nchar(a)-1)

names(wine)[2:14] <-substr(colums, 4,nchar(colums))
names(wine)
names(wine)[1] <- 'Y'
names(wine)

# 데이터셋 분할
train_set = sample_frac(wine, 0.75)
str(train_set)
table(wine$Y)
table(train_set$Y)

test_set = setdiff(wine, train_set)
table(test_set$Y)

