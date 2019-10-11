# Import XLS files
dataname <- params$dataname # archive name
sheet_n <- params$sheet
routexl <- paste(datadir, "/", dataname, ".xls", sep="")  # complete route to archive

library(readxl)
mydata <- read_excel(routexl, sheet = sheet_n)  # imports first sheet
