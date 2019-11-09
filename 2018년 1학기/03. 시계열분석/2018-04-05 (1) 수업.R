
CBE <- read.table("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/cbe.txt",header=TRUE)
head(CBE)

Beer.ts <- with(CBE, ts(beer,start=1958,freq=12))               # with 는 attach와 똑같음.
plot(Beer.ts)                                                   # 호주 1958년 1월 ~ 1990년 12월 맥주 생산량 시계열 그림 작성.


# 그래프를 보면 증가하는 추세, 비정상 시계열 모형이다.


acf(Beer.ts)                           # ACF 그래프 그리기.
pacf(Beer.ts)                          # PACF 그래프 그리기.  
plot(diff(Beer.ts))                    # 일차 차분.  

plot(diff(log(Beer.ts)))               # 로그 변환 후 차분.
acf(diff(log(Beer.ts)))                # 로그 변환 후 ACF 함수.   튀어나온 1.0 과 2.0 부분이 계절변동이 있는것 처럼 보인다.
pacf(diff(log(Beer.ts)))               # 로그 변환 후 PACF 함수.


# ARIMA(1,1,0) 모형에서 난수 발생.
set.seed(1234)
z <- arima.sim(model=list(order=c(1,1,0),ar=0.5),n=1000)
plot(z)
acf(z)
pacf(z)

z1 <- diff(z)
plot(z1)                # 차분을 하면 정상성 만족.
acf(z1)                 # 둘중에 뭐를 절단, 감소로 할지 판단. 그래서 AR모형인지, MA모형인지 판단.
pacf(z1)

z2 <- diff(z,d=2)       # d=2 를 써주면 바로 2차 차분.
plot(z2)
acf(z2)
pacf(z2)


