# JSON 파일로 부터 읽어서 데이터프레임 만들기
library(jsonlite)

# person.json 파일로 부터 읽기
wiki_person <- fromJSON("OpenAPI/person.json")

# sample.json
data <- fromJSON("OpenAPI/sample.json")

data <- as.data.frame(data)
names(data) <- c('id','like', 'share','comment','unique','msg','time')
data$like <- as.numeric(as.character(data$like))
View(data)

# CSV 파일로 저장
write.csv(data,'OpenAPI/data.csv')

# Data Frame을 JSON 파일로 저장
json_data <- toJSON(data)
write(json_data, 'data.json')
prettify(json_data)
