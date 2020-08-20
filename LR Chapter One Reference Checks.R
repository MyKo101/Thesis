
#library(tesseract)
#eng <- tesseract("eng")
#old_paper_filename <- "First Year LR.pdf"
#Chapter_One <- tesseract::ocr(old_paper_filename,engine=eng)
#full_text <- paste(unlist(Chapter_One),collapse="\n\n\n")
#writeLines(full_text,"First Year LR.txt") 
#file.remove(list.files(pattern="First Year LR_.*.png"))

mutils::load_packages(tidyverse,magrittr)

#11
curly_quotes <- "First Year LR.txt" %>%
  readLines %>%
  extract(49) %>%
  list(text=.,chars=c(11,37)) %$%
  map2_chr(.x = text,.y=chars,.f = ~substring(.x,.y,.y)) %>%
  paste0(collapse='')


res <- "First Year LR.txt" %>%
  readLines %>%
  tail(461) %>%
  paste0(collapse="\n") %>%
  strsplit("\n\n") %>%
  extract2(1) %>%
  gsub("\n"," ",.) %>%
  tibble(raw = . ) %>%
  filter(nchar(raw) > 5) %>%
  mutate(rn = row_number(),
         stretch = map(row_number(),
                       ~if(. == 96){
                         strsplit(raw[96],"[",fixed=T)[[1]][-1]
                         } else {
                           raw[.]
                         } )) %>%
  group_by(raw,rn) %>%
  expand(stretch = unlist(stretch)) %>%
  arrange(rn) %>%
  ungroup %>%
  mutate(start_string = substring(stretch,1,5),
         num = as.integer(gsub("[^0-9.]","",start_string)),
         rn = row_number()) %>%
  mutate(num = case_when(rn < 100 & rn == num - 100 ~ rn,
                         num > 1000 & rn == num - 1000 ~ rn,
                         num != rn ~ -99L,
                         num == rn ~ num)) %>%
  mutate(stretch = gsub(paste0("[",curly_quotes,"]"),"\"",stretch)) %>%
  mutate(ref = "") %>%
  select(num,ref,stretch)

#write_csv(res,"First Year References.csv")


library(bibtex)

bibliography <- read.bib("bib/thesis.bib")

in_bib <- tibble(cite_reference = names(bibliography),
                 `in bib` = T)

filename <- "First Year References.csv"
filename %>%
  read_csv(col_types = cols()) %>%
  select(-`in bib`) %>%
  mutate(sub2 = if_else(sub != ""& !is.na(sub), paste0("-",sub),""),
         blank_CR = is.na(cite_reference) | (cite_reference == ""),
         cite_reference = 
           if_else(blank_CR,
                   as.character(str_glue("{Author}_{Pretitle}_{Year}{sub2}")),
                   cite_reference)) %>%
  left_join(in_bib,by="cite_reference") %>%
  mutate(`in bib` = replace_na(`in bib`,FALSE)) %>%
  mutate(cite_reference = if_else(blank_CR & !`in bib`,NA_character_,cite_reference)) %>%
  select(-sub2,-blank_CR) %>%
  mutate(cite_reference = if_else(cite_reference == "NA_NA_NA","",cite_reference)) %>%
  mutate(across(c(Author,Pretitle,Year,sub),replace_na,replace="")) %T>%
  write_csv(filename) %>%
  filter(!`in bib`) %>%
  
  slice(1:10) %>%
  pull(stretch) %>%
  substring(5,nchar(.)) %>%
  map(URLencode) %>%
  paste0("https://scholar.google.co.uk/scholar?q=",.) %>%
  map(browseURL)



## Processing the Lit Report and replacing LR citations

get_citation <- function(cites){
  
  cites_flat <- as.numeric(strsplit(cites,",")[[1]])
  
  refs <- read_csv("First Year References.csv",col_types = cols())
  
  refs_found <- refs$cite_reference[cites_flat]
  
  if(any(is.na(refs_found))){
    na_cites <- paste(cites_flat[is.na(refs_found)],collapse=", ")
    mutils::glue_warn("Citation(s): {na_cites} returned an NA reference")
    paste0("<",cites,">")
  } else {
    paste0("[",paste0("@",refs_found,collapse=";"),"]")
  }
}

get_citations <- function(cites){
  if(length(cites) == 0)
  {
    character(0)
  } else {
    map_chr(cites,get_citation)
  }
}

Process_Lit_Report <- function(from=1,to=length(Chapter_One)){
  Chapter_One <- readLines("01-Lit_Report.Rmd")
  
  pre_text <- Chapter_One[1:(from-1)]
  post_text <- Chapter_One[(to+1):length(Chapter_One)]
  
  cText <- Chapter_One[from:to] %>%
    paste0(collapse="\n") %>%
    strsplit("\n\n") %>%
    extract2(1) %>%
    gsub("\n"," ",.) %>%
    gsub("\v","ff",.) %>%
    gsub("\f","fi",.) %>%
    paste0(collapse="\n\n")
  
  cite_nums <- cText %>%
    str_extract_all("(?<=<)[0-9,]*(?=>)") %>%
    extract2(1) %>%
    unique
  
  replacements <- get_citations(cite_nums)
  
  cite_replacements <- data.frame(cites = paste0("<",cite_nums,">"),
                                  refs = replacements) %>%
    split(1:nrow(.))
  
  res <- reduce(.init=cText,.x=cite_replacements,
              function(x,y) str_replace_all(x,y[["cites"]],y[["refs"]]))
  
  writeLines(c(pre_text,strsplit(res,"\n")[[1]],post_text),
             "01-Lit_Report.Rmd")
  
}

Check_for_missing_cites <- function(replace=F){
  Chapter_One <- readLines("01-Lit_Report.Rmd")
  missing_df <- tibble(line = 1:length(Chapter_One)) %>%
    mutate(missing_cites = str_extract_all(Chapter_One,"[a-zA-Z]+[0-9]+(,[0-9]+)*"),
           missing_cites = map(missing_cites,missing_cites_ignore),
           n_missing = map_int(missing_cites,length)) %>%
    filter(n_missing>0) %>%
    select(line,missing_cites) %>%
    unnest(missing_cites)
  
  
  
  if(replace){
    res <- missing_df %>%
      mutate(replacements = str_replace(missing_cites,"([0-9,]+$)","<\\1>"))
    for(i in 1:nrow(res)){
      Chapter_One <- gsub(res$missing_cites[i],
                          res$replacements[i],
                          Chapter_One)
    }
    res <- res %>%
      str_glue_data("On line: {line}, \"{missing_cites}\" replaced with \"{replacements}\"")
    
    writeLines(Chapter_One,"01-Lit_Report.Rmd")
  } else {
    res <- missing_df %>%
      str_glue_data("On line: {line}, the text \"{missing_cites}\" appears")
    if(length(res) == 0)
      res <- glue::glue("No possible missing citations found. Congrats!")
  }
  print(res)
}

missing_cites_ignore <- function(x){
  ignore <- c("QRISK2","QRISK3")
  x[!x%in%ignore]
}

fix_LR_cites <- function(replace = F){
  Chapter_One <- readLines("01-Lit_Report.Rmd")
  
  cite_df <- Chapter_One %>%
    str_extract_all("(?<=<)[0-9,]*(?=>)") %>%
    unlist %>%
    unique %>%
    tibble(old = .) %>%
    mutate(new = get_citations(cite_nums)) %>%
    mutate(old = paste0("<",old,">")) %>%
    filter(new != old)
  
  for(i in 1:nrow(cite_df)){
    Chapter_One <- gsub(cite_df$old[i],
                        cite_df$new[i],
                        Chapter_One,
                        fixed=T)
  }
  
  writeLines(Chapter_One,"01-Lit_Report.Rmd")
  
}







Check_for_missing_cites(T)

Process_Lit_Report(111,125)




x <- "This is3 a test4, I would like5,6 to pull10,11 out the words with numbers, but not just commas32,43,101"

this_reg <- "[a-zA-Z]+[0-9]+(,[0-9]+)*"

str_extract_all(x,this_reg)




x <- "Here is a cite[@auth;@p_] and here is a missing cite4 and another5"

str_extract_all(x,"[^\\s][0-9]")
