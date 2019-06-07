##### ex 11-1
zci2 <- function(n1, n2, xb1, xb2, s1, s2, alp) {
  err <- qnorm(1-alp/2) * sqrt(s1^2/n1 + s2^2/n2)
  xd <- xb1-xb2
  cat("[",xd-err,",",xd+err,"]")
}

# 신뢰구간만 계산
zci2(25, 34, 198.5, 201.3, 5, 5, 0.05)

# 검정 과정 -> P-Value
##### ex 11-2
sdev <- 5; alp <- 0.05
n1 <- 25; n2 <- 34
m1 <- 198.5; m2 <- 201.3
se <- sdev*sqrt(1/n1+1/n2)
pv <- 2 * pnorm(m1-m2, 0, se) # pnorm 자체는 단측검정 계산 따라서 양측검정을 위해 *2
tstat <- abs(m1-m2)/se
cat("Stat = ", tstat, "\tP-v=", pv, "\n")

# 위 예제와 맞는지 확인
err <- qnorm(1-alp/2) * se
paste0("[", round(m1-m2-err,3), ",", round(m1-m2+err, 3), "]")

win.graph(7,5)
source("normtest-plot.txt") # 함수 코드 Import
normtest.plot(m1-m2, 0, se, c(-4,4), "two")

#### ex11-3
tci2 <- function(n1, n2, xb1, xb2, s1, s2, alp) {
  sp2 <- ((n1-1) * s1^2 + (n2-1) * s2^2) / (n1+n2-2)
  sp <- sqrt(sp2)
  err <- qt(1-alp/2, n1+n2-2) * sp * sqrt(1/n1 + 1/n2)
  xd <- xb1 - xb2
  cat("Sp^2 =", sp2, "\tSp = ", sp, "\n")
  cat("[", xd-err, ",", xd+err, "]")
}

tci2(25, 34, 198.5, 201.3, 4.8, 5.1, 0.05)

#### ex11-5

alp <- 0.05; n1 <- 25; n2 <- 34
m1 <- 198.5; m2 <- 201.3
sd1 <- 4.8; sd2 <- 5.1
sp <- ((n1-1)*sd1^2 + (n2-1)*sd2^2)/(n1+n2-2)
se <- sqrt(sp*(1/n1+1/n2))
cat("Sp^2=",sp,"\ts.e=",se,"\n")

tstat <- abs(m1-m2)/se
pv <- 2*pt(-tstat, n1+n2-2)
cat("Stat=",tstat,"\tP-v=",pv,"\n")

err <- qt(1-alp/2, n1+n2-2)*se
paste0("[",round(m1-m2-err,3),",",round(m1-m2+err,3),"]")

win.graph(7,5)
source("ttest-plot.txt")
ttest.plot(tstat,n1+n2-2,c(-3.5,3.5))

