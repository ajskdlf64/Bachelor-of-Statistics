library(forecast)

# 자료 불러오기.
pop <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/pop.txt")
pop <- round(pop/10000)
pop.ts <- ts(pop,start=c(1960),frequency=1) 
plot(pop.ts,ylab="Population")

# 시간(t) 변수 생성 및 회귀모형 적합.
Time <- time(pop.ts)
fit1 <- lm(pop.ts~Time)

# 적합 결과 확인.
summary(fit1)

# 잔차분석.
checkresiduals(fit1)                    # 2차 추세? 양의 상관관계?     =>     2차 추세모형 시도.
 
# 2차 추세모형의 적합.
fit2 <- lm(pop.ts~Time+I(Time^2))       # R에서 I()는 안에 내용을 수학적으로 이해시켜줌.
summary(fit2)
checkresiduals(fit2)

# 로그변환을 통한 분산 안정화.
fit3 <- lm(log(pop.ts)~Time+I(Time^2))
summary(fit3)
checkresiduals(fit3)

# 오차가 독립이 아님.
# 오차에 대한 모형이 필요함.     오차 모형 : ARMA(p,q)
# 오차 모형 단계
# 1. 모형 식별.
# 2, 모형 추정.
# 3. 모형 진단.

resid <- ts(fit3$resid,start=1960)
ggtsdisplay(resid)
# 모형 식별 : AR(1) 로 판단.
fit4 <- arima(resid,order=c(1,0,0), include.mean=FALSE)
confint(fit4)
checkresiduals(fit4)
fit4_1 <- arima(resid,order=c(2,0,0), include.mean=FALSE)
confint(fit4_1)
checkresiduals(fit4_1)
fit4_2 <- arima(resid,order=c(1,0,1), include.mean=FALSE)
confint(fit4_2)
checkresiduals(fit4_2)

# AR(2) 로 잠정 결정.

# 추세모형(fit3)와 AR(2) 오차모형 : 두 모형의 결합.
fit_x <- model.matrix(fit3)[,-1]
f1 <- Arima(pop.ts,order=c(2,0,0),xreg=fit_x,lambda=0)
f1