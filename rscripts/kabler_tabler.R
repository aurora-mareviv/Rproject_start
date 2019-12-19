# Kable Extra formatter

require(magrittr)
kabler <- function(x){
  y <- x %>%
  knitr::kable("html", escape = F, align = "c") %>%
  kableExtra::kable_styling("striped", full_width = F)
  y
}
