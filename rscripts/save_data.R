# SAVE DATA IN VARIOUS FORMATS

dataname_export <- exported_dataname  # name we will give to our binary file (not applicable to RData at this moment)


# RDATA
assign(dataname_export, mydata)
routeRdata_export <- paste(datadir_out, "/", dataname_export, ".RData", sep="")
save(dataname_export, file=routeRdata_export)
# save(mydata, file="./data_out/mydata.RData")


# MSEXCEL
routexl_export <- paste(datadir_out, "/", dataname_export, ".xlsx", sep="")   # complete route to future archive

if (require(xlsx) == TRUE) {
  write.xlsx(mydata, routexl_export) # creates archive in specified route
} else {
  print("xlsx package is not installed")
}
# library(xlsx)
# write.xlsx(mydata, routexl_export) # creates archive in specified route


# CSV / TSV (separated by tabs in this example)
routecsv_export <- paste(datadir_out, "/", dataname_export, ".csv", sep="")  # complete route to future archive

write.table(mydata, file = routecsv_export, append = FALSE, quote = FALSE, sep = "\t ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE)


