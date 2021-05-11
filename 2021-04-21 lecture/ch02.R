women

plot(women)
str(cars)

# 두 줄을 선택한 후 상단에 있는 'run' 버튼을 누르면 한꺼번에 실행됨
a <-2
b <- a*a

# 작업 디렉토리 지정
getwd()
setwd('/workspace/r')
getwd()

library(dplyr)
library(ggplot2)
search()


str(iris)
iris
head(iris)        # Default는 상위 6개만 보여줌
head(iris, 30)

tail(iris)        # Default는 하위 6개만 보여줌줌


plot(iris)

plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch = 18)
legend(iris$Petal.Length, iris$Petal.Width, legend=c("line 1", "line 2", "line 3"), col=c("black","blue","green"), lty 1:2:3, cex=0.8)

# tips.csv download
tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
head(tips)
str(tips)
head(tips)

# 요약 통계
summary(tips)

# ggplot2 그림 그려보기
tips %>% ggplot(aes(size))+geom_histogram()          # 히스토그램
tips %>% ggplot(aes(total_bill, tip))+geom_point()   # 신잠도
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day))
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day,pch=sex),size=3)
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day,pch=time),size=3)