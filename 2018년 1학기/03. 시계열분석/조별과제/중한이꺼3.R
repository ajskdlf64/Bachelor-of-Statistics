airport <- scan("C:/Users/user/Desktop/학교수업/시계열분석/조별과제/airport.txt")
airport.ts<-ts(airport,start=2002,freq=12)
plot(airport.ts)
library(forecast)
ggtsdisplay(airport.ts)

log_airport <- log(airport.ts)
plot(log_airport)
d_airport <- diff(log(airport.ts))
plot(d_airport)
ggtsdisplay(d_airport)
sd_airport<-diff(d_airport,lag=12)
ggtsdisplay(sd_airport,lag.max = 48)

port_1 <- diff(log_airport)
ggtsdisplay(port_1,lag.max=48)  #arima(0,1,1),arima(4,1,0) ,(1,1,1)(2,1,1)(1,1,2),(2,1,2)
port_12 <- diff(log_airport,lag=12)
ggtsdisplay(port_12,lag.max = 48)  #arima(2,0,0)(0,1,1) 
port_1_12 <- diff(port_1,lag=12)
ggtsdisplay(port_1_12,lag.max = 48)

fit1.1 <- Arima(log_airport,order=c(0,1,1),include.drift =FALSE)
fit1.1
confint(fit1.1)
fit1.1.1 <- Arima(log_airport,order=c(1,1,1),include.drift = FALSE)  #o
fit1.1.1
fit1.1.2 <- Arima(log_airport,order=c(0,1,2),include.drift = FALSE)  #o
fit1.1.2
confint(Arima(log_airport,order=c(2,1,1),include.drift = FALSE))  #x 추가된모수 비유의적
confint(Arima(log_airport,order=c(1,1,2),include.drift = FALSE))  #x ma1 비유의적 빼고보면 1,1,1됨
confint(Arima(log_airport,order=c(0,1,3),include.drift = FALSE))  #x 추가된 모수가 비유의저
#aic bic 비교했을떄 1,1,1이 제일 작음


## 계절형 차분만 실시 

fit2.1 <- Arima(log_airport,order=c(2,0,0),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12))
fit2.1
confint(fit2.1)
checkresiduals(fit2.1)  #ㅇㅋ 확인 가능

#(2,0,0)(0,1,1)에 대한 과대적합
confint(Arima(log_airport,order=c(2,0,1),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12)))#  추가된 모수는 유의적,ar2모수가 비유의적  ar2제거  
#ar2제거하고 (1,0,1)(0,1,1)로 확인
fit2.1.1.9 <- Arima(log_airport,order=c(1,0,1),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12))
fit2.1.1.9
confint(fit2.1.1.9)
checkresiduals(fit2.1.1.9)  #0
#(1,0,1)(0,1,1) 과대적합
confint(Arima(log_airport,order=c(1,0,2),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12))) #ma1 모수가 비유의적
confint(Arima(log_airport,order=c(1,0,2),include.drift = TRUE,fixed=c(NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))#0

confint(Arima(log_airport,order=c(1,0,3),include.drift = TRUE,fixed=c(NA,0,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #0
confint(Arima(log_airport,order=c(2,0,2),include.drift = TRUE,fixed=c(NA,NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #0

confint(Arima(log_airport,order=c(2,0,3),include.drift = TRUE,fixed=c(NA,NA,0,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #0
confint(Arima(log_airport,order=c(1,0,4),include.drift = TRUE,fixed=c(NA,0,NA,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X
confint(Arima(log_airport,order=c(3,0,2),include.drift = TRUE,fixed=c(NA,NA,NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X

confint(Arima(log_airport,order=c(3,0,3),include.drift = TRUE,fixed=c(NA,NA,NA,0,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X
confint(Arima(log_airport,order=c(2,0,4),include.drift = TRUE,fixed=c(NA,NA,0,NA,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #왜 안돌아가는지 모르겟음 ;; 
confint(Arima(log_airport,order=c(3,0,4),include.drift = TRUE,fixed=c(NA,NA,NA,0,NA,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X

#잠정모형
fit2.1.1.1.5 <- Arima(log_airport,order=c(2,0,3),fixed=c(NA,NA,0,NA,NA,NA,NA),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12))  #0
fit2.1.1.1.5
checkresiduals(fit2.1.1.1.5)


fit2.1.2 <- Arima(log_airport,order=c(3,0,0),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12))
fit2.1.2
confint(fit2.1.2)
checkresiduals(fit2.1.2)  #일단만족

#(3,0,0)(0,1,1)에 대한 과대적합
fit2.1.2.1 <- Arima(log_airport,order=c(4,0,0),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12))
confint(fit2.1.2.1)  #x
fit2.1.2.2 <- Arima(log_airport,order=c(3,0,1),include.drift=TRUE,include.mean = TRUE,seasonal = list(order=c(0,1,1),period=12))
fit2.1.2.2
confint(fit2.1.2.2)
checkresiduals(fit2.1.2.2)  #0

#(3,0,1)(0,1,1)에 대한 과대적합
confint(Arima(log_airport,order=c(4,0,1),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12)))  #x
confint(Arima(log_airport,order=c(3,0,2),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12)))  #x
#잠정모형

c(fit2.1.1.9$aic,fit2.1.1.9$bic)
c(fit2.1.2$aic,fit2.1.2$bic)

pred <- scan("C:/Users/user/Desktop/학교수업/시계열분석/조별과제/airport17.txt")
port17 <- ts(pred,start=2017,freq=12)

fit2.1.1.1.5 <- Arima(airport.ts,order=c(1,0,1),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12),lambda = 0)
port17 <- ts(pred,start=2017,freq=12)
fore_arima1 <- forecast(fit2.1.1.1.5,h=12,level=95)
plot(fore_arima1)
lines(port17,col="red")
new_t <- seq(2017,by=1/12,length=12)
lines(new_t,port17,col="red")
plot(fore_arima1,xlim=c(2017,2018),ylim=c(3000000,8000000))
lines(port17,col="red")
accuracy(forecast(fit2.1.1.1.5),port17)  #203 011


fit2.1.2.2 <- Arima(airport.ts,order=c(3,0,1),include.drift = TRUE,seasonal = list(order=c(0,1,1),period=12),lambda=0)
port17 <- ts(pred,start=2017,freq=12)
fore_arima <- forecast(fit2.1.2.2,h=12,level=95)
plot(fore_arima)
lines(port17,col="red")
new_t <- seq(2017,by=1/12,length=12)
lines(new_t,port17,col="red")
plot(fore_arima,xlim=c(2017,2018),ylim=c(3000000,8000000))
accuracy(forecast(fit2.1.2.2),port17)  #301 011


##회귀
Time <- time(log_airport)
Month <- cycle(log_airport)
fit11 <- lm(log_airport~Time+factor(Month)+0)
summary(fit11)
library(forecast)
checkresiduals(fit11)
resid <- fit11$residuals
ggtsdisplay(resid,lag.max = 48)   #ar(3)
Arima(resid,order=c(3,0,0),include.mean = FALSE)
fit_r1 <- Arima(resid,order=c(3,0,0),include.mean=FALSE)
confint(fit_r1)
checkresiduals(fit_r1)
fit_r2 <- Arima(resid,order=c(3,0,1),include.mean=FALSE)
fit_r3 <- Arima(resid,order=c(4,0,0),include.mean=FALSE)
confint(fit_r2)    #x
confint(fit_r3)    #x
fit_x <- model.matrix(fit11)
f1 <- Arima(airport.ts,order=c(3,0,0),xreg = fit_x,include.mean=FALSE,lambda = 0)  
f1
coef(f1)
confint(f1)
checkresiduals(f1)  #반드시 보고 가야함!
new_t <- time(ts(start=c(2017,1),end=c(2017,12),freq=12))
new_x <- cbind(new_t,diag(rep(1,12)))
fore_2 <- forecast(f1,xreg=new_x,level=95)
plot(fore_2)
lines(port17,col="red")
accuracy(f1)
plot(fore_2,xlim=c(2017,2018),ylim=c(3000000,8000000))
accuracy(fore_2,port17)  #회귀

?plot

##계절 비계절 차분실시
nsdiffs(log_airport)
fit1<-Arima(log_airport,order=c(2,1,0),seasonal = list(order=c(0,1,1),period=12))
checkresiduals(fit1)
fit2<-Arima(log_airport,order=c(2,1,1),seasonal = list(order=c(0,1,1),period=12))
confint(fit2)
checkresiduals(fit2)
fit2
fit3<-Arima(log_airport,order=c(0,1,3),seasonal = list(order=c(0,1,1),period=12))
confint(fit3)
checkresiduals(fit3)
fit4<-Arima(log_airport,order=c(3,1,1),seasonal = list(order=c(0,1,1),period=12))
confint(fit4)
checkresiduals(fit4)
auto.arima(log_airport,d=1,D=1)


fit2_1<-Arima(airport.ts,order=c(2,1,1),seasonal = list(order=c(0,1,1),period=12),lambda = 0)
c(fit2_1$aic, fit2_1$bic)


plot(forecast(fit2_1,h=12),xlim=c(2017,2018),ylim = c(3000000,8000000))
new<-seq(2017,by=1/12,length=12)
lines(new,port17,col="red")
accuracy(forecast(fit2_1,h=12),port17)  


fit1 <- Arima(airport.ts,order=c(2,1,1),seasonal = list(order=c(0,1,1),period=12),lambda=0)
port17 <- ts(pred,start=2017,freq=12)
fore_arima <- forecast(fit1,h=12,level=95)
plot(fore_arima)
lines(port17,col="red")
new_t <- seq(2017,by=1/12,length=12)
lines(new_t,port17,col="red")
plot(fore_arima,xlim=c(2017,2018),ylim=c(3000000,7000000))
lines(new_t,port17,col="red")
accuracy(forecast(fit1),port17)