pkgs <- c("devtools","thesisdown","tidyverse","rlang","flextable",
          "googledrive")

purrr::walk(pkgs,library,character.only=T)

xx <- function(x = "xxxx") paste0("[**",x,"**]")
cc <- function(x="Something") xx(paste0("Cite: ",x))
LR <- function(...) cc(paste0("LR - ",paste0(unlist(list(...)),collapse=", ")))


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

as_equation <- function(x,i=NULL,j=NULL,nickname)
{
  require(flextable)
  require(png)
  fnum <- 0
  
  ff <- list.files("codecogs")
  
  ff <- ff[grep(paste0("^",nickname),ff)]
  
  if(length(ff) > 0 )
    file.remove(paste0("codecogs/",ff))
  
  
  i <- flextable:::get_rows_id(x[["body"]], i)
  j <- flextable:::get_columns_id(x[["body"]], j)
  
  for(i0 in i) for(j0 in j)
  {
    fnum <- fnum + 1
    eqn <- x$body$dataset[i0,j0]
    eqn <- gsub("\\","%5C",eqn,fixed=T)
    eqn <- gsub(" ","",eqn,fixed=T)
    
    webaddress <- paste0("https://latex.codecogs.com/png.latex?",eqn)
    dir <- paste0("codecogs/",nickname," - ",fnum,".png")
    
    download.file(webaddress,dir,mode="wb",quiet=T)
    
    img <- readPNG(dir)
    
    cell.h <- dim(x)$heights[i0]
    cell.w <- dim(x)$widths[j0]
    cell.ar <- cell.w/cell.h
    
    h <- dim(img)[1]
    w <- dim(img)[2]
    ar <- w/h
    
    if(cell.ar < ar)
    {
      res.h <- cell.h
      res.w <- cell.h*ar
    } else{
      res.w <- cell.w
      res.h <- cell.w/ar
    }
    
    x <- compose(x,i0,j0,part="body",
                 value=as_paragraph(as_image(src=dir,height=res.h,width=res.w)))
  }
  
  return(x)
}


