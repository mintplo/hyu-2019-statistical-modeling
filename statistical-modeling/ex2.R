x <- seq(-10, 10, 1)
x

x <- seq(-10, 10, 0.1)
x

# ctrl + l = clean
y <- (x^2) + 4*x + 4
plot(x,y)

# Log Plot
x <- seq(0, 5, 0.1)
x

y <- log(x)
plot(x, y)

#
x <- seq(1, 1000, 1)
y <- sqrt(x)
plot(x, y, type="l", col="blue")
plot(x, y, type="l", col="red")
plot(x, y, type="l", col="blue", main="apple")
plot(x, y, type="l", col="blue", main="apple", sub="type=early")

#
x <- c(0, 4, 6, 7, 3, 5, 7, 3)
y <- c(0, 7, 8, 7, 6, 3, 2, 5)
par(mfrow=c(1,1))
plot(x, y)
abline(a=2, b=0.5)
abline(h=4)
abline(v=5)

#
x <- c(68, 67, 66, 64, 69, 68, 72, 65,71, 67, 69, 70)
y <- c(65, 63, 66, 64, 67, 62, 70, 66, 68, 69, 68, 71)
plot(x, y)
lm.result <- lm(y~x)
abline(lm.result)
abline(lm.result, col="red")

#
data(iris)
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)

hist(iris$Sepal.Length, probability = TRUE)
lines(density(iris$Sepal.Length))
lines(density(iris$Sepal.Length), col="blue")

#
set.seed(1234) # Random Number Generator
x=rbinom(1000, 50, 0.3)
x

x11()
hist(x, pro=T, xlab="x", main="", breaks=seq(2, 26, 1))

x1=seq(0, 25, 1)
fx=dbinom(x1, size = 50, prob=0.3)
lines(x1, fx, lwd=2, col="blue")

hist(x, pro=T, xlab="x", main="", breaks=seq(2, 26, 0.1))
hist(x, pro=T, xlab="x", main="", breaks=seq(2, 260, 1))
hist(x, pro=T, xlab="x", main="", breaks=seq(2, 26, 1))
hist(x, pro=T, xlab="x", main="", breaks=seq(2, 26, 0.5))


#
set.seed(1234)
x = rnbinom(1000, size = 5, prob = 0.3)
hist(x, plot=T, xlab="x", xlim=c(0, 40), breaks=seq(0, 42, 1))

x1 = seq(0, 40, 1)
fx = dnbinom(x1, size=5, prob=0.3)

#
set.seed(1234)
x = rnorm(1e4, mean=0, sd=sqrt(5))
hist(x, prob=T, xlab="x", main="", xlim=c(-8, 8), breaks=c(seq(-8, 8.2, 0.5)))
hist(x, prob=T, xlab="x", main="", xlim=c(-8, 8), breaks=c(seq(-8, 8.2, 0.2)))

# (1000번 시행을 한) 정규분포 PDF 그린다. => A4지에 (과정/절차)를 적어서 제출 (다음 수업시간까지)

# 어떤 시행을 했을 때 => 정규분포로 나타낼 수 있다. (P. 204, 205)
# 표본 조사 (1000명) => 평균 70kg로 가정 => 그 기준으로 좌우를 표현하는데....
# 그것에 대한 확률을 다 더할때 1이 되어야 하는데...

#
x1 = seq(-8, 8, length=100)
fx=dnorm(x1, 0, sqrt(5))
lines(x1, fx, lwd=3, col="blue")
