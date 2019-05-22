### ex 2-3 ####

getwd() # Working Directory Check
setwd("./") # Set Working Directory

data22 <- read.csv("data_set/tab2-2.csv") # Mac OSX 한글 깨짐 현상 발생
# 그럴 경우 Microsoft Excel Open -> 데이터 -> 외부 데이터 가져오기 -> 텍스트 파일 가져오기 -> 문제가 있는 CSV를 IMPORT
# 옵션 - Mac OSX 한글, 쉼표 구분 으로 가져오기 -> 다른이름으로 저장 -> CSV UTF-8 로 저장
str(data22)
summary(data22)

data22$성별 <- as.factor(data22$성별) # 성별은 범주형 변수가 맞기 때문에 잘못된 데이터 값이 들어가면 as.factor로 범주형 변수로 변환

### ex 2-9 ###

data21 <- read.csv("data_set/tab2-1.csv", header = FALSE) # First ROW를 Not Header 로 인식하도록!
x <- as.matrix(data21)

x2 <- matrix(x, ncol=1)

boxplot(x2, horizontal=T, main="저항 데이터의 상자그림", col=5)
points(x2, rep(1, 100))

xfn <- fivenum(x2);xfn
text(xfn, 0.65, labels=xfn, pos=3)
text(5.2, 1.3, labels=paste0("평균=", mean(x2), "\n표준편차=", round(sd(x2), 4), "\n표본개수=", length(x2)), col=4)

### ex 2-10 ###
?boxplot
boxplot(x, main="저항 데이터의 열별 상자그림", boxwex=0.5)
grid(col=3)
points(rep(1:10, each=10), x, pch=19, col=2) # Why? Y축 값에 x 를 넣는게 이해가 안됨..?

xstats <- apply(x, 2, fivenum)
text(rep(1:10, each=5), xstats, labels=xstats, col=4)

