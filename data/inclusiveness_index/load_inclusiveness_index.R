library(tidyverse)
library(readxl)

inclusiveness_index <- read_excel('data/inclusiveness_index/global_data_for_website_2020.xlsx',
                                  na="9999") %>%
  rename_with(~ str_remove_all(.x, "[(|)]") %>% str_replace_all("[-| ]", ".")) %>%
  dplyr::filter(Continent != "Antarctica")

inclusiveness_index_annual <- read_excel('data/inclusiveness_index/inclusiveness_global_data_2016_2020.xlsx',
                                  na="9999") %>%
  rename_with(~ str_remove_all(.x, "[(|)]") %>% str_replace_all("[-| ]", ".")) %>%
  dplyr::filter(Continent != "Antarctica")
