
#'@export
list_map <- function(type=NULL,n=3){
  if(!is.null(type)){
    fun <- sym(str_glue("map_{type}"))
  } else {
    fun <- quote(map)
  }
  
  map(1:n,
        ~new_formula(NULL,call2(fun,quote(`.`),.))) %>%
  set_names(1:n)
}

#'@export
Print_Scenario_Table <- function(){
  df <- tribble(
    ~Sc, ~g1, ~g2,       ~B1,       ~B2, ~pi, ~k,
    1,   0,   0, c(-1,0,1),         0,   0,1,
    2,  -1,  -1, c(-1,0,1),         0,   0,1,
    3,  -1,   1, c(-1,0,1),         0,   0,1,
    4,   0,   0,         0, c(-1,0,1),   0,1,
    5,   0,   0,         0,         0,   1,1,
    6,   0,   0,         1,         0,   0,c(0,1,2),
    7,   0,   0, c(-1,0,1),         0,   0,1,
    8,   0,   0, c(-1,0,1),         0,   0,1
  ) %>%
    mutate(pi = if_else(pi == 1,
                        list(c("$\\sfrac{1}{10}$",
                               "$\\sfrac{1}{2}$",
                               "$\\sfrac{9}{10}$")),
                        list("$\\sfrac{1}{2}$")),
           rho = if_else(Sc == 5,
                         list(c(0,0.14,0.29,0.42,0.57)),
                         list(c(0,0.2,0.4,0.6,0.8))),
           Baseline = case_when(Sc == 7 ~ "Weibull",
                                Sc == 8 ~ "Plausible",
                                T ~ "Constant"),
           across(B1:k,
                  ~if_else(vapply(.,length,numeric(1)) == 3,.,
                           map(.,~c(NA,.,NA)))),
           across(c(B1,B2,k),list_map("dbl",3)),
           across(starts_with(c("B1_","B2_","k_")),justify,d=0),
           across(rho,list_map("dbl",5)),
           across(starts_with("rho_"),justify,d=2),
           across(pi,list_map("chr",3)),
           across(starts_with("pi_"),justify),
           k_1 = if_else(k_1 == "0","$\\sfrac{1}{2}$",k_1)) %>%
    select(Sc,
           starts_with("rho"),-rho,
           Baseline,
           starts_with("B1"),-B1,
           starts_with("B2"),-B2,
           starts_with("pi"),-pi,
           starts_with("k"),-k)
  
  nms <- names(df) %>%
    str_replace_all("_(\\d+)","") %>%
    str_replace_all("B(\\d)","$\\\\beta_\\1$") %>%
    str_replace_all("(^rho$|^pi$)","$\\\\\\1$") %>%
    str_replace_all("^k$","$k$")
  
  nms <- table(nms)[unique(nms)]
    
    
  my_kbl(df,
         caption=as_caption("Details of parameters for each Scenario"),
         col.names=rep("",ncol(df))) %>%
    add_header_above(nms)
}

         

#' @export
Print_CRConf_Res <- function(ScNum){

  res_file <- here::here("figure","CR_Conf",
                         str_glue("Sc {ScNum} Res.png"))
  leg_file <- here::here("figure","CR_Conf",
                         str_glue("Sc {ScNum} Res leg.png"))
  
  leg_scale <- 2.5
  buffer_width <- 30
  plot_ratio <- 1.4
  
  res_png <- png::readPNG(res_file)
  leg_png <- png::readPNG(leg_file)
  
  res_width <- ncol(res_png)
  leg_width <- ncol(leg_png)*leg_scale
  
  res_height <- nrow(res_png)
  leg_height <- nrow(leg_png)*leg_scale
  
  plot_width <- res_width + leg_width + buffer_width
  plot_height <- res_height
  
  frame_height <- plot_width/plot_ratio
  
  plot_bottom <- (frame_height -plot_height)/2
  
  op <- par(mar = rep(0,4))
  
  plot(NULL,xlim=c(0,plot_width),ylim=c(0,frame_height),
       axes=F,xlab="",ylab="")
  
  rasterImage(res_png,
              0,
              plot_bottom,
              res_width,
              plot_bottom + res_height)
  rasterImage(leg_png,
              res_width + buffer_width,
              plot_bottom + res_height/2 - leg_height/2,
              res_width + buffer_width + leg_width,
              plot_bottom + res_height/2 + leg_height/2)
  
  par(op)
}
