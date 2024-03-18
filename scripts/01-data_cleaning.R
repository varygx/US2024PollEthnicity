#### Preamble ####
# Purpose: Cleans the raw dataset provided by Pew Research Center and saves to parquet
# Author: Allen Uy
# Date: 18 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: The dataset from Pew Research Center is downloaded and placed in the
# appropriate location. Refer to the README for detailed instruction.


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(foreign)


#### Download data ####
raw_data <- read.spss("data/raw_data/ATP W116.sav",
                      to.data.frame = TRUE)

selected_data <- raw_data %>% 
  select(F_GENDER, F_EDUCCAT2, F_RACETHNMOD, F_PARTYSUM_FINAL) %>% 
  filter(F_PARTYSUM_FINAL %in% c("Rep/Lean Rep", "Dem/Lean Dem")) %>% 
  rename(
    gender = F_GENDER,
    education = F_EDUCCAT2,
    ethnicity = F_RACETHNMOD,
    party = F_PARTYSUM_FINAL
  ) %>% 
  filter_all(all_vars(. != "Refused"))

#### Save data ####
write_parquet(x = selected_data, sink = "data/analysis_data/clean_polldata.parquet")


