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
                     group_col=NULL,col_widths=NULL,
                     col_groups=NULL,col_groups_sep=FALSE)
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
    
    if(col_groups_sep)
    {
      header_borders <- cumsum(col_headers)[-length(col_headers)]
      header_border_styles <- fb("2px solid lightgray",T,T)
      
    }
    
  } else col_headers <- NULL
  
  
  .pre <- .tbl %>%
    mutate_if(is.character,~replace_na(.,"")) %>%
    if_fun(get_format("gitbook"),
           function(x) mutate_at(x,numeric_cols,
                                 ~gsub("<","&lt;",.,fixed=T) %>%
                                   gsub(">","&gt;",.,fixed=T) %>%
                                   gsub("&lt;strong&gt;","<strong>",.,fixed=T) %>%
                                   gsub("&lt;/strong&gt;","</strong>",.,fixed=T) %>%
                                   gsub("&lt;span(.+?)&gt;","<span\\1>",.) %>%
                                   gsub("&lt;/span&gt;","</span>",.)) %>%
             mutate_at(vars(-numeric_cols),
                       ~gsub("\\^([a-zA-Z0-9])","<sup>\\1</sup>",.) %>%
                         gsub("<strong>","**",.,fixed=T) %>%
                         gsub("</strong>","**",.,fixed=T) %>%
                         gsub("&lt;strong&gt;","**",.,fixed=T) %>%
                         gsub("&lt;/strong&gt;","**",.,fixed=T)),
           function(x) mutate_at(x,vars(-numeric_cols),
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
                  full_width=F)  %>%
    if_fun(!is.null(col_headers),
           . %>% add_header_above(col_headers)) %>%
    if_fun(!is.null(col_headers) & col_groups_sep,
           . %>% column_spec(header_borders,border_right = header_border_styles)) %>%
    if_fun(lscape,
           . %>% landscape(margin="2cm"),
           . %>% kable_styling(latex_options="hold_position")) %>%
    if_fun(!is.null(group_col) && !is.na(group_col),
           . %>% pack_rows(index=grp_index)) %>%
    do_colspace(numeric_cols,col_widths)%>%
    if_fun(get_format("gitbook"),
           . %>% scroll_box(width="100%",fixed_thead = T)) %>%
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



#' @export
my_kbl <- function(x,...,escape=F,font_size=NULL){
  kbl(x,...,escape=escape) %>%
  kable_styling(
    bootstrap_options = c("striped","hover"),
    latex_options="striped",
    font_size=font_size,
    full_width=F
  )
}

#'
clear_blanks <- function(x){
  x[x == str_dup(" ",nchar(x))] <- ""
  x
}

#' @export
add_numeric_cols <- function(x,...,.font_size=NULL,.digits=3){
  .cols <- enexprs(...)
  
  ws_sym <- fb("&ensp;"," ","\\\\quad")
  mutate(x,
         across(
           c(!!!.cols),
           . %>%
             justify(.,d=.digits) %>%
             clear_blanks %>%
             set_whitespace(symbol=ws_sym) %>%
             cell_spec(monospace=T,align="right",font_size=.font_size,
                       escape=F,extra_css="float:right;")
         ))
  
}

#' @export
as_caption <- function(...){
  dots <- enexprs(...)
  #dots
  out_str <- exec("str_glue",!!!dots,.sep=" ",.envir=parent.frame())
  paste0(
    fb("<font size=\"2\">","{\\small","{\\small"),
    out_str,
    fb("</font>","}","}")
  )
}

