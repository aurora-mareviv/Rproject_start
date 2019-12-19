# ggplot2 theme

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7") 

themed_basic <- function(x){
  ggx <- x + 
    theme_bw() # + 
    # scale_color_manual(guide = FALSE, values=cbPalette) +
    # scale_fill_manual(values=cbPalette) 
  ggx
}
