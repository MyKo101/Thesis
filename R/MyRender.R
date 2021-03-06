#' @name 
#' Rendering Functions
#' 
#' @title
#' Temporary knitting functions
#'
#' @description
#' functions to render my thesis
#'
#'
#' @export
go<- function(...,get.comments=F)
{
  devtools::document()
  devtools::install(upgrade="never",dependencies=T)
  library(MyThesis)
  file.edit("index.Rmd")
  
  dots <- list(...)
  dots_num <- vapply(dots,is.numeric,logical(1))
  dots_log <- vapply(dots,is.logical,logical(1))
  
  x <- dots[dots_num]
  if(length(x) == 0) x <- NULL else x <- x[[1]]
  y <- dots[dots_log]
  if(length(y) == 0) y <- NULL else y <- y[[1]]
  
  if(!is.null(x) && is.numeric(x))
  {
    x <- if(x<10) paste0("0",x) else paste0(x)
    ff <- list.files()
    ff <- ff[grep(paste0("^",x),ff)]
    if(length(ff)>0)
    {
      ff <- lapply(ff,file.edit)
    }
    if(get.comments) Pull_Comments(x)
  }
  
  if(!is.null(y) && is.logical(y) && y){
    bookdown::render_book("index.Rmd",output_format=bookdown::gitbook())
  }
}

#' @export
Gitbook_Render <- function(...,output_format=bookdown::gitbook())
{
  
  requireNamespace("bookdown",quietly=T)
  
  if(file.exists("thesis.Rmd"))
  {
    cat("thesis.Rmd found in directory\n")
    
    
    cat("Files have been updated since last render\n")
    file.remove("thesis.Rmd")
    cat("thesis.Rmd has been deleted to continue with render\n")
    Sys.sleep(1)
    
    
  }
  
  cat("Starting Render\n")
  bookdown::render_book(...,output_format = output_format,clean=F)
  
  cat("Full Thesis Rendered\n")
  cat("\n")
  
}

#' @export
MyRender <- function(...)
{
  
  requireNamespace("bookdown",quietly=T)
  
  cat("Running GitRender")
  Gitbook_Render(...,output_format="all")
  cat("\nGitRender Done. Rendering individual files\n")
  

  ff <- list.files()
  ff <- ff[grep("^[0-9]",ff)]
  

  numlist <- setdiff(unique(substring(ff,1,2)),
                     c("00","99"))
  cat("File Numbers extracted: ",numlist,"\n")


  for(i in numlist)
  {
    ff <- list.files()
    ff <- ff[grep("^[0-9]",ff)]
    cat("Starting File ",i,"\n")
    cff <- ff[grep(i,ff)]
    cat("File(s) listed:", cff,"\n")
    rmd.list <- lapply(cff,readLines)
    cat("rmd.list loaded, ",length(rmd.list)," files\n")
    rmd <- rmd.list[[1]]
    cat("Total number of rows: ",nrow(rmd)," first five rows:\n")
    cat(paste0(rmd[1:5],collapse="\n"),"\n")

    if(length(rmd.list) > 1)
    {
      rmd.list[[1]] <- c("# (APPENDIX) Appendices {-}")
      cat("Appendix line added\n")
    }



    title.row <- grep("#",rmd,fixed=T)[1]
    cat("title is on row ",title.row,"\n")
    title <- gsub("#","",rmd[title.row])
    title <- gsub("\\{.*?\\}","",title)
    title <- trimws(title)
    cat("title is ",title,"\n")

    authors.row <- title.row + 1
    cat("Checking authors on row ",authors.row,"\n")
    if(substr(rmd[authors.row],1,1) == "*")
    {
      cat("Authors found")
      authors <- rmd[authors.row]
      authors <- gsub("*","",authors,fixed=T)
      authors <- strsplit(authors,",",fixed=T)[[1]]
      authors <- trimws(authors)
      
      authors_pdf <- paste0(paste0("  - ",authors),collapse="\n")
      authors_pdf <- paste0("author:\n",authors_pdf,"\n")
      
      authors_word <- paste0(authors,collapse=", ")
      authors_word <- paste0("author: '",authors_word,"'\n")
      
      cat("\n",authors_pdf,"\n")
      cat("\n",authors_word,"\n")
    } else
    {
      cat("Authors not found\n")
      authors_pdf <- "author: 'MA Barrowman'\n"
      authors_word <- "author: 'MA Barrowman\'\n"
      authors.row <- NULL
      cat(authors_pdf,"\n")
      cat(authors_word)
    }

    pdf_output <- c("  bookdown::pdf_book:\n",
                    "    includes:\n",
                    "      in_header: [header.tex, latex_packages.txt]\n",
                    "    keep_tex: TRUE\n",
                    authors_pdf)
    word_output <- c("  bookdown::word_document2:\n",
                     "    reference_docx: reference_doc.docx\n",
                     authors_word)


    header_pre<- c("---\n",
                    "title: '",title,"'\n",
                    "knit: bookdown::render_book\n",
                    "output:\n")
    
    header_post <- c("csl: csl/ieee.csl\n",
                    "bibliography: [\"bib/thesis.bib\",\"bib/MyCites.bib\"]\n",
                    "biblio-style: \"ieee\"\n",
                    "link-citations: true\n",
                    "---\n",
                    "```{r include_packages, include = FALSE}\n",
                    "options(output.format = \"single\")\n",
                    "library(MyThesis)\n",
                    "```\n","\n",
                    "<script type=\"text/x-mathjax-config\">\n",
                    "MathJax.Hub.Config({\n",
                    "TeX: { equationNumbers: { autoNumber: \"AMS\" } }\n",
                    "});\n",
                    "</script>\n")
    header_pre <- paste0(header_pre,collapse="")
    header_post <- paste0(header_post,collapse="")
    header <- list(
      pdf = paste0(header_pre,paste0(pdf_output,collapse=""),header_post),
      docx = paste0(header_pre,paste0(word_output,collapse=""),header_post)
    )
    
    cat("Headers set\n")

    Section.Rows <- grep("^#",rmd)
    cat("# Rows extracted\n")
    cat(head(Section.Rows,30),"\n")

    Code.Chunks <- c(grep("^```\\{",rmd),
                     setdiff(grep("^```",rmd),
                             grep("^```\\{",rmd)))
    Code.Chunks <- matrix(Code.Chunks,ncol=2)
    Code.Chunks <- apply(Code.Chunks,1,function(x) x[1]:x[2])
    Code.Chunks <- c(unlist(Code.Chunks))
    cat("Code Chunk Rows Extracted\n")
    cat(head(Code.Chunks,30),"\n")

    Section.Rows <- setdiff(Section.Rows,Code.Chunks)
    cat("Section Headings Extracted\n")

    rmd[Section.Rows] <- gsub("^#","",rmd[Section.Rows])
    cat("Headings promoted\n")

    if(length(rmd.list) > 1)
    {
      cat("Multiple files were detected\n")
      title.rows <- lapply(rmd.list[-1],
                           function(x) grep("#",x,fixed=T)[1])
      title.rows <- unlist(title.rows)
      cat("Titles detected on rows ",title.rows," respectively\n")
      titles <- lapply(2:length(rmd.list),
                       function(i) rmd.list[[i]][title.row[i-1]])

      titles <- unlist(titles)
      titles <- gsub(title,"",titles)
      titles <- gsub("-","",titles)
      titles <- gsub("\\s+"," ",titles)
      cat("Titles detected in supp. material:\n")
      cat(paste0(titles,collapse="\n"),"\n")

      rmd.list[2:length(rmd.list)] <- lapply(2:length(rmd.list),
                                             function(i)
                                             {
                                               output <- rmd.list[[i]]
                                               output[title.row[i-1]] <- titles[i-1]
                                               return(output)
                                             })
      cat("Titles added into supp. material\n")
      rmd.out <- unlist(rmd.list)
      rmd.out <- c(rmd,rmd.out)
      cat("rmd merged together\n")
    } else
    {
      rmd.out <- rmd
      cat("No supp. found, so just single rmd used\n")
    }

    rmd.out <- rmd.out[-c(title.row,authors.row)]
    cat("Title and Author rows removed\n")

    rmd.out <- paste0(rmd.out,collapse="\n")
    cat("rmd compressed to single string (length = ",length(rmd.out), "nchar = ",nchar(rmd.out),")\n")

    rmd.out <- lapply(header,function(x) paste0(x,rmd.out,"\n# References {-}"))
    cat("Header added to rmd\n")

    out.name <- sapply(1:length(header),
                       function(i)
                         paste0("docs/Chapters/",
                                gsub("Rmd",names(header)[i],basename(cff)[1])))
    cat("out.name created = ",out.name,"\n")


    ind_file <- paste0("ind_",gsub(".Rmd","",basename(cff)[1]))
    cat("ind_file created = ",ind_file,"\n")

    for(j in 1:length(header))
    {
      
      temp_file <- paste0("knitting_",j,"_",basename(cff)[1])
      cat("temp_file created = ",temp_file,"\n")
      
      
      writeLines(rmd.out[[j]],temp_file)
      cat("rmd.out written to temp_file\n")
  
      current_bookdown <- c("output_dir: \"docs/Chapters\"\n",
                        "book_filename: \"",ind_file,"\"\n",
                        "rmd_files: \"",temp_file,"\"\n",
                        "delete_merged_file: true\n")
      current_bookdown <- paste0(current_bookdown,collapse="")
      cat("Current bookdown:\n\n")
      cat(current_bookdown,"\n\n")
  
      bookdown_file <- paste0("_bookdown_",i,j,".yml")
      cat("bookdown_file created = ",bookdown_file,"\n")
      writeLines(current_bookdown,bookdown_file)
      cat("current_bookdown written to bookdown_file\n")
  
      cat("Trying render_book for file number ",i," in format ",names(header)[j],"\n")
      try(bookdown::render_book(temp_file,
                                clean_envir=F,
                                config_file = bookdown_file,
                                new_session=F))
      cat("Completed render_book. Did it work?\n\n")
      if(file.exists(temp_file)) file.remove(temp_file)
      if(file.exists(gsub(".Rmd",".md",temp_file)))
        file.remove(gsub(".Rmd",".md",temp_file))
      if(file.exists(bookdown_file))
        file.remove(bookdown_file)
    }


    
    if("i" %in% ls())
      cat("Ending Render for file ",i,"\n\n\n\n") else
        cat("Ending Render for current file. i does not exist\n\n\n\n")


  }

  cat("All files rendered, deleting \"ind_\" files")
  ff <- list.files()
  ff <- ff[grep("ind_",ff,fixed=T)]
  file.remove(ff)
  
  ff <- list.files()
  ff <- ff[grep("^thesis\\.",ff)]
  file.remove(ff)


}

#' @export
html_latex_header <- function(){
  fb(
    gitbook=paste0(readLines("header.tex"),collapse="\n")
  )
}
