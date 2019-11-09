
ex7_5a <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex7_5a.txt")
head(ex7_5a)

ex7_5a.ts <- ts(ex7_5a)            
plot(ex7_5a.ts)                                                 
acf(ex7_5a.ts)
pacf(ex7_5a.ts)
plot(diff(ex7_5a.ts))
acf(diff(ex7_5a.ts))
pacf(diff(ex7_5a.ts))




ex7_5b <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex7_5b.txt")
head(ex7_5b)

ex7_5b.ts <- ts(ex7_5b)            
plot(ex7_5b.ts)                                                 
acf(ex7_5b.ts)
pacf(ex7_5b.ts)
plot(diff(ex7_5b.ts))
acf(diff(ex7_5b.ts))
pacf(diff(ex7_5b.ts))




ex7_5c <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex7_5c.txt")
head(ex7_5c)

ex7_5c.ts <- ts(ex7_5c)            
plot(ex7_5c.ts)                                                 
acf(ex7_5c.ts)
pacf(ex7_5c.ts)
plot(diff(ex7_5c.ts))
acf(diff(ex7_5c.ts))
pacf(diff(ex7_5c.ts))




ex7_5d <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex7_5d.txt")
head(ex7_5d)

ex7_5d.ts <- ts(ex7_5d)            
plot(ex7_5d.ts)                                                 
acf(ex7_5d.ts)
pacf(ex7_5d.ts)
plot(diff(ex7_5d.ts))
acf(diff(ex7_5d.ts))
pacf(diff(ex7_5d.ts))
