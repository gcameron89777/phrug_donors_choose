library(tidyverse)


# import data
train <- read.csv("train.csv", stringsAsFactors = F)
test <- read.csv("test.csv", stringsAsFactors = F)
resources <- read.csv("resources.csv", stringsAsFactors = F)
combined <- bind_rows(train, test) %>% left_join(resources, by = "id")
# need to detemrine how best to weave in resources data since a project can appear multiple times


# glimpse
glimpse(train)
glimpse(resources)


# assess missing data
table(complete.cases(train))
table(complete.cases(test))
table(complete.cases(resources))
# no missing data but from glimpse looks like some empty strings exist