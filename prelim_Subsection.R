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