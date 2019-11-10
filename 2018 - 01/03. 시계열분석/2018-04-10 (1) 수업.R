
ex1 <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex1.txt")
head(ex1)
ex1.ts <- ts(ex1)         # 시계열 자료로 변환.
plot(ex1.ts)              # 시계열 그래프 생성.               
acf(ex1.ts)               # 자기상관함수.
pacf(ex1.ts)              # 부분자기상관함수.
plot(diff(ex1.ts))        # 1차 차분 후의 시계열 그래.
acf(diff(ex1.ts))         # 1차 차분 후의 자기상관함수.
pacf(diff(ex1.ts))        # 1차 차분 후의 부분자기 상관함수.

# ex1 모형은 ARIMA(0,1,1) 로 보이는 것 같다.
# 정답은 ARIMA(2,1,0) 이다.





ex2 <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex2.txt")
head(ex2)
ex2.ts <- ts(ex2)         # 시계열 자료로 변환.
plot(ex2.ts)              # 시계열 그래프 생성.               
acf(ex2.ts)               # 자기상관함수.
pacf(ex2.ts)              # 부분자기상관함수.
plot(diff(ex2.ts))        # 1차 차분 후의 시계열 그래프.
acf(diff(ex2.ts))         # 1차 차분 후의 자기상관함수.
pacf(diff(ex2.ts))        # 1차 차분 후의 부분자기 상관함수.

# ex1 모형은 ARIMA(0,1,2) 로 보이는 것 같다.
# 정답은 ARIMA(0,1,2) 이다.





ex3 <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex3.txt")
head(ex3)
ex3.ts <- ts(ex3)             # 시계열 자료로 변환.
plot(ex3.ts)                  # 시계열 그래프 생성.               
acf(ex3.ts)                   # 자기상관함수.
pacf(ex3.ts)                  # 부분자기상관함수.
plot(diff(ex3.ts,d=2))        # 1차 차분 후의 시계열 그래프.
acf(diff(ex3.ts,d=2))         # 1차 차분 후의 자기상관함수.
pacf(diff(ex3.ts,d=2))        # 1차 차분 후의 부분자기 상관함수.

# 정답은 ARIMA(1,1,1) 이다.