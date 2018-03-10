library(tidyverse)
library(lubridate)


# import data
train <- read.csv("train.csv", stringsAsFactors = F)
test <- read.csv("test.csv", stringsAsFactors = F)
tt <- bind_rows(train, test) %>% 
  mutate(project_submitted_datetime = ymd_hms(project_submitted_datetime))
resources <- read.csv("resources.csv", stringsAsFactors = F)
# need to determine how best to weave in resources data since a project can appear multiple times


# glimpse
glimpse(tt)
glimpse(resources)


# assess missing data
table(complete.cases(train))
table(complete.cases(test))
table(complete.cases(resources))
# no missing data but from glimpse looks like some empty strings exist