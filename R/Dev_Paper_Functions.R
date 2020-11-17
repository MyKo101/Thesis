
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

#'
cell_realign <- function(x,left_align=T,...){
  if(length(left_align)==1){
    if(left_align)
    {
      cell_spec(x,align="left",...)
    } else {
      cell_spec(x,align="right",extra_css="float:right;",...)
    }
  } else if(length(x) != length(left_align)){
    stop("length of x & left_align do not match in cell_realign()",call.=F)
  } else {
    vapply(1:length(x),
           FUN = function(i) cell_realign(x[[i]],left_align[[i]],...),
           FUN.VALUE = character(1))
  }
}

#' @export
Print_Population_Table_One <- function(SKS = T,UoG = T,f_size=9){
  if(SKS == F && UoG == F)
    rlang::abort("Neiher SKS nor UoG Selected")
  
  l_justified <- c("Age","SBP","DBP", "BMI",
                   "Albumin","Haemoglobin","Calcium","Phosphate")
  with_decimals <- c(l_justified,"eGFR","eGFR Rate","uPCR","uPCR Rate")
  
  tbl_raw <- here::here("data","Dev_Paper","TableOne.csv") %>%
    read_csv(col_types = cols()) %>%
    mutate(across(ends_with("IQR.p"),
                  ~if_else(. == "%","0.00%",.))) %>%
    mutate(Variable = recode(Variable,
                             `DiagGroup:` = "Diagnosis Group:",
                             `SmokingStatus:` = "Smoking Status:",
                             `Former 3Y` = "Former (More than 3Y)")
           ) %>%
    add_row(Variable = "Comorbidities:",
            .before=which(.$Variable=="Diabetes (DM)")) %>%
    mutate(rn=row_number())
  
  l_justified_rows <- with(tbl_raw,
                           which(
                             Variable %in% l_justified |
                               str_detect(Variable,"eGFR")|
                               str_detect(Variable,"uPCR")|
                               str_detect(Variable,":$")
                           )
  )
  
  if(UoG & !SKS){
    tbl_raw %<>%
      filter((UoG_p.miss != "100.00%" | is.na(UoG_p.miss) )) %>%
      filter((UoG_IQR.p != "0.00%" | is.na(UoG_IQR.p) ))
  }
  
  tbl_pre <- tbl_raw %>%
    pivot_longer(-c(rn,Variable),
                 names_pattern="(.*)_(.*)",
                 names_to=c("src",".value")) %>%
    if_fun(!UoG,. %>% filter(src != "UoG")) %>%
    if_fun(!SKS,. %>% filter(src != "SKS")) %>%
    mutate(show_mean = !is.na(mean.n),
           show_range = !is.na(min),
           show_missing = !is.na(n.miss)) %>%
    mutate(across(-c(rn,Variable,starts_with("show_"),mean.n),
                  format,justify="r")) %>%
    mutate(mean.n = if_else(Variable %in% with_decimals,
                            format(round(mean.n,3),justify="r",nsmall=3),
                            format(round(mean.n),nsmall=0,justify="r"))) %>%
    transmute(Variable,rn,src,
              `mean (IQR) or n (%)` = if_else(show_mean,
                                              str_glue("{mean.n} ({IQR.p})"),
                                              ""),
              `range` = if_else(show_range,
                                str_glue("[{min}, {max}]"),
                                ""),
              `missing (%)` = if_else(show_missing,
                                      str_glue("{n.miss} ({p.miss})"),
                                      "")) %>%
    mutate(Variable = cell_realign(Variable, font_size=f_size,
                                   left_align=rn %in% l_justified_rows)) %>%
    mutate(across(c(`mean (IQR) or n (%)`,`range`,`missing (%)`),
                  cell_realign,font_size=f_size,left_align=F,monospace=T)) 
  
  cap <- as_caption("Population demographics, continuous displayed",
          "as mean (Inter-Quartile Range), and",
          "Categorical/Comorbidity data as number (percent)",
          "range and number missing are also included")
  
  if(SKS & UoG){
    tbl_wide <- tbl_pre %>%
      pivot_wider(
        names_from = src,
        values_from = c(`mean (IQR) or n (%)`,`range`,`missing (%)`),
        names_glue = "{src}_{.value}"
      ) %>%
      arrange(rn) %>%
      select(Variable,starts_with("SKS"),starts_with("UoG"))
    
    SKS_cols <- sum(str_detect(names(tbl_wide),"^SKS_"))
    UoG_cols <- sum(str_detect(names(tbl_wide),"^UoG_"))
    
    
    tbl_wide %>%
      to_kable(col_names = function(x) gsub("^SKS_|^UoG_","",x),
               caption = cap,
               col_groups=c("",rep("SKS",SKS_cols),rep("SERPR",UoG_cols)),
               numeric_cols = 2:(SKS_cols + UoG_cols))
    
  } else {
    tbl_pre %>%
      arrange(rn) %>%
      select(-src,-rn) %>%
      add_numeric_cols(-Variable) %>% 
      my_kbl(caption=cap)
  }
  
  
  
}

#' @export
Dev_Valid_Paper_Var_Names <- function(.tbl,.variable,group_var=NULL,Full_Comorb=0)
{
  .V <- pull(.tbl,as_name(enquo(.variable)))
  
  if(!is.null(group_var))
  {
    .grp <- rep(NA,length(.V))
    
    .grp[grepl("Age",.V,fixed=T)] <- "Age"
    .grp[grepl("eGFR",.V,fixed=T)] <- "eGFR"
    .grp[grepl("uPCR",.V,fixed=T)] <- "uPCR"
    
    .grp[.V %in% c("CCF","COPD","CVA","DM","HT",
                   "IHD","LD","MI","PVD","ST")] <- "Comorbidity"
    
    
    .V_g <- grepl(" : ",.V,fixed=T)
    
    if(any(.V_g)) 
    {
      .grp[!.V_g & is.na(.grp)] <- "Measures"
      
      .V_m <- matrix(unlist(str_split(.V[.V_g] ," : ")),ncol=2,byrow=T)
      
      .grp[.V_g] <- .V_m[,1]
      .V[.V_g] <- .V_m[,2]
    } else .grp[is.na(.grp)] <- "Measures"
    
    .grp <- case_when(.grp == "SmokingStatus" ~ "Smoking Status",
                      .grp == "Primary Renal" ~ "Primary Renal Diagnosis",
                      T~.grp)
    
    .grp_n <- case_when(.grp == "Age" ~ 1,
                        .grp == "eGFR" ~ 2,
                        .grp == "uPCR" ~ 3,
                        .grp == "Measures" ~ 4,
                        .grp == "Gender" ~ 5,
                        .grp == "Smoking Status" ~ 6,
                        .grp == "Primary Renal Diagnosis" ~ 7,
                        .grp == "Comorbidity" ~ 8,
                        T ~ 9)
    
    
    
    .tbl %<>% mutate(group_temp = .grp,
                     Order = .grp_n,
                     !!enquo(.variable) := .V) %>%
      arrange(Order,group_temp) %>%
      select(-Order) %>%
      select(group_temp,!!enquo(.variable),everything()) %>%
      rename(!!enquo(group_var) := group_temp)
    
    
    .V <- pull(.tbl,as_name(enquo(.variable)))
  }
  
  
  
  .V <- case_when(.V == "eGFR.Rate" ~ "eGFR Rate",
                  .V == "log.eGFR.Rate" ~ "log(eGFR Rate)",
                  .V == "uPCR.Rate" ~ "uPCR Rate",
                  .V == "log.uPCR.Rate" ~ "log(uPCR Rate)",
                  .V == "Calcium" ~ "Corrected Calcium",
                  T ~ .V)
  
  .V <- gsub("Former_3Y","Former (3 years+)",.V)
  .V <- gsub("Non_Smoker","Non-Smoker",.V)
  
  if(Full_Comorb == 1)
  {
    .V <- case_when(.V == "CCF"  ~ "Congestive Cardiac Failure",
                    .V == "COPD" ~ "Chronic Obstructive Pulmonary Disease",
                    .V == "CVA"  ~ "Prior Cerebrovascular Accident",
                    .V == "DM"   ~ "Diabetes",
                    .V == "HT"   ~ "Hypertension",
                    .V == "IHD"  ~ "Ischemic Heart Disease",
                    .V == "LD"   ~ "Chronic Liver Disease",
                    .V == "MI"   ~ "Prior Myocardial Infarction",
                    .V == "PVD"  ~ "Peripheral Vascular Disease",
                    .V == "ST"   ~ "Solid Tumour")
  }
  
  if(Full_Comorb == 2)
  {
    .V <- case_when(.V == "CCF"  ~ "Congestive Cardiac Failure (CCF)",
                    .V == "COPD" ~ "Chronic Obstructive Pulmonary Disease (COPD)",
                    .V == "CVA"  ~ "Prior Cerebrovascular Accident (CVA)",
                    .V == "DM"   ~ "Diabetes (DM)",
                    .V == "HT"   ~ "Hypertension (HT)",
                    .V == "IHD"  ~ "Ischemic Heart Disease (IHD)",
                    .V == "LD"   ~ "Chronic Liver Disease (LD)",
                    .V == "MI"   ~ "Prior Myocardial Infarction (MI)",
                    .V == "PVD"  ~ "Peripheral Vascular Disease (PVD)",
                    .V == "ST"   ~ "Solid Tumour (ST)")
  }
  
  .tbl %<>% mutate(!!enquo(.variable) := .V)
  
  .tbl
  
}