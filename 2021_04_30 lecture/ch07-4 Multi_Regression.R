# 다중회귀분석
state.x77
?state
head(state.x77)
state <- as.data.frame(state.x77[,c("Murder","Population",
                                    "Illiteracy","Income","Frost")])

fit <- lm(Murder ~ Population+Illiteracy+Income+Frost, data=state)
summary(fit)+
    
par(mfrow=c(2,2))
plot(fit)
par(mfrow=c(1,1))

# 다중공선성: 독립변수간 강한 상관관계가 나타나는 문제
# Correlation (0.9 이상이면 다중공선성 의심)
# 0.9 이상이면 boxplot으로 이상치를 지우고 시도
states.cor <- cor(state[2:5])
states.cor

#VIF(Variation Inflation Factor) 계산 (10 이상이면 다중공선성 의심)
library(car)
vif(fit)

# Condition Number (15 이상이면 다중공선성의 가능성이 있음)
eigen.val <- eigen(states.cor)$values
sqrt(max(eigen.val)/eigen.val)

fit1 <- lm(Murder ~ ., data = state)
summary(fit1)

fit2 <- lm(Murder ~ Population + Illiteracy, data=state)
summary(fit2)

# AIC(Akaike Information Criterion) 작게나오는것이 좋은 모델
AIC(fit1,fit2)

# Backward stepwise regression, Forward stepwise regression
step(fit1, direction = 'backward')

fit3 <- lm(Murder ~ 1, data=state)
step(fit3,direction = "forward", 
     scope=~ Population+Illiteracy+Income + Frost)
step(fit3, direction = "forward",
     scope= list(upper=fit1,lower=fit3))

install.packages('leaps')
library(leaps)
subsets <- regsubsets(Murder~., data=state, method='seqrep',
                      nbest=4)
subsets <- regsubsets(Murder~., data=state, method='exhaustive',
                      nbest=4)
summary(subsets)
plot(subsets)

