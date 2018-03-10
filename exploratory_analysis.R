# trend of submissions by month
library(zoo)

tt %>% 
  mutate(year_month = as.factor(as.yearmon(project_submitted_datetime))) %>%
  group_by(year_month) %>%
  summarise(Count = n()) %>%
  ggplot(aes(x = (year_month), y = Count)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = -90, hjust = 0))