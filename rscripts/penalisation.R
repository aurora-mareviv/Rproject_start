
############################################
### SCRIPT IN R FOR FALSE DISCOVERY RATE ###
############################################
# Update Bioconductor
# source("http://bioconductor.org/biocLite.R")
# biocLite()

# Instala paquetes que puedan faltar en tu sistema. Automagicamente! 
list.of.packages <- c("qvalue")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)){ 
  # Install qvalue from Bioconductor
  source("http://bioconductor.org/biocLite.R")
  biocLite("qvalue")
 }

# Instala paquetes que puedan faltar en tu sistema. Automagicamente! 
list.of.packages <- c("kableExtra")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='https://cran.rstudio.com/')


library(qvalue)

# Open graphical interface:
#   qvalue.gui()
#   Computing q-values...done: pi_0 = 0.5488.

my_pvalues <- pvalues$p
qobj <- qvalue(p = my_pvalues, lambda=0)

# Estimating the false discovery rate for a given p-value cut-off. If one wants to estimate
# the false discovery rate when calling all p-values less than or equal to 0.05 significant,
# then type:
q_value_threshold <- max(qobj$qvalues[qobj$pvalues <= 0.05])

# Estimating a p-value cut-off for a given false discovery rate level. If one wants to
# estimate the p-value cut-off for controlling the false discovery rate at level 0.05, then
# type:
p_value_threshold <- max(qobj$pvalues[qobj$qvalues <= 0.05])
# This calculates the largest p-value with estimated q-value less than or equal to 0.05. 
p_value_bonferroni <- 0.05/nrow(pvalues)

# An estimate of the overall proportion of true null hypotheses pi0 (null hypotheses/ all the hypotheses):
pi0 <- qobj$pi0

# An estimate of the proportion of significant tests:
pi1 <- 1- qobj$pi0

pvalues <- pvalues %>% 
  mutate(qvalues = qobj$qvalues,
         sign_FDR = if_else(p < p_value_threshold, "Signif", "No signif"),
         sign_Bonferroni = if_else(p < p_value_bonferroni, "Signif", "No signif")
         ) 

# Colors
color_signif <- "#ffffff"
color_no_signif <- "#333333"
bground_signif <- "#4e7827"
bground_no_signif <- "#ffff66"


library(kableExtra)
pvalues_html <- pvalues %>% 
  mutate(
    sign_FDR = cell_spec(sign_FDR, "html", 
                         color = ifelse(sign_FDR == "Signif", color_signif, color_no_signif),
                         background = factor(sign_FDR, c("Signif", "No signif"), c(bground_signif, bground_no_signif))),
    sign_Bonferroni = cell_spec(sign_Bonferroni, "html", 
                                color = ifelse(sign_Bonferroni == "Signif", color_signif, color_no_signif),
                                background = factor(sign_Bonferroni, c("Signif", "No signif"), c(bground_signif, bground_no_signif)))
    )


