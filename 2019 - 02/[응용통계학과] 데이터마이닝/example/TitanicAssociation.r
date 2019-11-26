load("j:/Lectures/DM/Data/titanic.raw.rdata")

titanic <- as(titanic.raw, "transactions")
titanic

rules <- apriori(titanic, control = list(verbose=F),
                 parameter = list(supp=0.005, conf=0.8),
                 appearance = list(rhs=c("Survived=No", "Survived=Yes"),
                                   default="lhs"))
inspect(head(rules, n = 20, by = "lift"))

library(arulesViz)
plot(rules, method = "grouped", control = list(k = 20))


# paracoord: Plotting only 100
subrules <- head(rules, n = 20, by ="lift")
plot(subrules, method = "paracoord")
plot(subrules, method ="graph")
