

#' @export
baseline_metric <- function(metric,level,...){
  
  Q <- c(...)
  K <- 2
  
  if(length(Q) == 0){
    Q <- 0.5
  } else if(length(Q) > 1){
    Q <- Q/sum(Q)
    K <- length(Q)
  }
  
  
  metric_data <- list(
    `Brier Score` = exprs(P=0,
                          NI=sum(Q*(1-Q))/(1+(K==2))),
    aBS = exprs(P=1,NI=0),
    `c-statistic` = exprs(P=1,NI=0.5),
    PDI = exprs(P=1,NI=1/K),
    Intercept = exprs(P=rep(0,K),NI=NA),
    Slope = exprs(P=diag(K),NI=NA)
  )
  eval(metric_data[[c(metric,level)]])
  
}

#' @export
Get_Q <- function(type,filename="Five_Year_Proportions.csv"){
  tbl <- filename %>%
    here::here("data",.) %>%
    read_csv(col_types = cols())
  
  M <- tbl %>%
    select(-State) %>%
    as.matrix %>%
    set_rownames(tbl$State)
  
  Total <- sum(M["CKD",])
  CKD <- M["CKD","Pop"]
  RRT <- M["RRT","Pop"]
  Death <- M["Death","Pop"]
  
  switch(type,
         `CKD vs All` = c(CKD,Total-CKD),
         `RRT vs All` = c(RRT,Total-RRT),
         `Death vs All` = c(Death,Total-Death),
         `CKD vs Death` = c(CKD,Death),
         `CKD vs RRT` = c(CKD,RRT),
         `RRT vs Death` = c(RRT,Death),
         `CKD to Death` = c(CKD,M["CKD","->Death"]),
         `CKD to RRT` = c(CKD,M["CKD","->RRT"]),
         `RRT to Death` = c(RRT,M["RRT","->Death"]),
         `MSM` = c(CKD,RRT,Death)
  )
  
}


#' @export
Print_Proportion_tbl <- function(filename,f_size=12){
  #filename = "Five_Year_Proportions.csv"
  filename %>%
    here::here("data",.) %>%
    read_csv(col_types = cols()) %>%
    mutate(Prop = paste0(justify(100*Pop/sum(Pop),d=2),"%"),.after=Pop) %>%
    add_numeric_cols(-State,.digits=0,.font_size=f_size) %>%
    my_kbl(caption=as_caption("Distribution of patients in Population at 5 years",
                           "including number of times each transition occured"),
           font_size=f_size)
}

#' @export
Print_NI_Brier <- function(f_size=12){
  
  Type_order_vect <- order_vect(`One Vs All`,Pairwise,Transition,MSM)
  
  tbl_pre <- tribble(
    ~Type, ~names,
    "One Vs All", list("CKD vs All","Death vs All","RRT vs All"),
    "Pairwise", list("CKD vs Death","CKD vs RRT","RRT vs Death"),
    "Transition", list("CKD to Death","CKD to RRT","RRT to Death"),
    "MSM", "MSM"
  ) %>%
    group_by_all() %>%
    expand(names=unlist(names)) %>%
    mutate(Q = map(names,Get_Q)) %>%
    mutate(BS = map_dbl(Q,baseline_metric,metric="Brier Score",level="NI")) %>%
    select(-Q) %>%
    add_numeric_cols(BS,.font_size=f_size) %>%
    group_by(Type) %>%
    mutate(col_names=letters[row_number()]) %>%
    mutate(metric="BS") %>%
    bind_with(. %>% 
                mutate(BS = names,
                       metric="_name") %>%
                filter(Type != names)) %>%
    select(-names) %>%
    pivot_wider(names_from=col_names,values_from=BS) %>%
    mutate(Type_order = recode(Type,!!!Type_order_vect)) %>%
    arrange(Type_order,metric) %>%
    mutate(across(.fns=replace_na,replace="")) %>%
    select(-metric,-Type_order) %>%
    ungroup
  
  tbl_pre %>%
    select(-Type) %>%
    my_kbl(caption=as_caption("NI-level for the different populations Brier Scores"),
           col.names=rep("",ncol(.)),
           escape=F,
           align="rrr",
           font_size=f_size,
           full_width=F) %>%
    pack_rows(index=table(tbl_pre$Type)[unique(tbl_pre$Type)]) 
}

#' @export
Print_metric <- function(filename,metric,f_size=12){
  #metric should either be "Accuracy", "Discrimination", "Intercept" or "Slope"
  #filename = "Methods_Paper_Valid.csv"
  
  metric_simple <- metric %in% c("Accuracy","Discrimination")
  
  Type_order_vect <- order_vect(OneVAll,Pairwise,Transition,MSM)
  metric_order_vect <- order_vect(`_name`,
                                  `Brier Score`,aBS,
                                  PDI,`c-statistic`,
                                  Intercept, Slope,
                                  `(bootstrap)`)
  
  tbl_list <- filename %>%
    here::here("data",.) %>%
    read_csv(col_types = cols()) %>%
    if_fun(metric_simple,
           . %>% 
             filter(measure == .env$metric),
           . %>%
             filter(.data$metric == .env$metric)
    ) %>%
    mutate(across(starts_with("val"),~justify(.,3)))
  
  nl <- fb("<br>","\\newline","\\newline")
  
  trivial_tbl <- tbl_list %>%
    filter(Type != "MSM") %>%
    clear_ws(vars(starts_with("val"))) %>%
    mutate(val = str_glue("{val} ({val_LL},{val_UL}){nl}({val_LL_boot},{val_UL_boot})")) %>%
    add_numeric_cols(val,.font_size=f_size)  %>%
    select(Type,name,metric,val) %>%
    group_by(Type,metric) %>%
    mutate(col_name=letters[row_number()]) %>%
    ungroup %>%
    bind_with(. %>%
                mutate(metric="_name",
                       val=name) %>%
                unique
    ) %>%
    select(-name) %>%
    pivot_wider(names_from=col_name,values_from = val) 
  
  MSM_tbl <- tbl_list %>%
    filter(Type == "MSM") %>%
    group_by(across(-c(starts_with("val"),rn2))) %>%
    summarise(across(starts_with("val"),
                     ~paste(.,collapse=", ")),.groups="drop") %>%
    group_by(across(-c(starts_with("val"),rn1))) %>%
    summarise(across(starts_with("val"),~paste(.,collapse=nl)),.groups="drop") %>%
    if_fun(!metric_simple,
           . %>%
             bind_with(. %>%
                         mutate(metric = str_glue("(bootstrap)"),
                                val = "",
                                val_LL = val_LL_boot,
                                val_UL = val_UL_boot)),
           . %>%
             mutate(val_LL = str_glue("{val_LL}{nl}{val_LL_boot}"),
                    val_UL = str_glue("{val_UL}{nl}{val_UL_boot}"))
           ) %>%
    select(metric,a=val,b=val_LL,c=val_UL) %>%
    add_numeric_cols(-metric,.font_size=f_size) %>%
    add_row(metric="_name",a="Est",b="Lower",c="Upper",.before=1) %>%
    mutate(Type="MSM")
  
  
  tbl_pre <- trivial_tbl %>%
    bind_rows(MSM_tbl) %>%
    mutate(Type_order = recode(Type,!!!Type_order_vect),
           metric_order = recode(metric,!!!metric_order_vect),
           Type = recode(Type,OneVAll="One Vs All")) %>%
    arrange(Type_order,metric_order) %>%
    select(-Type_order,-metric_order) %>%
    mutate(across(c(a,b,c),
                  ~if_else(metric!="_name",.,
                           cell_spec(.,align="right",
                                     extra_css="float:right;"))
                  )) %>%
    mutate(metric=recode(metric,`_name` = "",`(bootstrap)` =""))
  
  
  
  out_pre <- tbl_pre %>%
    select(-Type) %>%
    my_kbl(caption = as_caption("Measures of {metric} for the Trivial",
                             "extensions and Multi-State Model method.",
                             "95% Confidence Intervals are shown, with",
                             "calculated/population-based intervals",
                             "above bootstrapped intervals in brackets",
                             "(where needed)"),
        col.names=rep("",ncol(.)),
        escape=F,
        font_size=f_size) %>%
    pack_rows(index=table(tbl_pre$Type)[unique(tbl_pre$Type)]) 
  
  
  out_pre
  
  
}
