#' @name 
#' Functions
#' 
#' @title 
#' Functions exported
#' 
#' @description 
#' All functions used in development of thesis
#' 

#' @export
xx <- function(x = "xxxx") paste0("[**",x,"**]")

#' @export
cc <- function(x="Something") xx(paste0("Cite: ",x))

#' @export
LR <- function(...) cc(paste0("LR - ",paste0(unlist(list(...)),collapse=", ")))

#' @export
prelim_Subsection <- function(out="latex",name=NULL,prelim="00--prelim.Rmd")
{
  if(out == "latex")
    check_out_func <- knitr:::is_latex_output() else
      if(out=="html")
        check_out_func <- knitr:::is_html_output() else
          check_out_func <- T
        
        if(check_out_func)
        {
          rmd <- readLines(prelim)
          heading.lines <- grep("^## ",rmd)
          
          headings <- rmd[heading.lines]
          headings <- gsub("^##","",headings)
          headings <- gsub("{-}","",headings,fixed=T)
          headings <- trimws(headings)
          
          if(is.null(name))
            return(headings) else if(name == "all")
            {
              res <- rmd
              while(res[1] == "") res <- res[-1]
              while(res[length(res)] == "") res <- res[-length(res)]
              res <- trimws(res)
              
              res <- paste0(res,collapse="\n")
              
              res <- gsub("\n ##","\n##",res,fixed=T)
              
              return(res)
            } else
            {
              which.heading <- which(tolower(name) == tolower(headings))
              if(length(which.heading)==0)
                stop("Heading ",name," not found in prelim file: ",prelim)
              
              rows <- c(heading.lines[1],
                        rep(heading.lines[-1],each=2),
                        length(rmd)+1)
              rows <- matrix(rows,ncol=2,byrow=T)
              
              start.row <- rows[which.heading,1]+1
              end.row <- rows[which.heading,2]-1
              
              
              row.seq <- seq(start.row,end.row)
              
              res <- rmd[row.seq]
              while(res[1] == "") res <- res[-1]
              while(res[length(res)] == "") res <- res[-length(res)]
              res <- trimws(res)
              res <- paste0(res,collapse="\n  ")
              res <- gsub("\n  \n","  \\par\n  \n",res,fixed=T)
              return(res)
              
            }
        } else " "
}

#' @export
get_format <- function(...)
{
  .res <- options("output.format")$output.format
  
  x <- list(...)
  if(length(x) == 0)
  {
    return(.res)
  } else
  {
    return(.res %in% unlist(x))
  }
  
}

#' @export
fb <- function(gitbook=NULL,thesis=NULL,single=NULL)
{
  .res <- ""
  if(get_format("gitbook") & !is.null(gitbook)) .res <- gitbook
  if(get_format("thesis") & !is.null(thesis)) .res <- thesis
  if(get_format("single") & !is.null(single)) .res <- single
  return(.res)
}

#' @export
get.files <- function(filenum,dir=".",pre="^")
{
  filenum %>%
    ifelse(.<10,paste0("0",.),.) %>%
    paste0(pre,.) %>%
    grep(.,list.files(dir)) %>%
    extract(list.files(dir),.)
}

#' @export
add_downloads <- function(filenum)
{
  .files <- get.files(filenum,dir="docs/Chapters",pre="^ind_")
  
  .files.pdf <- .files[grep("(.)\\.pdf$",.files)]
  .files.tex <- .files[grep("(.)\\.tex$",.files)]
  .files.docx <- .files[grep("(.)\\.docx$",.files)]
  
  .res <- paste0("Download as individual paper draft: ",
                 "[pdf](Chapters/",.files.pdf,"), ",
                 "[tex](Chapters/",.files.tex,"), ",
                 "[word](Chapters/",.files.docx,")")
  fb(gitbook=.res)
}

#' @export
Updated <- function(filenum)
{
  get.files(filenum) %>%
    file.mtime %>%
    max %>%
    format("Last updated: %d %b")
}






