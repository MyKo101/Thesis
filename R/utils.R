
#' @export
logit <- function(p) log(p/(1-p))

#' @export
logit1 <- function(o) exp(o)/(exp(o)+1)


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
