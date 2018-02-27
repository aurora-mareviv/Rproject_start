# Data summary

mydata <- mydata %>%
  mutate_if(sapply(mydata, is.character), as.factor) %>%
  mutate_if(sapply(mydata, is.factor), forcats::as_factor)
skimr::skim(mydata)

# Hmisc::describe(mydata)
# head(mydata)

