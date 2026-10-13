#audit
library(tidyverse)
df=read_csv("data/2025_q2.csv")

#Three checks
dim(df) #should be 54 4
names(df)
summary(df)

########## Step 1: Cleaning ##########

#claim_id is good
#claim_type is good
#date_filed is good
#days_to_close must be edited

df_clean <- df |>
  mutate(days_to_close = na_if(days_to_close,-1))
summary(df$days_to_close)
summary(df_clean$days_to_close)
#They are different! -1s have been converted to NAs


######### Step 2: Analysis ##########

lim = 30

df_clean |>
  mutate(late = days_to_close > lim) |>
  group_by(claim_type) |>
  summarize(n=n(),
            open = sum(is.na(days_to_close)),
            mean_days=mean(days_to_close, na.rm = TRUE),
            pct_late=mean(late, na.rm = TRUE)
  )

#save
write_csv(df,"FINAL.csv")
