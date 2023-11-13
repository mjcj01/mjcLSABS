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
      stafford_1999 %>% select(ncessch, school_name, street_mailing), 
      by.x = c("ncessch.y", "school_name.y", "street_mailing.y"), 
      by.y = c("ncessch", "school_name", "street_mailing"), all = TRUE) %>% 
  rename(nces_id_1989 = "ncessch.x",
         nces_id_1999 = "ncessch.y",
         school_name_1989 = "school_name.x",
         school_name_1999 = "school_name.y",
         street_mailing_1989 = "street_mailing.x",
         street_mailing_1999 = "street_mailing.y") %>%
  merge(.,
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
        by.x = "nces_id_1999", by.y = "ncessch.x", all = TRUE) %>%
  select(-school_name.x, -street_mailing.x, -year.x.y) %>%
  merge(.,
        stafford_2009 %>% select(ncessch, school_name, street_mailing), 
        by.x = c("ncessch.y", "school_name.y", "street_mailing.y"), 
        by.y = c("ncessch", "school_name", "street_mailing"), all = TRUE) %>%
  rename(nces_id_2009 = "ncessch.y",
         school_name_2009 = "school_name.y",
         street_mailing_2009 = "street_mailing.y") %>%
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
          link(.) %>% as.data.frame(),
        by.x = "nces_id_2009", by.y = "ncessch.x", all = TRUE) %>%
  #select(-school_name.x, -street_mailing.x, -year.x) %>%
  merge(.,
        stafford_2019 %>% select(ncessch, school_name, street_mailing), 
        by.x = c("ncessch.y", "school_name.y", "street_mailing.y"), 
        by.y = c("ncessch", "school_name", "street_mailing"), all = TRUE) %>%
  rename(nces_id_2019 = "ncessch.y",
         school_name_2019 = "school_name.y",
         street_mailing_2019 = "street_mailing.y") %>%
  select(-.y.x, -.x.x, -year.x.x, -year.y.x, -.y.y, -.x.y, -year.y.y, 
         -.y, -.x, -school_name.x, -street_mailing.x, -year.x, -year.y) %>%
  select(nces_id_1989, nces_id_1999, nces_id_2009, nces_id_2019,
         school_name_1989, school_name_1999, school_name_2009, school_name_2019,
         street_mailing_1989, street_mailing_1999, street_mailing_2009, street_mailing_2019)
  
