# 작업 환경 설정
getwd()

# 데이터 로드 
df <- read.csv("insurance.csv")

# 데이터 확인
head(df)
str(df) #1338행, 7열
summary(df)

summary(df$charges)

summary(df$region)

# 전처리
# 범주형 변수 변환
# 1. 성별 변환
df["sex_dummy"] <- ifelse(df$sex=="male",1,0) #남자면 1 여자면 0으로 변경
df$sex_dummy<-as.factor(df$sex_dummy, levels=c(0, 1))
head(df$sex_dummy)
head(df$sex)

# 2. 흡연여부 변환
df["smoker_dummy"] <- ifelse(df$smoker=="yes",1,0) #비흡연 0 흡연 1로 변경
df$smoker_dummy<-as.factor(df$smoker_dummy)
head(df$smoker_dummy)
head(df$smoker)

# 3. 지역 변환
table(df$region)
df["region_dummy"] <- ifelse(df$region=="northeast",0,ifelse(df$region=="northwest",1,ifelse(df$region=="southeast",2,3))) #비흡연 0 흡연 1로 변경
df$region_dummy<-as.factor(df$region_dummy)
head(df$region_dummy)
head(df$region)
library(car)
library(MASS)

#=====================================================================
#  *변수조합 
head(df)
attach(df)
str(df)
df$smoker_dummy<-as.numeric(df$smoker_dummy) # 1,2로 바뀜 (이유 모름)
df$smoker_dummy<-df$smoker_dummy-1 # 1 빼줌 
df[, "smoker*bmi"] = df[, "bmi"]*df[, "smoker_dummy"] # 1. smoker * bmi 생성
head(df)

hist(bmi) # 30기준으로 거의 대칭
df["bmi_dummy"] = ifelse(df$bmi>30, 1, 0) # 30넘으면 1, 이하는 0인 변수 2. bmi_dummy 생성
head(df)
df["smoker*bmi_dummy"] = df[, "bmi_dummy"]*df[, "smoker_dummy"] # 3. smoker * bmi_dummy 생성
head(df)

df$sex_dummy<-as.numeric(df$sex_dummy) # 1,2로 바뀜 (이유 모름)
df$sex_dummy<-df$sex_dummy-1 # 1 빼줌
df["sex*smoker*bmi_dummy"] = df[,"smoker*bmi_dummy"]*df[,"sex_dummy"] # 4. sex*smoker*bmi_dummy 생성
head(df)

str(df) # dummy들 factor로 다 바꾸어줌 
df$sex_dummy <-as.factor(df$sex_dummy)
df$smoker_dummy <-as.factor(df$smoker_dummy)
df$bmi_dummy <-as.factor(df$bmi_dummy)
df[,"smoker*bmi_dummy"] <-as.factor(df[,"smoker*bmi_dummy"])
df[,"sex*smoker*bmi_dummy"] <-as.factor(df[,"sex*smoker*bmi_dummy"])
str(df)
head(df)

#========================================================
# 회귀 모델
m1 <- lm(charges~., data=df)
summary(m1)


# 변수선택 
m2<-step(m1, direction = "both")
summary(m2)
vif(m2)

# 로그화
head(df)
df["age_log"]<-log(df$age)
df["bmi_log"]<-log(df$bmi)
df["charges_log"]<-log(df$charges)

df_log<-subset(df, select=-c(charges,age,bmi))
m3 <- lm(charges_log~., data=df_log)
summary(m3)

m4<-step(m3, direction = "both")
summary(m4)
vif(m4) # 다중공선성 존재 
head(df_log)
# 제외해줌
df_log<-df_log[,-8]
m3 <- lm(charges_log~., data=df_log)
summary(m3)

m5<-step(m3, direction = "both")
summary(m5)
vif(m5) # 다중공선성 해소 

# => m2, m5(log) 모델이 최종 

#=================================================================
# 가정 검정

# 1. 선형성 : x가 y와 선형관계를 가지는가 => 상관분석과 변수선택을 통해 검증완료

# 2. 독립성 : x끼리 독립인가 => vif를 통해 검증 완료

# 3. 정규성 : 잔차가 정규분포를 띄는가 => qq plot 위배 

# 4. 자기상관성 : 잔차끼리 상관성 유무 파악 

# 잔차분석
resid <-rstandard(m2)
yhat <- fitted(m2)
qqnorm(resid);qqline(resid,col=3)
shapiro.test(resid) # 정규성 위반 
durbinWatsonTest(m5) #자기상관성 존재 x


resid <-rstandard(m5)
yhat <- fitted(m5)
qqnorm(resid);qqline(resid,col=3)
shapiro.test(resid) # 정규성 위반 
durbinWatsonTest(m5) #자기상관성 존재 x

# 결론 => 두모델 모두 정규성만 만족하지 못함 => 이대로 끝내도 ok

# ==============================================================
# further step
# 두개의 모델 만들기 
# idea : 끝쪽에 휘어지는 부분(잔차>2부분)만 따로 모델만듦  
# 1. 잔차>2 모델 
resid <-rstandard(m2)
a<-data.frame(resid)
a[,2]<-rownames(a)
head(a)
b<-a[a[, 1]>2,]
head(b)
b[,2]
bigres<-df[b[,2], ]
str(bigres)

bigres<-subset(bigres, select = -c(age_log,bmi_log,charges_log))

res_lm <- lm(charges~., data=bigres)
summary(res_lm)

res_step<-step(res_lm, direction = "both")
summary(res_step)
vif(res_step)

# 잔차분석
res <-rstandard(res_step)
yhat <- fitted(res_step)
qqnorm(res);qqline(res,col=3)
shapiro.test(res) # 정규성 만족
durbinWatsonTest(res_step) #자기상관성 존재 x

summary(res_step)

# 2. 잔차 <=2 모델
resid <-rstandard(m2)
head(resid)
a<-data.frame(resid)
a[,2]<-rownames(a)
head(a)
b<-a[a[, 1]<=2,]
head(b)
b[,2]
smallres<-df[b[,2], ]
str(smallres)

smallres<-subset(smallres, select = -c(age_log,bmi_log,charges_log))

res_lm2 <- lm(charges~., data=smallres)
summary(res_lm2)

res_step2<-step(res_lm2, direction = "both")
summary(res_step2)
vif(res_step2)# 다중공선성 존재 

# 제외해줌
names(smallres)
smallres<-smallres[,-11]
head(smallres)
res_lm3 <- lm(charges~., data=smallres)
summary(res_lm3)

res_step3<-step(res_lm3, direction = "both")
summary(res_step3)
vif(res_step3) #다중공선성 해소 

# 잔차분석
res <-rstandard(res_step3)
yhat <- fitted(res_step3)
qqnorm(res);qqline(res,col=3)
shapiro.test(res) # 정규성 위배 
durbinWatsonTest(res_step3) #자기상관성 존재 x

# 현재까지 결론 모델 1은 정규성까지 만족, 2는 정규성만 위배
# R2= 0.866 / 0.9857

# Model1
datafr = data.frame(
  age=28,
  children=0
)
datafr[,"smoker*bmi"] = 22.9
datafr[,"smoker*bmi_dummy"] = factor(0, levels=c(0, 1))

predict(res_step, newdata = datafr)

datafr = data.frame(
  age=25,
  children=0
)
datafr[,"smoker*bmi"] = 0
datafr[,"smoker*bmi_dummy"] = factor(0, levels=c(0, 1))

predict(res_step, newdata = datafr)


#Model2
summary(res_step3)

datafr = data.frame(
  age=28,
  bmi=22.9,
  children=0,
  sex=factor("male", levels=c("female", "male")),
  smoker=factor("yes", levels=c("no","yes")),
  region = factor("southwest", levels=c("northeast", "northwest", "southeast", "southwest")),
  bmi_dummy = factor(0, levels = c(0,1))
)
datafr[,"smoker*bmi_dummy"] = factor(0, levels=c(0, 1))
datafr[,"sex*smoker*bmi_dummy"] = factor(0, levels=c(0, 1))

datafr = data.frame(
  age=25,
  bmi=23.8,
  children=0,
  sex=factor("male", levels=c("female", "male")),
  smoker=factor("no", levels=c("no","yes")),
  region = factor("southwest", levels=c("northeast", "northwest", "southeast", "southwest")),
  bmi_dummy = factor(0, levels = c(0,1))
)
datafr[,"smoker*bmi_dummy"] = factor(0, levels=c(0, 1))
datafr[,"sex*smoker*bmi_dummy"] = factor(0, levels=c(0, 1))

predict(res_step3, newdata = datafr)
