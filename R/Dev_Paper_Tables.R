
#' @export
print_table_PH <- function(fn,Model,lscape=F)
{
  sModel <- recode(Model,`2`="Two",`3`="Three",`5`="Five")
  nTrans <- case_when(Model == 2 ~ 1,Model==3~3,Model==5~6)
  algn <- paste0(rep("r",nTrans),collapse="")
  fn %>%
    read_csv(col_types=cols()) %>%
    select(Var,starts_with(paste0("Trans_",Model)))%>%
    Dev_Valid_Paper_Var_Names(Var,group_var=".group")%>%
    to_kable(col_names=Trans_short2long,
             row_names="Var",
             align=algn,
             numeric_cols=1:nTrans+1,
             group_col = ".group",
             caption=paste0("Proportional Hazards for each transition in the ",
                            sModel,"-State Model"),
             lscape=lscape,
             col_widths=c("30em",rep("43em",nTrans)))
  
}



#' @export
print_Cum_Haz_eq <- function(fn,Model)
{
  sModel <- recode(Model,`2`="Two",`3`="Three",`5`="Five")
  nTrans <- case_when(Model == 2 ~ 1,Model==3~3,Model==5~6)
  fn %>%
    read_csv(col_types=cols()) %>% 
    filter(Model == sModel) %>%
    mutate(L0 = gsub("exp(case_when(","",L0,fixed=T),
           L0 = strsplit(L0,"\n\t\t"),
           L0 = map(L0,~tibble(haz = .,rn=1:length(.)))) %>%
    unnest(L0) %>%
    separate(haz,into=c("Range","Equation"),sep="~") %>%
    mutate(Transition = paste0(From," to ",To),
           Range = gsub("t & t","t",Range),
           Equation = gsub(",","",Equation,fixed=T),
           From = recode(From,Alive=1,CKD=1,HD=2,PD=3,Tx=4,RRT=5,Dead=6),
           To = recode(To,Alive=1,CKD=1,HD=2,PD=3,Tx=4,RRT=5,Dead=6)) %>%
    group_by(Transition,From,To) %>%
    arrange(Transition,rn) %>%
    mutate(L0 = paste0(Equation," & ",Range)) %>%
    summarise(L0 = paste0(L0,collapse="\\\\")) %>%
    mutate(L0 = paste0("\\begin{equation}\n\\Lambda_{0,",From,To,"}(t)=",
                       "\\begin{cases}",L0,
                       "(\\#eq:CH-",sModel,"-",From,To,")",
                       "\\end{cases}\n\\end{equation}"),
           L0 = gsub("log","\\log",L0,fixed=T),
           L0 = gsub("*","",L0,fixed=T),
           L0 = gsub("<=","\\le",L0,fixed=T)) %>%
    ungroup %>%
    pull(L0) %>%
    paste0(collapse="\n")
}

#' @export
list_table_Valid <- function(fn,Model,external)
{
  sModel <- recode(Model,`2`="Two",`3`="Three",`5`="Five")
  nTrans <- case_when(Model == 2 ~ 1,Model==3~3,Model==5~6)
  
  cap <- paste0(if_else(external,"External","Internal"),
                " Validation of the ",
                sModel,"-State Model, results presented as Estimate (95% CI, where possible)")
  
  .mid <- fn %>%
    read_csv(col_types=cols()) %>%
    filter(Model == sModel,src == ifelse(external,"UoG","SKS")) %>%
    select(-Model,-src) %>%
    arrange(Measure,Collapsed,!low.eGFR) %>%
    mutate(low.eGFR = if_else(low.eGFR,"< 60","< 30")) %>%
    rename_at(vars(ends_with("Year")),
              ~gsub("_"," ",.,fixed=T)%>%
                trimws) %>%
    rename(Predicting=Collapsed,
           Average = Overall,
           eGFR = low.eGFR)
  
  
  .out <- .mid %>%
    filter(!(Predicting == "Five" & Measure == "Slope")) %>%
    to_kable(caption=cap,group_col="Measure",align="llrrrr",numeric_cols=3:6)
  
  
  
  if(Model == 5)
  {
    .out2 <- .mid %>%
      filter(Predicting == "Five" & Measure == "Slope") %>%
      select(-Predicting,-Measure) %>%
      mutate(eGFR = paste0(if_else(external,"External ","Internal "),eGFR)) %>%
      pivot_longer(-eGFR,names_to="Time",values_to="Slope") %>%
      pivot_wider(names_from=eGFR,values_from=Slope) 
    
    
  } else .out2 <- ""
  
  list(.out,.out2)
  
}