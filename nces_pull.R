library(educationdata)
library(tidyverse)

stafford_1989 <- get_education_data(level = 'schools',
                                    source = 'ccd',
                                    topic = 'directory',
                                    filters = list(year = c(1989),
                                                   leaid = c('5103660')),
                                    add_labels = TRUE) %>%
  mutate("school_name" = gsub("\\.*", "", school_name),
         "school_name" = gsub("ELEMENTARY", "ELEM", school_name),
         "street_mailing" = str_to_upper(street_mailing),
         "street_mailing" = gsub("\\.*", "", street_mailing))

stafford_1999 <- get_education_data(level = 'schools',
                                    source = 'ccd',
                                    topic = 'directory',
                                    filters = list(year = c(1999),
                                                   leaid = c('5103660')),
                                    add_labels = TRUE) %>%
  mutate("school_name" = gsub("\\.*", "", school_name),
         "school_name" = gsub("ELEMENTARY", "ELEM", school_name),
         "street_mailing" = str_to_upper(street_mailing),
         "street_mailing" = gsub("\\.*", "", street_mailing))

stafford_2009 <- get_education_data(level = 'schools',
                                    source = 'ccd',
                                    topic = 'directory',
                                    filters = list(year = c(2009),
                                                   leaid = c('5103660')),
                                    add_labels = TRUE) %>%
  mutate("school_name" = gsub("\\.*", "", school_name),
         "school_name" = gsub("ELEMENTARY", "ELEM", school_name),
         "street_mailing" = str_to_upper(street_mailing),
         "street_mailing" = gsub("\\.*", "", street_mailing))

stafford_2019 <- get_education_data(level = 'schools',
                                    source = 'ccd',
                                    topic = 'directory',
                                    filters = list(year = c(2019),
                                                   leaid = c('5103660')),
                                    add_labels = TRUE) %>%
  mutate("school_name" = gsub("\\.*", "", school_name),
         "school_name" = gsub("ELEMENTARY", "ELEM", school_name),
         "street_mailing" = str_to_upper(street_mailing),
         "street_mailing" = gsub("\\.*", "", street_mailing))