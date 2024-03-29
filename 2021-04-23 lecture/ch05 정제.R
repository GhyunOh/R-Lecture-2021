#데이터 정제
score <- read.csv('data/students2.csv')
score
for(i in 2:4){
    score[, i] <- ifelse(score[,i]>100|score[,i]<0,
                         NA, score[,i])
}
score

# 결측값 처리
head(airquality)
sum(is.na(airquality))     # 44
table(is.na(airquality))

sum(is.na(airquality$Temp))    # 0개의 NA
mean(airquality$Temp)

sum(is.na(airquality$Ozone))   # 37개의 NA
mean(airquality$Ozone)
mean(airquality$Ozone, na.rm=T) # NA를 제외한 평균

# 결측값 제거
air_narm <- na.omit(airquality)
sum(is.na(air_narm))

# 결측값 대체
options(digits=4)
airquality$Ozone <- replace(airquality$Ozone,
                            is.na(airquality$Ozone),
                            mean(airquality$Ozone, na.rm=T))
head(airquality)

# 결측값 대체 - 중앙값(median)
airquality$Solar.R <- replace(airquality$Solar.R,
                              is.na(airquality$Solar.R),
                              median(airquality$Solar.R, na.rm=T))
head(airquality)

# 이상값(Outlier) 처리
patients <- data.frame(name=c('환자1','환자2','환자3','환자4','환자5'),
                       age=c(22,20,25,30,27), gender=c('M','F','M','K','F'), 
                       blood.type=c('A','O','B','AB','C'))
patients

# 성별의 이상치 제거
patients_outrm <- patients[patients$gender == 'M'|patients$gender == 'F',]
patients_outrm

# 성별과 혈액형의 이상치 제거
patients_outrm <- patients[(patients$gender == 'M'|patients$gender == 'F') & 
                               (patients$blood.type=='A'|patients$blood.type=='B'
                                |patients$blood.type=='O'| patients$blood.type=='AB'),]

patients_outrm

patients_outrm <- patients[patients$gender %in% c('M','F') &
                               patients$blood.type %in% c('A','O','B','AB'),]
patients_outrm

# 이상치를 NA로 대체
patients2 <-  data.frame(name=c('환자1','환자2','환자3','환자4','환자5'),
                      age=c(22,20,25,30,27), 
                      gender=c('M','F','M','K','F'), 
                      blood.type=c('A','O','B','AB','C'))
patients2$gender <-ifelse(patients$gender %in% c('M','F'),
                          patients$gender, NA)
patients2$blood.type <- ifelse(patients2$blood.type %in% c('A','B','O','AB'),
                               patients2$blood.type,NA)
patients2
sum(is.na(patients2))

# 숫자의 이상치
boxplot(airquality[, c(1:4)])
boxplot(airquality[,1])$stats
boxplot(airquality$Ozone)$stats

air <- airquality
air$Ozone <- ifelse(air$Ozone < boxplot(airquality$Ozone)$stats[1] |
                    air$Ozone > boxplot(airquality$Ozone)$stats[5],
                    NA, air$Ozone)
sum(is.na(air$Ozone))
sum(is.na(airquality$Ozone))
mean(air$Ozone, na.rm= T)
mean(airquality$Ozone, na.rm=T)

