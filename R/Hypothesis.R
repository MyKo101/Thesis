
#' @export
Pull_Comments <- function(filenum,return=F)
{
  .dirs <- get.files(filenum) %>%
    gsub("(.*?)-","",.) %>%
    gsub(".Rmd","",.) %>%
    gsub("_","-",.) %>%
    paste0("chap-",.,".html")
  
  .dirs <- list.files("docs") %>%
    .[tolower(.) %in% tolower(.dirs)]
  
  .pull <- .dirs %>%
    paste0("https://michaelbarrowman.co.uk/Thesis/",.) %>%
    map_dfr(~hypothesisr::hs_search_all(uri=.)) 
  
  if(nrow(.pull) == 0)
  {
    warning("No Comments Found",call.=F)
    return(NULL)
  } else {
    .pull %>%
    separate("user",into=c(NA,"user",NA),sep="[:@]") %>%
    #filter(user != "myko101") %>%
    mutate(src =  gsub("https://michaelbarrowman.co.uk/Thesis/chap-","",uri,fixed=T),
           src = gsub(".html","",src,fixed=T),
           position = map_int(target,~Pull_Target_detail(.,"position")),
           source = map_chr(target,~Pull_Target_detail(.,"text")),
           Done = map_lgl(tags,~"Done" %in% .),
           Replied = map_lgl(tags,~"Replied" %in% .),
           dt = as_datetime(created),
           has.parent = map_lgl(references,~!is.null(.)),
           Current = row_number() == which(!Done & !Replied & !has.parent)[1]) %>%
    select(id,dt,src,user,position,source,references,text,Done,Replied,has.parent,Current) %>%
    arrange(position) %>%
    assign(".comlist",.,envir=global_env())
    
  }
  
  if(return)
    return(.comlist)
  else
    Show_Comment()
}

#' @export
Pull_Target_detail <- function(target,detail)
{
  # details = c("position","text")
  if(length(target)<2)
  {
    res <- NA
  } else {
    selector <- target[[2]][[1]]
    if(detail == "position")
    {
      res <- min(selector$startOffset,na.rm=T)
    } else if(detail == "text")
    {
      res <- selector %>%
        filter(!is.na(prefix) & !is.na(exact) & !is.na(suffix)) %>%
        mutate(exact = if_else(exact == " ","**",exact)) %>%
        transmute(text = str_glue(
          "{prefix}<strong>{exact}</strong>{suffix}")) %>%
        slice(1) %>%
        pull(text)
    }
  }
  
  return(res)
}


#' @export
Current_html <- function(comlist)
{
  Parent <- comlist %>%
    filter(Current)
  
  cID <- Parent$id
  
  Children <- comlist %>%
    mutate(child = map_lgl(references,~cID %in% .)) %>%
    filter(child)
  
  
  header <- paste0("<html>
            <head>
              <style>
                table, th, td {
                  border: 1px solid black;
                }
              </style>
            </head>",
                   if(Parent$Replied)"Replied!",
            "<body>
              <table>")
  
  if(Parent$Replied)
    header <- paste0()
  
  footer <- "</table>
            </body>"
  
  parent_glue <- "
      <tr>
        <th>{{src}}</th>
        <th>{{user}}</th>
      </tr>
      <tr>
        <td colspan=\"2\">{{source}}</td>
      </tr>
      <tr>
        <td colspan=\"2\">{{text}}</td>
      </tr>"
  
  child_glue <- "
      <tr>
        <td><strong>{{user}}</strong></td>
      </tr>
      <tr>
        <td>{{text}}</td>
      </tr>"
  
  html.out <- Parent %>%
    str_glue_data(parent_glue,.open="{{",.close="}}") %>%
    paste0(header,.)
  if(nrow(Children)>0)
  {
    html.out <- Children %>%
      str_glue_data(child_glue,.open="{{",.close="}}") %>%
      paste0(collapse="\n") %>%
      paste0("<tr><td colspan=\"2\"><table style=\"width:100%\">",.,"</table></tr></td>") %>%
      paste0(html.out,.)
  }
  html.out <- paste0(html.out,footer)
  
  
  return(html.out)
  
}



#' @export
Show_Comment <- function()
{
  tfile <- tempfile(fileext=".html")
  .comlist %>%
    Current_html %>%
    writeLines(tfile)
  rstudioapi::viewer(tfile)
}

#' @export
Done_Comment <- function()
{
  cCom <- .comlist %>% 
    filter(Current) %>%
    rename(Username = user) %>%
    left_join(
      read_csv("data/Hypothesis.csv",col_types=cols()),
      by="Username")
  
  hs_update(token=cCom$token,
            id = cCom$id,
            tag = "Done")
  
  .comlist %>%
    mutate(Done = if_else(Current,T,Done)) %>%
    assign(".comlist",.,envir=global_env())
  
  
  Skip_Comment()
  
}

#' @export
Skip_Comment <- function(include.Replies = F)
{
  if(include.Replies)
    .possibles <- which(!.comlist$Done & !.comlist$has.parent)
  else
    .possibles <- which(!.comlist$Done & !.comlist$Replied & !.comlist$has.parent)
    
    
    
  .possibles_after <- .possibles[.possibles > which(.comlist$Current)]
  if(length(.possibles_after) == 0)
  {
    .possibles_after <- .possibles
  }
  
  .comlist %>%
    mutate(Current = row_number() == .possibles_after[1]) %>%
    assign(".comlist",.,envir=global_env())
  
  Show_Comment()
    
}

#' @export
Reply_Comment <- function(reply)
{
  mytoken <- read_csv("data/Hypothesis.csv",
                      col_types=cols()) %>%
    filter(Username == "myko101") %>%
    pull(token)
  
  uri <- paste0("https://michaelbarrowman.co.uk/Thesis/chap-",.comlist$src[.comlist$Current],".html")
  
  cCom <- .comlist %>% 
    filter(Current) %>%
    rename(Username = user) %>%
    left_join(
      read_csv("data/Hypothesis.csv",col_types=cols()),
      by="Username")
  
  hs_create(token = mytoken,
            uri=uri,
            user = "acct:myko101@hypothes.is",
            text = reply,
            custom=list(references = cCom$id)
            )
  
  
  hs_update(token=cCom$token,
            id = cCom$id,
            tag = "Replied")
  
  .comlist$Replied[.comlist$Current] <- T
  
  assign(".comlist",.comlist,envir=global_env())
  
  Skip_Comment()
}

#' @export
Progress_Comment <- function()
{
  .comlist %>%
    filter(!has.parent) %>%
    mutate(Status = case_when(Done ~ "Done",
                              Replied ~ "Replied",
                              T~"To Be Done")) %$%
    table(Status)
}


#' @export
Update_Comments <-function()
{
  for(i in 1:10)
  {
    Pull_Comments(i)
    To_Be_Deleted <- .comlist %>%
      filter(Done)
    if(nrow(To_Be_Deleted) > 0)
    {
      To_Be_Deleted %>%
        rename(Username = user) %>%
        left_join(read_csv("data/Hypothesis.csv",col_types=cols()),
                  by="Username") %>%
        split(1:nrow(.)) %>%
        map(~hs_delete(.$token,.$id))
    }
  }
}