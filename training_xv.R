# State predictors and target from original df
preds <- c("teacher_prefix",
           "school_state",
           "project_grade_category",
           #"project_subject_categories", # not enough factor levels during cross validation, might need to roll up
           "teacher_number_of_previously_posted_projects")


# Then combine with relevant block from dfm matrix
training_df <- train %>% select_at(vars(preds)) %>% bind_cols(select(train_tokens, -(id:project_is_approved)))
target <- train$project_is_approved %>% make.names() %>% as.factor()


## Training and cross validation
# Baseline model based on essay 1 only along with some initially provided vars
# tuning & parameters
library(caret)
set.seed(123) # reproducibility
train_control <- trainControl(
  method = "cv",
  number = 5,
  savePredictions = TRUE,
  verboseIter = TRUE,
  classProbs = TRUE,
  summaryFunction = twoClassSummary
)


# Fit a decision tree
initial_dt <- train(
  x = training_df, y = target,
  trControl = train_control,
  method = "rpart", # decision tree
  tuneLength = 3,
  metric = "ROC")


# Fit a logistic regression
initial_logit <- train(
  x = training_df, y = target,
  trControl = train_control,
  method = "glm",
  tuneLength = 3,
  metric = "ROC")


## Model evaluation
results <- resamples(list(tree = initial_dt,
                          logit = initial_logit)) # need twio models to evaluate using resamples()
summary(results)
dotplot(results)