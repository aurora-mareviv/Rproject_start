# Instala paquetes que puedan faltar en tu sistema. Automagicamente!
list.of.packages <- c("rmarkdown", "base64enc", "tidyverse", "Rcpp", "knitr", "car", "RColorBrewer", "gridExtra", "rJava", "readxl", "xlsx", "png", "cowplot", "RefManageR", "forcats", "skimr", "formatR", "janitor", "pROC", "tidyverse", "survminer", "JM", "JMbayes")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='https://cran.rstudio.com/')


library(tidyverse)
library(knitr)
# library(formatR)