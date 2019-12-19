# PRINTS TABLE 1b: "SUMMARY TABLE BY FACTOR"

table1_by_fac_printer <- function(
  mydata,
  grouping,
  char_vars = NULL,
  num_vars = NULL,
  char_names = NULL,
  num_names = NULL
){
  
  # REMOVE NAs FRM GROUPING VBLE
  mydata <- mydata %>%
    filter(
      !is.na(!!!grouping)
    )
  # SELECT DATAFRAMES
  # bang!!
  require(dplyr)
  if(is.null(char_vars)){
    char_names = NULL
    mydata_fac <- tibble()
    table_fac1 <- tibble(
      variable = character(),
      value = character(),
      `Missing (n)` = integer()
    )
  }else{
    mydata_fac <- mydata %>%
      select(!!char_vars)
    # Change colnames to make them pleasing, catching errors
    if( length(char_names) != length(colnames(mydata_fac)) ){
      warning(
        "Character variables: new column names should have the same length as old names"
      )
    }else{
      colnames(mydata_fac) <- char_names
    }
    # CATEGORICAL VARIABLES TABLE 1b
    index_group_var <- which(names(mydata_fac) == group_var)
    # names0 <- names(mydata_fac)[1:(length(names(mydata_fac))-1)] # select variables to calculate stats of interest, removes last variable
    names0 <- names(mydata_fac)[-index_group_var] # select variables to calculate stats of interest, removes the grouping variable
    
    n_total_by_fac <- mydata_fac %>% # calculate total N by gouping factor level
      group_by(!!!grouping) %>%
      summarise(total_by_fac = n())
    
    table_fac0_tot <- mydata_fac %>%
      gather(variable, value, !!names0) %>%  # BANG BANG!
      group_by(
        variable, value) %>%
      summarise (Total = n()) 
    
    table_fac0 <- mydata_fac %>%
      gather(variable, value, !!names0) %>%  # BANG BANG!
      group_by(!!!grouping, variable, value) %>%  # BANG BANG BANG! quo!
      summarise (n = n()) %>%
      ungroup() %>%
      # paste total N in grouping variable levels
      full_join(n_total_by_fac) %>%
      mutate(
        !!group_var := paste0(!!!grouping, " N=", total_by_fac)
      ) %>%
      select(-total_by_fac)
  
    table_fac0 <- table_fac0 %>%
      spread(c(rlang::UQS(grouping)), n) %>%
      ungroup() %>%
      # put zeroes instead of NA in categories with no elements
      mutate_at(
        vars(-value),
        funs(
          replace(., is.na(.), 0))
      ) %>%
      mutate_at(
        vars(-value),
        funs(
          as.character(.)
        ) 
      ) %>%
      full_join(table_fac0_tot)
    
    table_fac0_miss <- table_fac0 %>%
      filter(is.na(value)) %>%
      group_by(variable) %>%
      summarise (`Missing (n)` = sum(Total))
    
    # P-values
    table_fac0_pval <- mydata_fac %>%
      summarise_all (
        funs(
          chisq.test(!!!grouping, .)$p.value
        )
      ) %>%
      t()
    table_fac0_pval <- as_tibble(table_fac0_pval) %>%
      transmute(variable =  attr(table_fac0_pval, "dimnames")[[1]],
                P = V1
      ) 
    
    # Final categorical table
    table_fac1 <- table_fac0 %>%
      full_join(table_fac0_pval) %>%
      full_join(table_fac0_miss) %>%
      filter(!is.na(value)) %>%
      mutate(Total = as.character(Total))
  }
  
  
  if(is.null(num_vars)){
    num_names = NULL
    mydata_num <- tibble()
    table_num1 <- tibble(
      variable = character(),
      `Missing (n)` = integer()
    )
  }else{
    mydata_num <- mydata %>%
      select(!!num_vars)
    # Change colnames to make them pleasing, catching errors
    if( length(num_names) != length(colnames(mydata_num)) ){
      warning(
        "Numerical variables: new column names should have the same length as old names"
      )
    }else{
      colnames(mydata_num) <- num_names
    }
    # NUMERIC VARIABLES TABLE 1b
    # P-values
    table_num0_pval <- mydata_num %>%
      # select(-c(rlang::UQS(grouping))) %>%
      summarise_all(
        funs(
          kruskal.test(., as.factor(!!!grouping))$p.value
        )
      ) %>%
      t() 
    table_num0_pval <- as_tibble(table_num0_pval) %>%
      transmute(variable =  attr(table_num0_pval, "dimnames")[[1]],
                P = V1
      ) %>%
      mutate(
        variable = paste0(variable, " (mean &plusmn; SD)")
      ) %>%
      select(variable, P)
    
    # Means table
    table_num0_mean <- mydata_num %>%
      select(-c(rlang::UQS(grouping))) %>%
      summarise_all(
        funs(
          mean(., na.rm=TRUE)
        )
      ) %>%
      t() 
    table_num0_mean <- as_tibble(table_num0_mean) %>%
      transmute(variable =  attr(table_num0_mean, "dimnames")[[1]],
                mean = round(V1, 2)
      ) %>%
      mutate(
        variable = paste0(variable, " (mean &plusmn; SD)")
      ) %>%
      select(variable, mean)
    
    # SDs table
    table_num0_SD <- mydata_num %>%
      select(-c(rlang::UQS(grouping))) %>%
      summarise_all(
        funs(
          sd(., na.rm=TRUE)
        )
      ) %>%
      t() 
    table_num0_SD <- as_tibble(table_num0_SD) %>%
      transmute(variable =  attr(table_num0_SD, "dimnames")[[1]],
                SD = round(V1, 2)
      ) %>%
      mutate(
        variable = paste0(variable, " (mean &plusmn; SD)")
      ) %>%
      select(variable, SD)
    
    # Means table by Factor level
    table_num0_byfactor_mean <- mydata_num %>%
      group_by(!!!grouping) %>%
      summarise_all(
        funs(
          mean(., na.rm=TRUE)
        )
      ) %>%
      select(-c(rlang::UQS(grouping))) %>%
      t() 
    table_num0_byfactor_mean <- as_tibble(table_num0_byfactor_mean) %>%
      mutate(variable =  attr(table_num0_byfactor_mean, "dimnames")[[1]]
      ) %>%
      mutate(
        variable = paste0(variable, " (mean &plusmn; SD)")
      ) %>%
      select(variable, everything())
    
    # change names of splitted variables
    nams <- mydata %>%
      select(!!!grouping) %>%
      # paste total N in grouping variable levels
      full_join(n_total_by_fac) %>%
      mutate(
        !!group_var := paste0(!!!grouping, " N=", total_by_fac)
      ) %>%
      select(-total_by_fac) %>%
      purrr::map(., as.factor)
    nams <- nams[[1]] %>%
      levels()
    names(table_num0_byfactor_mean) <- c("variable", nams)
    
    # SDs table by Factor level
    table_num0_byfactor_SD <- mydata_num %>%
      group_by(!!!grouping) %>%
      summarise_all(
        funs(
          sd(., na.rm=TRUE)
        )
      ) %>%
      select(-c(rlang::UQS(grouping))) %>%
      t() 
    table_num0_byfactor_SD <- as_tibble(table_num0_byfactor_SD) %>%
      mutate(variable =  attr(table_num0_byfactor_SD, "dimnames")[[1]]
      ) %>%
      mutate(
        variable = paste0(variable, " (mean &plusmn; SD)")
      ) %>%
      select(variable, everything())
    names(table_num0_byfactor_SD) <- c("variable", nams)
    
    # Join mean & SD by Factor level. wow
    table_num0_byfactor_Tot <- table_num0_byfactor_mean %>%
      full_join(table_num0_byfactor_SD) %>%
      mutate_at(
        vars(-variable),
        funs(
          round(., 1)
        ) 
      ) %>%
      # merges the two V1s by collapsing them. same with V2, V3... as many categories has the splitting factor
      group_by(variable) %>%
      summarise_at(
        vars(-variable),
        funs(
          paste(., collapse=" &plusmn; ")
        ) 
      )
    
    # Subset of Levels equal to NA
    table_num0_NA <- mydata_num %>% # less rows because not all vbles have NAs  `Missing (n)`
      select(-c(rlang::UQS(grouping))) %>%
      gather(variable, value) %>%
      group_by(variable) %>%
      filter(is.na(value)) %>%
      summarise(`Missing (n)` = n()) %>%
      mutate(
        variable = paste0(variable, " (mean &plusmn; SD)")
      )
    
    # Total numeric
    table_num1 <- table_num0_mean %>%
      full_join(table_num0_SD) %>%
      mutate_at(
        vars(-variable),
        funs(
          round(., 1)
        ) 
      ) %>%
      mutate(
        Total = paste0(mean, " &plusmn; ", SD)
      ) %>%
      select(-mean, -SD) %>%
      full_join(table_num0_byfactor_Tot) %>%
      mutate(
        value = ""
      ) %>%
      full_join(table_num0_pval) %>%
      left_join(table_num0_NA) %>%
      filter(!is.na(value)) 
  }
  
  # Total TABLE 1b
  table1b_print <- table_num1 %>%
    full_join(table_fac1) %>%
    mutate(
      Q = penalisation(P)
      # Q = P
    ) %>%
    mutate(
      Sign = case_when(
        Q >= 0.05 ~ "NO SIGN",
        Q < 0.05 ~ "SIGNIF",
        TRUE ~ ""
      ),
      `p-value` = case_when(
        Q < 0.0001 ~ "&#60; 0.0001",
        # Q < 0.0001 ~ "< 0.0001",
        Q >= 0.0001 & Q < 0.01 ~ Q %>% round(5) %>% as.character(),
        TRUE ~ Q %>% round(2) %>% as.character()
      )
    ) 
  
  table1b_NOsignificant_variables0 <- table1b_print %>% # select significant vbles for printing
    filter(Sign == "NO SIGN") %>%
    select(variable) %>%
    mutate(variable = ifelse(
      variable == "Age median &plusmn; IQR", 
      "Age", 
      variable
    )
    )
  table1b_NOsignificant_variables <- paste(unique(unlist(table1b_NOsignificant_variables0), collapse=", "))
  
  table1b_print <- table1b_print %>% # remove unneeded columns
    select(
      variable, 
      category = value,
      everything(),
      -P, -Q, -Sign
    ) %>%
    mutate(
      `Missing (n)` = ifelse(
        is.na(`Missing (n)`), "",
        `Missing (n)`
      )
    )
  
  list(
    table = table1b_print,
    no_sig = table1b_NOsignificant_variables
  )
}




