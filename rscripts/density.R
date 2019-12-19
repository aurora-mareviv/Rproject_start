# Density 

if (is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[[1]])) + 
    geom_density(alpha=0.6, color="gray40", fill="gray50") + 
    xlab(names(x))
  # p1
}

if (!is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[[1]], color=fac[,1], fill=fac[,1])) + 
    geom_density(alpha=0.6) + 
    guides(fill=guide_legend(title = names(fac))) + 
    guides(color=guide_legend(title = names(fac))) + 
    xlab(names(x)) 
  # p1
}


