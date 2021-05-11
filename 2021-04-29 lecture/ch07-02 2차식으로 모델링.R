# Women data
women
plot(women)
m <- lm(weight~height, data = women)
abline(m, col='red', lwd=2)
summary(m)

# 2차식으로 모델링
m2 <- lm(weight ~ poly(height,2),data=women)
x <- seq(58, 72, length.out=300)
y <- predict(m2,data.frame(height=x))
lines(x,y,col='blue', lwd=2)
summary(m2)
coef(m2)
