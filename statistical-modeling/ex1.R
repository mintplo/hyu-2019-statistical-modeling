#
data1 <- 1:3
data1
data2 <- 1:5
data2
plot(data2)

#
x <- 10:15
x
x[x>=13]<-50

#
x <- 1:15
x
x[2<=x & x<=10]
x[2<x & x<10]

#
pi
sin(5*pi/6)

sqrt(5)

log(5, base=10)

log(10, base=5)

log(100)

abs(-50)

factorial(6)

choose(10, 7)

#
s_score <- c(98, 90, 86, 76, 78, 85, 88, 93, 82, 90)
s_score

# concatenate

s_score_2 <- c(87, 93, 96, 91, 87, 85, 92, 88, 94, 97)
s_score_2

z<-c(7, 19, 27, 35, 97)
z

# family <- named char (문자열 삽입)
family <- c("min", "ko", "jiyoung", "bae")
names(family)=c("father", "mother", "daughter", "son")
family

#
logic1 <- c (T,F,F,F,T,F,F)

x <- (-4:3)
x

v <- (x<1)
v

sum(v)

#
min <- c(10, 20, 30, 40)
min

min1 <- as.factor(min)
min1

M.log<-as.logical(min)
M.log

#
sub.fact <- factor(c("kor", "math", "eng", "eng", "kor", "math"))
sub.fact

sub.fact1 <- as.numeric(sub.fact)
sub.fact1

#
a <- c(3.465, 5.789, 4.275, -2.676)
ceiling(a)
trunc(a)
floor(a)
round(a, digit=2)

#
stat<-c(87, 85, 86, 96, 78, 83, 89, 95, 92, 68)
sum(stat)
mean(stat)
max(stat)
min(stat)
range(stat)
var(stat)
sd(stat)
median(stat)
rank(stat)
length(stat)

#
x<-seq(1,10)
x

x<-1:10
x

seq(from=1, to=10, by=1)
seq(from=1, to=10, by=2)
seq(1, 10, 2)

seq(5, 30, by=3)

#
rep(1, 5)
rep(seq(-3, 3, by=2), 3)
rep(c(2,5,8), 4)
x<-rep(0,7)
x

#
rev(1:10)
10:1

x<-c(50, 58, 65, 70, 72, 77, 80, 84, 91, 94, 100, 101)
x[1]
x[9]
x[1:3]
x[c(6,7,9)]
names(x)<-seq(1,12)
x1<-x[-1]
x1
x2<-x[-c(2,5,6)]
x2

x3<-x[x<=77]
x3

x4<-x[x>80]
x4

x5<-x[x!=77]
x5

#
a<-c(100, 150, 120)
b<-c(90, 80, 66)
total<-matrix(c(a,b),nrow=2,byrow=TRUE)
total

dimnames(total)[[1]]<-c("A_company", "B_company")
total

dimnames(total)[[2]]<-c("Q1", "Q2", "Q3")
total

a<-c(5,6,7)
b<-c(1,2,3)
c<-c(4,5,6)
rbind(a,b,c)
cbind(a,b,c)

total<-cbind(total, c(110, 88))
total

dimnames(total)[[2]][4]<-c("Q4")
total

total<-rbind(total, c(110, 90, 88, 100))
dimnames(total)[[1]][3]<-c("C_company")
total

#
t_total<-t(total)
t_total

library(MASS)
mat<-total
inv<-ginv(mat)
inv