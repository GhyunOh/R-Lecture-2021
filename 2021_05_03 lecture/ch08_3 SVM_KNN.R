# 서포트 벡터 머신
install.packages('e1071')
library(caret)
library(e1071)

set.seed(2021)
train_index <- createDataPartition(iris$Species,p=0.8,list=F)
iris_train <- iris[train_index,]
iris_test <- iris[-train_index,]

# 모델링
svc <- svm(Species~., iris_train)

# 예측
pred <- predict(svc, iris_test, type='class')

# 평가
table(pred,iris_test$Species)
confusionMatrix(pred, iris_test$Species)

# 하이퍼 파라미터 C(cost)
svc100 <- svm(Species~., iris_train,cost = 100)
pred100 <- predict(svc100, iris_test, type='class')
table(pred100, iris_test$Species)

svc001 <-svm(Species~., iris_train, cost=0.01)
svc001 <- predict(svc001, iris_test, type= 'class')
self100 <- predict(svc100, iris_train, type='class')
table(self100,iris_train$Species)

# K-NN(Nearest Neighbor) K-최근접 이웃
library(class)
k <- knn(iris_train[,1:4],iris_test[,1:4],iris_train$Species, k=5)
k
iris_test$Species
confusionMatrix(k,iris_test$Species)

# train 함수
dt <- train(Species~., iris_train,method='rpart')
rf <- train(Species~., iris_train,method='rf')
sv <- train(Species~., iris_train,method='svmRadial')
kn <- train(Species~., iris_train,method='knn')
names(getModelInfo())
