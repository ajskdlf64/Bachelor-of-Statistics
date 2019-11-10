calcium = matrix(
  c(2.11, 10.1, 3.4,
    2.36, 35.0, 4.1,
    2.13, 2.0, 1.9,
    2.78, 6.0, 3.8,
    2.17, 2.0, 1.7), ncol = 3, byrow=T)
calcium = as.data.frame(calcium)
names(calcium) = c("PLANT", "AVAILABLE", "EXCHANGEABLE")

library(ICSNP)
HotellingsT2(calcium, mu=c(2.85,15,6), test="f") 

HotellingsT2(calcium, mu=c(2.85,15,6), test="chi")
