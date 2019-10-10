# Import CSV / TSV (separated by tabs in this example)
dataname <- params$dataname # archive name
routecsv <- paste(datadir, "/", dataname, ".csv", sep="")  # complete route to archive

mydata <- read.csv(routecsv, 
                   header = TRUE, 
                   sep = "\t",
                   dec = ".")