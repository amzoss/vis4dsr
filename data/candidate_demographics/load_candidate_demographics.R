library(tidyverse)
library(readxl)

candidate_demographics <- bind_rows(
  read_excel('data/candidate_demographics/RD-Candidate-Analysis-2012-8.xlsx', sheet=1) %>%
    mutate(year = 2018),
  read_excel('data/candidate_demographics/RD-Candidate-Analysis-2012-8.xlsx', sheet=2) %>%
    mutate(year = 2016),
  read_excel('data/candidate_demographics/RD-Candidate-Analysis-2012-8.xlsx', sheet=3) %>%
    mutate(year = 2014),
  read_excel('data/candidate_demographics/RD-Candidate-Analysis-2012-8.xlsx', sheet=4) %>%
    mutate(year = 2012)
)
