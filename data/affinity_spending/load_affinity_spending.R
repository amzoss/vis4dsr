library(tidyverse)
library(lubridate)

affinity_spending <- read_csv('data/affinity_spending/Affinity - National - Daily.csv', na=".") %>%
  mutate(date = ymd(paste(year, month, day, sep="-"))) %>%
  dplyr::select(-starts_with("spend_s_")) %>%
  pivot_longer(cols =  starts_with("spend_"), names_to = "spending_category", values_to = "spending_proportion") %>%
  mutate(spending_category = str_replace(str_remove(spending_category, "spend_"), "_q", "|q")) %>%
  separate(spending_category, into=c("spending_category", "income_quartile"), sep="[|]") %>%
  dplyr::filter(!is.na(spending_proportion) &
                  !is.na(income_quartile) &
                  spending_category %in% c("retail_w_grocery", "retail_no_grocery",
                                           "durables", "nondurables",
                                           "remoteservices", "inpersonmisc")) %>%
  dplyr::select(date, income_quartile, spending_category,
                spending_proportion, freq, provisional)

ggplot(affinity_spending, aes(x=date, y=spending_proportion, color=income_quartile)) +
  geom_line() +
  facet_wrap(vars(spending_category))
