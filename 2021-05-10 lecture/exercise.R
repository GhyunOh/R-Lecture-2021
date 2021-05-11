library(rvest)
library(stringr)
library(dplyr)
library(httr)
# 한빛 미디어 책 리스트 1페이지 부터 25페이지까지 크롤링하기
url <- c()
base_url <- 'https://www.hanbit.co.kr/media/books'
middle_url <- '/new_book_list.html?page='
sub_url <- '&cate_cd=&srt=&searchKey=&keyWord='
new_books <- data.frame()
for(i in 1:25){
  url[i] <- paste0(base_url,middle_url,i,sub_url)
  html <- read_html(url[i])
  
  container <- html_node(html, '#container') # id="container"
  book_list <- html_node(container, '.new_book_list_wrap')
  sub_book_list <- html_node(book_list, '.sub_book_list_area')
  lis <- html_nodes(sub_book_list, 'li')    # <li> 모두 찾기

  title_vector <- c()
  writer_vector <- c()
  page_vector <- c()
  price_vector <- c()

  for (li in lis){
    info <- html_node(li, '.info')
    title <- info %>% 
      html_node('.book_tit') %>% 
      html_text()
    writer <- info %>% 
      html_node('.book_writer') %>% 
      html_text()
    href <- li %>% 
      html_node('.info') %>% 
      html_node('a') %>% 
      html_attr('href')
    book_url <- paste(base_url,href, sep='/')
    book_html <- read_html(book_url)
    info_list <- html_node(book_html, 'ul.info_list')
    book_lis <- html_nodes(info_list,'li')
    
    for (book_li in book_lis){
      item <- book_li %>% 
        html_node('strong') %>% 
        html_text()
      if(substring(item,1,3) == '페이지'){
        page <- book_li %>% 
          html_node('span') %>% 
          html_text()
        len <- str_length(page)
        page <- as.integer(substring(page,1,len-2))
        break
      }
    }
    pay_info <- html_node(book_html, '.payment_box.curr')
    ps <- html_nodes(pay_info, 'p')
    # 12페이지 두개의 책에서 price정보를 얻을 수 없음
    if (length(ps)==0){
      price <- 0
    } else {
      price <- ps[2] %>% 
        html_node('.pbr') %>% 
        html_node('strong') %>% 
        html_text()
      price <- as.integer(gsub(',','',price))
    }
    title_vector <- c(title_vector, title)
    writer_vector <- c(writer_vector, writer)
    page_vector <- c(page_vector,page)
    price_vector <- c(price_vector,price)
  }
    now_books <- data.frame(
    title = title_vector,
    writer = writer_vector,
    page = page_vector,
    price = price_vector)

    new_books <- rbind(new_books,now_books)
}

View(new_books)

write.csv(new_books,'data/한빛도서.csv', fileEncoding='utf-8',
          row.names=F)
df <- read.csv('data/한빛도서.csv', fileEncoding='utf-8')
#################################################

# 지니 일간차트 크롤링

base_url <- 'https://www.genie.co.kr/chart/genre'
query <- '?ditc=D&ymd=20210509&genrecode=M0100&pg='

ranks <- c()
last_ranks <- c()
titles <- c()
artists <- c()
albums <- c()
for (page in 1:2) {
  url <- paste0(base_url, query, page)
  html <- read_html(url)
  trs <- html %>%
    html_node('.list-wrap') %>%
    html_node('tbody') %>% 
    html_nodes('tr')
  for (tr in trs) {
    num <- html_node(tr, '.number') %>% html_text()
    nums <- unlist(str_split(num, '\r\n'))
    rank <- as.integer(nums[1])
    ranks <- c(ranks, rank)
    move <- str_trim(nums[2])
    if (move == 'new') {
      last <- 999
    } else {
      slen <- str_length(move)
      inc <- 0
      if (slen > 2) {
        inc <- as.integer(substring(move, 1, slen-2))
      }
      c_str <- substring(move, slen-1, slen)
      if (c_str == '상승') {
        last <- rank + inc
      } else if (c_str == '하강') {
        last <- rank - inc
      } else {
        last <- rank
      }
    }
    last_ranks <- c(last_ranks, last)
    title <- html_node(tr, '.title.ellipsis') %>% html_text()
    title <- gsub('\r\n', '', title)
    titles <- c(titles, title)
    artist <- html_node(tr, '.artist.ellipsis') %>% html_text()
    artists <- c(artists, artist)
    album <- html_node(tr, '.albumtitle.ellipsis') %>% html_text()
    albums <- c(albums, album)
  } 
}
daily_chart <- data.frame(rank=ranks, last=last_ranks, 
                          title=titles, artist=artists, album=albums)
View(daily_chart)

