df <- read.csv("data.csv", header=T)
df$outcome[df$diagnosis=="B"]=0
df$outcome[df$diagnosis=="M"]=1
df$outcome <- as.integer(df$outcome)
df <- df[,-1]
str(df)

m1 <- glm(outcome~.,data=df, family=binomial(link='logit'),control=list(maxit=50))
summary(m1)
step(m1, trace=F)

# X1, X6 제거
m2 = glm(outcome ~ X2 + X3 + X4 + X5 + X7 + X8 + X9 + X10, family = binomial(link='logit'), data=df, control=list(maxit=50))
summary(m2)

# X3, X5 제거
m3 = glm(outcome ~ X2 + X4 + X7 + X8 + X9 + X10, family = binomial(link='logit'), data=df, control=list(maxit=50))
summary(m3)

#install.packages("car")
library(car)
vif(m3)

pred <- predict(m3, df, type='response')
pred <- ifelse(pred < 0.5, 0, 1)
table(pred, df$outcome)
summary(as.factor(df$outcome)) 

#install.packages("caret")
library(caret)
confusionMatrix(as.factor(pred),as.factor(df$outcome)) # 앞부분에 예측값, 뒷부분에 실제값
round(357/(357+212),4)