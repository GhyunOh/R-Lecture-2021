library(dplyr)
data1 <- read.csv("d_trade.csv")
data2 <- read.csv("y_trade.csv")
data3 <- read.csv("ds_trade.csv")

# 행합치기
data <- rbind(data1,data2,data3)

# "일" 앞에 0입력
data$계약일 <- as.numeric(data$계약일)
data$계약일 <- sprintf("%02d",data$계약일)

# 거래일자 변수명 추가
data <- mutate(data,거래일자=paste0(data$계약연도,data$계약일))

# 계약연월 변수명 추가
data <- mutate(data,계약연월=data$계약연도)

# 계약연도 수정
data$계약연도 <- year(format(as.Date(data$거래일자,"%Y")))


write.csv(data,"최종통합.csv")
data$거래금액 <- as.numeric(data$거래금액)

plot(data$전용면적,data$거래금액)
