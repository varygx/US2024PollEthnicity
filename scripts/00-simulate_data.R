#### Preamble ####
# Purpose: Simulates a dataset of predictor variables and the party. Based on sketches
# prior to obtaining the actual data that the person votes for.
# Author: Allen Uy 
# Date: 18 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)

set.seed(42)

num_obs <- 1000

us_political_preference <- tibble(
  education = sample(0:4, size=num_obs, replace=TRUE),
  gender = sample(0:2, size=num_obs, replace=TRUE),
  ethnicity = sample(0:3, size=num_obs, replace=TRUE),
  support_prob = ((education+gender+ethnicity)/9)
) %>% mutate(
  party = if_else(runif(n = num_obs) < support_prob, "Democrat", "Republican"),
  education = case_when(
    education == 0 ~ "< High school",
    education == 1 ~ "High school",
    education == 2 ~ "Some college",
    education == 3 ~ "College",
    education == 4 ~ "Post-grad"
  ),
  gender = case_when(
    gender == 0 ~ "Male",
    gender == 1 ~ "Female",
    gender == 2 ~ "Other"
  ),
  ethnicity = case_when(
    ethnicity == 0 ~ "White",
    ethnicity == 1 ~ "Black",
    ethnicity == 2 ~ "Hispanic",
    ethnicity == 3 ~ "Other"
  )
) |>
  select(-support_prob)
