library(tidyverse)
library(reclin2)
library(educationdata)

stafford_split <- split(stafford_all, f = stafford_all$year)

list2env(stafford_split, envir = .GlobalEnv)

names(stafford_split)

nces_record_linkage <- function(start_year, end_year, district_nces_id) {
  years <- seq(from = start_year, to = end_year, by = 10)
  
  df <- get_education_data(level = 'schools',
                           source = 'ccd',
                           topic = 'directory',
                           filters = list(year = c(years),
                                          leaid = district_nces_id),
                           add_labels = TRUE) %>%
    mutate("school_name" = gsub("\\.*", "", school_name),
           "school_name" = gsub("ELEMENTARY", "ELEM", school_name),
           "street_mailing" = str_to_upper(street_mailing),
           "street_mailing" = gsub("\\.*", "", street_mailing))
  
  for (i in 1:length(df)) {
    assign(paste0("district_year", i), as.data.frame(df[[i]]))
  }
  
  
}

