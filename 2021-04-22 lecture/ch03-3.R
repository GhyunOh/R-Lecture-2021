#데이터 프레임
name <- c('철수','춘향','길동')
age <- c(22,20,25)
gender <- factor(c('M','F','M'))
blood_type <- factor(c('A', 'O', 'B'))

patients <- data.frame(name,age,gender,blood_type)
patients

patients$name
typeof(patients$name)
patients[1,] # 첫번째 행 모두 출력 반대로 [,n] 형태는 해당 열을 모두 출력
patients[,2] # patients$age 와 동일
patients$gender[2] # patients[2,3]과 동일 |  값은 F
patients[patients$name == '철수',]   # patients[1,] 과 동일 "필터링(filtering)"
patients[patients$name == '철수',c('age',"gender")] # selection

# 데이터프레임의 속성명을 변수명으로 사용(attach ~ detach)
attach(patients)
name
blood_type
detach(patients)
patients
head(cars)
attach(cars)
speed
dist
detach(cars)
speed          #에러: 객체 'speed'를 찾을 수 없습니다.


mean(cars$speed)
max(cars$dist)
with(cars, mean(speed)) # attach 와 detach를 자동으로 해줌

# subset
subset(cars, speed > 20)  # dplyr 의 %>%을 주로 사용하기 떄문에 그냥 알고만 있자
cars[cars$speed>20,]
subset(cars, speed>20, select = c(dist))       
subset(cars, speed>20, select = -c(dist))       

# 결측값(NA) 처리
head(airquality)
str(airquality)
sum(airquality$Ozone)

head(na.omit(airquality)) # omit은 na가 있는 행 자체를 날려버림

# 병합(merge)
patients
patients1 <- data.frame(name,age, gender)
patients2 <- data.frame(name,blood_type)
merge(patients1,patients2, by= 'name')

# 데이터프레임에 행 추가
length(patients1$name)
length(patients2$name)
patients1[length(patients1$name)+1,] <- c('몽룡',19,'M')
patients1
patients2[length(patients2$name)+1,] <- c('영희','A')
patients2


# 열 추가
patients1['birth_year'] <- c(1500, 1550, 1600, 1800)
patients1

# merge
## Inner join
merge(patients1,patients2)    # x,y
# Left outer join
merge(patients1,patients2, all.x=T)
# Right outer join
merge(patients1, patients2, all.y=T)
# (Full) outer join
merge(patients1, patients2, all.x=T, all.y=T)

