#파일 읽기
getwd()
students <- read.table("data/students1.txt", header = T)
students
str(students)

# read.csv 는 첫 행을 헤더로 읽는 것이 디폴트
students <- read.csv('data/students.csv')
students

# 파일 쓰기 - encoding 신경쓸 것
write.table(students, file= "data/output.txt", fileEncoding = 'utf-8')
write.csv(students, file = 'data/output.csv') # 한글 깨짐
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8')

# row.names=F option 설정
## 앞에 있는 숫자들을 지워주는 옵션
write.table(students, file= "data/output.txt", fileEncoding = 'utf-8'
            , row.names=F)
write.csv(students, file= "data/output.csv", fileEncoding = 'utf-8'
            , row.names=F)

# quote=F option
write.table(students, file='data/output.txt', fileEncoding = 'utf-8'
            , row.names=F, quote=F)
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8'
            , row.names=F, quote=F)

# 제대로 읽는지 확인
students <- read.table('data/output.txt', header =T, fill=T
                       , fileEncoding ='utf-8')
students
students <- read.csv('data/output.csv', fileEncoding='utf-8')
students
str(students)

# 읽을 때 stringAsFactors=F 로 하면 문자열을 범주형으로 읽지 않음
students <- read.csv('data/output.csv',fileEncoding='utf-8',stringsAsFactors =F)
students