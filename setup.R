pkgs <- c("devtools","thesisdown","tidyverse","rlang","kableExtra",
          "googledrive")

purrr::walk(pkgs,library,character.only=T)

cc <- function(x) paste0("[**Cite: ",x,"**]")

xx <- function(x = "xxxx") paste0("[**",x,"**]")
