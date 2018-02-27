# directory where the notebook is
wdir <- getwd() 
# directory where data are imported from
datadir <- file.path(wdir, "data") # better than datadir <- paste(wdir, "/data", sep="")
# directory where data are saved to
datadir_out <- file.path(wdir, "data_out") # better than datadir <- paste(wdir, "/data", sep="")
# directory where external images are imported from
imgdir <- file.path(wdir, "img")
# directory where plots are saved to
plotdir <- file.path(wdir, "plot")
# directory where the scripts reside
scriptdir <- file.path(wdir, "rscripts")
# the folder immediately above root
Up <- paste("\\", basename(wdir), sep="")
wdirUp <- gsub(Up, "", wdir) 

