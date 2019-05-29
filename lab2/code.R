# ======
# Regression Analysis in R
# ======
# 1. 주제 선정 & 데이터 수집 (SKT Data Hub, 기상청 날씨누리)
# - 분석 가능한 주제로 선정
# - 흥미 있는 주제로 선정
# - 국내 데이터로 먼저 탐색

# 2. 탐색적 데이터 분석
# - 데이터에 대한 이해 (관측치 수 파악)
# - 데이터 전처리 (곁측치 처리, 이상치 처리)
# - 변수들 간의 관계 파악 (상관관계, 그림을 통한 이해, 검정 등)
# - 일변량 데이터 분석

# 3. 데이터 분석
# - 분석의 목표 설정 (집값 예측 ,환자군 분류, 주가 예측)
# - EDA를 마친 데이터로 회귀분석 진행
# - 유의미한 변수 선택, 다중공선성 확인 (v-if 확인)
# - 잔차 분석 (ex. 정규성 검정, 자기상관성 존재 유무)
# - 결론 도출 (분석의 타당성, 회귀계수의 해석, 향후 과제 등)

data <- mtcars
view(data)

rownames(data) <- seq(1:length(data[,1]))
str(data) # 데이터 구조에 대한 분석

data <- data[,1:7] # mpg + (나머지 6개의 변수) 만 남김
str(data)

# 이미 전처리가 되어있는 데이터이기 때문에 회귀 분석 진행
# ========================================================

a <- as.data.frame(data[,1]) # Y 변수 선택하기 - mpg 추출
colnames(a)[1] <- colnames(data)[1] # Y 변수의 열 이름 지정

# x 값들을 하나씩 넣어서 분석하는 univariate analysis 진행
for (i in 2:length(data[1,])) {
  b <- summary(lm(data[,1]~data[,i]))

  if (b$coefficients[8] <= 0.05) {
    a <- cbind.data.frame(a, data[,i])
    colnames(a)[i] = colnames(data)[i]
  }
}

# ===== 유의미하지 않은 데이터는 탈락시키는 변수 선택 진행
finaldata <- a
View(finaldata)

m1 <- lm(mpg~., data=finaldata) # mpg~.(상관관계 - 모든 변수에 대한) linear model을 생성
summary(m1) # P-Value 회귀 계수가 0이냐에 대한 귀무가설 (회귀 계수가 0이면 상관관계가 없으니 적합X - 적합도 검정) P-Value를 낮춰야 하고 R^2 값은 높여야 한다.

step(m1, direction = 'both') # 변수 선택 법의 양방향을 모두 선택하는 방법

m2 <- lm(mpg~ cyl + hp + wt, data=finaldata)
summary(m2)

# 수동으로 진행 - 선택!
m3 <- lm(mpg ~ cyl + wt, data=finaldata)
summary(m3)

# ===== 다중 공선성 검증 (v-if check)
# 1. 직접 하는 방법
# 2. 패키지를 사용하는 방법

install.packages("car")
library(car)

vif(m3) # v-if 값이 모두 # 5보다 작기 때문에 다중 공선성이 없다!

# ====== 잔차 검증 (필수!)
resid <- rstandard(m3)
yhat <- fitted(m3)
qqnorm(resid);qqlinne(resid, col=2)
shapiro.test(resid) # P-Value 아슬아슬하게 0.05를 넘기 때문에 애매하게 정규성을 만족한다.

durbinWatsonTest(m3) # 자기 상관성 검증 P-Value > 0.5 => 자기 상관성이 존재하지 않는다.

# ====== On Next Week.