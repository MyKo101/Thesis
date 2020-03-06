pkgs <- c("devtools","thesisdown","tidyverse","rlang","kableExtra",
          "googledrive")

purrr::walk(pkgs,library,character.only=T)

cc <- function(x) paste0("[**Cite: ",x,"**]")

xx <- function(x = "xxxx") paste0("[**",x,"**]")

write_chapter_rmd <- function(.file,output="rmarkdown::pdf_document")
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  if(is.numeric(.file))
  {
    if(.file <10) .file <- paste0("0",.file) else .file <- paste0(.file)
    ff <- list.files()
    .file <- ff[grep(.file,ff)]
  }
  rmd <- readLines(.file)
  
  title <- rmd[grep("^# ",rmd[1:3])]
  title <- substring(title,1,regexpr("{",title,fixed=T)[[1]]-1)
  title <- trimws(gsub("#","",title,fixed=T))
  
  title <- paste0("title: ",title)
  
  header <- c(
    "---",
    title,
    "bibliography: ../bib/thesis.bib",
    "csl: ../csl/ieee.csl",
    "number_sections: true",
    "output:",
    paste0("  ",output),
    "---",
    "```{r setup, include=F}",
    "source(\"../setup.R\")",
    "```"
  )
  
  rmd <- rmd[-grep("^# ",rmd[1:3])]
  
  rmd <- gsub("^#","",rmd)
  
  rmd <- c(header,rmd,"","# References","")
  
  writeLines(rmd,paste0("Chapters/",.file))
}

knit_chapter <- function(.file,output="rmarkdown::pdf_document")
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  if(is.numeric(.file))
  {
    if(.file <10) .file <- paste0("0",.file) else .file <- paste0(.file)
    ff <- list.files()
    .file <- ff[grep(.file,ff)]
  }
  write_chapter_rmd(.file,output)
  
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/Chapters")
  rmarkdown::render(.file)
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
}

knit_all_chapters <- function(output="rmarkdown::pdf_document")
{
  ff <- list.files()
  ff <- ff[grep("^[0-9]",ff)]
  ff <- ff[-grep("^(00|99)",ff)]
  
  for(iff in ff) write_chapter_rmd(iff,output)
  
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/Chapters")
  for(iff in ff) rmarkdown::render(iff)
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
}

knit_to_Google <- function(.file,output=F)
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  if(is.numeric(.file))
  {
    if(.file <10) .file <- paste0("0",.file) else .file <- paste0(.file)
    ff <- list.files()
    .file <- ff[grep(.file,ff)]
  }
  knit_chapter(.file,output="rmarkdown::word_document")
  
  file.title <- gsub("_"," ",gsub(".Rmd","",gsub("^[0-9][0-9]-","",.file)),fixed=T)
  
  file.docx <- paste0("Chapters/",gsub(".Rmd",".docx",.file))
  
  if(nrow(drive_find(file.title))==0)
  {
    drib <- drive_upload(media=file.docx,path="Thesis",name=file.title,type="document")
    cat("\nNew File Created (sharing may be not be active)")
  } else {
    drib <- drive_update(file=file.title,media=file.docx)
    cat("\nUpdated file on Google Docs")
  }
  
  cat("\n\nShareable Link for ",file.title,":\n\t",
      "https://docs.google.com/document/d/",drib$id,"/edit?usp=sharing",sep="")
  
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  
  if(output) return(drib)
    
    
  
}

knit_all_Google <- function()
{
  ff <- list.files()
  ff <- ff[grep("^[0-9]",ff)]
  ff <- ff[-grep("^(00|99)",ff)]
  
  docs <- map_dfr(ff,knit_to_Google,output=T)
  return(docs)
}




