pkgs <- c("devtools","thesisdown","tidyverse","rlang",
          "googledrive","magrittr","kableExtra","stringi")

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

get_format <- function(...)
{
  .res <- options("output.format")
  
  x <- list(...)
  if(length(x) == 0)
  {
    return(.res)
  } else
  {
    return(.res %in% unlist(x))
  }
  
}

fb <- function(gitbook=NULL,thesis=NULL,single=NULL)
{
  .res <- ""
  if(get_format("gitbook") & !is.null(gitbook)) .res <- gitbook
  if(get_format("thesis") & !is.null(thesis)) .res <- thesis
  if(get_format("single") & !is.null(single)) .res <- single
  return(.res)
}

add_downloads <- function(filenum)
{
  filename <- c("Lit Report",
                "Scoping Review Paper",
                "CR Conf",
                "IPCW logistic",
                "Performance Metrics",
                "Dev Paper",
                "","","",
                "Conclusion")[filenum] %>%
    gsub(" ","_",.) %>%
    paste0("ind_",ifelse(filenum<10,paste0("0",filenum),filenum),"-",.)
  
  .res <- paste0("Download as individual paper draft: [pdf](Chapters/",
         filename,".pdf), [tex](Chapters/",filename,".tex)")
  fb(.res,.res,"")
}

make_linebreaks <- function(.tbl)
{
  if(get_format("thesis","single"))
  {
    .out <- .tbl
    
    lb_cols <- grepl("\n",lapply(.out,paste0,collapse=""),fixed=T)
    .out[,lb_cols,drop=F] <- lapply(.out[,lb_cols],linebreak)
    
  } else .out <- .tbl
  return(.out)
}

clear_ws <- function(.tbl,cols)
{
  if(!is.null(cols))
  {
    ws_sym <- fb("&emsp;"," ","\\\\quad")
    suppressWarnings(.tbl %>%
      mutate_at(cols,
                function(x) x %>% 
                  stri_reverse %>%
                  gsub("  "," #",.) %>%
                  stri_reverse %>%
                  gsub("#",ws_sym,.)))
  } else .tbl
}

do_colwidths <- function(.tbl,col_widths)
{
  .res <- .tbl
  
  if(!is.null(col_widths))
  {
    if(length(col_widths) == 1)
    {
      .res <- .res %>%
        magic_mirror %>%
        extract2("ncol") %>%
        seq_len %>%
        column_spec(.tbl,column=.,width=col_widths)
    } else
    {
      for(i in 1:length(col_widths))
      {
        .res %<>% column_spec(column=i,width=col_widths[i])
      }
    }
  }
  return(.res)
}

to_kable <- function(.tbl,caption,...,numeric_cols=NULL,lscape=F,
                     col_names=do_nothing,row_names=NULL,
                     group_col=NULL,col_widths=NULL,col_groups=NULL)
{
  if(!is.null(group_col)&&!is.na(group_col))
  {
    grp_index <- .tbl[[group_col]] %>%
      replace(.==""," ") %>%
      fct_inorder %>%
      table
    .tbl %<>% select(-any_of(group_col))
  }
  
  if(!is.null(col_groups)&&!is.na(col_groups))
  {
    col_headers <- col_groups %>%
      replace(.==""," ") %>%
      fct_inorder %>%
      table
  } else col_headers <- NULL
  
  
  .pre <- .tbl %>%
    mutate_if(is.character,~replace_na(.,"")) %>%
    if_fun(get_format("gitbook"),
           function(x) mutate_if(x,is.character,
                                 ~gsub("<","&lt;",.,fixed=T) %>%
                                   gsub(">","&gt;",.,fixed=T) %>%
                                   gsub("\n","<br>",.,fixed=T)%>%
                                   gsub("^2","&sup2;",.,fixed=T)),
           function(x) mutate_if(x,is.character,
                                 ~gsub("^2","\\textsuperscript{2}",.,fixed=T) %>%
                                   gsub("%","\\%",.,fixed=T))) %>%
    make_linebreaks %>%
    clear_ws(numeric_cols) %>%
    if_fun(!is.null(row_names),
           function(x) column_to_rownames(x,row_names))
  
  if(get_format("gitbook"))
  {
    caption <- gsub("<","&lt;",caption,fixed=T)
    caption <- gsub(">","&gt;",caption,fixed=T)
    caption <- gsub("^2","&sup2;",caption,fixed=T)
  }
  
  if(get_format("thesis","single"))
  {
    caption <- gsub("%","\\%",caption,fixed=T)
  }
  
  .pre %>%
    kable(format=fb("html","latex","latex"),
          booktabs=T,
          col.names = col_names(colnames(.pre)),
          escape=F,
          caption=paste0(
            fb("<font size=\"2\">","{\\small ","{\\small "),
            caption,
            fb("</font>","}","}")),
          ...) %>%
    kable_styling(bootstrap_options="striped",
                  latex_options="striped",
                  font_size=fb(9,7,7),
                  full_width=F) %>%
    if_fun(!is.null(col_headers),
           add_header_above(col_headers)) %>%
    if_fun(lscape,landscape,
           function(x) kable_styling(x,latex_options="hold_position")) %>%
    if_fun(!is.null(numeric_cols),
           function(x) column_spec(x,numeric_cols,monospace = T)) %>%
    if_fun(!is.null(group_col) && !is.na(group_col),
           function(x) pack_rows(x,index=grp_index)) %>%
    do_colwidths(col_widths) %>%
    if_fun(get_format("gitbook"),
           function(x) scroll_box(x,width="100%")) %>%
    gsub("\\\\vphantom\\{.*?\\} ","",.) %>% 
    gsub("\\\\\\quad","\\\\ \\quad",.,fixed=T) 
  
}


fm <- function(x) footnote_marker_alphabet(x,format=fb("html","latex","latex"))

do_nothing <- function(x) x


if(knitr:::is_latex_output())
  options(output.format = "thesis") else 
    options(output.format = "gitbook")
