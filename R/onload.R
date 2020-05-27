.onLoad <- function(libname, pkgname)
{
  pkgs <- c("devtools","rlang",
    "bookdown","thesisdown","rmarkdown",
    "knitr","kableExtra",
    "dplyr","ggplot2","lubridate","stringi","stringr",
    "tibble","readr","tidyr","purrr","forcats",
    "magrittr","mutils")
  purrr::walk(pkgs,library,character.only=T)
  options(kableExtra.html.bsTable = T)
  options(output.format = "gitbook")
}
