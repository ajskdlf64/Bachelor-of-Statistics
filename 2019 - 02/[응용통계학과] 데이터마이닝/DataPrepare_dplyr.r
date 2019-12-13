cust <- read.csv("./01. data/BGCON_CUST_DATA.csv", fileEncoding = "UTF-16")
cntt <- read.csv("./01. data/BGCON_CNTT_DATA.csv", fileEncoding = "UTF-16")
claim <- read.csv("./01. data/BGCON_CLAIM_DATA.csv", fileEncoding = "UTF-16")


library(dplyr)



# Number of claim for each customer

n_of_cust = nrow(cust)   # number of customers
cust$N_of_claim = NA

for(i in 1:n_of_cust){
  tmp <- filter(claim, CUST_ID == cust$CUST_ID[i])
  cust$N_of_claim[i] = nrow(tmp)
}


# cust <- group_by(claim, CUST_ID) %>% summarize(N_of_claim = length(CUST_ID)) %>% inner_join(cust, by = "CUST_ID")

# Is valuable?

fraud = table(filter(cust, SIU_CUST_YN == "Y") %>% select(N_of_claim))
normal = table(filter(cust, SIU_CUST_YN == "N") %>% select(N_of_claim))

barplot(fraud, col = "red")
barplot(normal, col = "blue")

plot(as.numeric(names(normal)), normal/sum(normal), type = "b", col = "blue", xlab = "Number of claim", ylab = "Proportion")
lines(as.numeric(names(fraud)), fraud/sum(fraud), type = "b", col = "red")


# 치료기간 host_otpa_days = claim$HOSP_OTPA_ENDT - claim$HOSP_OTPA_STDT + 1 
# claim$HOSP_OTPA_STDT, claim$HOSP_OTPA_ENDT,   20070321  yyyymmdd 
# NA: 입원하지 않은 경우 

library(date)

# hosp_days <- mutate(claim, hosp_otpa_days = as.date(as.character(HOSP_OTPA_ENDT), order = "ymd") - 
#                      as.date(as.character(HOSP_OTPA_STDT),order = "ymd") + 1) %>% select(CUST_ID, hosp_otpa_days)

# hosp_days$hosp_otpa_days[is.na(hosp_days$hosp_otpa_days)] = 0

# cust <- group_by(hosp_days, CUST_ID) %>% summarize(hosp_otpa_days_max = max(hosp_otpa_days)) %>% inner_join(cust, by = "CUST_ID")


cust$hosp_otpa_days_max = NA
claim$hosp_otpa_days = as.date(as.character(claim$HOSP_OTPA_ENDT), order = "ymd") - as.date(as.character(claim$HOSP_OTPA_STDT),order = "ymd") + 1
claim$hosp_otpa_days[is.na(claim$hosp_otpa_days)] = 0

for(i in 1:n_of_cust){
  tmp <- filter(claim, CUST_ID == cust$CUST_ID[i])
  cust$hosp_otpa_days_max[i] = max(tmp$hosp_otpa_days) 
}

with(cust, boxplot(hosp_otpa_days_max ~ SIU_CUST_YN ))


# CAUSE CODE

claim$SIU_CUST_YN = NA
idx = 1:nrow(claim)

for(i in 1:n_of_cust){
  id = idx[claim$CUST_ID == cust$CUST_ID[i]]
  claim$SIU_CUST_YN[id] = cust$SIU_CUST_YN[i]
}

# c_code <- select(claim, CUST_ID, CAUS_CODE) 
# custYN <- select(cust, CUST_ID, SIU_CUST_YN)
# cause_Code <- inner_join(c_code, custYN, by = "CUST_ID" )

mosaicplot(CAUS_CODE ~ SIU_CUST_YN, data = cause_Code, color = TRUE)



