pkgs <- c("devtools","thesisdown","tidyverse","rlang","flextable",
          "googledrive")

purrr::walk(pkgs,library,character.only=T)

xx <- function(x = "xxxx") paste0("[**",x,"**]")
cc <- function(x) xx(paste0("Cite: ",x))
LR <- function(x) cc(paste0("LR - ",x))


logit <- function(p) log(p/(1-p))
logit1 <- function(o) exp(o)/(exp(o)+1)

.wd <- "C:/Users/mbrxsmbc/Documents/Thesis/index/"

add_flextable_caption <- function(ref,caption)
{
  cat("<caption>(\\#tab:",ref,") ",caption,"</caption>",sep="")
}

stardard_format_table <- function(x,numeric.cols=NULL,widths=NULL)
{
  x.new <- x %>%
    theme_zebra(odd_header="cornflowerblue") %>%
    color(part="header",color="white") %>%
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

collapse_footer <- function(x,sep="; ",footer.height=NULL)
{
  old.content <- x$footer$content$content$data
  
  new.content <- list()
  
  sep.content <- old.content[1,1][[1]][1,]
  sep.content$txt <- sep
  sep.content$vertical.align <- NA
  
  
  for(i in 1:(nrow(old.content)-1))
  {
    old.content[i,1][[1]] <- rbind(old.content[i,1][[1]],sep.content)
  }
  
  new.content[[1]] <- do.call(rbind,old.content[,1])
  new.content[[1]]$seq_index <- 1:nrow(new.content[[1]])
  
  for(i in (2:ncol(old.content))) new.content[[i]] <- old.content[1,i][[1]]
  
  dim(new.content) <- c(1,ncol(old.content))
  
  colnames(new.content) <- colnames(old.content)
  
  x$footer$content$content$data <- new.content
  
  x <- merge_at(x,part="footer")
  
  if(is.null(footer.height)) footer.height = tail(dim(x)$heights,1)
  x <- height(x,height=0,part="footer")
  x <- height(x,i=1,height=footer.height,part="footer")
  
  x
  
}

Dev_Valid_Paper_Var_Names <- function(.tbl,.variable)
{
  .tbl %>% 
    mutate(!!enquo(.variable) := case_when(
      !!enquo(.variable) == "eGFR.Rate" ~ "eGFR Rate",
      !!enquo(.variable) == "log.eGFR.Rate" ~ "log(eGFR Rate",
      !!enquo(.variable) == "uPCR.Rate" ~ "uPCR Rate",
      !!enquo(.variable) == "log.uPCR.Rate" ~ "log(uPCR Rate",
      !!enquo(.variable) == "Calcium" ~ "Corrected Calcium",
      T ~ !!enquo(.variable)))
}




