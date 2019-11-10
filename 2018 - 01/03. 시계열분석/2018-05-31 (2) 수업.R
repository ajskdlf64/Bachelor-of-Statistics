

# 계절추세 + ARMA 오차 회귀 모형.


library(forecast)

# 자료 불러오기.
depart <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/depart.txt")
depart.ts <- ts(depart,start=c(1984),frequency=12) 
plot(depart.ts,ylab="월 매출액")

# 분산안정화를 위한 로그 변환.
lndepart <- log(depart.ts)
plot(lndepart,ylab="월 매출액")

# 시간(t) 변수 생성 및 변수(D) 생성.
Time <- time(lndepart)
Month <- cycle(lndepart)

# 계절추세모형 적합.
fit1 <- lm(lndepart~Time+factor(Month)+0)          # +0 하는 이유 : 절편 제거.

# 적합 결과 확인.
summary(fit1)

# 잔차분석.
checkresiduals(fit1)                    # 2차 추세? 양의 상관관계?     =>     양의 상관관계로 판단.
 
# 오차가 독립이 아님.
# 오차에 대한 모형이 필요함.     오차 모형 : ARMA(p,q)
# 오차 모형 단계
# 1. 모형 식별.
# 2, 모형 추정.
# 3. 모형 진단.

resid <- ts(fit1$resid,start=1984)
ggtsdisplay(resid)

# 모형 식별 : AR(3) 로 판단.
fit2 <- arima(resid,order=c(3,0,0), include.mean=FALSE, fixed=c(NA,0,NA))
confint(fit2)
checkresiduals(fit2)
fit2_1 <- arima(resid,order=c(4,0,0), include.mean=FALSE,fixed=c(NA,0,NA,NA))
confint(fit2_1)
checkresiduals(fit2_1)   # 추가된 모수가 비유의적.
fit2_2 <- arima(resid,order=c(3,0,1), include.mean=FALSE,fixed=c(NA,0,NA,NA))
confint(fit2_2)
checkresiduals(fit2_1)   # 추가된 모수가 비유의적.

# AR(3) 로 잠정 결정.

# 추세모형(fit1)와 AR(3) 오차모형 : 두 모형의 결합.
fit_x <- model.matrix(fit1)
fit2 <- Arima(depart.ts,order=c(3,0,0),xreg=fit_x,include.mean=FALSE,fixed=c(NA,0,NA,rep(NA,13)),lambda=0)
confint(fit2)            # 모수의 유의성 검정.
summary(fit2)
coef(fit2)

# 잘못됨!!! 독립성이 위반!!!
# df가 확줄어들음....p-값이 유의적이라고 나옴...
# 자유도가 너무 작아서 독립 가설을 기각한 것으로 판단.
checkresiduals(fit2)

# 모형 예측.
new_t <- time(ts(start=c(1989,1),end=c(1989,12),freq=12))
new_x <- cbind(new_t,diag(rep(1,12)))
fore_2 <- forecast(fit2,xreg=new_x)
accuracy(fore_2)
plot(fore_2)

# 계절형 ARIMA 모형과 비교하면 좋음.