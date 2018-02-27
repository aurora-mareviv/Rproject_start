# KAPLAN-MEIER

require("survival")
require("survminer") # masks tidyr::extract 

# name_fac <- names(fac)
# assign(name_fac, fac) 

if (is.null(fac)){  
  fit <- survfit(Surv(time_to_event, censor) ~ 1, 
                 data = mydata)
  
  km.export <- ggsurvplot(fit, data = mydata, risk.table = TRUE, risk.table.height=0.2, 
                          ylim = c(0.5, 1),
                          xlab = "Tiempo (d)",
                          ylab = "% Supervivencia", 
                          legend.title = "",
                          legend.labs = "Pacientes", 
                          # legend = "none",
                          risk.table.title = "Num. pacientes en riesgo"
  )
  p1 <- ggsurvplot(fit, data = mydata, risk.table = TRUE, 
                   ylim = c(0.5, 1),
                   xlab = "Tiempo (d)",
                   ylab = "% Supervivencia", 
                   legend.title = "", 
                   legend.labs = "Pacientes", 
                   # legend = "none", 
                   risk.table.title = "Num. pacientes en riesgo"
  )
}

if (!is.null(fac)){  
  fit <- survfit(Surv(time_to_event, censor) ~ fac,
                 data = mydata)
  
  km.export <- ggsurvplot(fit, data = mydata, risk.table = TRUE, risk.table.height=0.2, 
                          ylim = c(0.5, 1),
                          xlab = "Tiempo (d)",
                          ylab = "% Supervivencia", 
                          legend.title = "",
                          legend.labs = levels(fac),
                          # legend = "none",
                          risk.table.title = "Num. pacientes en riesgo"
  )
  p1 <- ggsurvplot(fit, data = mydata, risk.table = TRUE, 
                   ylim = c(0.5, 1),
                   xlab = "Tiempo (d)",
                   ylab = "% Supervivencia", 
                   legend.title = "", 
                   legend.labs = levels(fac),
                   # legend = "none", 
                   risk.table.title = "Num. pacientes en riesgo",
                   conf.int = TRUE
  )
}


# fit <- Surv(mydata$survival_surgery2, mydata$exitustotal)


# USAGE

# time_to_event <- mydata$survival
# censor <- mydata$censoring
# 
# fac <- NULL
# 
# source("./rscripts/kaplan_meier.R", echo=TRUE)
# kaplan1 <- p1
# kaplan1
# 
# 
# fac <- mydata$factor %>%
#   as.factor() %>% 
#   forcats::fct_recode(`factor=0`="0", `factor=1`="1")
# 
# source("./rscripts/kaplan_meier.R", echo=TRUE)
# kaplan2 <- p1
# kaplan2

