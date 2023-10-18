library(educationdata)
library(tidyverse)

school_names <- get_education_data(level = 'schools',
                                   source = 'ccd',
                                   topic = 'directory',
                                   filters = list(year = c(1989, 1999, 2009, 2019),
                                                  leaid = c('5103660')),
                                   add_labels = TRUE)

school_names %>%
  select(year, school_id, lea_name, street_mailing, city_mailing, zip_mailing, lowest_grade_offered, highest_grade_offered)
