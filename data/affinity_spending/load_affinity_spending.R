library(tidyverse)
library(lubridate)

affinity_spending_cat <- read_csv('data/affinity_spending/Affinity - National - Daily.csv', na=".") %>%
  mutate(date = ymd(paste(year, month, day, sep="-"))) %>%
  dplyr::select(-starts_with("spend_s_"), -starts_with("spend_19_")) %>%
  pivot_longer(cols =  starts_with("spend_"), names_to = "spending_category", values_to = "spending_prop_vs_jan_2020") %>%
  mutate(spending_category = str_replace(str_remove(spending_category, "spend_"), "_q", "|q")) %>%
  separate(spending_category, into=c("spending_category", "income_quartile"), sep="[|]") %>%
  dplyr::filter(!is.na(spending_prop_vs_jan_2020) &
                  !is.na(income_quartile) &
                  spending_category %in% c("retail_w_grocery", "retail_no_grocery",
                                           "durables", "nondurables",
                                           "remoteservices", "inpersonmisc")) %>%
  dplyr::select(date, income_quartile, spending_category,
                spending_prop_vs_jan_2020, freq, provisional)


affinity_spending_mcc <- read_csv('data/affinity_spending/Affinity - National - Daily.csv', na=".") %>%
    mutate(date = ymd(paste(year, month, day, sep="-"))) %>%
    dplyr::select(-starts_with("spend_s_"), -starts_with("spend_19_")) %>%
    pivot_longer(cols =  starts_with("spend_"), names_to = "merchant_category_code", values_to = "spending_prop_vs_jan_2020") %>%
    mutate(merchant_category_code = str_replace(str_remove(merchant_category_code, "spend_"), "_q", "|q")) %>%
    separate(merchant_category_code, into=c("merchant_category_code", "income_quartile"), sep="[|]") %>%
    mutate(
      retail_w_grocery = merchant_category_code %in% c("aap","cec","gen","grf","hic","sgh","etc"),
      retail_no_grocery = merchant_category_code %in% c("aap","cec","gen","hic","sgh","etc"),
      durables = merchant_category_code %in% c("cec","cte","hic","mov","sgh","etc"),
      nondurables = merchant_category_code %in% c("aap","afh","gen","grf","hpc","wht"),
      remoteservices = merchant_category_code %in% c("aws","cns","eds","fai","inf","pst","pua","utl"),
      inpersonmisc = merchant_category_code %in% c("mos","rll")
    ) %>%
    dplyr::filter(!is.na(spending_prop_vs_jan_2020) &
                    !is.na(income_quartile) &
                    !merchant_category_code %in% c("all", "retail_w_grocery", "retail_no_grocery",
                                             "durables", "nondurables",
                                             "remoteservices", "inpersonmisc")) %>%
    dplyr::select(date, income_quartile, merchant_category_code,
                  spending_prop_vs_jan_2020, freq, provisional, retail_w_grocery,
                  retail_no_grocery, durables, nondurables, remoteservices, inpersonmisc)
