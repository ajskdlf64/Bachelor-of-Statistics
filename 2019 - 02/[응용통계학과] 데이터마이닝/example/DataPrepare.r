library(dplyr)
library(readxl)

cust <- read_excel("h:/Data/BGCON_CUST_DATA.xlsx", na = c("", "#"))
cust <- filter(cust, DIVIDED_SET == 1)
cust_te <- filter(cust, DIVIDED_SET == 2)
save(cust, file = "h:/Data/cust.RData")
save(cust_te, file = "h:/Data/cust_te.RData")

claim <- read_excel("h:/Data/BGCON_CLAIM_DATA.xlsx", na = c("", "#"))
claim <- arrange(claim, CUST_ID)
save(claim, file = "h:/Data/claim.RData")

