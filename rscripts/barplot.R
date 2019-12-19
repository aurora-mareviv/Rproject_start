# Barplot 

if (is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[,1])) + 
    geom_bar() + 
    xlab(names(x))
  # p1
}

if (!is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[,1], color=fac[,1], fill=fac[,1])) + 
    geom_bar(position="dodge") + 
    xlab(names(x))
  # p1
}