# 공공 데이터 포털 API 활용
## 지자체별 사고다발지역정보 조회 서비스
library(jsonlite)

service_url <- 'http://apis.data.go.kr/B552061/frequentzoneLg/getRestFrequentzoneLg'
public_api_key <- readLines('OpenAPI/public_api_key.txt')
year <- 2019
siDo <- 30
guGun <- 230
rows <- 10
page <- 1
url <- sprintf('%s?ServiceKey=%s&searchYearCd=%d&siDo=%d&guGun=%d&numOfRows=%d&pageNo=%d&type=json',
               service_url,public_api_key,year,siDo,guGun,rows,page)
url

response <- fromJSON(url)

str(response)
df <-response$items$item
View(df)

# 결과 메시지
response$resultMsg

# 총 건수
response$totalCount

