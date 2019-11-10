library(tidyverse)

chicago <- readRDS("chicago.rds")

str(chicago)


# select 

subset <- select(chicago, city:dptp)   #  subset <- chicago[,1:3]

subset <- select(chicago, names(chicago)[1:3])

names(chicago)

names(chicago)[1:3]

subset <- select(chicago, -(city:dptp))

subset <- select(chicago, ends_with("2"))

subset <- select(chicago, starts_with("d"))

# filter

chic.f <- filter(chicago, pm25tmean2 > 30)             # subset(chicago, pm25tmean2 > 30))
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80) # chic.f <- subset(chicago, pm25tmean2 > 30 & tmpd > 80)

# arrange
 
chic.t <- arrange(chicago, tmpd)        # ascending 
sort(chicago$tmpd, index.return = T)
chic.tsort <- chicago[sort(chicago$tmpd, index.return = T)$ix, ]

chic.d <- arrange(chicago, date)         # ascending 
chic.d <- arrange(chicago, desc(date))   # descending 

sort(chicago$date, index.return = T)$ix  # does not work
chic.dsort <- chicago[sort(chicago$date, index.return = T)$ix,]  # does not work

# rename

chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)

chicago2 <- chicago[,-c(3, 5)]           # select(chicago, -c("dptp", "pm25tmean2")) is better
chicago2$dewpoint <- chicago$dptp
chicago2$pm25 <- chicago$pm25tmean2

# mutate

chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = T))
chicago2 <- transmute(chicago, pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm = T),
                      o3detrend = o3tmean2 - mean(o3tmean2, na.rm = T))
chicago2

# date function

date <- c("2005-12-31","2003-12-30")              # character variable
date <- as.POSIXlt(date)                          # convert a time variable
date
date$year                                         # extract year, origin 1900
date$year + 1900

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)  # create year

# group_by

years <- group_by(chicago, year)                             # 년도별
summarize(years, pm25 = mean(pm25, na.rm = TRUE),            #  average of pm25  
          o3 = max(o3tmean2, na.rm = TRUE),                  #  maximum of o3
          no2 = median(no2tmean2, na.rm = TRUE))             #  median of no3  


qq <- quantile(chicago$pm25, seq(0, 1, 0.2), na.rm = TRUE)   # compute the quantile of pm25
qq
cut(chicago$pm25, qq)[4828:4850]                             # 어느 구간에 속하나

chicago <- mutate(chicago, pm25.quint = cut(pm25, qq))        

quint <- group_by(chicago, pm25.quint)

summarize(quint, o3 <- mean(o3tmean2, na.rm = TRUE), no2 = mean(no2tmean2, na.rm = TRUE))

result <- summarize(quint, o3 = mean(o3tmean2, na.rm = TRUE), no2 = mean(no2tmean2, na.rm = TRUE))
plot(result$no2, type = "l")
lines(result$o3, lty=3)


mutate(chicago, pm25.quint = cut(pm25, qq)) %>%
  group_by(pm25.quint) %>%
  summarize(o3 = mean(o3tmean2, na.rm = TRUE),
            no2 = mean(no2tmean2, na.rm = TRUE)) -> result2
