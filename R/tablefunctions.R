#' @export
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




#' @export
make_linebreaks <- function(.tbl)
{
  if(get_format("thesis","single"))
  {
    n.lsub <- function(x) paste0("\\makecell[r]{",
                                 gsub("\n","\\\\",x,fixed=T),"}")
  } else {
    n.lsub <- function(x) gsub("\n","<br>",x,fixed=T)
  }
  
  .out <- .tbl
  for(i in 1:nrow(.tbl)) for(j in 1:ncol(.tbl))
  {
    if(grepl("\n",.tbl[i,j]))
    {
      .out[i,j] <- n.lsub(.tbl[i,j])
    }
  }
  
  return(.out)
}

#' @export
clear_ws <- function(.tbl,cols)
{
  if(!is.null(cols))
  {
    ws_sym <- fb("&ensp;"," ","\\\\quad")
    .tbl %>% mutate_at(cols,set_whitespace,symbol=ws_sym)
  } else .tbl
}

#' @export
do_colspace <- function(.tbl,numeric_cols,col_widths)
{
  ncols <- .tbl %>%
    magic_mirror %>%
    extract2("ncol")
  
  mono <- rep(F,ncols)
  
  if(!is.null(numeric_cols))
  {
    mono[numeric_cols] <- T
  }
  
  if(is.null(col_widths))
  {
    wid <- rep(NA,ncols)
  } else if(length(col_widths==1))
  {
    wid <- rep(col_widths,ncols)
  } else
  {
    wid <- col_widths
  }
  
  .res <- .tbl
  
  for(i in 1:ncols)
  {
    .res %<>% if_fun(is.na(wid[i]),
                     function(x) column_spec(x,column=i,monospace=mono[i]),
                     function(x) column_spec(x,column=i,monospace=mono[i],width=wid[i]))
  }
  
  
  return(.res)
}

#' @export
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
           function(x) mutate_at(x,numeric_cols,
                                 ~gsub("<","&lt;",.,fixed=T) %>%
                                   gsub(">","&gt;",.,fixed=T)) %>%
             mutate_if(is.character,
                       ~gsub("\\^([a-zA-Z0-9])","<sup>\\1</sup>",.) %>%
                         gsub("<strong>","**",.,fixed=T) %>%
                         gsub("</strong>","**",.,fixed=T) %>%
                         gsub("&lt;strong&gt;","**",.,fixed=T) %>%
                         gsub("&lt;/strong&gt;","**",.,fixed=T)),
           function(x) mutate_if(x,is.character,
                                 ~gsub("\\^[a-zA-Z0-9]",
                                       "\\\\textsuperscript{\\1}",.) %>%
                                   gsub("%","\\%",.,fixed=T) %>%
                                   gsub("<strong>","\\emph{",.,fixed=T) %>%
                                   gsub("</strong>","}",.,fixed=T))) %>%
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
           . %>% add_header_above(col_headers)) %>%
    if_fun(lscape,
           . %>% landscape(margin="2cm"),
           . %>% kable_styling(latex_options="hold_position")) %>%
    if_fun(!is.null(group_col) && !is.na(group_col),
           . %>% pack_rows(index=grp_index)) %>%
    do_colspace(numeric_cols,col_widths) %>%
    gsub("\\\\vphantom\\{.*?\\} ","",.)
  
}

#'@export
format_table2 <- function(tbl,caption)
{
  ncols <- ncol(tbl)
  
  column_widths <- map_int(tbl,~max(nchar(.))) %>%
    paste0("em")
  
  tbl %>%
    mutate_all(justify) %>%
    mutate_all(set_whitespace,symbol=fb("&emsp;","\\\\quad","\\\\quad")) %>%
    kable(format=fb("html","latex","latex"),
          booktabs=T,
          col.names=colnames(tbl),
          escape=F,
          caption=paste0(fb("<font size=\"2\">","{\\small ","{\\small "),
                         caption,
                         fb("</font>","}","}"))) %>%
    kable_styling(bootstrap_options="striped",
                  latex_options="striped",
                  font_size=fb(9,7,7),
                  full_width=F) %>%
    column_spec(column=1:ncols,monospace=T,width=column_widths) %>%
    scroll_box(width="100%")
}


#' @export
fm <- function(x) footnote_marker_alphabet(x,format=fb("html","latex","latex"))


