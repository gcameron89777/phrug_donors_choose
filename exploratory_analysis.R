# trend of submissions by month
library(zoo)
tt %>% 
  mutate(year_month = as.factor(as.yearmon(project_submitted_datetime))) %>%
  group_by(year_month) %>%
  summarise(Count = n()) %>%
  ggplot(aes(x = year_month, y = Count)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = -90, hjust = 0))


# descending bar chart by state
tt %>% group_by(school_state) %>% summarise(Count = n()) %>% # alters the data frame tt into the right format
  ggplot(aes(x = reorder(school_state, Count), y = Count)) + # call ggplot and tell it what the x and y axis should be
  geom_bar(stat = "identity") + # tell ggplot it's a bar chart. I don;t really know why we need stat = "identity" but without it it doesn't work.
  coord_flip() # flips the chart from a column chart to a descending bar chart (states as rows not columns)
  

# @Christine descending bar chart by category


# @MJ descending bar chart by teacher prefix


# table of teacher prefix and success rate
train %>% select(teacher_prefix, project_is_approved) %>% # train only since we need the outcome "is approved"
  filter(teacher_prefix != "") %>% # get rid of 4 blank entries for prefix
  group_by(teacher_prefix) %>% 
  summarise(CountSubmissions = n(),
            CountApproved = sum(project_is_approved),
            SuccessRate = CountApproved / CountSubmissions) %>% 
  mutate(SuccessRate = round(SuccessRate, 2)) # get rid of lots of decimal places during % calculation
