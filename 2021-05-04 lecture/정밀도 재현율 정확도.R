# UCLA 데이터에 대해서 Cross validation을 하고
# 4가지 모델에 대해서 정확도, 정밀도 , 재현율을 구하라
library(class)
library(caret)
library(e1071)
library(randomForest)
library(rpart)

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)

set.seed(2021)
data <- ucla[sample(nrow(ucla)),]
options(digits = 4)
# K-Fold CV, K=5
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)
accuracy <- 0
precision <- 0
recall <- 0

# Decision Tree

for(i in 1:k){
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    dt <- rpart(admit~., data_train)
    pred <- predict(dt,data_test,type='class')
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2] / (t[1,2]+ t[2,2])
}
dt_avg_acc <- accuracy / k
dt_avg_prec <- precision / k
dt_avg_rec <- recall / k
sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        dt_avg_acc,dt_avg_prec,dt_avg_rec)


# Random Forest

accuracy <- 0
precision <- 0
recall <- 0

for(i in 1:k){
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(admit~., data_train)
    pred <- predict(rf,data_test,type='class')
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2] / (t[1,2]+ t[2,2])
}
rf_avg_acc <- accuracy / k
rf_avg_prec <- precision / k
rf_avg_rec <- recall / k
options(digits = 4)
sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc,rf_avg_prec,rf_avg_rec)


# svm

accuracy <- 0
precision <- 0
recall <- 0

for(i in 1:k){
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    sv <- svm(admit~., data_train)
    pred <- predict(sv,data_test,type='class')
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2] / (t[1,2]+ t[2,2])
}
sv_acc <- accuracy / k
sv_prec <- precision / k
sv_rec <- recall / k
options(digits = 4)
sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        sv_acc,sv_prec,sv_rec)


# K-Nearest Neighbor

accuracy <- 0
precision <- 0
recall <- 0

for(i in 1:k){
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    pred <- knn(data_train[,2:4], data_test[,2:4], 
                data_train$admit, k=5)
    t <- table(pred, data_test$admit)

    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2] / (t[1,2]+ t[2,2])
}
kn_avg_acc <- accuracy / k
kn_avg_prec <- precision / k
kn_avg_rec <- recall / k
options(digits = 4)
sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        kn_avg_acc,kn_avg_prec,kn_avg_rec)

