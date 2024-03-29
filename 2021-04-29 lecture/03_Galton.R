# Galton 선형회귀
library(dplyr)
library(ggplot2)

df <- read.csv('http://www.randomservices.org/random/data/Galton.txt',
                sep='\t')
head(df)

# 아버지와 아들의 키
galton <- df %>% 
    filter(Gender == 'M') %>% 
    mutate(father=2.54*Father, son=2.54*Height)
head(galton)

ggplot(galton, aes(father, son)) +
    geom_point(position='jitter', color='darkorange')

model <- lm(son~father, data=galton)
coef(model)
ggplot(galton, aes(father, son)) +
    geom_point(position='jitter', color='darkorange') +
    geom_abline(intercept=coef(model)[1], slope=coef(model)[2], 
                color='darkblue', size=1)

summary(model)
par(mfrow=c(2,2))
plot(model)
par(mfrow=c(1,1))

# 다차식 회귀
x <- seq(min(galton$father), max(galton$father), length.out=1000)
plot(jitter(galton$father), jitter(galton$son),
     xlab='Father', ylab='Son')
colors <- c('red','purple','darkorange','blue')
for (i in 1:4) {
    m <- lm(son ~ poly(father, i), data=galton)
    assign(paste('m', i, sep='.'), m)
    y <- predict(m, data.frame(father=x))
    lines(x, y, col=colors[i], lwd=2)
}
anova(m.1, m.2, m.3, m.4)

 coef(model)
 head(galton)

