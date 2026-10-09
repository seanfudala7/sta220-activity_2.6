#audit
df=read_csv("data/2025_q1.csv")
lim = 30

df_clean <- df |>
  mutate(late = days_to_close > lim)
x2 <- df_clean |>
  group_by(claim_type) |>
  summarize(n=n(),mean_days=mean(days_to_close),pct_late=mean(late))

#save
write_csv(df,"FINAL.csv")
