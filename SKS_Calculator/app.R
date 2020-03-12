
library(tidyverse)
library(shiny)
library(lubridate)

# Load up hardcoded functions
{
    LP_cd <- function(X) -0.42409*(X$DiagGroup == "Familial / hereditary nephropathies") +
        - 0.39496*(X$DiagGroup == "Glomerular disease") +
        -0.26346*(X$DiagGroup == "Miscellaneous renal disorders") +
        -0.46322*(X$DiagGroup == "Tubulointerstitial disease") +
        -0.23552*(X$Gender == "Female") +
        -0.21287*(X$SmokingStatus == "Former_3Y") +
        -0.1983*(X$SmokingStatus == "Non_Smoker") + 
        0.35638*(X$SmokingStatus == "Smoker") + 
        0.16192*X$Age - 0.00091*X$Age2 - 5.72516*X$log.Age +
        -0.3946*X$CCF - 0.28955*X$COPD - 0.07072*X$CVA + 0.12207*X$DM +
        -0.2745*X$ST + 0.10235*X$IHD- 0.16992*X$LD - 0.24625*X$MI - 0.2489*X$PVD +
        -0.04456*X$Albumin + 0.28017*X$Calcium - 0.01303*X$Haemoglobin + 0.51175*X$Phosphate  + 
        0.00668*X$DBP - 0.00126*X$SBP + 
        -0.01338*X$eGFR + 0.04289*X$log.eGFR.Rate + 
        0.1254*X$uPCR
    
    LP_cr <- function(X) 1.02938*(X$DiagGroup == "Familial / hereditary nephropathies") +
        -0.16562*(X$DiagGroup == "Glomerular disease") +
        -0.64915*(X$DiagGroup == "Miscellaneous renal disorders") +
        -0.26562*(X$DiagGroup == "Tubulointerstitial disease") +
        -0.27787*(X$Gender == "Female") +
        -0.13374*(X$SmokingStatus == "Former_3Y") +
        -0.16215*(X$SmokingStatus == "Non_Smoker") + 
        0.17563*(X$SmokingStatus == "Smoker") +
        -0.04146*X$Age - 3e-04*X$Age2 + 
        0.14188*X$DM + 0.27491*X$HT - 0.07731*X$IHD - 0.31699*X$LD + 0.23415*X$MI +
        -0.16875*X$PVD - 0.18137*X$ST  +
        -0.03216*X$Albumin - 0.51517*X$Calcium - 0.00539*X$Haemoglobin + 0.86995*X$Phosphate + 
        0.00698*X$DBP + 0.00523*X$SBP +
        -0.09557*X$eGFR + 0.05504*X$eGFR.Rate + 
        0.70047*X$uPCR - 0.01999*X$uPCR.Rate + 0.21849*X$log.uPCR.Rate
    
    LP_rd <- function(X) -0.5626*(X$DiagGroup == "Familial / hereditary nephropathies") +
        -0.48899*(X$DiagGroup == "Glomerular disease") +
        0.03309*(X$DiagGroup == "Miscellaneous renal disorders") +
        -0.31072*(X$DiagGroup == "Tubulointerstitial disease") +
        -0.282*(X$SmokingStatus == "Former_3Y") +
        -0.29452*(X$SmokingStatus == "Non_Smoker") + 
        0.38746*(X$SmokingStatus == "Smoker") + 
        0.06348*X$Age +
        -0.29995*X$CCF - 0.16827*X$CVA + 0.20035*X$DM - 0.4164*X$HT - 0.0979*X$IHD - 0.27017*X$LD +
        0.18662*X$MI - 0.1834*X$PVD - 0.27804*X$ST +
        -0.04468*X$Albumin - 0.00558*X$Haemoglobin + 
        0.01182*X$eGFR - 0.05648*X$eGFR.Rate + 0.2277*X$log.eGFR.Rate +
        -0.10847*X$uPCR + 0.03684*X$uPCR.Rate - 0.19847*X$log.uPCR.Rate 

    l_cd.0 <- function(t)  (1/t)*case_when(0 <= t & t < 3 ~ (1.19795)*exp(1.19795*log(t)+17.68798),
                                           3 <= t & t < 443 ~ (-0.00027*log(t)^2+6e-04*log(t)+1.19761)*exp(-9e-05*log(t)^3+3e-04*log(t)^2+1.19761*log(t)+17.68811),
                                           443 <= t & t < 873 ~ (0.47607*log(t)^2-5.8038*log(t)+18.88018)*exp(0.15869*log(t)^3-2.9019*log(t)^2+18.88018*log(t)-18.22403),
                                           873 <= t & t < 1295 ~ (-0.90288*log(t)^2+12.87318*log(t)-44.36299)*exp(-0.30096*log(t)^3+6.43659*log(t)^2-44.36299*log(t)+124.54338),
                                           1295 <= t & t < 1876 ~ (-0.12474*log(t)^2+1.72056*log(t)-4.40166)*exp(-0.04158*log(t)^3+0.86028*log(t)^2-4.40166*log(t)+29.08554),
                                           1876 <= t & t < 2738 ~ (1.53789*log(t)^2-23.34096*log(t)+90.03919)*exp(0.51263*log(t)^3-11.67048*log(t)^2+90.03919*log(t)-208.17245),
                                           2738 <= t & t < 5497 ~ (-0.71976*log(t)^2+12.39726*log(t)-51.3924)*exp(-0.23992*log(t)^3+6.19863*log(t)^2-51.3924*log(t)+164.96467),
                                           5497 <= t ~ (1.98997)*exp(1.98997*log(t)+11.72244))

    l_cr.0 <- function(t) (1/t)*case_when(0 <= t & t < 18 ~ (1.55753)*exp(1.55753*log(t)-5.44635),
                                          18 <= t & t < 270 ~ (-0.00837*log(t)^2+0.0484*log(t)+1.48757)*exp(-0.00279*log(t)^3+0.0242*log(t)^2+1.48757*log(t)-5.37894),
                                          270 <= t & t < 538 ~ (-0.40728*log(t)^2+4.51552*log(t)-11.01817)*exp(-0.13576*log(t)^3+2.25776*log(t)^2-11.01817*log(t)+17.96111),
                                          538 <= t & t < 919 ~ (1.47399*log(t)^2-19.14292*log(t)+63.36209)*exp(0.49133*log(t)^3-9.57146*log(t)^2+63.36209*log(t)-137.93609),
                                          919 <= t & t < 1316 ~ (-2.30934*log(t)^2+32.49082*log(t)-112.80782)*exp(-0.76978*log(t)^3+16.24541*log(t)^2-112.80782*log(t)+262.78176),
                                          1316 <= t & t < 2000 ~ (0.90117*log(t)^2-13.62904*log(t)+52.82254)*exp(0.30039*log(t)^3-6.81452*log(t)^2+52.82254*log(t)-133.77073),
                                          2000 <= t & t < 5173 ~ (-0.0369*log(t)^2+0.63104*log(t)-1.37092)*exp(-0.0123*log(t)^3+0.31552*log(t)^2-1.37092*log(t)+3.53243),
                                          5173 <= t ~ (1.32717)*exp(1.32717*log(t)-4.15818))
    
    l_rd.0 <- function(t) (1/t)*case_when(0 <= t & t < 8 ~ (1.35522)*exp(1.35522*log(t)-7.7618),
                                          8 <= t & t < 196 ~ (-0.05112*log(t)^2+0.2126*log(t)+1.13417)*exp(-0.01704*log(t)^3+0.1063*log(t)^2+1.13417*log(t)-7.60859),
                                          196 <= t & t < 506 ~ (0.65283*log(t)^2-7.2206*log(t)+20.75671)*exp(0.21761*log(t)^3-3.6103*log(t)^2+20.75671*log(t)-42.14228),
                                          506 <= t & t < 816 ~ (-2.02674*log(t)^2+26.1483*log(t)-83.12956)*exp(-0.67558*log(t)^3+13.07415*log(t)^2-83.12956*log(t)+173.47479),
                                          816 <= t & t < 1388 ~ (2.4129*log(t)^2-33.38206*log(t)+116.42771)*exp(0.8043*log(t)^3-16.69103*log(t)^2+116.42771*log(t)-272.49495),
                                          1388 <= t & t < 1927 ~ (-3.80196*log(t)^2+56.55476*log(t)-208.94656)*exp(-1.26732*log(t)^3+28.27738*log(t)^2-208.94656*log(t)+512.26643),
                                          1927 <= t & t < 4940 ~ (0.51057*log(t)^2-8.68488*log(t)+37.78861)*exp(0.17019*log(t)^3-4.34244*log(t)^2+37.78861*log(t)-109.83234),
                                          4940 <= t ~ (0.85568)*exp(0.85568*log(t)-5.12598))
    
    L_cd.0 <- function(t) exp(case_when(0 <= t & t < 3 ~ 1.19795*log(t)+17.68798,
                                        3 <= t & t < 443 ~ -9e-05*log(t)^3+3e-04*log(t)^2+1.19761*log(t)+17.68811,
                                        443 <= t & t < 873 ~ 0.15869*log(t)^3-2.9019*log(t)^2+18.88018*log(t)-18.22403,
                                        873 <= t & t < 1295 ~ -0.30096*log(t)^3+6.43659*log(t)^2-44.36299*log(t)+124.54338,
                                        1295 <= t & t < 1876 ~ -0.04158*log(t)^3+0.86028*log(t)^2-4.40166*log(t)+29.08554,
                                        1876 <= t & t < 2738 ~ 0.51263*log(t)^3-11.67048*log(t)^2+90.03919*log(t)-208.17245,
                                        2738 <= t & t < 5497 ~ -0.23992*log(t)^3+6.19863*log(t)^2-51.3924*log(t)+164.96467,
                                        5497 <= t ~ 1.98997*log(t)+11.72244))
    
    L_cr.0 <- function(t) exp(case_when(0 <= t & t < 18 ~ 1.55753*log(t)-5.44635,
                                        18 <= t & t < 270 ~ -0.00279*log(t)^3+0.0242*log(t)^2+1.48757*log(t)-5.37894,
                                        270 <= t & t < 538 ~ -0.13576*log(t)^3+2.25776*log(t)^2-11.01817*log(t)+17.96111,
                                        538 <= t & t < 919 ~ 0.49133*log(t)^3-9.57146*log(t)^2+63.36209*log(t)-137.93609,
                                        919 <= t & t < 1316 ~ -0.76978*log(t)^3+16.24541*log(t)^2-112.80782*log(t)+262.78176,
                                        1316 <= t & t < 2000 ~ 0.30039*log(t)^3-6.81452*log(t)^2+52.82254*log(t)-133.77073,
                                        2000 <= t & t < 5173 ~ -0.0123*log(t)^3+0.31552*log(t)^2-1.37092*log(t)+3.53243,
                                        5173 <= t ~ 1.32717*log(t)-4.15818))
    
    L_rd.0 <- function(t) exp(case_when(0 <= t & t < 8 ~ 1.35522*log(t)-7.7618,
                                        8 <= t & t < 196 ~ -0.01704*log(t)^3+0.1063*log(t)^2+1.13417*log(t)-7.60859,
                                        196 <= t & t < 506 ~ 0.21761*log(t)^3-3.6103*log(t)^2+20.75671*log(t)-42.14228,
                                        506 <= t & t < 816 ~ -0.67558*log(t)^3+13.07415*log(t)^2-83.12956*log(t)+173.47479,
                                        816 <= t & t < 1388 ~ 0.8043*log(t)^3-16.69103*log(t)^2+116.42771*log(t)-272.49495,
                                        1388 <= t & t < 1927 ~ -1.26732*log(t)^3+28.27738*log(t)^2-208.94656*log(t)+512.26643,
                                        1927 <= t & t < 4940 ~ 0.17019*log(t)^3-4.34244*log(t)^2+37.78861*log(t)-109.83234,
                                        4940 <= t ~ 0.85568*log(t)-5.12598))
    
    
    l_cd <- function(t,X) exp(LP_cd(X))*l_cd.0(t)
    l_cr <- function(t,X) exp(LP_cr(X))*l_cr.0(t)
    l_rd <- function(t,X) exp(LP_rd(X))*l_rd.0(t)
    
    L_cd <- function(u,t,X) exp(LP_cd(X))*(L_cd.0(t) - L_cd.0(u))
    L_cr <- function(u,t,X) exp(LP_cr(X))*(L_cr.0(t) - L_cr.0(u))
    L_rd <- function(u,t,X) exp(LP_rd(X))*(L_rd.0(t) - L_rd.0(u))
    
    
    P_cc <- function(u,t,X) exp(-L_cd(u,t,X) - L_cr(u,t,X))
    P_rr <- function(u,t,X) exp(-L_rd(u,t,X))
    P_cr_ever <- function(u,t,X) #Probability of going to RRT
        integrate(f = function(s) P_cc(u,s,X)*l_cr(s,X),
                  lower = u, upper = t,abs.tol = 10^(-10))$value
    P_cr <- function(u,t,X) # Probability of staying in RRT
        integrate(f = function(s) P_cc(u,s,X)*l_cr(s,X)*P_rr(s,t,X),
                  lower = u, upper = t,abs.tol = 10^(-10))$value
    P_cd_direct <- function(u,t,X) #Probability of going straight to dead
        integrate(f = function(s) P_cc(u,s,X)*l_cd(s,X),
                  lower = u, upper = t,abs.tol = 10^(-10))$value
    P_cd_via.r <- function(u,t,X) P_cr_ever(u,t,X) - P_cr(u,t,X) #Going to dead after RRT
    P_cd <- function(u,t,X) P_cd_direct(u,t,X) + P_cr_ever(u,t,X) #Total dead probability
    
    New_Prediction <- function()
        tibble()
    
    Add_Prediction<- function(.tbl,t,X)
    {
        if(t %in% .tbl$t) .tbl else 
        {
            .tbl %>%
                rename(u = t) %>%
                arrange(-u) %>%
                filter(u < t) %>%
                slice(1) %>%
                mutate(P.CKD  = P_cc(0,t,X),
                       P_cr_ever = P_cr_ever + P_cr_ever(u,t,X),
                       P.Dead = P.Dead + P_cd_direct(u,t,X), 
                       P.RRT  = P_cr(0,t,X),
                       P.Dead_RRT = P_cr_ever - P.RRT,
                       P_cd = P.Dead + P.Dead_RRT,
                       u = t)%>%
                rename(t = u) %>%
                mutate(Tp = sum(P.CKD + P.RRT + P.Dead_RRT + P.Dead)) %>%
                mutate_at(vars(starts_with("P")),~divide_by(.,Tp)) %>%
                bind_rows(.tbl,.) %>%
                select(-Tp) %>%
                arrange(t) 
        }
    }
    
    Predict <- function(X,t)
    {
        .tbl <- New_Prediction()
        
        .tbl %<>% reduce(t,Add_Prediction,X=X,.init=.)
        
        return(.tbl)
    }
}


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Multi-State Clinical Prediction Model for CKD Patients"),

    sidebarLayout(
        sidebarPanel(
            numericInput("min.x",
                        "minimum x value",
                        value = 30),
            numericInput("max.x",
                        "maximum x value",
                        value = 60)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

server <- function(input, output) {

    output$distPlot <- renderPlot({
        future({
            seq(input$min.x,input$max.x) %>%
                tibble(x=.) %>%
                mutate(y = Slow.Square(x))
            }) %...>%
            ggplot(aes(x,y)) +
            geom_line()
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
