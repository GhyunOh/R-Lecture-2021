# R library를 이용한 전처리
library(RCurl)
library(XML)
library(stringr)

html <- readLines("https://en.wikipedia.org/wiki/Data_science")
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p', xmlValue)

library(tm)        # Text Mining 라이브러리
library(SnowballC) # 어간 추출 라이브러리

doc <- Corpus(VectorSource(doc))
inspect(doc)

doc <- tm_map(doc, content_transformer(tolower)) # 소문자 변환
doc <- tm_map(doc, removeNumbers)                # 숫자 제거
stop_words <- c(stopwords('en'),'said')
doc <- tm_map(doc, removeWords, stopwords('english')) # 불용어 제거
doc <- tm_map(doc, removePunctuation)            # 구둣점 제거
doc <- tm_map(doc, stripWhitespace)              # 앞뒤 공백 제거

###################
# DTM 구축
###################
dtm <- DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)


###################
# Word Cloud
###################
library(wordcloud)

m <- as.matrix(dtm) #DTM list를 matrix로 변환
v <- sort(colSums(m), decreasing = T)
v[1:5]
df <- data.frame(word=names(v), freq=v)
head(df)
wordcloud(words = df$word, freq = df$freq,min.freq=1, max.words=100,
          random.order=F, rot.per= 0.35)
library(wordcloud2)
wordcloud2(df)

d200 <- df[1:200,]
wordcloud2(d200, shape='star')
wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3,
           rotateRatio = 1.0)
wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3,
           rotateRatio = 1.0,
           backgroundColor='black')
wordcloud2(d200, minRotation = pi/6,
           maxRotation = pi/3, rotateRatio = 1.0,
           figPath = 'data/Alice_mask.png')
