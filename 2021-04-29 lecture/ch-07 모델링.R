# 현실 세계의 모델링
X = c(3,6,9,12.)
Y = c(3,4,5.5,6.5)
plot(X,Y)

# model 1: y=0.5x+1.0
Y1 = 0.5*X + 1.0
Y1
# 평균 제곱 오차: Mean Squared Error
(Y - Y1)**2
sum((Y - Y1)**2)
mse <- sum((Y-Y1)**2)/length(Y)
mse

# model 2: y=5/12x + 7/4
Y2 = 5* X /12 + 7/4
Y2
mse2 <- sum((Y-Y2)**2) / length(Y)
mse2

# R의 단순 선형회귀 모델 lm
model <- lm(Y ~ X)
model

plot(X,Y)

abline(model, col='red')
fitted(model)
mse_model <- sum((Y - fitted(model))**2) /length(Y)
mse_model

# 잔차 - Residuals  ***실제 값과 예측값의 차이
residuals(model)

# 잔차 제곱합
deviance(model)

# 평균 제곱오차(MSE)
deviance(model) / length(Y)

summary(model)

# 예측
newX <- data.frame(x=c(1.2,2.0,20.65))
newY <- predict(model, newdata=newX)
newY

# 연습문제
#1) 훈련 집합이 X={10.0,12.0,9.5,22.2,8.0},Y={360.2,420.0,359.5,679.0,315.3}
#이다. lm 함수로 모델링하라.[그림7-4]와 [표7-3]을 제시하고, 잔차 제곱합과 평균 
#제곱 오차를 구하라. 새로운 샘플이 10.5,25.0,15.0일 때 
#predict 함수로 예측한 결과를 제시하라

X <- c(10.0,12.0,9.5,22.2,8.0)
Y <- c(360.2,420.0,359.5,679.0,315.3)
model <- lm(Y ~ X)
summary(model)
plot(X,Y)
abline(model,col='red')

newX <- data.frame(X=c(10.5,25.0,15.0))
newY <- predict(model, newdata = newX)
newY
plot(newX$X, newY, pch=2)
abline(model,col='red')
