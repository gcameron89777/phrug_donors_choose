library(quanteda) # language processing


# Create a DFM based on essay 1
tt_corpus <- corpus(tt, 
                    docid_field = "id",
                    text_field = "project_essay_1")


# make document term matrix
tt_dfm <- dfm(tt_corpus, 
                  remove = stopwords("english"),
                  remove_punct = T,
                  remove_numbers = T,
                  remove_symbols = T,
                  # ngrams = 1:2, maybe try this later
                  stem = T) %>% dfm_tolower()


# Remove sparse terms
tt_sparse <- dfm_select(tt_dfm, "\\w{2,}", valuetype = "regex" ) %>%
  dfm_trim(sparsity = 0.85) %>% as.data.frame()



# Combine with original df tt for training
tt_tokens <- cbind(tt, tt_sparse)


# Separate training from test data
train_tokens <- tt_tokens[1:nrow(train), ]
test_tokens <- tt_tokens[(nrow(train) + 1):nrow(tt_tokens), ]