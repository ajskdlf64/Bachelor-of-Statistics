test = as.data.frame(matrix(c(100,115,110,125,90, 105,110,130,
                              125,140,130,140,105,125), ncol = 2, byrow=T))
names(test) = c("pretest", "posttest")
test$subject=as.factor(1:7)              # wide format data

# For paired t-test and Hotelling’ T^2
diff = test$pretest - test$posttest
t_test = t.test(diff)                    # t.test(test$pretest, test$posttest, paired = T)
t_test

F_val = t_test$statistic * t_test$statistic
F_val


# For RBD test
strength = c(test$pretest,test$posttest)
subject = as.factor(rep(1:7, 2))
treatment = as.factor(rep(c("pretest", "posttest"), each=7))
RBDdat = data.frame(strength, subject, treatment)         # long format data
                                                          # t.test(strength ~ treatment, data = RBDdat, paired = T)
                                                          
RBD = aov(strength ~ subject + treatment, data = RBDdat)
summary(RBD)

library(ICSNP)
HotellingsT2(diff, test="f")


