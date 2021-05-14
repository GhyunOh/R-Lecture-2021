library(rvest) 
library(stringr)
library(dplyr)
library(ggplot2)
library(gapminder)

# 코로나 크롤링 2020-02-15~2021-03-14 (한달단위)
sum <- c()
keyword <- "코로나"
base_url <- "https://search.daum.net/search?nil_suggest=btn&w=news&DA=STC&cluster=y&q="
address1 <- "&sd=202"
address2 <- "15000000&ed=202"
address3 <- "14235959&period=u"
months_vec <- c('002','003','004','005','006','007','008','009',
                '010','011','012','101','102','103')
for(month in 1:13){
  monthFrom <- months_vec[month]
  monthTo <- months_vec[month+1]
  keyword <- URLencode(iconv(keyword, to='UTF-8'))
  url <- paste0(base_url,keyword,address1,monthFrom,
                address2,monthTo,address3)
  html <- read_html(url)
  num <- html %>% html_nodes("div.coll_tit")%>% html_text()
  num <- unlist(str_split(num[1], '/'))
  num <- str_trim(num[2])
  num <- unlist(str_split(num, ' '))      
  num <- gsub(",","",num[2])
  num <- gsub("건","",num)
  num <- as.integer(num)
  sum <- c(sum, num)
}
sum

# 부동산대책 크롤링 2016-01-15~2020-12-14 (한달단위)
sum <- c()
keyword <- "부동산대책"
keyword <- URLencode(iconv(keyword, to='UTF-8'))
base_url <- "https://search.daum.net/search?nil_suggest=btn&w=news&DA=STC&cluster=y&q="
address1 <- "&sd="
address2 <- "15000000&ed="
address3 <- "14235959&period=u"
years_vec <- c("2016","2017","2018","2019","2020","2021")
months_vec <- c('01','02','03','04','05','06','07','08','09',
                '10','11','12','13')
for(year in 1:65){
  for(month in 1:12){
    monthFrom <- months_vec[month]
    monthTo <- ifelse(months_vec[month+1] != '13',months_vec[month+1] ,'01')
    yearFrom <- years_vec[year]
    yearTo <- ifelse(months_vec[month+1] != '13',years_vec[year],years_vec[year+1])
    if(yearTo == "2021" ){
      break
    }
    url <- paste0(base_url,keyword,address1,yearFrom,monthFrom,
                  address2,yearTo,monthTo,address3)
    html <- read_html(url)
    num <- html %>% html_nodes("div.coll_tit")%>% html_text()
    num <- unlist(str_split(num[1], '/'))
    num <- str_trim(num[2])
    num <- unlist(str_split(num, ' '))      
    num <- gsub(",","",num[2])
    num <- gsub("건","",num)
    num <- as.integer(num)
    if(is.na(num) == T){
      sum <- c(sum,950)
    } else {
      sum <- c(sum, num)
    }
  }
} 
sum


## 그래프 ##
## 매매가 형성 그래프 ##

t_trade <- read.csv('t_total.csv')

t_g <- t_trade %>%
  group_by(구,계약연도) %>% 
  ggplot(aes(계약연도,거래금액)) + 
  geom_point(stat='identity',alpha=0.2, position='jitter')
t_g


t_g_b <- t_trade %>%
  group_by(구,계약연도) %>% 
  ggplot(aes(계약연도,거래금액,group=구,col=구)) + 
  geom_bar(stat='identity', position='dodge',aes(fill=구)) 
t_g_b

## 평균매매가 변화량 추이 그래프 ##

t_trade %>% 
  group_by(계약연도,구) %>% 
  summarise(avg_t_trade = mean(거래금액)) %>% 
  ggplot(aes(계약연도,avg_t_trade))  +
  geom_line(aes(color=구))  +
  ylab("평균거래가") +
  labs(title = '지역구별 평균거래가격 추이')

## 연도별 거래 변화량 추이 그래프##

## 검색 트래픽과 주택가격 변화량의 상관관계 그래프 ##


# 3-1 그래프 연도별 거래량 그래프 bar(거래량) + lines(코로나, 부동산대책)
# 3-2 그래프 연도별 평균가 그래프 bar(거래량) + lines(코로나, 부동산대책)영그러면 median
