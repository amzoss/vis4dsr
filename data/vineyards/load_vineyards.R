library(tidyverse)

vineyards <- read_tsv('data/vineyards/vineyards.txt',
                      col_types = list(Domestic = "l",
                                       Vinifera = "l",
                                       Retail = "l",
                                       Food = "l"))
