# Scatterplot

if (is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[[1]], y=y[[1]])) + geom_point() + 
    xlab(names(x)) + 
    ylab(names(y))
  # p1
}

if (!is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[[1]], y=y[[1]], color=fac[,1])) + geom_point() + 
    guides(fill=guide_legend(title = names(fac))) + 
    guides(color=guide_legend(title = names(fac))) + 
    xlab(names(x)) + 
    ylab(names(y))
  # p1
}



