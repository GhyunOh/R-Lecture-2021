# 함수
fact <- function(x){
    prod <- 1
    for(i in 1:x){
        prod <- prod * i
    }
    return(prod)
}


fact(5)
fact(10)

# 정수 a~b의 합을 구하는 함수(rang_sum)
range_sum <- function(a,b){
    sum <- 0
    if(a > b){
        temp <- b
        b <- a
        a <- temp
    }
    for(i in a:b){
        sum <- sum + i
    }
    return(sum)
}
range_sum(10,1)

# 재귀 함수
facto <- function(n){
    if(n == 0){
        return(1)
    }
    return(n * facto(n-1))
}
facto(10)

fibo <- function(n){
    if(n == 0 | n == 1){
        return(1)
    } 
    return(fibo(n-1) + fibo(n-2))
}
fibo(0)

for(i in 0 :10) {
    print(paste(i,fibo(i)))
}

# Peak-to-peak 함수
peak2peak <- function(x){
    return(max(x) - min(x))
}
mat <- matrix(1:12, nrow= 3)
apply(mat, 1, mean)
mat
apply(mat, 1,peak2peak)
apply(mat, 2, peak2peak)
