pkgs <- c("devtools","thesisdown","tidyverse","rlang","flextable",
          "googledrive")

purrr::walk(pkgs,library,character.only=T)

cc <- function(x) paste0("[**Cite: ",x,"**]")

xx <- function(x = "xxxx") paste0("[**",x,"**]")

.wd <- "C:/Users/mbrxsmbc/Documents/Thesis/index/"

add_flextable_caption <- function(ref,caption)
{
  cat("<caption>(\\#tab:",ref,") ",caption,"</caption>",sep="")
}

stardard_format_table <- function(x,numeric.cols=NULL,widths=NULL)
{
  x.new <- x %>%
    theme_zebra(odd_header="cornflowerblue") %>%
    fontsize(size=8) %>%
    font(part="all",font="Garamond") %>%
    padding(padding=0) %>%
    align(align="left") %>%
    border(border=officer::fp_border(color="black",width=0.5),part="all") %>%
    height(height=0.5/2.54)
  
  if(is.null(widths))
  {
    x.new <- autofit(x.new)
  } else 
  {
    x.new <- width(x.new,width=widths/2.54)
  }
  
  if(!is.null(numeric.cols))
  {
    x.new <- x.new %>%
      fontsize(j=numeric.cols,size=7) %>%
      font(j=numeric.cols,font="courier new") %>%
      align(j=numeric.cols,align="right")
      
  }
  
  return(x.new)
  
}