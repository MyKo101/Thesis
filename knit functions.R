
write_chapter_rmd <- function(.file,output="pdf")
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  if(is.numeric(.file))
  {
    if(.file <10) .file <- paste0("0",.file) else .file <- paste0(.file)
    ff <- list.files()
    .file <- ff[grep(paste0("^",.file),ff)]
    if(length(.file)>1)
    {
      .supp <- .file[grep("[0-9]{2}[a-z]",.file)]
      .file <- .file[-grep("[0-9]{2}[a-z]",.file)]
      .supp <- sort(.supp)
    } else .supp <- NULL
  } else .supp <- NULL
  rmd <- readLines(.file)
  
  if(!is.null(.supp))
  {
    rmd.supp <- lapply(.supp,readLines)
    rmd.supp <- unlist(rmd.supp)
  } else rmd.supp <- NULL
  
  
  latex.commands <- readLines("latex_commands.tex")
  
  latex.slash <- grep("^\\\\",latex.commands)
  
  latex.commands[ latex.slash] <- paste0(" - ",latex.commands[ latex.slash])
  latex.commands[-latex.slash] <- paste0("   ",latex.commands[-latex.slash])
  
  title <- rmd[grep("^# ",rmd[1:3])]
  title <- substring(title,1,regexpr("{",title,fixed=T)[[1]]-1)
  title <- trimws(gsub("#","",title,fixed=T))
  
  title <- paste0("title: ",title)

  replace_figs <- function(x)
  {
    figure.lines <- grep("include_graphics(\"",x,fixed=T)
    if(length(figure.lines) > 0)
    {
      x[figure.lines] <- gsub("include_graphics(\"",
                                "include_graphics(\"../",
                                x[figure.lines],
                                fixed=T)
    }
    
    return(x)
  }
  
  rmd <- replace_figs(rmd)
  
  
  if(!is.null(.supp))
  {
    rmd.supp <- replace_figs(rmd.supp)
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
    "header-includes:",
    latex.commands,
    "---",
    "```{r setup, include=F}",
    "source(\"../setup.R\")",
    "```",
    "<style>",
    "caption {",
    "  display: table-caption;",
    "  text-align: center;",
    "}",
    "</style>"
    
  )
  
  rmd <- rmd[-grep("^# ",rmd[1:3])]
  
  rmd <- gsub("^#","",rmd)
  
  in.ref <- grep("^# References",rmd)
  
  if(length(in.ref) == 0 & !is.null(.supp))
  {
    rmd <- c(rmd,"# References","<div id=\"refs\"></div>","")
  } else if(length(in.ref)>0)
  {
    rmd <- append(rmd,c("", "<div id=\"refs\"></div>",""),after=in.ref)
  } else 
  {
    rmd <- c(rmd,"","# References","")
  }
  
  
  rmd <- c(header,rmd,rmd.supp)
  
  writeLines(rmd,paste0("Chapters/",.file))
  
  return(paste0("Chapters/",.file))
  
}

knit_chapter <- function(.file,output="pdf")
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  out.file <- write_chapter_rmd(.file,output)
  
  rmarkdown::render(out.file)
  return(out.file)
}

knit_all_chapters <- function(output="pdf")
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  ff <- list.files()
  ff <- ff[grep("^[0-9]{2}",ff)]
  ff <- unique(substring(ff,1,2))
  ff <- as.numeric(ff)
  ff <- ff[ff!=0 & ff != 99]
  
  out.files <- lapply(ff,knit_chapter,output=output)
  out.files <- unlist(out.files)
  return(out.files)
  
}

knit_to_Google <- function(.file,out=F)
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  out.file <- knit_chapter(.file,"word")
  
  file.title <- gsub("_"," ",gsub(".Rmd","",gsub("^[0-9]{2}-","",basename(out.file))),fixed=T)
  
  file.docx <- gsub(".Rmd",".docx",out.file)
  
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
  
  
  if(out) return(drib)
  
  
  
}

knit_all_Google <- function()
{
  setwd("C:/Users/mbrxsmbc/Documents/Thesis/index/")
  ff <- list.files()
  ff <- ff[grep("^[0-9]{2}",ff)]
  ff <- unique(substring(ff,1,2))
  ff <- as.numeric(ff)
  ff <- ff[ff!=0 & ff != 99]
  
  docs <- map_dfr(ff,knit_to_Google,out=T)
  return(docs)
}


