load(file = "C:/Users/user/Desktop/University/빅데이터분석실습/Data/titanic.RData")

library(dplyr)

# Data cleaning 

titanic.clean <- titanic %>%
  select(-c(home.dest, cabin, name, X, ticket)) %>%
  mutate(pclass = ordered(pclass, levels = c(1, 2, 3), labels = c('Upper', 'Middle', 'Lower')),   #  Convert to factor level
         survived = factor(survived, levels = c(0, 1), labels = c('No', 'Yes'))) %>%
  na.omit()

glimpse(titanic.clean)

# Data Split 

splitSample <- sample(1:2, size=nrow(titanic.clean), prob=c(0.8,0.2), replace = TRUE)
titanic.tr  <- titanic.clean[splitSample==1,]
titanic.te  <- titanic.clean[splitSample==2,]

# Fit decision tree 

library(rpart)
library(rpart.plot)
fit1 <- rpart(survived ~ ., data = titanic.tr, method = 'class')
summary(fit1)
rpart.plot(fit1)

# prune tree

printcp(fit1) # display the results 
plotcp(fit1) # visualize cross-validation results 

fit2 <- prune(fit1, cp = 0.027) #0.018)#cp=fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]) 
rpart.plot(fit2)

# Confusion matrix 

# all tree
predict_fit1 <- predict(fit1, titanic.te, type = 'class')
table(titanic.te$survived, predict_fit1)

# node=2 tree
predict_fit2 <- predict(fit2, titanic.te, type = 'class')
table(titanic.te$survived, predict_fit2)

