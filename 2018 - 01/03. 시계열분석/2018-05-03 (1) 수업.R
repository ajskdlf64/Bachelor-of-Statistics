library(forecast)

e_stock <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/elecstock.txt")
e_stock.ts <- ts(e_stock)
plot(e_stock.ts)
acf(e_stock.ts)
pacf(e_stock.ts)

# 차분 실시
ndiffs(e_stock)             # 단위근 검정 결과는 1차 차분
e_stock2 <- diff(e_stock)
e_stock2.ts <- ts(e_stock2)
plot(e_stock2.ts)
acf(e_stock2)
pacf(e_stock2)

# 1차 차분된 자료 : 백색잡음과정, 원자료 : 확률보행과정
# 함수 arima()는 d>=1 인 경우 절편의 추정 및 검정은 불가능.

# Arima(x, order=c(0,0,0,), include.mean=TRUE, include.drift=FALSE, fixed=NULL)
# x <- 시계열 자료.
# order(0,0,0) <-  ARIMA(p,d,q)의 차수 지정.
# include.mean <- d=0의 자료에 대하여 모형의 평균 포함 여부.
# include.drift <- d=1의 자료에 대하여 절편 포함 여부.
# fixed <- 비유의적 모수 제거.

Arima(e_stock, order=c(0,1,0), include.drift=TRUE)            # -0.08 / 0.56   (추정값/se)를 해서 0 근처면 비유의적.
(fit <- Arima(e_stock,order=c(0,1,0)))

tsdiag(fit, gof.lag=24)     # 잔차 분석.

# 과대 적합 실시
fit1 <- Arima(e_stock, order=c(1,1,0), include.drift=TRUE)
confint(fit1)     # 추가된 모수가 비유의적.
fit2 <- Arima(e_stock, order=c(0,1,1), include.drift=TRUE)
confint(fit2)     # 추가된 모수가 비유의적.

# 추가된 모수가 모두 비유의적이므로 따라서 절편 없는 ARIMA(0,1,0) 모형 확정.
