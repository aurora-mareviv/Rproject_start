# CLEANING DATA

cleanUTFchar <- function(x){ 
  colnames(x) <- gsub(pattern="ñ", replacement="nh", colnames(x)) 
  colnames(x) <- gsub(pattern="á", replacement="a", colnames(x)) 
  colnames(x) <- gsub(pattern="é", replacement="e", colnames(x))
  colnames(x) <- gsub(pattern="í", replacement="i", colnames(x))
  colnames(x) <- gsub(pattern="ó", replacement="o", colnames(x))
  colnames(x) <- gsub(pattern="ú", replacement="u", colnames(x))
  x 
} 

mydata <- mydata %>% 
  janitor::clean_names() %>%
  janitor::remove_empty_rows() %>%
  janitor::remove_empty_cols() %>% 
  cleanUTFchar() 




