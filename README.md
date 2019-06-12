## [HYU] 2019_1학기_통계적모델링_실습

## 개발 환경 설정 (based on OSX)
### Requirements
- [R Language](https://www.r-project.org/)
- [R Studio IDE](https://www.rstudio.com/products/rstudio/download/)

위 Requirements를 자신의 운영체제(OS)에 맞게 설치

1. R Language는 Mac OSX의 패키지 매니저인 Homebrew를 이용해 설치한다.
```
brew install r (high sierra 버전부터 가능, 이전 버전은 아래의 URL 참조)
```
https://stackoverflow.com/questions/20457290/installing-r-with-homebrew

2. R Studio IDE는 Standalone 설치 가능

## 실습 Overview
| 날짜   |      실습 내용      |
|----------|:-------------:|
| 2019-03-27 | 전체적인 내용 및 설치, R Lang 기본적인 내용 수업 |
| 2019-04-03 | 정규분포 관련 R Function |
| 2019-05-22 | R Boxplot + Data Manipulation 수업 |
| 2019-05-29 | 회귀분석 #1 |
| 2019-06-05 | User Defined Function + 로지스틱 회귀분석 #2 |

## Term Project

`보험료 회귀분석 with Medical Cost Dataset` from [Medical Cost Personal Datasets in Kaggle](https://www.kaggle.com/mirichoi0218/insurance)

회귀 분석을 이용한 보험료 예측을 주제로 탐색적 자료 분석 (EDA) + 회귀 분석 + 가정 검정을 진행

4개의 기본 가정 검정 중 정규성 검증을 위배하는 모델 존재

잔차 1.5를 기준으로 데이터를 2그룹으로 나누어 `2 - Model`로 나누어 회귀 모델 생성하여 해결

### 데이터 소개

| 변수   |      변수 설명      |
|----------|:-------------:|
| 보험료 | 건강보험으로 청구된 개인 의료비 |
| 성별 | 보험계약자의 성별 |
| 흡연 여부 | 보험계약자의 흡연 여부 |
| 지역 | 수혜자의 거주지 |
| 자녀 수 | 건강보험 적용 대상 아동 수 또는 피부양자 수 (0~5) |
| 나이 | 1차 수혜자의 연령 (18~64) |
| BMI | 신체에 대한 이해를 제공하는 체질량 지수 |

### EDA

Correlation Analysis 결과

- `보험료 (Charges)` 기준
- `나이`와 가장 강한 상관관계
- 전체적으로 약한 양의 상관관계

### 전처리 + 변수 조합

`성별`, `흡연 여부`, `지역` 범주형 변수를 데이터 변환

변수 조합 `Smoker * BMI`, `Smoker * Sex * BMI_Dummy`로 변수간의 상관관계가 있는 2개, 3개의 요인을 묶어 분석

### 회귀 분석 및 가정 검증

- Stepwise Variable Selection Method `Both`
- Shapiro-Wilk Test for Normality
- Durbin Watson Test

### 데이터 변환

- Z-Standardization
- Log Translation
- 2 - Model for Normality

