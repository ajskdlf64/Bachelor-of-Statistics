



z <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/z.txt")
z.ts <- ts(z)
plot(z.ts)
acf(z.ts)
pacf(z.ts)

fit1 <- arima(z,order=c(3,0,0))
confint(fit1)

arima(z,order=c(1,0,1))$aic
arima(z,order=c(1,0,2))$aic
arima(z,order=c(2,0,1))$aic
arima(z,order=c(2,0,2))$aic

fit1.1 <- arima(z,order=c(2,0,1))
confint(fit1.1)

tsdiag(fit1.1, gof.lag=24, type="Ljung-Box")
Box.test(fit1.1$resid,lag=18, type="Ljung-Box",fitdf=4)



my_diag <- function(fit,fitdf){
n_lag <- 24
res <- numeric(n_lag)
for(i in seq_along(res)){res[i] <- Box.test(fit$resid,lag=i+n_fit,type="Ljung-Box",fitdf=n_fit)$p.value}
plot(1:n_lag+n_fit,res,ylim=c(0,max(res)),xlab="Lag",ylab="P-value")
abline(h=0.05,col="blue")
}
my_diag(fit1,fitdf=3)
my_diag(fit2,fitdf=3)

library(forecast)
Arima(z,order=c(2,0,1))
