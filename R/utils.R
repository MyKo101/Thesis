

#' @export
if_fun <- function(.x,.predicate,.fun,.elsefun=NULL) 
{
  if(.predicate) .fun(.x) else 
    if(!is.null(.elsefun))
      .elsefun(.x) else
        .x
}



#' @export
do_nothing <- function(x) x

