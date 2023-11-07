library(tidyverse)
library(reclin2)

merge(pair_blocking(stafford_1989 %>% select(ncessch, school_name, street_mailing, year), 
                    stafford_1999 %>% select(ncessch, school_name, street_mailing, year), "ncessch") %>%
        compare_pairs(., on = c("ncessch", "school_name", "street_mailing"), 
                      default_comparator = cmp_jarowinkler(0.9), inplace = TRUE) %>%
        problink_em(~ ncessch + school_name + street_mailing, data = .) %>%
        predict(., pairs = pair_blocking(stafford_1989 %>% select(ncessch, school_name, street_mailing, year),
                                         stafford_1999 %>% select(ncessch, school_name, street_mailing, year),
                                         "ncessch") %>%
                  compare_pairs(., on = c("ncessch", "school_name", "street_mailing"), 
                                default_comparator = cmp_jarowinkler(0.9), inplace = TRUE), add = TRUE) %>%
        select_n_to_m(., "weights", variable = "greedy", threshold = 0) %>%
        link(.),
      pair_blocking(stafford_1999 %>% select(ncessch, school_name, street_mailing, year), 
                    stafford_2009 %>% select(ncessch, school_name, street_mailing, year), "ncessch") %>%
        compare_pairs(., on = c("ncessch", "school_name", "street_mailing"), 
                      default_comparator = cmp_jarowinkler(0.9), inplace = TRUE) %>%
        problink_em(~ ncessch + school_name + street_mailing, data = .) %>%
        predict(., pairs = pair_blocking(stafford_1999 %>% select(ncessch, school_name, street_mailing, year),
                                         stafford_2009 %>% select(ncessch, school_name, street_mailing, year),
                                         "ncessch") %>%
                  compare_pairs(., on = c("ncessch", "school_name", "street_mailing"), 
                                default_comparator = cmp_jarowinkler(0.9), inplace = TRUE), add = TRUE) %>%
        select_n_to_m(., "weights", variable = "greedy", threshold = 0) %>%
        link(.) %>% as.data.frame(),
      by.x = ".y", by.y = ".x", all = TRUE) %>%
  merge(.,
        pair_blocking(stafford_2009 %>% select(ncessch, school_name, street_mailing, year), 
                      stafford_2019 %>% select(ncessch, school_name, street_mailing, year), "ncessch") %>%
          compare_pairs(., on = c("ncessch", "school_name", "street_mailing"), 
                        default_comparator = cmp_jarowinkler(0.9), inplace = TRUE) %>%
          problink_em(~ ncessch + school_name + street_mailing, data = .) %>%
          predict(., pairs = pair_blocking(stafford_2009 %>% select(ncessch, school_name, street_mailing, year),
                                           stafford_2019 %>% select(ncessch, school_name, street_mailing, year),
                                           "ncessch") %>%
                    compare_pairs(., on = c("ncessch", "school_name", "street_mailing"), 
                                  default_comparator = cmp_jarowinkler(0.9), inplace = TRUE), add = TRUE) %>%
          select_n_to_m(., "weights", variable = "greedy", threshold = 0) %>%
          link %>% as.data.frame(),
        by.x = ".y.y", by.y = ".y", all = TRUE) %>%
  select(ncessch.x.x, school_name.x.x, street_mailing.x.x, year.x.x,
         ncessch.y.x, school_name.y.x, street_mailing.y.x, year.y.x,
         ncessch.y.y, school_name.y.y, street_mailing.y.y, year.y.y,
         ncessch.y, school_name.y, street_mailing.y, year.y) %>%
  rename(nces_id_1989 = "ncessch.x.x",
         school_name_1989 = "school_name.x.x",
         street_mailing_1989 = "street_mailing.x.x",
         nces_id_1999 = "ncessch.y.x",
         school_name_1999 = "school_name.y.x",
         street_mailing_1999 = "street_mailing.y.x",
         nces_id_2009 = "ncessch.y.y",
         school_name_2009 = "school_name.y.y",
         street_mailing_2009 = "street_mailing.y.y",
         nces_id_2019 = "ncessch.y",
         school_name_2019 = "school_name.y",
         street_mailing_2019 = "street_mailing.y") %>% View()
