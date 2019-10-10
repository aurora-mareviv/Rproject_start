# Import R files
dataname <- params$dataname # archive name
routeRdata <- paste(datadir, "/", dataname, ".RData", sep="")  # complete route to archive

  load(routeRdata)
  data_name <- sub("(.*\\/)([^.]+)(\\.[[:alnum:]]+$)", "\\2", routeRdata)
  mydata <- get(data_name)

