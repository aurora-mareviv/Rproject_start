# Histogram 

# if (is.factor(fac) || is.character(fac) ){  
#   fac <- fac # doesn't need to transform to vector
# }
# 
# if (!is.factor(fac) && !is.character(fac)){  
#   fac <- fac[,1] # transform to vector
# }

if (is.null(fac)){  
p1 <- ggplot(mydata, aes(x=x[[1]])) + 
  geom_bar(aes(fill = ..count..), color="gray60", alpha=0.6) +
  scale_fill_gradient2(low="grey", mid="darkgrey", high="#F17022") + 
  theme(legend.position="none") + 
  xlab(names(x)) 
# p1
}

if (!is.null(fac)){  
  p1 <- ggplot(mydata, aes(x=x[[1]], color=fac[,1], fill=fac[,1])) + 
    geom_bar(alpha=0.6) + 
    guides(fill=guide_legend(title = names(fac))) + 
    guides(color=guide_legend(title = names(fac))) + 
    xlab(names(x)) 
  # p1
}