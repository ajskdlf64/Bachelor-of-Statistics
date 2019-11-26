
# Transaction Data
library(arules)
mat <- matrix(c(1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1,1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1), 
              ncol = 6, dimnames = list(1:5, c("Bread", "Milk", "Diaper", "Bee", "Eggs", "Cola")), byrow = T)
trans <- as(mat, "transactions")
inspect(head(trans,10))

# Rules
rules <- apriori(trans, parameter = list(support = 0.01, confidence = 0.5))
inspect(head(sort(rules, by ="confidence"), 10))

# Visualization
library(arulesViz)
plot(rules)
plot(rules, measure =c("support", "lift"), shading = "confidence")
plot(rules, method ="two-key plot")
plot(rules, method = "grouped", control = list(k = 20))

# paracoord: Plotting only 100
subrules <- head(rules, n = 20, by ="lift")
plot(subrules, method = "paracoord")
plot(subrules, method ="graph")

# long format transaction data
trans_data <- read.csv(file="./transaction.csv", header = T)

# as(split(item 변수, id 변수, ”transactions”)
trans2 <- as(split(trans_data[,"Items"], trans_data[,"ID"]), "transactions")
inspect(head(trans2, 5))

# Groceries data: 169 개 item에 대한 9835 개의 transaction data
data(Groceries)
summary(Groceries)
rules <- apriori(Groceries, parameter = list(support = 0.001, confidence = 0.5))
rules

# options(digits = 2)
inspect(head(rules, n = 3, by = "lift"))
plot(rules)
plot(rules, measure =c("support", "lift"), shading = "confidence")
plot(rules, method ="two-key plot")
plot(rules, method = "grouped", control = list(k = 20))

# paracoord: Plotting only 100
subrules <- head(rules, n = 20, by ="lift")
plot(subrules, method = "paracoord")
plot(subrules, method ="graph")

