
# GLOBAL 데이터.

library(forecast)

# 자료 불러오기.
global <- scan("C:/Users/user/Desktop/학교수업/시계열분석/수업 자료/global.txt")
globalt <- ts(global, start = c(1856, 1), frequency = 12)
globaltd <- window(globalt, start = c(1970, 1), end = c(2003, 12), frequency = 12)
new.global <- window(globalt, start = c(2004, 1), end = c(2005, 12), frequency = 12)
plot(globaltd, ylab = "온도")

############################################################################################################
############################################################################################################

# 계절추세 + ARMA 오차 회귀 모형.

# 시간(t) 변수 생성 및 변수(D) 생성.
Time <- time(globaltd)
Month <- cycle(globaltd)

# 계절추세모형 적합.
fit <- lm(globaltd ~ Time + factor(Month) + 0) # +0 하는 이유 : 절편 제거.   2차 모형을 해보고 넘어갈 필요는 있음.

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

resid <- ts(fit$resid, start = 1970)
ggtsdisplay(resid,lag.max = 48)

# 모형 식별 : AR(2) 로 판단.
fit1 <- arima(resid, order = c(2,0,0), include.mean = FALSE)
confint(fit1)
checkresiduals(fit1)
fit1_1 <- arima(resid, order = c(3,0,0), include.mean = FALSE)
confint(fit1_1)
checkresiduals(fit1_1)          # 추가된 모수가 비유의적.
fit1_2 <- arima(resid, order = c(2,0,1), include.mean = FALSE)
confint(fit1_2)
checkresiduals(fit1_1)          # 추가된 모수가 비유의적.

# AR(2)로 결정.

# 추세모형(fit)와 AR(2) 오차모형 : 두 모형의 결합.
fit_x <- model.matrix(fit)
fit2 <- arima(globaltd, order = c(2,0,0), xreg = fit_x, include.mean = FALSE)
confint(fit2)                   # 모수의 유의성 검정.
summary(fit2)
coef(fit2)


# 잘못됨!!! 독립성이 위반!!!
# df가 확줄어들음....p-값이 유의적이라고 나옴...
# 자유도가 너무 작아서 독립 가설을 기각한 것으로 판단.
checkresiduals(fit2)

# 모형 예측.
new_t <- time(ts(start = c(2004, 1), end = c(2005, 12), freq = 12))
new_x <- cbind(new_t, rbind(diag(rep(1,12)),diag(rep(1,12))))
fore <- forecast(fit2, xreg = new_x,level=95)
accuracy(fore)
plot(fore)
lines(new.global,col="red")

############################################################################################################
############################################################################################################

# 계절형 ARIMA 모형.

# 시계열 그래프 그리기.
plot(globaltd, ylab = "온도")
ggtsdisplay(globaltd)

# 일반 차분 실시.
global_1 <- diff(globaltd)
plot(global_1)
ggtsdisplay(global_1)

# 잠정모형 : aR(3), ma(3), arma(1,1), arma(1,2), arma(2,1), arma(2,2)

fit7 <- Arima(globaltd, order=c(3,1,0), include.drift = FALSE, fixed=c(NA,0,NA))
confint(fit7)
fit7_1 <- Arima(globaltd, order=c(4,1,0), include.drift = FALSE, fixed=c(NA,NA,0,NA))
confint(fit7_1)
fit7_2 <- Arima(globaltd, order=c(3,1,1), include.drift = FALSE, fixed=c(NA,0,NA,NA))
confint(fit7_2)
checkresiduals(fit7)
#  ar(3) 사용 가능.

fit8 <- Arima(globaltd, order=c(0,1,3), include.drift = FALSE, fixed=c(NA,0,NA))
confint(fit8)
fit8_1 <- Arima(globaltd, order=c(1,1,3), include.drift = FALSE, fixed=c(NA,0,NA,NA))
confint(fit8_1)
fit8_2 <- Arima(globaltd, order=c(0,1,4), include.drift = FALSE, fixed=c(NA,0,NA,NA))
confint(fit8_2)
checkresiduals(fit8)
# ma(3) 사용 불가. 독립성 가정에 문제가 되는 모형.

fit9_1 <- Arima(globaltd, order=c(1,1,1), include.drift = FALSE)
fit9_2 <- Arima(globaltd, order=c(2,1,1), include.drift = FALSE)
fit9_3 <- Arima(globaltd, order=c(1,1,2), include.drift = FALSE)
fit9_4 <- Arima(globaltd, order=c(2,1,2), include.drift = FALSE)

fit9_1$aic
fit9_2$aic # arma(2,1) 선택.
fit9_3$aic
fit9_4$aic

fit9_2 <- Arima(globaltd, order=c(2,1,1), include.drift = FALSE)
confint(fit9_2)
fit9_2_1 <- Arima(globaltd, order=c(3,1,1), include.drift = FALSE)
confint(fit9_2_1)
fit9_2_2 <- Arima(globaltd, order=c(2,1,2), include.drift = FALSE)
confint(fit9_2_2)
checkresiduals(fit9_2)
# arma(2,1) 사용가능.

# 최종 통과된 모형들 : arima(3,1,0), arma(2,1,1)
c(fit7$aic, fit7$bic)
c(fit9_2$aic,fit9_2$bic)

# 최종 모형 : ARIMA(2,1,1)

# 계절형 차분도 해보고 결정하자!