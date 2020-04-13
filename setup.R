pkgs <- c("devtools","thesisdown","tidyverse","rlang",
          "googledrive","magrittr","kableExtra")

purrr::walk(pkgs,library,character.only=T)


options(kableExtra.html.bsTable = T)

xx <- function(x = "xxxx") paste0("[**",x,"**]")
cc <- function(x="Something") xx(paste0("Cite: ",x))
LR <- function(...) cc(paste0("LR - ",paste0(unlist(list(...)),collapse=", ")))


logit <- function(p) log(p/(1-p))
logit1 <- function(o) exp(o)/(exp(o)+1)

.wd <- "C:/Users/mbrxsmbc/Documents/Thesis/index/"

Trans_short2long <- function(x)
{
  t.list <- grep("^Trans_",x)
  y <- character(length(x))
  y[-t.list] <- x[-t.list]
  
  y[t.list] <- x[t.list] %>%
    substr(8,9) %>%
    strsplit("",fixed=T) %>%
    map(~recode(.,a="Alive",c="CKD",d="Dead",r="RRT",h="HD",p="PD",t="Tx")) %>%
    map(~paste0(.,collapse=" to ")) %>%
    unlist
  
  return(y)
}

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

if_fun <- function(.x,.predicate,.fun,.elsefun=NULL) 
{
  if(.predicate) .fun(.x) else 
    if(!is.null(.elsefun))
      .elsefun(.x) else
        .x
}

get_format <- function(x=NULL)
{
  if(knitr:::is_latex_output()) "latex" else "html"
}

format_choice <- function(.latex,.html)
{
  if(get_format() == "latex") .latex else .html
}

make_linebreaks <- function(.tbl)
{
  if(get_format() == "latex")
  {
    .out <- .tbl
    
    lb_cols <- grepl("\n",lapply(.out,paste0,collapse=""),fixed=T)
    .out[,lb_cols,drop=F] <- lapply(.out[,lb_cols],linebreak)
    
  } else .out <- .tbl
  return(.out)
}

to_kable <- function(.tbl,caption,...,numeric_cols=NULL,lscape=F,
                     col_names=do_nothing,row_names=NULL,group_col=NULL)
{
  if(!is.null(group_col))
  {
    grp_index <- .tbl[[group_col]] %>%
      replace(.==""," ") %>%
      fct_inorder %>%
      table
    .tbl %<>% select(-any_of(group_col))
  }
  
  .pre <- .tbl %>%
    mutate_if(is.character,~replace_na(.,"")) %>%
    if_fun(get_format()=="html",
           function(x) mutate_if(x,is.character,
                                 ~gsub("<","&lt;",.,fixed=T) %>%
                                   gsub(">","&gt;",.,fixed=T) %>%
                                   gsub("\n","<br>",.,fixed=T)%>%
                                   gsub("^2","&sup2;",.,fixed=T)),
           function(x) mutate_if(x,is.character,
                                 ~gsub("^2","\\textsuperscript{2}",.,fixed=T) %>%
                                   gsub("%","\\%",.,fixed=T))) %>%
    make_linebreaks %>%
    if_fun(!is.null(row_names),
           function(x) column_to_rownames(x,row_names))
  
  
  if(get_format() == "html")
  {
    caption <- gsub("<","&lt;",caption,fixed=T)
    caption <- gsub(">","&gt;",caption,fixed=T)
    caption <- gsub("^2","&sup2;",caption,fixed=T)
  }
  
  .pre %>%
    kable(format=get_format(),
          booktabs=T,
          col.names = col_names(colnames(.pre)),
          escape=F,
          caption=paste0(
            format_choice("{\\small ","<font size=\"2\">"),
            caption,
            format_choice("}","</font>")),
          ...) %>%
    kable_styling(bootstrap_options="striped",
                  latex_options="striped",
                  font_size=format_choice(7,9)) %>%
    if_fun(lscape,landscape,
           function(x) kable_styling(x,latex_options="hold_position")) %>%
    if_fun(!is.null(numeric_cols),
           function(x) column_spec(x,numeric_cols,monospace = T)) %>%
    if_fun(!is.null(group_col),
           function(x) pack_rows(x,index=grp_index))
  
}


fm <- function(x) footnote_marker_alphabet(x,format=get_format())

do_nothing <- function(x) x
