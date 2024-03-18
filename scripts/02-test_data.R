#### Preamble ####
# Purpose: Tests cleaned data to ensure robustness
# Author: Allen Uy
# Date: 16 March 2024
# Contact: allen.uy@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-data_cleaning was run


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(here)


poll_data <- read_parquet(here::here("data/analysis_data/clean_polldata.parquet"))

#### Test data ####
test_that("variables are expected type", {
  expect_type(poll_data$ethnicity, "integer") 
  expect_type(poll_data$education, "integer")
  expect_type(poll_data$party, "integer")
  expect_type(poll_data$gender, "integer")
})

test_that("variables do not have null values", {
  expect_false(any(is.null(poll_data$education)), "age should not have null values")
  expect_false(any(is.null(poll_data$gender)), "gender should not have null values")
  expect_false(any(is.null(poll_data$party)), "party should not have null values")
  expect_false(any(is.null(poll_data$ethnicity)), "ethnicity should not have null values")
})

test_that("party variable is binary", {
  expect(all(poll_data$party %in% c("Dem/Lean Dem", "Rep/Lean Rep")))
})