# 계절추세 + ARMA 오차 회귀 모형.

library(forecast)

# 자료 불러오기.
tourist <- scan("C:/Users/user/Desktop/학교수업/시계열분석/수업 자료/tourist.txt")
tourist.ts <- ts(tourist, start = c(1981), frequency = 12)
tour92 <- scan("C:/Users/user/Desktop/학교수업/시계열분석/수업 자료/tourist.txt")
tour92.ts <- ts(tourist, start = c(1982), frequency = 12)
plot(tourist.ts, ylab = "관광객")

# 분산안정화를 위한 로그 변환.
lntourist <- log(tourist.ts)
plot(lntourist, ylab = "관광객")

# 시간(t) 변수 생성 및 변수(D) 생성.
Time <- time(lntourist)
Month <- cycle(lntourist)

# 계절추세모형 적합.
fit <- lm(lntourist ~ Time + factor(Month) + 0) # +0 하는 이유 : 절편 제거.   2차 모형을 해보고 넘어갈 필요는 있음.

# 적합 결과 확인.
summary(fit)

# 잔차분석.
checkresiduals(fit)

# 오차가 독립이 아님.
# 오차에 대한 모형이 필요함.     오차 모형 : ARMA(p,q)
# 오차 모형 단계
# 1. 모형 식별.
# 2, 모형 추정.
# 3. 모형 진단.

resid <- ts(fit$resid, start = 1981)
ggtsdisplay(resid,lag.max = 48)

# 모형 식별 : AR(3) 로 판단.
fit1 <- arima(resid, order = c(3, 0, 0), include.mean = FALSE)
confint(fit1)
checkresiduals(fit1)
fit1_1 <- arima(resid, order = c(4, 0, 0), include.mean = FALSE)
confint(fit1_1)
checkresiduals(fit1_1)           # 추가된 모수가 비유의적.
fit1_2 <- arima(resid, order = c(3, 0, 1), include.mean = FALSE)
confint(fit1_2)
checkresiduals(fit1_1)           # 추가된 모수가 비유의적.

# AR(3) 로 잠정 결정.

# 추세모형(fit1)와 AR(3) 오차모형 : 두 모형의 결합.
fit_x <- model.matrix(fit)
fit2 <- Arima(tourist.ts, order = c(3, 0, 0), xreg = fit_x, include.mean = FALSE, lambda = 0)
confint(fit2) # 모수의 유의성 검정.
summary(fit2)
coef(fit2)

# 잘못됨!!! 독립성이 위반!!!
# df가 확줄어들음....p-값이 유의적이라고 나옴...
# 자유도가 너무 작아서 독립 가설을 기각한 것으로 판단.
checkresiduals(fit2)

# 모형 예측.
new_t <- time(ts(start = c(1991, 1), end = c(1991, 12), freq = 12))
new_x <- cbind(new_t, diag(rep(1, 12)))
fore <- forecast(fit2, xreg = new_x)
accuracy(fore)
plot(fore)
lines(tour92,col='red')
# 계절형 ARIMA 모형과 비교하면 좋음...