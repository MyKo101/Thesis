

#' @export
if_fun <- function(.x,.predicate,.fun,.elsefun=NULL) 
{
  if(.predicate) .fun(.x) else 
    if(!is.null(.elsefun))
      .elsefun(.x) else
        .x
}

#' @export
bind_with <- function(data,fun){
  bind_rows(data,fun(data))
}

#' @export
order_vect <- function(...){
  dots  <- enexprs(...)
  dots_str <- vapply(dots,as_string,character(1))
  set_names(1:length(dots_str),dots_str)
}


#' @export
do_nothing <- function(x) x



#' @export
mutate_where <- function(x,predicate,...){
  
  full_x <- mutate(x,..row_ids = 1:n())
  
  .predicate <- enquo(predicate)
  
  predicated_x <- filter(full_x,!!.predicate)
  other_x <- filter(full_x,!(!!.predicate)|is.na(!!.predicate))
  
  mutated_x <- mutate(predicated_x,!!!enquos(...))
  
  return_x_unsorted <- bind_rows(mutated_x,other_x)
  
  return_x_sorted <- arrange(return_x_unsorted,..row_ids)
  
  select(return_x_sorted,-..row_ids)
}
