setwd("./")
getwd()

View(iris) # 인자로 넘기는 데이터 구조 + 데이터를 확인하는 함수
str(iris) # 인자로 넘기는 데이터 구조를 확인, 대략적인 관측치 (structure) num - numeric, Factor - 범주형 변수
summary(iris) # 각 변수에 대한 통계 요약 값 확인 가능

x <- iris[[2]]
xh <- hist(x) # Histogram
str(xh) # breaks -> 경계값, counts -> 경계값에 들어가는 데이터 개수, density -> 상대도수, mids -> 계급값

xh$breaks # 구간 경계치
xh$counts # 구간별 도수
xh$mids # 구간별 대푯값, 계급값

n <- length(x) # 데이터의 갯수 (Vector Type에서 자주 사용)

xcf <- cumsum(xh$counts) # 구간별 누적 도수 cumulative sum..?

xrf <- xh$counts / n # 구간별 상대도수
xrf <- round(xrf, 4) # 소수점 4자리까지 표현하도록

?round # Command + Enter -> Func Help DOC

xrcf <- xcf / n # 구간별 상대누적도수
xrcf <- round(xrcf, 4) # 소수점 4자리까지 표현하도록

?paste0
xclass <- paste0("(", xh$breaks[-13], ",", xh$breaks[-1], "]") # (2.0, 2.2] ... (4.2, 4.4] Why? Verctor Type Data를 넣었기 때문에 Iteration
xclass

xtab <- cbind(xh$mids, xh$counts, xcf, round(xrf, 4), round(xrcf, 4)) # Column Bind 열단위로 합치게 된다.
rownames(xtab) <- xclass # 각 ROW의 이름
colnames(xtab) <- c('대푯값', '도수', '누적도수', '상대도수', '상대누적도수') # 각 Column의 이름
print(xtab)
