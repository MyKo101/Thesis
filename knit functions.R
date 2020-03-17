
write_chapter_rmd <- function(.file,output="pdf")
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
  
  figure.lines <- grep("include_graphics(\"",rmd,fixed=T)
  if(length(figure.lines) > 0)
  {
    rmd[figure.lines] <- gsub("include_graphics(\"",
                              "include_graphics(\"../",
                              rmd[figure.lines],
                              fixed=T)
  }
  
  if(output == "pdf")
  {
    output.header <- c("output:",
                       "  bookdown::pdf_document2")
  } else if(output=="word")
  {
    
    output.header <- c("output:",
                       "  bookdown::word_document2:",
                       "    reference_docx: Ref.docx")
  } else
  {
    output.header <- c("output:",
                       paste0("  bookdown::",output))
  }
  
  
  header <- c(
    "---",
    title,
    "bibliography: ../bib/thesis.bib",
    "csl: ../csl/ieee.csl",
    "number_sections: true",
    output.header,
    "---",
    "```{r setup, include=F}",
    "source(\"../setup.R\")",
    "```",
    "\\include{latex_commands.txt}",
    "<style>",
    "caption {",
    "  display: table-caption;",
    "  text-align: center;",
    "}",
    "</style>"
    
  )
  
  rmd <- rmd[-grep("^# ",rmd[1:3])]
  
  rmd <- gsub("^#","",rmd)
  
  rmd <- c(header,rmd,"","# References","")
  
  writeLines(rmd,paste0("Chapters/",.file))
  
}

knit_chapter <- function(.file,output="pdf")
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

knit_all_chapters <- function(output="pdf")
{
  ff <- list.files()
  ff <- ff[grep("^[0-9]",ff)]
  ff <- ff[-grep("^(00|99)",ff)]
  
  for(iff in ff) write_chapter_rmd(iff,output)
  
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/Chapters")
  for(iff in ff) rmarkdown::render(iff)
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
}

knit_to_Google <- function(.file,out=F)
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  if(is.numeric(.file))
  {
    if(.file <10) .file <- paste0("0",.file) else .file <- paste0(.file)
    ff <- list.files()
    .file <- ff[grep(.file,ff)]
  }
  knit_chapter(.file,"word")
  
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
  
  if(out) return(drib)
  
  
  
}

knit_all_Google <- function()
{
  ff <- list.files()
  ff <- ff[grep("^[0-9]",ff)]
  ff <- ff[-grep("^(00|99)",ff)]
  
  docs <- map_dfr(ff,knit_to_Google,out=T)
  return(docs)
}




