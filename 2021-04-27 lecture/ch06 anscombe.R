# Anscombe's Quartet
head(anscombe)

# 평균
apply(anscombe,2,mean)
# 분산
apply(anscombe, 2,var)

# 상관관계
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)
for(i in 1:4) {
    ans_cor <- cor(anscombe[,i], anscombe[,i+4])
    print(ans_cor)
}

#요약
summary(anscombe)

# 그래프 그리기
library(ggplot2)

ggplot(anscombe) + 
    geom_point(aes(x1,y1),color='darkorange',size=3)

ggplot(anscombe) + 
    geom_point(aes(x2,y2),color='darkorange',size=3)

ggplot(anscombe) + 
    geom_point(aes(x3,y3),color='darkorange',size=3)

ggplot(anscombe) + 
    geom_point(aes(x4,y4),color='darkorange',size=3)

ggplot(anscombe) + 
    geom_point(aes(x1,y1),color='darkorange',size=3) +
    xlim(2,20) +
    ylim(2,14)

ggplot(anscombe) + 
    geom_point(aes(x1,y1),color='darkorange',size=3) +
    scale_x_continuous(breaks=seq(2,20,2)) +
    scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(slope = 0.5, intercept = 3,
                color = 'cornflowerblue',size=1) +
    labs(title = 'Dataset 1')
p1

p2 <- ggplot(anscombe) + 
    geom_point(aes(x2,y2),color='darkorange',size=3) +
    scale_x_continuous(breaks=seq(2,20,2)) +
    scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                color='cornflowerblue', size=1) +
    labs(title = 'Dataset II')

p3 <- ggplot(anscombe) + 
    geom_point(aes(x3,y3),color='darkorange',size=3) +
    scale_x_continuous(breaks=seq(2,20,2)) +
    scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                color='cornflowerblue', size=1) +
    labs(title = 'Dataset III')
    
p4 <- ggplot(anscombe) + 
    geom_point(aes(x4,y4),color='darkorange',size=3) +
    scale_x_continuous(breaks=seq(2,20,2)) +
    scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                color='cornflowerblue', size=1) +
    labs(title = 'Dataset IV')

library(gridExtra)
grid.arrange(p1,p2,p3,p4, ncol= 2, top="Anscombe's Quartet")

# Source Refactoring
x <- ggplot(anscombe) +
    geom_point(aes(x4,x4),color='darkorange', size=3)
m1 <- x
assign(paste('m',4,sep='.'),x)

grid.arrange(p1,p2,p3,m.4, ncol= 2, top="Anscombe's Quartet")

library(dplyr)
for(i in 1:4){
    x_data <- anscombe[,i]
    y_data <- anscombe[,4+i]
    x <- ggplot(anscombe) + 
        geom_point(aes(anscombe[,i],anscombe[,i+4]),
                   color='darkorange',size=3) +
        scale_x_continuous(breaks=seq(2,20,2)) +
        scale_y_continuous(breaks=seq(2,14,2)) +
        xlim(2,20) +
        ylim(2,14) +
        geom_abline(intercept = 3, slope = 0.5,
                    color='cornflowerblue', size=1) +
        labs(title = paste0('Dataset ',i),  
             x = paste0("x",i), y= paste0("y",i))
    assign(paste('m',i,sep='.'),x)
}
grid.arrange(m.1,m.2,m.3,m.4, ncol= 2, top="Anscombe's Quartet")

anscombe[,1]
