#### Preamble ####
# Purpose: Models party support for Canada 2021 Election
# Author: Allen Uy
# Date: 16 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-data_cleaning was run


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
poll_data <- read_parquet("data/analysis_data/clean_polldata.parquet")

### Model data ####
# Model based on personal variables
poll_model <-
  stan_glm(
    formula = party ~ gender + education + ethnicity,
    data = poll_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 42
  )

#### Save model ####
saveRDS(
  poll_model,
  file = "models/poll_model.rds"
)
