

global <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/global.txt")
head(global)



global.ts <- ts(global,start=(1856.1),frequency = 12)                 # 벡터형 변수를 시계열그림 그리기.
plot(global.ts, main="Monthly series")



New.series <- window(global.ts,start=c(1970.1),end=c(2005.12))        # 구간을 축소해서 그리기.
plot(New.series, main="Monthly series2")



New.time <- time(New.series)                                          # 시간이라는 변수 생성하기.
head(New.time, n=3)

plot(New.series)             
 
abline(lm(New.series ~ New.time),col="red")                           # 회귀직선 그리기.
