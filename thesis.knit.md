---
author: 'Michael Andrew Barrowman'
date: 'May 2020'
institution: 'University of Manchester'
division: 'Division of Informatics, Imaging and Data Science'
advisor: 'Dr. Matthew Sperrin, Prof. Niels Peek, Dr. Glen Martin, Dr. Mark Lambie'
# If you have more two advisors, un-silence line 7
#altadvisor: ''
department: 'School of Health Sciences'
degree: 'PhD Medicine'
title: 'Multi-State Clinical Prediction Models in Renal Replacement Therapy'
knit: MyThesis::MyRender
#knit: MyThesis::simple_render
site: bookdown::bookdown_site
output: 
  bookdown::gitbook:
    includes:
      in_header: "hypothesis.html"
      css: style.css  
    config:
      toc:
        collapse: section
  thesisdown::thesis_pdf: 
    includes:
      in_header: [header.tex, latex_packages.txt]
#  thesisdown::thesis_word: default
#  thesisdown::thesis_epub: default
# If you are creating a PDF you'll need to write your preliminary content (e.g., abstract, acknowledgements) here or
# use code similar to line 22-23 for the .RMD files. If you are NOT producing a PDF, you can delete or silence lines 21-32 in this YAML header.
abstract: |
  Insert Abstract Here...
# If you'd rather include the preliminary content in files instead of inline
# like below, use a command like that for the abstract above.  Note that a tab is 
# needed on the line after the `|`.
acknowledgements: |
  Insert Ackowledgements Here...  \par
  
  <!--  \par
  
  I would like to thank my wife, Rachel, for her constant support throughout my studies. She acted as sounding board for my most boring of thoughts and allowed me to rant and rave about statistical models in every way possible. She endured my frustrations when something wasn't working and encouraged me when my optimism turned to pesimism.  \par
  
  My thanks also go to my children, Matilda and Theodore, who were an everlasting source of happiness and reprieve from my work. Acting as a distraction (in the best and worst ways) and an incentive.  \par
  
  My everlasting gratitude will always lie with my parents, Brenda and Andy, who have allowed me to be myself and to find my own path. They never pushed me into something that I didn't want to do, but also guided me towards what I would be good at.  \par
  
  My final thanks go to my PhD supervisors, Matt, Niels, Glen and Mark, who have provided advice and feedback for over four years.  \par
  
  -->
# Specify the location of the bibliography below 
bibliography: ["bib/thesis.bib","bib/MyCites.bib"]
biblio-style: "ieee"
link-citations: true
# Download your specific csl file and refer to it in the line below.
csl: csl/ieee.csl #https://github.com/citation-style-language/styles
lot: true
lof: true
#header-includes: |
#  
---




  
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: { equationNumbers: { autoNumber: "AMS" } }
});
</script>



# Introduction {-}

<!--
To Do List:
Write up current draft of other papers
Add Timeline

-->

Welcome to my Thesis. I've used R Markdown to create a gitbook style thesis, as well as a traditional pdf (following the UoM Thesis template). The html version can be found [here](https://michaelbarrowman.co.uk/thesis).
  
I sent an email with details of how you can log in to the [hypothes.is](https://hypothes.is/) system. This will let you add comments to the gitbook pages. This is actually a really useful tool and has the ability to add annotations to any webpage. Annotated text can be seen highlighted and to add your own, just highlight the text you want to comment on, and the annotate bubble pops up (try it now). Make sure you click Post to Public after writing the annotation and annotations can include Rich Text and Markdown. You can view Annotations by clicking the menu on the right and this will show all comments.

<mark>New note: Comments added to textual whitespace (e.g. spaces or equations), don't get targetted correctly. They appear in the system where they should be, but the whitespace doesn't get highlighted in the text, which makes it a bit harder to locate them and add in the edits (e.g. if you want me to add a bit more text to the end of a sentence). If you could, please highlight *some* text (even a full stop works).</mark>

Google Docs was great, but when I started to use R Markdown for other purposes, I realised I could embed tables and equations much easier and automatically using `kable`. Google Docs on it's own became rather clunky (especially with tables, just like Word) and whenever I updated a document using R Markdown, any comments that were added to the document were lost. It was also difficult for you to remember *where* each document lived. Since R Markdown can also output to `LaTeX` I thought it would be easier to collate papers together. I'd have had to do this kind of transition over to`LaTeX` for my thesis eventually and this would have been difficult and tedious from Google Docs or Word.
  

Importantly, I've also added in functionality to output each chapter individually. For unpublished papers, there will be a link to download the pdf and tex versions of the individual paper.



Everything here is hosted in a [Github repo](https://https://github.com/MyKo101/Thesis). I originally used Github as my backup, but then decided to increase how I used it.



 


<!--chapter:end:index.Rmd-->


# Literature Report {#chap-lit-report}
\chaptermark{Literaure Report}
Last updated: 25 May

## Introduction


## Clinical Prediction Models

The idea of prognosis dates back to ancient Greece with the work of Hippocrates [@hippocrates_genuine_1886] and is derived from the Greek for "know before" meaning to forecast the future. Within the sphere of healthcare, it is definde as the risk of future health outcomes in patients, particularly patients with a certain disease or health condition. Prognosis allows clinicians to provide patients with a prediction of how their disease will progress and is uaully given as a probability of having an event in a prespecified number of years. For example, QRISK3 [@hippisley-cox_development_2017] provides a probability that a patient will have a heart attack or stroke in the next 10 years. Prognostic research encompasses any work which enhances the field of prognosis, whether through methodological advancements, field-specific prognostic modelling or educational material designed to improve general knowledge of prognosis. Prognostic models come under the wider umbrella of predictive models which also includes diagnostic models; because of this most of the keys points in the field or prognostic modeling can be applied to diagnostic models with little to no change.

Prognosis allows clinicians to evaluate the natural history of a patient (i.e. the course of a patient's future without any intervention) in order to establish the ffect of screening for asymptomatic diseases (such as with mammograms[@hemingway_prognosis_2013]). Prognosis research can be used to develop new definitions of diseases, whether a redefinition of an existing disease (such as the extension to th definition of myocardial infarction to include non-fatal events [@thygesen_universal_2007]) or a previously unknown subtype of a disease (such as Brugada syndrome as a type of cardiovascular disease[@probst_long-term_2010])

In general, prognosis research can be broken down into four main categories, with three subcategories [@riley_prognosis_2019]:

* Type I: Fundamental prognosis research [@hemingway_prognosis_2013] 
* Type II: Prognostic factor research [@riley_prognosis_2013]
* Type III: Prognostic model research [@steyerberg_prognosis_2013]
  * Model development [@royston_prognosis_2009]
  * Model validation [@altman_prognosis_2009]
  * Model impact evaluation [@moons_prognosis_2009]
* Type IV: Stratified Medicine [@hingorani_prognosis_2013]

For a particular outcome, prognostic research will usually progress through these types, beginning with papers designed to evaluate overall prognosis within a whole population and then focusing in on more specificity and granularity towards individualised, causal predictions.

The model development and validation will usually occur in the same paper [@collins_transparent_2015;@moons_transparent_2015]. studies into all three of the subcategories of prognostic model research *should* be completed before a model is used in clinical practice [@riley_external_2016], although this does not always occur [@steyerberg_prognosis_2013]. External validation is considered by some to be more important than the actual deviration of the model as it demonstrates generalisability of the model [@collins_systematic_2013], whereas a model on it's own may be highly susceptible to overfitting [**Cite: Something**].

### Fundamental Prognosis Research

[**What is it? Old definition is incorrect, so will need to write this fresh**]

### Prognostic Factor Research

The aim of prognostic factor research (Type II) is to discover which factors are associated with disease progression. This allows for the general attribution of relationships between predictors and clinical outcomes.

Predictive factor research can give researchers and clinicians an idea of which patient factors are important when assessing a disease. It is vital to the development of clinical predictive models as without an idea of what covariates *can* affect an outcome, we cannot figure out which variables *will* affect the outcome. For example, [**xxxx**] demonstrated that [**xxxx**] is correlated with [**xxxx**], which subsequently used as a covariate in the development of the [**xxxx**] model. Note the use of the word correlate here as prognostic relationships do not have to be causal ones [**Cite: Something**]. These factors may indeed represent an underlying causal pathway, but this is not a requirement and it would require aetiological methods to discern whether it were causal or not. For example, when predicting [**xxxx**], we can demonstrate that [**xxxx**] is a prognostic factor, [however since the arrow of causation is [**xxxx**]] [**OR**] [however since [**xxxx**] causes both [**xxxx**] and [**xxxx**]], the relationship is prognostic, but not causal. [**Previously used Apgar score here, reference 40**]

Counter to the idea that prognostic factors aren't always causal, they are *always* confounding factors for the event they predict. Thue prognostic factors should be taken into account when planning clinical trials as if they are wildly misbalanced across the arms (or not accounted for in some other manner), they can cause biases in the results [@riley_prognosis_2013]. Sometimes these factors are so strong that adjusting the results of a clinical trial by the factor can affect, or even reverse the interpretation of the results [@royston_dichotomizing_2006]. If a prognostic factor is causal, then by directly affecting the factor, it can causally affect the outcome. By discovering new prognostic factors, and investigating their causality, we can potentially open the door to new directions of attack for treatments.

It is unfortunate, however, that Riley at al [@riley_systematic_2003-1] found that only 35.5% of prognostic factor studies in paediatric oncology actually reported the size of the effect of the prognostic factor they reported on. This means that very little information can be drawn from these studies. It is also important that prognostic factor research papers consider and report on the implications of the factor they assess such as healthcare costs. These kinds of implications are rarely assessed, especially when compared to drugs or interventions [@riley_prognosis_2013].

### Prognostic Model Research

Predictive factors can be combined into a predictive model, which is a much more specific measurement of the effect of a factor on an outcome [@steyerberg_prognosis_2013] and they are deigned to augment the job of a clinician; and not to completely replace them [@moons_prognosis_2009]. Diagnostic prediction model can be used to indicate whether a patient is likely to need further testing to establish the presence of a disease [@collins_transparent_2015;~moons_transparent_2015]. Prognostic prediction models can be used to decide on further treatment for that patient, whether as a member of a certain risk group, or under a stratied medicine approach [@collins_transparent_2015;@moons_transparent_2015]. Outcomes being assessed in a prediction model should be directly relevant to the patient (such as mortality) or have a direct causal relationship with something that is [@moons_prognosis_2009]. There is a trend of researchers focusing on areas of improvement that are of less significance to the patient than it is to a physician [@kurella_optimizing_2012]. For example, older patient's might prefer to have an improved quality of life than an increase in life expectancy, and thus models should be developed to account for this.

Creating a clinicaly useful model is not as simple as just using some availble data to develop a model, despite what a lot of researchers seem to believe [**Cite: Something**]. To quote Steyerberg et al [@steyerberg_prognosis_2013]. " To be useful for clinicia,s a prognostic model needs to provide validated and accurate predictions and to improve patient outcomes and cost-effectiveness of care". This means that, although a mdel might appear to be useful, its effectiveness is only relevant to the population it was developed in. If your population is different, then the model will behave differently. Bleeker [@bleeker_external_2003] developed a model to predict bacterial infections in febrile children with an unknown source. The model scored well when assessed for the predictive value in the development dataset, however it scored much worse in an external dataset implying that, though it worked well in the development population, it would be unwise to apply it to a new population.

#### Model Development

The first stage of having a useful model is to develop one. Clinical predictive models can take a variety of forms, such as logistic regression, cox models or some kind of machine learning. Regardless of the specific model type being used, there are certain universal truths than should be held up during model development which will be discussed here. The size of the dataset being used is of vital importance as it can combat overfitting of the data, but so is choosing which prognostic factors to be included in the final model. This section will discuss various ideas that researchers need to account for when developing a model from any source and can be applied to any model type.

By considering a multivariable approach to prediction models (as opposed to a univariable one), researchers can consider different combinations of predictive factors, usually refered to as potential predictors [@riley_prognosis_2013]. These can include factors where a direct relationship with the disease can be clearly seen, such as tumour size in the prediction of cancer mortality [@haybittle_prognosis_1982], or ones which could have a more general effect on overall health, such as socioeconomic and ethnicity variables [@zaman_social_2008]. By ignoring any previous assumptions about a correlation between these potential predictors and the outcome of interest, we can cast a wider net in our analysis allowing us to catch relationships that might have otherwise been lost [@hanauer_exploring_2009]. Prediction models should take into account as many predictive factors as possible. Demographic data should also be included as these are often found to be confounding factors, variables such as ethnicity and social deprivation risk exacerbating the existing inequality between groups [@hippisley-cox_predicting_2008].


When developing a predictive model, the size of the dataset being used in an important consideration. A typical "rule of thumb" is to have at least 10 events for every potential predictor [@peduzzi_importance_1995;@peduzzi_simulation_1996], know as the Events-per-Variable (EPV). Recently, this number has been superseded by a methods to evaluate a specific required sample size [@riley_minimum_2019] based on Events-per-Predictor (EPP), where categorical variables are transformed into dummy variables prior to calculation (therefore number of predictors is higher than the number of variables). If there aren't enough events to satisfy this criteria, then some potential predictors should be eliminated before any formal analysis takes place (for example using clinical knowledge) [@sauerbrei_selection_2007]. In general, it is also recommended that this development dataset contain at least 100 events (regardless of number of potential predictors) [@riley_external_2016; @vergouwe_substantial_2005; @collins_sample_2016]. A systematic review by Counsell et al [@counsell_systematic_2001] found that out of eighty-three prognostic models for acute stroke, less than 50% of them had more than 10 EPV, and the work by Riley et al [@riley_minimum_2019] showed that less that [**Pull example from Riley EPV**]. Having a low EPV can lead to overfitting of the model which is a concern associated with having a small data set. Overfitting leads to a worse prediction when the model is used on a new population which essentially makes the model useless [@royston_prognosis_2009]. However, just because a dataset is large does not imply that it will be a *good* dataset if the quality of the data is lacking [@riley_external_2016]. Having a large amount of data can lead to predictors being considered statistically significant when in reality they only add a small amount of information to the model [@riley_external_2016]. The size of the effect of a predictor should therefore be taken into account in the final model and, if beneficial, some predictors can be dropped at the final stage.


Large datasets can be used for both development and validation if an effective subset is chosen. This subset should not be random or data driven and should be decided before data analysis is begun [@riley_external_2016]. Randomly splitting a dataset set into a training set (for development) and a testing set (for internal validation) can result in optimistic results in the validation process in the testing set. This is due to the random nature of the splitting causing the two populations to be too exchangeable, which is similar to the logic behind the splitting of patients in a Randomised Control Trial (RCT). Splitting the population by a specific characteristic (such as geographic location or time period) can result in a better internal validation [@altman_prognosis_2009; @ivanov_predictive_2000]. Derivation of the QRISK2 Score [@hippisley-cox_derivation_2007] (known later as QRISK2-2008) randomly assigned two thirds of practices to the derivation dataset and the remainder to the validation dataset. This model was further externally validated [@collins_independent_2012], and its most modern incarnation, QRISK3, performed the external validation in the same paper [@hippisley-cox_development_2017] The Nottingham Prognostic Index (NPI) was trained on the first 500 patients admitted to Nottingham City Hospital after the study began [@haybittle_prognostic_1982] and later validated on the next 320 patients to be admitted [@todd_confirmation_1987], this validation was not performed at the same time as the initial development and is thus an external validation.

As with any technology, clinicians and researchers should be wary of models becoming outdated [@pate_uncertainty_2019]. Healthcare systems and lifestyles change over time, and so models developed and externally validated in an outdated population will drift [@bhatnagar_epidemiology_2015] and so should be updated regularly, as with QRISK [@hippisley-cox_development_2017] or automatically with a dynamic model [@jenkins_dynamic_2018]


If a sufficient amount of data is available and it has been taken from multiple sources (practices, clinics or studies), then it should be clustered to account for heterogeneity across sources [@liquet_investigating_2012]. It is important that any sources of potential variability are identified (such as heterogeneity between centres) as this can have an impact on the results of any analysis [@hemingway_prognosis_2013;@riley_external_2016]. Heterogeneity is particularly high when using multiple countries as a source of data [@snell_multivariate_2016] or if a potential predictor is of a subjective nature, which leads to discrepancies between assessors [@hougaard_frailty]. Overlooking of this clustering can lead to incorrect inferences [@liquet_investigating_2012]. The generalisability of the sources of data should also be considered in the development of a model. For example, the inclusion and exclusion criteria of an RCT can greatly reduce generalisability if used as a data source [@moons_prognosis_2009].

<!-- Removed paragraph on missing data --->

A prediction model researcher needs to select clinically relevant potential predictors for use in the development of the model [@royston_prognosis_2009]. Once chosen, researchers need to be very specific about how these variables are treated. Any adjustments from the raw data should be reported in detail [@collins_transparent_2015;@moons_transparent_2015]. Potential predictors with high levels of missingness should be excludes as this missingness can introduce bias [@royston_prognosis_2009]. One key fact that many experts agree on is that categoriation of continuous predictors should be avoided [**Cite: LOADS**] as it retains much more predictive information. The cut-points of these categorisations lead to artificial jumps in the outcome risk [@sauerbrei_selection_2007]. It is also worth noting that cut-points are often either arbitrarily decided or data-driven with the latter leading to overfitting [@sauerbrei_selection_2007]. If categorisation is performed, clear rationale should be provided with an ackowledgement that this wil reduce performance [@lagakos_effects_1988;@collins_systematic_2013]. When applying a model to a new population, extrapolation of a model should be avoided [@eberhart_applicability_1988] and so to aid in this, the ranges of continuous variables, and the considered values of categorical variables should be reported [@collins_systematic_2013]. this is especially true for age. QRISK2 was derived in a population ranging from 35 to 74 years of ages and so should not have been applied to patients out of this range [@hippisley-cox_predicting_2008]. This ranges was later extended with the updated version [@hippisley-cox_advantages_2011] and currently can be applied to patients aged 25-84 [**Update with QRISK3**].

When building a prediction model, we begin with a certain pool of potential predictors and try to establish which to include in the final model [@sauerbrei_selection_2007]. With $k$ candidate variables, we have $2^k$ possible choices which can get unwieldy even for low values of $k$, with only 10 predictors (a very reasonable number), there are over 1,000 combinations. This doesn't include interactions or non-linear components which increases this number even more. Therefore, model-building techniques are important for anybody attempting to build an accurate prediction model. It is currently undecided what the "best" way to select predictors in a multivariable model is or even if it exists [@sauerbrei_selection_2007]. One method that researchers use to decide on which predictors to include is to analyse each potential predictor individually for a correlation with the outcome in a univariable analysis and keeping those which are considered to have a statistically significant correlation. The general consensus amongst researchers is that predictors should not be excluded in this way [@royston_prognosis_2009]. Univariables analysis does not account for any dependencies between potential predictors and so any cross correlations that exists between them can cause a bias in the results. Despite its clear weaknesses, any prognostic studies still use univariable analysis to build their models [@riley_reporting_2003].

<!-- Removed paragraph of NPI -->

Backwards elimination (BE) involves starting with all potential predictors in the model and removing ones which do not reach a certain level of statistical significant (for example, 5%) one at a time untill all remaining variables are significant. Forward selection begins wth no variables and adds one a a time based on similar criteria. Under either of these methods, a lower significance level will exxlucde more variables [@royston_prognosis_2009]. Backward elimination of variables is preferable over forward selection as users are less likely to end up in local minima [@mantel_why_1970]. A variant of these techniques is to use the Akaike Information Criteria (AIC) rather than statistical significance. This method avoids the comparison to p-values and so is often preferable to build robust models [**Cite: p-values be bad reference**]. For this method, to establish which predictors should be removed at each step, the model is re-built with each of the predictors individually removed, and the AIC is calculated. The model with the lowest AIC is chosen to be the new model and the process is repeated. This process is repeated until the removal of a predictor would increase the AIC (i.e. make the model's fit worse). This same technique can be applied to a forward selection style model or, if the computing power is available, a backward-forward elimination technique were predictors are added or removed at each stage. The advantage of this method is that it avoids local minima better by trying more combinations.

It is also important to assess non-linearity relationships between variables and outcomes to ensure the relationship is accurately modeled. This can be done using standard transformations (e.g. logarithms, sqauring) or using fractional polynomials [**Cite: LR - 7 or 76?**]. Interactions between terms also need to be checked for the same reasons, and when interactions are strong, it may be useful to completely stratify by a factor, rather than including as a covariate in the model. Strong interactions can be an indicator for a differential response amongst populations and so should be investigated directly [**Cite: LR - 4**]. If a predictor is expensive or invasive, it may be better to include a less significant predictor which is easier to come by [**Cite: LR - 40**]. A limiting factor for some prognostic models is that the prognostic factors they measure are not readily available or are not used in routine care [**Cite: LR - 3**]. The measurement (or lack thereof) can also be an indicator of patient health and so researchers need to be aware of these causal links when analysing measurements [**Cite: Rose's Work**].


Once developed, prognostic models can be used to create risk groups for a population. Risk groups should be defined by clinical knowledge rather than statistical criteria[**Cite: LR - 35**]. Grouping patients into risk groups is not as accurate as using the specific model to provide an estimated risk [**Cite: LR - 3**].

<!-- Paragraph regarding groupings in NPI, followed by intergation of QRISK in computer systems-->



#### Model Validation

#### Impact Evaluation

### Stratified Medicine

### Examples

#### Reviews

Along with the EPV assessment mentioned earlier, Counsell et al's systematic review [**Cite: LR - 62**] assessed other criteria related to validity, evaluation and practicality. Of those eighty-three models, only four met their requirements, none of which had been externally validated. The other seven criteria were:

* Adequate inception cohort
* Less than 10% loss to followup
* Prospective data collection
* Valid and reliable outcome
* Age as a candidate predictor
* Severity of condition as a candidate predictor
* Use of stepwise regression

<!-- Taken from page 8, continue with the other reviews mentioned there --->

## Competing Risks & Multi-State Models

## Chronic Kidney Disease

### Clinical Prediction Models

### Multi-State Models


<!--chapter:end:01-Lit_Report.Rmd-->


# The Application of Multi-State Methods to Develop Clinical Prediction Models Designed for Clinical Use - A Scoping Review {#chap-scoping-review}
*MA Barrowman, D Jenkins, GP Martin, N Peek, M Lambie, M Sperrin*
\chaptermark{Scoping Review}
Last updated: 21 Apr





## Introduction

eHealthcare is moving towards a more data-driven approach to decision making, exploiting the variety of data sources collected as part of routine care [1]. This increases efficiency, which is becoming increasingly vital as patients are living longer and requiring more care, while budgets are being reduced [2], [3]. Correspondingly, there has been a shift towards primary prevention, rather than purely treating disease as it arises [4] therefore clinical prediction models (CPMs) are more relevant than ever before [5].

Prognostic CPMs (those that predict the future) allow end-users to estimate an individual's probability/risk of experiencing an outcome of interest within a certain timeframe. CPMs are algorithms that relate a set of prognostic factors to the risk of a chosen outcome [6], often using multivariable regression. They can provide predictions of the future course of an illness and provide evidence for the commencement of medical  interventions [7].

Along with this overall increase in importance, different methods of producing CPMs are also being used, and each makes different assumptions, and models at different levels of granularity. One of these methods is the Multi-State Model (MSM), an extension to traditional survival analysis wherein patients exist in one of many distinct states at any given time and can transition between them (these individual transitions are akin to that of traditional survival analysis) [8]. A subset of MSMs is that of a Competing Risks model, where patients can only move from a single initial state to many absorbing states without any intermediate or transient states. A huge advantage of Multi-State CPMs, and indeed, Competing Risks CPMs, is that they can provide predictions for multiple outcomes with MSMs going further by allowing the prediction of multiple pathways to that outcome, whereas traditionally developed models only provide predictions for a single end-point.

However, little is known about how widely these types of models are implemented in clinically relevant prognostic research. Therefore, we here aim to document a scoping review protocol that will intend to uncover any  prediction models using MSMs that have been developed for clinical use. As part of the process of this investigation, we will also document how many CPMs account for Competing Risks alone. We define a scoping review as described by Arksey and O'Malley [9] , which is similar to a systematic review, but with less formal outline for the analysis and synthesis of literature [10]. By assessing how MSMs have currently  been applied in this field, we aim to describe the landscape of their current use, the context in which they are being used and discuss ways in which their use, application and uptake can be improved. To the best of our knowledge, a review such as this for Multi-State Models has never been performed.


## Methods

### Scope of Review

This review will cover articles related to the development of Multi-State Clinical Prediction models designed for clinical use. It will not include models that were developed solely for demonstrations of novel methodological improvements in the field of clinical prediction modelling and/or multi-state modelling. Article inclusion will be based on the screening of the article text and interpretation of its aims, primary distinction will be made on whether an existing dataset is used as a core part of the article or as a subsidiary example. It will include articles that validate previously developed models and those that review existing models, only so far as to use them to find the original development article (a method known as Snowballing).  

As this analysis will follow the style of a scoping review; the final paper will adhere to the PRISMA-ScR guidelines [11], which were set out to extend the traditional PRISMA guidelines to a Scoping Review setting.

Models which focus only on a competing risks scenario (whether directly or simply adjusting for competing risks) will not be analysed in detail, however to avoid missing possible Multi-State Models, we will only omit these at the final stage of screening (See below). This will also allow for a brief description of how many CR models exist compared to the MSM models to be analysed in detail in this review.

As per the definitions set out by the PROGRESS research group, prognostic research is split into four overarching themes/types:

* Type I - Fundamental Prognosis Research [12]
* Type II - Prognostic Factor Research [13]
* Type III - Prognostic Model Research [14]
* Type IV - Stratified Medicine Research [15]

As such, we will be focusing on papers of Type III [14]. Articles related to the other types of prognostic research often develop a model within their work, but since the intent of these papers is to investigate overall outcomes, effects of an individual factor or interactive effects of treatments in individuals, they are considered disjoint from CPM development and so they will not be included in our analysis.

### Initial Search Strategy

#### Search Terms

To ensure we cover as much of the medical literature as possible, we will use the Ovid search engine to search two databases:

* EMBASE (1974 to 2018 December 31)
* Ovid MEDLINE and Epub Ahead of Print, In-Process & Other Non-Indexed Citations, Daily and Versions 1946 to December 31, 2018

We will use a standard set of terms designed by Ingui & Rogers [16] and added to by Geersing et al [17] used for searching for clinical prediction related literature. We will also extend this by including search terms relating to time-to-event outcomes and/or survival analysis that were defined by the authors, and which aim to broaden our search (see table 1). This will be combined by a set of search terms designed to filter for MSMs and/or CRs.

These novel MSM/CR terms include "fine adj2 gray" to include papers which use the Fine & Gray subdistribution proportional hazard method [18]. It will also include"semimarkov or semi markov" to include articles which specify that the model adopts a semi-Markov perspective, which is common amongst MSMs [8]. However, we chose not to include the term "markov" alone as  it is considered to be too unspecific to be of use (a la search for "model" alone when finding clinical prediction models). The full search details can be found in table 2.

We believe that the broadness of our search terms allows for high sensitivity in our results and will therefore provide a larger and more comprehensive  pool of papers than using a more specific set of search terms.

[**Insert Table from paper**]

#### Validation set of articles

To ensure that our search strategy is satisfactory, we will compare our results to a set of Validation papers. These are papers that we are already aware of that satisfy our inclusion/exclusion criteria and which therefore should be included in our analysis. We will compare the results of our initial search with this set of papers to ensure that all of the Validation set appear in our results. If they do not, then we will adjust our search strategy iteratively increasing sensitivity and improving the reach of our search until all Validation papers are included. The set of Validation papers is as follows:

* *Estimation and Prediction in a Multi-State Model for Breast Cancer*, Putter et al, 2006 [20]
* *A Multi-State Model to Predict Heart Failure Hospitalizations and All-Cause Mortality in Outpatients With Heart Failure With Reduced Ejection Fraction: Model Derivation and External Validation*, Upshaw et al, 2016 [21]
* *Predicting timing of clinical outcomes in patients with chronic kidney disease and severely decreased glomerular filtration rate*, Grams et al, 2018 [22]
* *Estimating transition probability of different states of type 2 diabetes and its associated factors using Markov model*, Nazari et al, 2018 [23]
* *Advantages of a multi-state approach in surgical research: how intermediate events and risk factor profile affect the prognosis of a patient with locally advanced rectal cancer*, Manzini et al, 2018 [24]

### Filtering

Once the initial set of articles has been found, these will be filtered at various degrees of granularity to focus on papers which are included in the scope of our review as per our inclusion/exclusion criteria. We will also define which papers will be used only for the snowballing process, but will not be used as part of our analysis.

#### Inclusion/Exclusion Criteria

Inclusion

* Type III Prognostic Study Papers (i.e. those developing a clinical prediction model) [14]
* Papers which use a Multi-State Model framework to provide individual level patient predictions

Exclusion

* Papers that develop overall population level predictions (Type I)
* Papers focused on identification of prognostic factors (Type II)
* Papers that investigate stratified medicine (Type IV)
* Papers that only develop Competing Risks models
* Papers designed to describe methodological models with or without clinical application used only for an example

#### Stages

The filtering of the results will be performed in three stages:
1. Title (MB)
2. Abstract (MB with 20% replication by DJ)
3. Full Paper (MB with 20% replication by DJ)

Filtering will begin with an initial check through all titles to assess whether it is believed that the paper may be relevant to the review. This will help to omit a large amount of papers that were incorrectly returned by the broad search strategy. To ensure the review remains as sensitive as possible, only papers where it is abundantly clear that they violate an inclusion/exclusion criteria will be removed at this stage.

A second filter will be performed on the abstracts of the remaining articles and removed papers will be classified by the reason for their omission. To allow for faster data extraction, a final glancing filter will also be performed over the full papers to again reduce the numbers of collated papers in the final review and reduce the likelihood of removing papers at the analysis stage. To ensure robustness of this filtering, both of these stages will be replicated by a second reviewer (DJ) in a randomly selected 20% of the abstracts and papers and differences will be discussed internally. At this point, models focusing solely on competing risks (i.e. those without a transient state) will be filtered out.

### Data Extraction

To study the use of Multi-State Clinical Prediction Models from a quantitative perspective, certain vital data points will be extracted from the extant models. These measurements can be grouped as to what element of the prediction model they are evaluating:
* Clinically Relevant points
   * Number of patients
   * Clinical setting (i.e. primary vs secondary care, geographic setting)
   * Field of study (e.g. cardiovascular, renal, etc.)
   * Summary of patient demographics (i.e. inclusion/exclusion criteria)
   * Outcomes being predicted
* Multi-State Model details
   * Number of States and what they are
   * Shape/Structure of the model (i.e. how patients can transition between states)
   * How were relevant variables chosen?
   * Transition assumptions (e.g. parametric vs non-parametric, PH assumption, etc...)
   * Stated justification for, and reported benefits of an MSM versus traditional methods.
* Predictive Ability
   * Timeframe (e.g. single time point(s), continuous time prediction, dynamic prediction, etc...)
   * What validation was performed (None vs. Internal (bootstrap, CV, etc.) vs. External)
* Comparisons to current guidelines
   * Assessment of Bias of their model (using PROBAST)
   * Utilisation of the TRIPOD Guidelines (e.g. Was it referenced? Was it adhered to?)
* Prominence information
   * Number of citations (although not clinically relevant, it is relevant to understanding the model's utilisation)
   * Year of publication (again, not clinically relevant, but useful to spot any time trends in prominence and/or quality)
The data extracted at this stage will be checked by DJ in 20% of the papers to confirm results for the analysis

### Reporting

The search and filtering strategy will be depicted with a modified PRISMA flow diagram [30], which includes papers found by Snowballing and how they are included in the filtration process, see figure 1. 

[**Add in PRISMA**]

A table of the extracted information will be included with the paper, depending on the number of results, this may be supplementary material. This information will also be summarised and analysed both quantitatively and qualitatively. For example, as the Illness-Death model [8] is simple and common amongst multi-state models, we will count how many of the MSCPMs use this structure as well as the other most common structures used. Any direct comparisons that can be made between predictions of this type (i.e. from the same field with the same outcomes) will be described.



<!--chapter:end:02-Scoping_Review_Paper.Rmd-->


# How unmeasured confounding in a competing risks setting can affect treatment effect estimates in observational studies {#chap-Conf-CR}
*MA Barrowman, N Peek, M Lambie, GP Martin, M Sperrin*
\chaptermark{Competing Risks and Unmeasured Confounding}
Last updated: 21 Apr


Published as: **MA Barrowman**, N Peek, M Lambie et al, How unmeasured confounding in a competing risks setting can affect treatment effect estimates in observational studies, BMC Medical Research Methodology (2019) doi: [10.1186/s12874-019-0808-7](https://doi.org/10.1186/s12874-019-0808-7)

## Abstract {-}

### Background {-}
Analysis of competing risks is commonly achieved through a cause specific or a subdistribution framework using Cox or Fine & Gray models, respectively. The estimation of treatment effects in observational data is prone to unmeasured confounding which causes bias. There has been limited research into such biases in a competing risks framework.

### Methods {-}
We designed simulations to examine bias in the estimated treatment effect under Cox and Fine & Gray models with unmeasured confounding present. We varied the strength of the unmeasured confounding (i.e. the unmeasured variable's effect on the probability of treatment and both outcome events) in different scenarios.

### Results {-}
In both the Cox and Fine & Gray models, correlation between the unmeasured confounder and the probability of treatment created biases in the same direction (upward/downward) as the effect of the unmeasured confounder on the event-of-interest. The association between correlation and bias is reversed if the unmeasured confounder affects the competing event. These effects are reversed for the bias on the treatment effect of the competing event and are amplified when there are uneven treatment arms.

### Conclusion {-}
The effect of unmeasured confounding on an event-of-interest or a competing event should not be overlooked in observational studies as strong correlations can lead to bias in treatment effect estimates and therefore cause inaccurate results to lead to false conclusions. This is true for cause specific perspective, but moreso for a subdistribution perspective. This can have ramifications if real-world treatment decisions rely on conclusions from these biased results. Graphical visualisation to aid in understanding the systems involved and potential confounders/events leading to sensitivity analyses that assumes unmeasured confounders exists should be performed to assess the robustness of results.

### Supplementary Material {-}

Supplementary Material is in Appendix \@ref(chap-Conf-CR-supp)


## Background

Well-designed observation studies permit researchers to assess treatment effects when randomisation is not feasible. This may be due to cost, suspected non-equipoise treatments or any number of other reasons [1]. While observational studies minimise these issues by being cheaper to run and avoiding randomisation (which, although unknown at the time, may prescribe patients to worse treatments), they are potentially subject to issues such as unmeasured confounding and increased possibility of competing risks (where multiple clinically relevant events occur). Although these issues can arise in any study, Randomised Controlled Trials (RCTs) attempt to mitigate these effects by using randomisation of treatment and strict inclusion/exclusion criteria. However, the estimated treatment effects from RCTs are of potentially limited generalisability, accessibility and implementability [2].

A confounder is a variable that is a common cause of both treatment and outcome. For example, a patient with a high Body Mass Index (BMI) is more likely to be prescribed statins [3], but are also more likely to suffer a cardiovascular event. These treatment decisions can be affected by variables that are not routinely collected (such as childhood socio-economic status or the severity of a comorbidity [4]. Therefore, if these variables are omitted form (or unavailable for) the analysis of treatment effects in observational studies, then they can bias inferences [5]. As well as having a direct effect on the event-of-interest, confounders (along with other covariates) can also have further reaching effects on a patient's health by changing the chances of having a competing event. Patients who are more likely to have a competing event are less likely to have an event-of-interest, which can affect inferences from studies ignoring the competing event. In the above BMI example, a high BMI can also increase a patient's likelihood of developing (and thus dying from) cancer [6].

The issue of confounding in observational studies has been researched previously [7,8,9], where it has been consistently shown that unmeasured confounding is likely to occur within these natural datasets and that there is poor reporting of this, even after the introduction of the The Strengthening the Reporting of Observational Studies in Epidemiology (STROBE) Guidelines [10, 11]. Hence, it is widely recognised that sensitivity analyses are vital within the observational setting [12]. However these previous studies do not extend this work into a competing risk setting, meaning research in this space is lacking [13], particularly where the presence of a competing event can affect the rate of occurrence of the event-of-interest. These issues will commonly occur in elderly and comorbid patients where treatment decisions are more complex. As the elderly population grows, the clinical community needs to understand the optimal way to treat patients with complex conditions; here, causal relationships between treatment and outcome need to account for competing events appropriately.

The most common way of analysing data that contains competing events is using a cause specific perspective, as in the Cox methodology [14], where competing events are considered as censoring events and analysis focuses solely on the event-of-interest. The alternative is to assume a subdistributional perspective, as in the Fine & Gray methodology [15], where patients who have competing events remain in the risk set forever.

The aim of this paper is to study the bias induced by the presence of unmeasured confounding on treatment effect estimates in the competing risks framework. We investigated how unmeasured confounding affects the apparent effect of treatment under the Fine & Gray and the Cox methodologies and how these estimates differ from their true value. To accomplish this, we used simulations to generate synthetic time-to-event-data and then model under both perspectives. Both the Cox and Fine & Gray models provide hazard ratios to describe the effects of a covariate. A binary covariate will represent a treatment and the coefficients found by the model will be the estimate of interest.

## Methods

We considered a simulation scenario in which our population can experience two events; one of which is the event-of-interest (Event 1), the other is a competing event (Event 2). We model a single unmeasured confounding covariate, $U \sim N (0,1)$ and a binary treatment indicator, $Z$. We varied how much $U$ and $Z$ affect the probability distribution of the two events as well as how they are correlated. For example, $Z$ could represent whether a patient is prescribed statins, $U$ could be their BMI, the event-of-interest could be cardiovascular disease related mortality and a competing event could be cancer-related mortality. We followed best practice for conducting and reporting simulations studies [16].

The data-generating mechanism defined two cause-specific hazard functions (one for each event), where the baseline hazard for event 1 was $k$ times that of event 2, see Fig. \@ref(fig:Transition_Diagram). We assumed a baseline hazard that was either constant (exponential distributed failure times), linearly increasing (Weibull distributed failure times) or biologically plausible [17]. The hazards used were thus:


\begin{align}
\lambda_1(t|U,Z) &= ke^{\beta_1U + \gamma_1Z}\lambda_0(t)\\
\lambda_2(t|U,Z) &= ke^{\beta_2U + \gamma_2Z}\lambda_0(t)
\end{align}

\begin{equation}
\lambda_0(t) \begin{cases}
1 & \textrm{Exponential}\\
2t & \textrm{Weibull}\\
\exp{-18+7.3t-11.5t^{0.5}\log(t) + 9.5t^{0.5}} & \textrm{Plausible}
\end{cases}
\end{equation}


In the above equations, $\beta$ and $\gamma$ are the effects of the confounding covariate and the treatment effect respectively with the subscripts representing which event they are affecting. These two hazard functions entirely describe how a population will behave [18].

\includegraphics[width=450px]{figure/CR_Conf/Transition_Diagram} 

We simulated populations of 10,000 patients to ensure small confidence intervals around our treatment effect estimates in each simulation. Each simulated population had a distinct value for $\beta$ and $\gamma$. In order to simulate the confounding of $U$ and $Z$, we generated these values such that $\textrm{Corr}(U,Z) = \rho$ and $\Pr(Z = 1) = \pi$ [19]. Population end times and type of event were generated using the relevant hazard functions. The full process for the simulations can be found in Additional file 1. Due to the methods used to generate the populations, the possible values for $\rho$ are bounded by the choice of $\pi$ such that when $\pi = 0.5$, $\left|\rho\right| <= 0.797$ and when $\pi = 0.1$ (or $\pi=0.9$), $\left|\rho\right| <= 0.57$. The relationship between the parameters can be seen in the Directed Acyclic Graph (DAG) shown in Fig. \@ref(fig:Model_DAG), where $T$ is the event time and $\delta$ is the event type indicator (1 for event-of-interest and 2 for competing event).



\begin{center}\includegraphics[width=450px]{figure/CR_Conf/DAG} \end{center}

From this, we also explicitly calculated what we would expect the true subdistribution treatment effects, $\Gamma_1$ and $\Gamma_2$, to be in these conditions [20] (See Additional file 2). It's worth noting that the values of $\Gamma$ will depend on the current value of $\rho$ since they are calculated using the expected distribution of end-times. However, it has been shown [18, 21] that, due to the relationship between the Cause-Specific Hazard (CSH) and the Subdistribution Hazard (SH), only one proportional hazards assumption can be true. Therefore the "true" values of the $\Gamma$ will be misspecified and represent a least false parameter (which itself is an estimate of the time-dependent truth) [20].


We used the simulated data to estimate the treatment effects under the Cox and Fine & Gray regression methods. We specify that $U$ is unmeasured and so it wasn't included in the analysis models. As discussed earlier, the Cox model defines the risk set at time $t$ to be all patients who have not had any event by time $t$, whereas the Fine & Gray defines it to be those who have not had the event-of-interest (or competing event) by time $t$.


For our models, for the events, $i={1,2}$, we therefore defined the CSH function estimate, $\hat{\lambda}_i$, and the SH function estimate, $\hat{h}_i$, to be

$$
\hat{\lambda}_i(t|Z) = \hat{\lambda}_{i0}(t)e^{\hat{\gamma}_iZ} \qquad\qquad 
\hat{h}_i(t|Z) = \hat{h}_{i0}(t)e^{\hat{\Gamma}_iZ}
$$


Where $\hat{\lambda}_{i0}(t)$ and $\hat{h}_{i0}(t)$ are the baseline hazard and baseline subdistribution hazard function estimates for the entire population (i.e. no stratification), and $\hat{\gamma}_i$ and $\hat{\Gamma}_i$ are the estimated treatment effects. From these estimates, we also extracted the estimate of the subdistribution treatment effect in a hypothetical RCT, where $\rho=0$ and $\pi=0.5$ to give $\hat{\Gamma}_{10}$ and  $\hat{\Gamma}_{20}$. To investigate how the correlation between $U$ and $Z$ affects the treatment effect estimate, we compared the explicitly prescribed or calculated values with the simulated estimates. Three performance measures for both events, along with appropriate 95% confidence intervals, were calculated for each set of parameters:

* $\theta_{\textrm{RCT},i} = \textrm{E}\left[\hat{\Gamma}_i - \hat{\Gamma}_{i0}\right]$ ~ The average difference between the SH treatment effect estimate from an idealised, hypothetical RCT situation.

* $\theta_{\textrm{Exp},i} = \textrm{E}\left[\hat{\Gamma}_i - \Gamma_i\right]$ ~ The average bias of the SH treatment effect estimate from the explicitly calculated value.

* $\theta_{\textrm{CSH},i} = \textrm{E}\left[\hat{\gamma}_i - \gamma_i\right]$ ~ The average bias of the CSH treatment effect estimate from the predefined treatment effect.

As mentioned above, the value of $\Gamma$ will depend on the current value of $\rho$ and so the estimation of the explicit bias will be a measure of the total bias induced on our estimate of the subdistribution treatment effect in those specific set of parameters. We also evaluate the bias compared to an idealised RCT to see how much of this bias could be mitigated if we were to perform an RCT to assess the effectiveness of the hypothetical treatment. Finally, we found the explicit bias in the cause specific treatment effect to again see the total bias applied to this measure. We did not compared the CSH bias to an idealised RCT as we believed that this could easily be inferred from the CSH explicit results, whereas this information wouldn't be as obvious in the SH treatment effect due to the existence of a relationship between $\Gamma$ and $\rho$.

Eight Scenarios were simulated based on real-world situations. In each scenario, $\rho$ varied across 5 different values ranging from 0 to their maximum possible value (0.797 for all Scenarios apart from Scenario 5, where it is 0.57, due to the bounds imposed by the values of $\pi$). One other parameter (different for different scenarios) varied across 3 different values, and all other parameters were fixed as detailed in Table 1. Each simulation was run 100 times and the performance measures were each pooled to provide small confidence intervals. This gives a total of 1,500 simulations for each of the 8 scenarios. Descriptions of the different scenarios are given below:

1. No Effect. To investigate whether treatment with no true effect ($\gamma_2=\gamma_2=0$) can have an "artificial" treatment effect induced on them in the analysis models through the confounding effect on the event-of-interest. $\beta_1$ varied between -1, 0 and 1.

2. Positive Effect. To investigate whether treatment effects can be reversed when the treatment is beneficial for both the event-of-interest and the competing event ($\gamma_2=\gamma_2=-1$). $\beta_1$ varied between -1, 0 and 1.

3. Differential Effect. To investigate how treatment effect estimates react when the effect is different for the event-of-interest ($\gamma_2=-1$) and the competing event ($\gamma_2=1$). $\beta_1$ varied between -1, 0 and 1.

4. Competing Confounder. To investigate whether treatments with no true effect ($\gamma_1=\gamma_2=0$) can have an "artificial" treatment effect induced on them by the effect of a confounded variable on the competing event only ($\beta_1=0$). $\beta_2$ varied between -1, 0 and 1.

5. Uneven Arms. To investigate how having uneven arms on a treatment in the population can have an effect on the treatment effect estimate ($\gamma_1=-1$, $\gamma_2=0$). $\pi$ varied between $\sfrac{1}{10}$, $\sfrac{1}{2}$ and $\sfrac{9}{10}$.

6. Uneven Events. To investigate how events with different frequencies can induce a bias on the treatment effect, despite no treatment effect being present ($\gamma_1=\gamma_2=0$). $k$ varied between $\sfrac{1}{2}$, $\sfrac{1}{2}$ and 2.

7. Weibull Distribution. To investigate whether a linearly increasing baseline hazard function affects the results found in Scenario 1. $\beta_1$ varied between -1, 0 and 1.

8. Plausible Distribution. To investigate whether a biologically plausible baseline hazard function affects the results found in Scenario 1. $\beta_1$ varied between -1, 0 and 1.

[**Insert Table 1**]

## Results

The first row of Fig. 3 shows the results for Scenario 1 (No Effect). When $\beta_1=\beta_2=0$ (the green line), correlation between $U$ and $Z$ doesn't imbue any bias on the treatment effect estimate for either event under any of the three measures, since all of the subdistribution treatment effects (estimated, calculated and hypothetical RCT) are approximately zero. When $\beta_1>0$, there is a strong positive association between correlation ($\rho$) and the RCT and CSH biases for the event-of-interest and a negative association for the RCT bias for the competing event. Similarly, these associations are reversed when $\beta_1<0$.





There was no effect on $\theta_{\textrm{CSH}}$ for the competing event in this Scenario regardless of $\rho$ or $\beta_1$. These results are similar to those found in Scenario 2 (Positive Effect) and Scenario 3 (Negative Effect) shown in Figs. 4 and 5. However, in both of these Scenarios, there is an overall positive shift in $\theta_{\textrm{CSH}}$ when $\beta_1\neq0$.




The magnitude of $\theta_{\textrm{Exp}}$ is greatly reduced and is the reverse of the other associations when $\beta_1\neq0$ in Scenario 1 for the event-of-interest and when $\beta_1>0$ it stays extremely small for low values of $\rho$, and becomes negative for large $\rho$ for the competing event. In Scenario 2, $\theta_{\textrm{Exp}}$ behaves similarly to Scenario 1 for both events when $\beta_1<0$ and the event-of-interest, but for the competing event, when $\beta_1>0$, the $\theta_{\textrm{Exp}}$ is much tighter to 0. The competing event data for $\theta_{\textrm{Exp}}$ in Scenario 3 is similar to Scenario 2 with $\beta_1>0$ shifted downwards, but the event-of-interest has a near constant level of bias regardless of $\rho$, apart from in the case when $\beta_1<0$, the bias switches direction.




In Scenario 4 (Competing Confounder), as would be expected, the results for the event-of-interest and the results for the competing event are swapped from those of Scenario 1 as shown in Fig. 6. Scenario 5 (Uneven Arms) portrays a bias similar to Scenario 1 where $\beta_1=1$, however, the magnitude of the RCT and CSH bias is increased when $\pi\neq0.5$ as shown in Fig. 7.





The parameters for Scenario 6 (Uneven Events) were similar to the parameters for Scenario 1 (No Effect), when $\beta_1=1$. This also reflects in the results in Fig. 8 which look similar to the results for this set of parameters in Scenario 1. This bias is largely unaffected by the value of $k$. The results of Scenario 7 (Weibull Distribution) and Scenario 8 (Plausible Distribution) were nearly identical to those of Scenario 1 as shown in Figs. 9 and 10.





As per our original hypotheses, Scenario 1 demonstrated that it is possible to induce a treatment effect when one isn't present through confounding effects on all biases, apart from the competing event CSH. In Scenario 2, with high enough correlation, the CSH event-of-interest bias could be greater than 1, meaning that the raw CSH treatment effect was close to 0, despite an actual treatment effect of -1, similarly large positive biases in the SH imply a treatment with no benefit and/or detrimental effect, despite the true treatment being beneficial for both events. This finding is similar for Scenario 3 with large biases changing the direction of the treatment effect (beneficial vs detrimental).




Scenario 4 demonstrated that even without a treatment effect and with no confounding effect on the event-of-interest, a treatment effect can be induced on the SH methodology, which can imply a beneficial/detrimental treatment, depending on whether the confounder was detrimental/beneficial. Fortunately, it does not induce an effect on the CSH treatment effect for the event-of-interest.




Scenarios 5 and 6 investigated other population level effects; differences in the size of the treatment arms and differences in the magnitude of the hazards of the events. Scenario 5 demonstrated that having uneven treatment arms can exacerbate the bias induced on both the $\theta_{\textrm{RCT}}$ and $\theta_{\textrm{CSH}}$ for both events and Scenario 6 showed that the different baseline hazards had little effect on the levels of bias in the results. This finding was supported by the additional findings of Scenarios 7 and 8, which showed that the underlying hazard functions did not affect the treatment effect biases compared to a constant hazard.





## Discussion

This is the first paper to investigate the issue of unmeasured confounding on a treatment effect in a competing risks scenario. Herein, we have demonstrated that regardless of the actual effect of a treatment on a population that is susceptible to competing risks, bias can be induced by the presence of unmeasured confounding. This bias is largely determined by the strength of the confounding relationship with the treatment decision and size of confounding effect on both the event-of-interest and any competing events. This effect is present regardless of any difference in event rates between the events being investigated and is also exacerbated by misbalances in the number of patients who received treatment and the number of patients who did not.

Our study has shown how different the case would be if a similar population (without inclusion/exclusion criteria) were put through an RCT and how the correlation between an unmeasured confounder and the treatment is removed, as would be the case in a pragmatic RCT. By combining the biases from an RCT and the explicitly calculated treatment effect, we can also use these results to infer how much of the bias found here is from omitted variable bias [22] and how much is explicitly due to the correlation between the covariates. Omitted variable bias occurs when a missing covariate has an effect on the outcome, but is not correlated with the treatment (and so is not a true confounder). It can occur even if the omitted variable is initially evenly distributed between the two treatment arms because, as patients on one arm have events earlier than the other, the distributions of the omitted variable drift apart. This makes up some of the bias caused by unmeasured confounding, but not all of it. For example, in Scenario 3 (Differential Effect), the treatment lowered the hazard of the event-of-interest, but increased the hazard of the competing event; with a median level of correlation ($\rho=0.4$), the event-of-interest bias from the RCT when there is a negative confounding effect ($\beta_1<0$) is -0.628 and the bias from the explicit estimate is $0.295$ and therefore, the amount of bias due purely to the correlation between the unmeasured confounder and the treatment is actually -0.923. In this instance, some of the omitted variable bias is actually mitigating the bias from the correlation; if we have two biasing effects that can potentially cancel each other out, we could encounter a Type III error [23] which is very difficult to prove and can cause huge problems for reproducibility (if you eliminate a single source of bias, your results will be farther from the truth).

Our simulations indicate that a higher (lower) value of $\beta_1$ and a lower (higher) value of $\beta_2$ will produce a higher (lower) bias in the event-of-interest. These two biasing effects could cancel out to produce a situation similar to above. In our scenarios, we saw that, even when a treatment has no effect on the event-of-interest or a competing event (i.e. the treatment is a placebo), both a cause specific treatment effect and a subdistribution treatment effect can be found. This also implies that the biasing effect of unmeasured confounders (both omitted variable and correlation bias) can result in researchers reaching incorrect conclusions about how a treatment affects a population in multiple ways. We could have a treatment that is beneficial for the prevention of both types of event, but due to the effects of an unmeasured confounder, it could be found to have a detrimental effect (for one or both) on patients from a subdistribution perspective.

Our investigation augments Lin et al's study into unmeasured confounding in a Cox model [5] by extending their conclusion (that bias is in the same direction as the confounder's effect and dependent on its strength) into a competing risks framework (i.e. by considering the Fine & Gray model as well) and demonstrating that this effect is reversed when there is confounding with the competing event. Lin et al. [5] also highlight the problems of omitted variable bias, which comes from further misspecification of the model; this finding was observed in our results as described above for Scenario 3.

The results from Scenario 7 (Weibull Distribution) and Scenario 8 (Plausible Distribution) are almost identical to those of Scenario 1 (No Effect) which implies that, by assuming both hazard functions in question are the same, we can assume they are both constant for simplicity. Since both the Cox and Fine & Gray models are ambiguous to underlying hazard functions and treatment effects are estimated without consideration for the baseline hazard function, it makes intuitive sense that the results would be identical regardless of what underlying functions were used to generate our data. This makes calculation of the explicit subdistribution treatment effect much simpler for future researchers.

Thompson et al. used the paradox that smoking reduces melanoma risk to motivate simulations similar to ours, which demonstrated how the exclusion of competing risks, when assessing confounding, can lead to unintuitive, mis-specified and possibly dangerous conclusions [24]. They hypothesised that the association found elsewhere [25] may be caused by bias due to ignoring competing events and used Monte Carlo simulations to provide examples of scenarios where these results would be possible. They demonstrated how a competing event could cause incorrect conclusions when that competing event is ignored - a conclusion we also confirm through the existence of bias induced on the Cox modelled treatment effect even with no correlation between the unmeasured confounder and treatment (i.e. $\theta_{\textrm{CSH,1}} \neq 0$ in Scenarios 2 & 3). Thompson's team began with a situation where there may be a bias due to a competing event and reverse-engineered a scenario to find the potential sources of bias, whereas our study explored different scenarios and investigated the biased results they potentially produced.

Groenwold et al. [26] proposed methods to perform simulations to evaluate how much unmeasured confounding would be necessary for a true effect to be null given that an effect has been found in the data. Their methods can easily be applied to any metric in clinical studies (such as the different hazard ratios estimated here). Currently, epidemiologists will instigate methods such as DAGs, see Fig. \@ref(fig:Model_DAG), to visualise where unmeasured confounding may be a problem in analysis [27] and statisticians who deal with such models will use transition diagrams, see Fig. \@ref(fig:Model_Transitions), to visualise potential patient pathways [28]. Using these two visualisation techniques in parallel will allow researchers to anticipate these issues, successfully plan to combat them (through changes to protocol or sensitivity analysis, etc. ...) and/or implement simulations to seek hidden sources of bias (using the methods of Groenwold [26] and Thompson [24]) or to adjust their findings by assuming biases similar to those demonstrated in our paper exist in their work.



The work presented here could be extended to include more complicated designs such as more competing events, more covariates and differing hazard functions. However, the intention of this paper was to provide a simple dissection of specific scenarios that allow for generalisation to clinical work. The main limitation of this work, to use of the same hazard functions for both events in each of our scenarios, was a pragmatic decision made to reduce computation time. The next largest limitation was the lack of censoring events, and was chosen to simplify interpretation of the model. This situation is unlikely to happen in the real world. However, since both the Cox and the Fine & Gray modelling techniques are robust to any underlying baseline hazard and independent censoring of patients [14, 15, 29], these simplifications should not have had a detrimental effect on the bias estimates given in this paper. This perspective on censoring is similar to the view of Lesko et al. [30] in that censoring would provide less clarity of the presented results.

## Conclusion

This paper has demonstrated that unmeasured confounding in observational studies can have an effect on the accuracy of outcomes for both a Cox and a Fine & Gray model. We have added to the literature by incorporating the effect of confounding on a competing event as well as on the event-of-interest simultaneously. The effect of confounding is present and reversed compared to that of confounding on the event-of-interest. This makes intuitive sense as a negative effect on a competing event has a similar effect at the population level as a positive effect on the event-of-interest (and vice versa). This should not be overlooked, even when dealing with populations where the potential for competing events is much smaller than potential for the event-of-interest and is especially true when the two arms of a study are unequal. Therefore, we recommend that research with the potential to suffer from these issues be accompanied by sensitivity analyses investigating potential unmeasured confounding using established epidemiological techniques applied to any competing events as well as the event-of-interest. In short, unmeasured variables can cause problems with research, but by being knowledgeable about what we don't know, we can make inferences despite this missing data.





<!--chapter:end:03-CR_Conf.Rmd-->


# Inverse Probability Weighting Adjustment of the Logistic Regression Calibration-in-the-Large {#chap-IPCW-logistic}
*MA Barrowman, A Pate, GP Martin, CJM Sammut-Powell, M Sperrin*
\chaptermark{IPCW Calibration-in-the-Large}
Last updated: 23 May



## Abstract {-}

### Introduction {-}

### Methods {-}

### Results {-}

### Discussion {-}


### Supplementary Material {-}

 Supplementary Material is available in Appendix \@ref(chap-dev-paper-supp).



## Introduction

Clinical prediction models (CPMs) are statistical models/algorithms that aim to predict the presence (diagnostic) or furture occurence (prognostic) of an event of interest, conditional on a set of predictor variables. Before they be implemented in practice, CPMs must be robustly validated. They need to be validated before they are used and a fundamental test of their validity is calibration: the agreement between observed and predicted outcomes. This requires that among individuals with $p\%$ risk of an event, $p\%$ of those have the event across the full risk range [@steyerberg_clinical_2008]. The simplest assessment of calibration is the calibration-in-the-large, which tests for agreement in mean calibration (the weakest form of calibration) [@calster_calibration_2016-1]. With continuous or binary outcomes, such a test is straight-forward: it can be translated to a test for a zero intercept in a regression model with an appropriately transformed linear predictor as an offset, and no other predictors. More complicated measurements of calibration can also be assessed to descibe how calibration changes across the risk range, such as calibration slope (see Appendix \@ref(chap-IPCW-logistic-supp)). Calibration alone is not enough to fully assess a model's performance however and so we also need measures of discrimination (how well models discern between different patients), e.g the c-statistic and overall accuracy, e.g. the Brier Score.






In the case of time to event models, however, estimation of calibration is complicated in three ways. First, calibration can be computed at multiple time-points and one must decide which time-points to evaluate, and how to integrate over these time-points. The choice and combination of time-points determines what we mean by calibration; this is problem-specific and not the focus of this paper. Calibration can also be integrated over time using the martingale residuals [@crowson_assessing_2016]; however we focus on the case where calibration at a specific time point is of interest - e.g. as is common in clinical decision support. Second, there exists no explicit intercept in the model because of the non-parametric baseline hazard function [@royston_external_2013]. The lack of intercept can be overcome provided sufficient information concerning the baseline survival curve is available (although this is rarely the case as seen in QRISK [@hippisley-cox_2007], ASCVD [@goff_2013_2014] and ASSIGN [@de_la_iglesia_performance_2011]. Once this is established, estimated survival probabilities are available.

Third, censoring needs to be handled in an appropriate way. This is commonly overcome by using Kaplan-Meier estimates  [@royston_external_2013;@hippisley-cox_derivation_2007], but the censoring assumptions required for the Kaplan-Meier estimate are stronger than those required for the Cox model: the former requiring unconditional independence (random censoring), the latter requiring independence conditional on covariates only. This is a problem because when miscalibration is found using this approach, it is not clear whether this is genuine miscalibration or a consequence of the different censoring assumptions. Royston [@royston_tools_2014;@royston_tools_2015] has proposed the comparison of KM curves within risk groups, which alleviates the strength of the independence assumption required for the censoring handling to be comparable between the Cox model and the KM curves (since the KM curves now only assume independent censoring within risk group). In these papers a fractional polynomial approach to estimating the baseline survival function (and thus being able to share it efficiently) is also provided. However, this does not allow calculations of the overall calibration of the model, which is of primary interest here.


QRISK used the overall KM approach in the 2007 paper [@hippisley-cox_derivation_2007] with good results (6.34% predicted vs 6.25% observed in women and 8.86% predicted vs 8.88% observed in men), but worse results in the QRISK3 update [@hippisley-cox_development_2017] (4.7% predicted v 5.8% observed in women and 6.4% predicted vs 7.5% observed in men ). This may be because, as follow-up extends, the dependence of censoring on the covariates increases (QRISK had 12 years follow-up, QRISK3 had 18) and an important change between the update was the lower age limit moved from 35 to 25, as well as the implementation of QRISK in clinical practice [**I remember discussing this with Alex & Matt a while ago as to whether the use of QRISK had a feedback loop when updated after it's own implementation. Did this go any further?**].

Royston [@royston_tools_2014] also presented an alternative approach for calibration at external validation. He uses the approach of pseudo-observations, as described by Perme and Anderson [@perme_checking_2008] to overcome the censoring issue and produce observed probabilities at individual level; however, this assumes that censoring is independent of covariates.

A solution to this problem is to apply a weighting to uncensored patients based on their probability of being censored according to a model that accounts for covariates.  The Inverse Probability of Censoring Weighting (IPCW)  relaxes the  assumption that patients who were censored are identical to those that remain at risk and replaces it with the assumption that they are exchangeable conditional on the measured covariates. The weighting inflates the patients who were similar to the censored population to account for those patients who are no longer available at a given time.

Gerds & Schumacher [@gerds_consistent_2006] have thoroughly investigated the requirements and advantages of applying an IPCW to a performance measure for modelling using the Brier score as an example and demonstrating the efficacy of its use, which was augmented by Spitoni et al [@spitoni_prediction_2018] who demonstrated that any proper scoring rule can be improved by the use of the IPCW. This work has been extended by Han et al [@han_comparing_2017] and Liu et al [@liu_comparing_2016] who demonstrated one can also apply IPCW to the c-statistic (a measure of discrimination). 



In this paper we present an approach to assessing the calibration intercept (calibration-in-the-large) and calibration slope in time-to-event models based on estimating the censoring distribution, and reweighting observations by the inverse of the censoring probability. We first show, theoretically, how this method can be used and evidence that the metrics for calibration are amenable to its use. We then compare simulation results from using this weighted estimate to an unweighted estimate within various commonly used methods of calibration assessment.


## Methods

### Theory

[**Lots of Theory work on the probabilities. May need to drop this if we're unable to do it between us.**]

### Aims

The aim of this simulation study is to investigate the bias induced by applying different methods of assessing model calibration to data that is susceptible to censoring and to compare it to the bias when this data has been adjusted by the Inverse Probability of Censoring Weighting (IPCW). 

### Data Generating Method

We simulated populations of patients with survival and censoring times, and took the observed event time as the minimum of these two values along with an event indicator of whether this was the survival or censoring time [@burton_design_2006]. Each population was simulated with three parameters: $\beta$, $\gamma$ and $\eta$, which defined the proportional hazards coefficients for the survival and censoring distributions and the baseline hazard function, respectively.



Patients were generated with a single covariate $Z \sim N(0,1)$ from which, we then generated a survival time, $T$ and a censoring time, $C$. Survival times were simulated with a baseline hazard $\lambda_0(t) = t^{\eta}$ (i.e. Weibull), and a proportional hazard of $e^{\beta Z}$. This allows the simulation of a constant baseline hazard ($\eta = 0$) as well as an increasing ($\eta = \sfrac{1}{2}$) and decreasing ($\eta = -\sfrac{1}{2}$) hazard function Censoring times were simulated with a constant baseline hazard, $\lambda_{C,0}(t) = 1$ and a proportional hazard of $e^{\gamma Z}$. <mark>This combines to give a simulated survival function, $S$ as
$$
S(t|Z=z) = \exp\left(-\frac{e^{\beta Z}t^{\eta+1}}{\eta+1}\right)
$$
and a simulated censoring function, $S_c$ as
$$
S_c(t|Z=z) = \exp\left(-e^{\gamma Z}t\right)
$$

</mark>

Once the survival and censoring times were generated, the event time, $X = \min(T,C)$, and the event indicator, $\delta = I(T=X)$, were generated. In practice, only $Z$, $X$ and $\delta$ would be observed.












During each simulation, we varied the parameters to take all the values,$\gamma = \{-2,-1.5,-1,-0.5,0,0.5,1,1.5,2\}$, $\beta = \{-2,-1.5,-1,-0.5,0,0.5,1,1.5,2\}$ and $\eta = \{-\sfrac{1}{2},0,\sfrac{1}{2}\}$. For each combination of parameters, we generated $N = 100$ populations of $n = 10,000$ patients (a high number of patients was chosen to improve precision of our estimates)
 
 
### Prediction Models

[**New section, taken from previous snippets, highlighting/strikethroughs will show the new changes**]

For each population, we used three distinct prediction models  for survival. $F_P$ was chosen to exactly model the Data Generating Mechanism (DGM) to emulate a perfectly specified model:

$$
\begin{array}{c}
F_P(t|Z = z) = 1 - \exp\left(-\frac{e^{\beta Z}t^{\eta+1}}{\eta+1}\right)
\end{array}
$$
From this, we also derived a prediction model that would systematically over-estimate the prediction model, $F_O$, and one which would systematically under-estimate the prediction, $F_U$. These are defined as:

$$
\begin{array}{rl}
F_U(t|Z=z) =& \logit^{-1}\left(\logit\left( F_P(t|z) - 0.2\right)\right)
\end{array}
$$
$$
\begin{array}{rl}
F_O(t|Z=z) =& \logit^{-1}\left(\logit\left( F_P(t|z) + 0.2\right)\right)
\end{array}
$$

These prediction models were used to generate an estimate of the Expected probability that a given patient, with covariate $z$, will have an event at the given time.

### The IPCW

In order to apply the IPCW, we need to calculate a censoring prediction model. For our purposes, we will again use a perfectly specified censoring distribution, $G$, to be derived directly from the DGM:

$$
\begin{array}{c}
G(t|Z=z) = 1-\exp\left(-e^{\gamma Z}t\right)
\end{array}
$$
This is used to calculate an IPCW for all non-censored patients at the last time they were observed ($t$ for patients who have not had an event, and $X_i$ for patients who have had the event), This is defined as:


$$
\begin{array}{c}
\omega(t|z) = \frac{1}{1 - G(\min(t,X_i)|z)}
\end{array}
$$

### Calibration Measurements

The prediction models were assessed at 100 time points, evenly distributed between the 25th and 75th percentile of observed event times, $X$. At each of these time points, we compare Observed outcomes ($O$) with the Expected outcomes ($E$) of the prediction models based on four choices of methodology [@royston_tools_2014;@royston_tools_2015;@riley_prognosis_2019;@andersen_pseudo-observations_2010] to produce measures for the calibration-in-the-large

* Kaplan-Meier (KM) - A Kaplan-Meier estimate of survival is estimated from the data and the value of the KM curve at the current time is taken to be the average Observed number of events within the population and this is compared with the average Expected value.
* Logistic Unweighted (LU) - Logistic regression is performed on the non-censored population to predict the binary Observed value using the logit(Expected) value as an offset and the Intercept of the regression is the estimate of calibration-in-the-large.
* Logistic Weighted (LW) - As above, but the logistic regression is performed using the IPCW as a weighting for each non-censored patient.
* Pseudo-Observations (PO) - The contribution of each patient (including censored patients) to the overall Observed value is calculated by removing them from the population and aggregating the difference. Regression is performed with the complimentary log-log function as a link function and the log cumulative hazard as an offset with the Intercept representing the estimate of calibration-in-the-large.

Some of these methods produce unusual results for the regressions. Firstly, the weights within the LW method cause the "number of events" being processed (i.e the sum of the weighted events) to be non-integer. This is a minor issue and can be dealt with by most software packages [@wildscop_biostatistics_2013]. Secondly, the PO method produces outcomes that are outside of the (0,1) range [@perme_checking_2008] required for the complimentary log-log function. To combat this, we re-scale the values produced to be with this range and perform the regression as normal.


### Estimands

For each set of parameters and methodology, our estimand at time, $t$, measured in simulation $i = 1,...,N$ is $\theta_i(t)$, the set of estimates of the calibration-in-the-large for the $F_P$, $F_U$ and $F_O$ models in order. Therefore our underlying truth for all time points is

$$\begin{array}{c}
\theta = \left(0,0.2,-0.2\right)
\end{array}$$

From this, we can also define our upper and lower bound for a 95% confidence interval as the vectors $\theta_{i,L}(t)$ and $\theta_{i,U}(t)$.

### Performance Measures

The measures we will take as performance measures as the Bias, the Empirical Standard Error and the Coverage at time, $t$, along with relevant standard errors and confidence intervals as per current recommendations [@morris_using_2019]. These measures can be seen in table \@ref(tab:PM-DGM-time). For these estimates at each time point, Method and Model, the top and bottom 5% of all simulation estimates will be omitted, leaving $N=90$ to avoid biasing the results from singly large random effects.


\begin{table}

\caption{(\#tab:PM-DGM-time){\small Performance Measures to be taken at each time point}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{lll}
\toprule
Performance Measure & Estimation & SE\\
\midrule
\rowcolor{gray!6}  Bias & $\hat{\theta}(t) = \frac{1}{N} \sum_{i=1}^N\theta_i(t) - \theta$ & $\hat{\theta}_{SE}(t) = \sqrt{\frac{1}{N(N-1)} \sum_{i=1}^N \left(\theta_i(t) - \hat{\theta}(t)\right)^2}$\\
EmpSE & $\hat{E}(t) = \sqrt{\frac{1}{N-1}\sum_{i=1}^N\left(\theta_i(t) - \hat{\theta}(t)\right)^2}$ & $\hat{E}_{SE}(t)=\frac{\hat{E}(t)}{\sqrt{2(N-1)}}$\\
\rowcolor{gray!6}  Coverage & $\hat{C}(t)=\frac{1}{N}\sum_{i=1}^NI\left(\theta_{i,L}(t) \le \theta \le \theta_{i,U}(t)\right)$ & $\hat{C}_{SE}(t) = \frac{\hat{C}(t)\left(1-\hat{C}(t)\right)}{N}$\\
\bottomrule
\end{tabular}
\end{table}

The bias provides a measure of how close our estimate is to the true value as per our data generating mechanisms. The coverage will demonstrate how often our confidence intervals surrounding our estimate actually include this true value. The Empirical Standard Error will show us how precise our estimates are.



### Software

All analysis was done in `R 3.6.3` [@r_core_team_r_nodate] using the various `tidyverse` packages [@wickham_tidy_2017], Kaplan-Meier estimates were found using the `survival` package [@therneau_package_2020], Pseudo-Observations were evaluated with the `pseudo` package [@perme_pseudo_2017], and the results app was developed using `shiny`[@chang_shiny_2020]. The code used for this simulation study is available [on Github](https://github.com/MyKo101/IPCW-Logistic) and the results can be seen in a [shiny app](https://michael-barrowman.shinyapps.io/IPCW_Calibrations/?_ga=2.129261196.1072091615.1588464259-38998367.1584541320)

## Results

[**Results shown here are new and improved from the previous version. No highlighting is shown**]

\begin{figure}
\includegraphics[width=54.68in]{figure/IPCW_Logistic/MainPlot_b(1)_g(0)_e(0.5)} \caption{Bias, Coverage and Empirical Standard Error for the Over-estimating, Perfect and Under-Estimating models across all four methods when $\beta=1$, $\gamma=0$ and $\eta=\sfrac{1}{2}$. Confidence Intervals are included in the plot, but are tight around the estimate}(\#fig:MainPlotg0)
\end{figure}

Figure \@ref(fig:MainPlotg0) shows the results when censoring is independent of covariates ($\gamma=0$). The LW method provides strong coverage across the entire timeframe and miminal bias. The absolute bias for PO and LU increases over time with PO under-reporting the correct value and LO over-reporting. KM bias remains constant across the timeframe, but for the imperfect models, is constantly under- or over-reported. LU and PO also provide minimal coverage at all time points, whereas KM covers perfect in the early stages of the Perfect Model with coverage dropping off as time progresses. Empirical Standard Error is clse to 0 for all models.


\begin{figure}
\includegraphics[width=54.68in]{figure/IPCW_Logistic/MainPlot_b(1)_g(1)_e(0.5)} \caption{Bias, Coverage and Empirical Standard Error for the Over-estimating, Perfect and Under-Estimating models across all four methods when $\beta=1$, $\gamma=1$ and $\eta=\sfrac{1}{2}$. Confidence Intervals are included in the plot, but are tight around the estimate}(\#fig:MainPlotg1)
\end{figure}

Figure \@ref(fig:MainPlotg1) shows the results when censoring and the event-of-interest have the same individual effects ($\beta=\gamma=1$). The LW method provides strong coverage across the entire timeframe and miminal bias, although this coverage is reduced compared to the previous set of results shown (approximately 75% throughout). Once again, the absolute bias for PO and LU increases over time, however the under-reporting for PO is much more strongly pronounced. KM bias behaves similarly but for coverage, it starts off at around 50% coverage reaches a peak of full coverage approximately 25% of the way through the timeframe.


\begin{figure}
\includegraphics[width=54.68in]{figure/IPCW_Logistic/MainPlot_b(1)_g(-1)_e(0.5)} \caption{Bias, Coverage and Empirical Standard Error for the Over-estimating, Perfect and Under-Estimating models across all four methods when $\beta=1$, $\gamma=-1$ and $\eta=\sfrac{1}{2}$. Confidence Intervals are included in the plot, but are tight around the estimate}(\#fig:MainPlotg2)
\end{figure}

Figure \@ref(fig:MainPlotg2) shows the results when censoring and the event-of-interest have opposite individual effects ($\beta=1, \gamma=-1$). The bias results are similar to those when censoring is independent. A difference here is that coverage begins greater than zero for the KM, LU and PO methods, but quickly drops to 0 before the 25% time point. For LW, the coverage appears to reduce to around 80% by the end of the time point.


## Discussion

Weighting = Good.

Not Weighting = Bad.

**limitation**: Maybe the "True" $\theta$ for the under and over predictions were wrong and that would explain the low Coverage.







<!--chapter:end:04-IPCW_logistic.Rmd-->

# Prediction Model Performance Metrics for the Validation of Multi-State Clinical Prediction Models {#chap-performance-metrics}
*MA Barrowman, GP Martin, N Peek, M Lambie, M Sperrin*
\chaptermark{Development and Validation of MSCPM}
Last updated: 30 Apr



## Introduction

Clinical Prediction Models (CPMs) provide individualised risk of a patient's outcome (cite), based on that patient's predictors. These predictions will usually be in the form of a risk score or probability. However, using traditional modelling techniques, these CPMs will only predict a single outcome. Multi-State Clinical Prediction Models (MS-CPMs) combine the multi-state modelling framework to the prognostic field to provide predictions for multiple outcomes in a single model.
Once a CPM has been developed, it is important to assess how well the model actually performs (cite). This process is called Model Validation and involves comparing the predictions produced by the model to the actual outcomes experienced by patients (cite). It  is expected that the development of a CPM will be accompanied by the validation of the model on the same dataset it was developed in (internal validation), using either bootstrapping or cross-validation to account for optimism in the developed model (cite). Models can also be validated on a novel dataset (external validation), which is used to assess the generalisability and transportability of the model (cite).
 During validation, there are different aspects of model performance that we can assess and these are measured using specific metrics. For example, to assess the overall Accuracy of a model, we may use the Brier Score (cite) or to analyse how well a model discriminates between patients, we could use the c-statistic (cite).  The current metrics that are commonly used have been designed and extended to work in a variety of model development frameworks. However, these extensions are limited to either a single outcome (as in traditionally developed models) or do not adequately account for the censoring of patients (as commonly occurs in longitudinal data).
This paper aims to provide use-able extensions to current performance metrics to be used when validating MS-CPMs. It is essential that these extensions are directly comparable with current metrics (to allow for quicker adoption), that they are collapsible to the current metrics and that they adjust for the bias induced by the censoring of patients.
Currently, the most common way to validate an MS-CPMs is by applying traditional methods to compare across two states at a given time and then aggregating the results in an arbitrary manner [cite something]. Other methodologists have extended existing metrics to multinomial outcomes [cite van Calster], which do not contain a time-based component; to simple competing risks scenarios [cite CR c-statistic], which do not contain transient states; or to [... insert third relevant example]. Spitoni et al [cite Spitoni 2018]] developed methods to apply the Brier Score (or any proper score functions) to a multi-state setting and so a simplified and specific version of their work is described in this paper.
 It is the hope of the authors that this work will increase the uptake of multi-state models and the sub-field of MS-CPMs will grow appropriately.

## Motivating Data Set

[**Table One for The Glasgow Data**]

Throughout this paper we will use a model developed in Chronic Kidney Disease (CKD) patients to assess their progression onto Renal Replacement Therapy (RRT) and/or Death [cite Dev/Valid Paper]. The model was developed using data from the Salford Kidney Study (SKS) and then applied to an external dataset derived from the West of Scotland (see Table 2) [1]. The original model predicts the probability that a patient has begun RRT and/or died after their first recorded eGFR below 60 ml/min/1.73m2, by any time in the future (reliable up to 10 years). For the purposes of this paper, we will take a "snapshot" of the predictions at the 5 year time point.
The Three-State model used in our example is designed as an Illness-Death Model [2], this is one of the simplest MSM designs and has the key advantage over a traditional model that they can predict whether a patient is in or has visited the transient state before reaching the absorbing state (i.e. patient who became ill before dying or who started RRT before dying) (see figure 1). 

[**Figure of the MSM**]

[**Describe Glasgow Data**]

## Current Approaches

Here we describe three commonly used performance metrics  for assessing the performance of a traditional survival  clinical prediction model. These metrics assess the Accuracy, Discrimination and Calibration of the models being validated. Accuracy is an overall measurement of how well the model predicts the outcomes in the patients. Discrimination assesses how well the model discerns between patients; in a two-state model this is a comparison of patients with and without the outcome, and should assign a higher value to those that experience the outcome. Calibration is the agreement between the observed outcomes and the predicted risks across the full risk-range. 
We are applying cross-sectional metrics at a set time point within the setting of a longitudinal model and so we need to account for the censoring of patients and therefore, each uncensored patient at a given time t will be weighted as per the Inverse Probability of Censoring Weighting (IPCW) [3]. This allows the uncensored patient population to be representative of the entire patient population.


### Baseline Models

To assess the performance of a model, we must compare the values produced by the performance metrics to those of two baseline models; a random or noninformative model and a perfect model.
A Non-Informative (NI-)model assigns the same probability to all patients to be in any state regardless of covariates and is akin to using the average prevalence in the entire population to define your model. For example, in a Two-State model and an event that occurs in 10% of patients, all patients are predicted to have a 10% chance of having the event. For many metrics, models can be compared to a Non-Informative model to assess whether the model is in fact "better than random".
A Perfect (P-)model is one which successfully assigns a 100% probability to all patients, and the predictions are correct; this is the ideal case, which many models can also be compared to as models as close to this display excellent predictive abilities. Although models may perform worse than a non-informative one, we will not consider these in detail here as they are considered to be without worth in terms of predictive ability.
The  metrics produced by these baseline models will often depend on the prevalence of each state and/or the number of states. These values can be used as comparators to provide contextual information regarding the strength of model performance. These baselines metrics for the NI-model and the P-model will be referred to as the NI-level and P-level for the metric.
In order to allow for simplicity and understanding of these measures, they will be standardised to the same scales.

### Notation

Throughout this paper, we will use consistent notation which is shown here for reference and to avoid repetition in definitions, etc...

[**Notation Table**]

### Patient Weighting

[**Lots of formula, so will leave for now**]

### Accuracy - Brier Score

### Discrimination - c-statistic

### Calibration - Intercept and Slope

## Extension to Multi-State Models

### Trivial Extensions

### Accuracy  - Multiple Outcome Brier Score

### Discrimination - Polytomous Discriminatory Index

#### Computational Limitations

### Calibration - Multinomial Intercept, Matched and Unmatched Slopes

## Application to Real-World Data

### Accuracy

### Discrimination

### Calibration

## Discussion

<!--chapter:end:05-Performance_Metrics.Rmd-->


# Development and External Validation of a Multi-State Clinical Prediction Model for Chronic Kidney Disease Patients Progressing onto Renal Replacement Therapy and Death {#chap-dev-paper}
*MA Barrowman, GP Martin, N Peek, M Lambie, W Hulme, R Chinnadurai, J Lees, P Kalra, P Mark, J Traynor, M Sperrin*
\chaptermark{Development and Validation of MSCPM}
Last updated: 27 May



## Abstract {-}

### Introduction {-}

Clinical Prediction Models (CPMs) provide individualised predictions for patient outcomes. Traditionally, these models provide predictions for single outcomes, however in many circumstances, the ability to predict ~~multiple outcomes~~<mark>a multi-dimensional outcome</mark> with a single model can be advantageous. ~~Multi-State Models are a method to provide these kinds of predictions.~~ <mark>Many CPMs have been developed to predict the risk of different outcomes in individuals following chronic kidney disease (CKD) onset, but few allow the ability to predict the risk of patients transitioning onto renal replacement therapy (RRT) as well as death. For example, the risk of having a transplant within 1 year following dialysis, or the risk of remaining on dialysis until death. Multi-state models provide the vehicle to make such predictions, but have not been used within the CKD context.</mark>

### Methods {-}

We developed a Multi-State Clinical Prediction Model (MSCPM) using tertiary care data from the Salford Kidney Study as our development data set and secondary care data from the West of Scotland (SERPR) dataset as our external validation set. We developed three models of different levels of complexity; a Two-State Model (Alive and Dead), a Three-State Model (Untreated CKD, Renal Replacement Therapy and Dead) and a Five-State model (Untreated CKD, Haemodialysis, Peritoneal Dialysis, Transplant and Dead).~~ We used Royston-Parmer regression techniques to allow us to provide individualised predictions for patients.~~ Model performance was assessed for accuracy, discrimination and calibration using methods both internally and externally. The best performing model was used to produce a CPM Calculator for clinical use.

### Results {-}

Of the three models produced, Age was a strong predictor of mortality in all cases and outcomes were highly dependent on primary renal diagnosis. Models performed well in both the internal and external validation with the Three-State Model out performing overall <mark>with a Brier Score of 0.67/0.62 (internal/external, respectively), c-statistic of 0.83/0.81 and an averaged calibration intercept of 0.00/0.00 and slope diagonal of 1.34/1.53 (indicating under-prediction of all non-untreated CKD states for more extreme values)</mark>. The Three-State Model was used to develop the online Calculator.

### Discusssion {-}

Our CPMs provide clinicians and patients with multi-dimensional predictions across different outcome states and any time point. This implies that users of these models can get more information about their potential future without a loss to the ~~quality of that prediction.~~<mark>model's calibration nor its discriminative ability.</mark>

### Supplementary Material {-}

 Supplementary Material is available in Appendix \@ref(chap-dev-paper-supp).


## Introduction

A clinical prediction model (CPM) is a tool which provides patients and clinicians with a measure of how likely a patient is to suffer a specific clinical event, more specifically, a prognostic model allows the prediction of future events [@steyerberg_prognosis_2013]. CPMs use data from previous patients to estimate the outcomes of an individual patient. Prognostic models can be used in clinical practice to influence treatment decisions.


Within Chronic Kidney Disease (CKD), prognostic models have been developed to predict mortality [@johnson_predicting_2007; @landray_prediction_2010; @bansal_development_2015; @marks_looking_2015; @wick_clinical_2017], End-Stage Renal Disease [@landray_prediction_2010], the commencements of Renal Replacement Therapy (RRT) [@marks_looking_2015; @johnson_predicting_2008; @schroeder_predicting_2017; @kulkarni_transition_2017] or mortality after beginning dialysis [@floege_development_2015; @hemke_survival_2013; @cao_predicting_2015]. Some previous models have used the commencement of RRT as a proxy for CKD Stage V [@tangri_predictive_2011; @roy_statistical_2017; @tangri_dynamic_2017], while others have investigated the occurrence of cardiovascular events within CKD patients[@shlipak_cardiovascular_2005; @weiner_framingham_2007; @mcmurray_predictors_2011]. Reviews by Grams & Coresh [@grams_assessing_2013], Tangri et al [@tangri_risk_2013] and Ramspek et al [@ramspek_prediction_2017], which explored the different aspects of assessing risk amongst CKD or RRT patients, found that the current landscape of CKD prediction models is lacking from both a methodological and clinical perspective [@collins_transparent_2015; @bouwmeester_reporting_2012-1]. 


Methodologically, the majority of existing CKD prediction models fail to account for competing events [@bansal_development_2015; @wick_clinical_2017; @perotte_risk_2015], have high risks of bias [@johnson_predicting_2007; @landray_prediction_2010; @johnson_predicting_2008] or are otherwise flawed compared to modern clinical prediction standards [@collins_transparent_2015; @steyerberg_prognosis_2013]


In 2013, Begun et al [@begun_identification_2013] developed a multi-State model for assessing population-level progression through the severity stages of CKD (III-V), RRT and/or death, which can be used to provide a broad statement regarding a patient's future. In 2014, Allen et al [@allen_chronic_2014] applied a similar model to liver transplant recipients and their progression through the stages of CKD with a focus on the predictions of measured vs estimated glomerular filtration rate (mGFR vs eGFR). In 2017, Kulkarni et al [@kulkarni_transition_2017] developed an MSM focusing on the categories of Calculated Panel Reactive Antibodies and kidney transplant and/or death. 

Most recently, in 2018, Grams et al [@grams_predicting_2018] developed a multinomial clinical prediction model for CKD patients which focused on the occurrence of RRT and/or cardiovascular events. As of the publication of this paper, this is the only currently existing CPMs of this kind for CKD patients.


However, the first three of these existing models (Begun, Allen and Kulkarni) categorise continuous variables to define their states at specific cut-offs and this has been shown to be inefficient when modelling [@royston_dichotomizing_2006] and none of these models have undergone any validation process, whether internal or external [@altman_prognosis_2009].

It is also important to note that although these models can be used to predict patient outcomes, they were not designed to produce individualised patient predictions as is a key aspect of a clinical prediction model; they were designed to assess the methodological advantages of MSMs in this medical field, to describe the prevalence of  over time of different CKD stages and to produce population level predictions for patients with different levels of  panel-reactive antibodies [@royston_prognosis_2009].

The fourth model (Grams), is presented as a Multi-State Model and the transitions involved were studied and defined, however the underlying statistical model is two multinomial logistic models analysed at 2 and 4 years, which assumes homogeneity of transition times. Two downsides to the implementation of this model are that it can only produce predictions at those predefined time points and that it is unable to estimate duration of time on dialysis.

Therefore, our aim is to develop a CPM - we do this by modelling patient pathways through a Multi-State Model by choosing transition points which can be exactly identified and include states which produce a clinical difference in patient characteristics. Our modeling techniques allow for individual predictions of ~~multiple outcomes~~<mark>multi-dimensional outcomes</mark> at any time point . The models produced by this process will then be validated, both internally and externally, to compare their results and demonstrate the transportability of the  clinical prediction models. We report our work in line with the TRIPOD guidelines for development and validation of clinical prediction models [@collins_transparent_2015; @moons_transparent_2015].

## Methods

### Data Sources

The models were developed using data from the Salford Kidney Study (SKS) cohort of patients (previously named the CRISIS cohort), established in the Department of Renal Medicine, Salford Royal NHS Foundation Trust (SRFT). The SKS is a large longitudinal CKD cohort recruiting CKD patients since 2002. This cohort collects detailed annualised phenotypic and laboratory data, and plasma, serum and whole blood stored at -80\textdegree C for biomarker and genotypic analyses. Recruitment of patients into SKS has been described in multiple previous studies [@hoefield_factors_2010;
@chinnadurai_increased_2019-1] and these have included a CKD progression prognostic factor study and to evidence the increased risk of cardiovascular events in diabetic kidney patients. In brief, any patient referred to Salford renal service (catchment population 1.5 million) who is 18 years or over and has an eGFR measurement of less than $60\textrm{ml}/\textrm{min}/1.73\textrm{m}^2$ (calculated using the CKD-EPI formula [@levey_new_2009]) was approached to be consented for the study participation.

At baseline, the data, including demographics, comorbidities, physical parameters, lab results and primary renal diagnosis are recorded in the database. Patients undergo an annual study visit and any changes to these parameters are captured. All data except blood results are collected via questionnaire by a dedicated team of research nurses. Blood results (baseline and annualised), first RRT modality and mortality outcome data are directly transferred to the database from Salford's Integrated Record  [@new_obtaining_2014]. eGFR, uPCR, comorbidity and blood results were measured longitudinally throughout a patient's time within the cohort. 

Due to limitations in our data, we were agnostic to how long since patients were diagnosed with CKD. Therefore, we defined a patient's start date for our model as their first date after consent at which their eGFR was recorded to be below $60\textrm{ml}/\textrm{min}/1.73\textrm{m}^2$. Some patients consented with an eGFR that was already below 60, and some entered our study later when their eGFR was measured to be below 60. This implies that our models includes both patient who have recently been diagnosed with CKD ($\textrm{eGFR} \lessapprox 60$) *and* those that have been suffering with CKD for an arbitrary amount of time. This timelessness of the model means it can be applied to any patient at any time during their CKD journey prior to commencement of RRT.

All patients registered in the database between October 2002 and December 2016 with available data were included in this study. As this is a retrospective convenience sample, no sample size calculations were performed prior to recruitment. All patients were followed-up within SKS until the end-points of RRT, death or loss to follow-up or were censored at their last interaction with the healthcare system prior to December 2017. Date of death for patients who commenced RRT was  also included in the SKS database.

For external validation of the model, we extracted an independent cohort from the West of Scotland Electronic Renal Patient Record (SERPR). Our extract of SERPR contains all patients known to the Glasgow and Forth Valley renal service who had an eGFR measure of less than $60\textrm{ml}/\textrm{min}/1.73m^2$ between January 2006 and January 2016. This cohort has been previously used in Chronic Kidney Disease Prognosis consortium studies investigating outcomes in patients with CKD [@matsushita_cohort_2013] and a similar cohort has been used for the analysis of skin tumours amongst renal transplant patients. Use of anonymised data from this database has been approved by the West of Scotland Ethics Committee for use of NHS Greater Glasgow and Clyde 'Safe Haven' data for research.

Both the internal and external validation cohort were used as part of the multinational validation cohort used by Grams et al in their multinomial CPM discussed above [@grams_predicting_2018]. In SERPR, start dates were calculated to be the first time point where the following conditions were met:

* eGFR is measured at less than 60
* There is at least one prior eGFR measurement
* Patient is 18 or over

The second requirement was implemented to avoid a bias in the eGFR Rate. eGFR Rate is a measure of the change in eGFR over time and is calculated as the difference between the most recent two eGFR measurements divided by the time between them. For patients who entered the system with an $\textrm{eGFR} < 60$, their eGFR Rate would be unavailable (i.e. missing). Otherwise, patient eGFRs would *have* to drop to below 60 and thus eGFR Rate would be negative. In addition, to avoid Acute Kidney Incident events, we also filtered measurements of eGFR Rate that were more extreme than 1.5x those found in the SKS population. 

### Model Design

Three separate models were developed, so we could determine a clinically viable model while maintaining model parsimony as much as possible: a Two-State, Three-State and Five-State model, each building on the previous models' complexity (see figure \@ref(fig:State-Diagram)). The Two-State model was a traditional survival analysis where a single event (death) is considered. The Three-State model expanded on this, by splitting the Alive state into transient states of (untreated) CKD and (first) RRT; patients can therefore transition from CKD to Death or CKD to RRT, and then onto RRT to Death. The Five-State model stratifies the RRT state into HD, PD and Tx and allows similar transitions into and out of the RRT states; however, the transition from Tx to Death was not considered as it was anticipated a priori that there would be insufficient patients undergoing this transition and that the process of undergoing a transplant would be medically transformative and so it would be inappropriate to assume shared parameters before and after the transition (i.e. Tx was modelled as a second absorbing state).

\begin{figure}

{\centering \includegraphics[width=0.9\linewidth]{figure/Dev_Paper_State_Diagrams} 

}

\caption{Diagram of the three models, the states being modelled and relevant transitions}(\#fig:State-Diagram)
\end{figure}

Missing data was handled using multiple imputation [@white_imputing_2009] using times for all events as imputation covariates. Variables considered as covariates were demographics (sex, age, smoking status and alcohol consumption), comorbidities (congestive cardiac failure (CCF), chronic obstructive pulmonary disease (COPD), prior  cerebrovascular accident (CVA), hypertension (HT), diabetes mellitus (DM), ischemic heart disease (IHD), chronic liver disease (LD), prior myocardial infarction (MI), peripheral vascular disease (PVD) and slid tumour (ST)), physical parameters (BMI, blood pressure), blood results (haemoglobin, albumin, corrected calcium and phosphate measures), urine protein creatinine ratio (uPCR) and primary renal diagnosis (grouped as per ERA-EDTA classifications [@venkat-raman_new_2012]). From these variables, uPCR and eGFR Rate of change were also derived [@kovesdy_past_2016; @naimark_past_2016] as well as their log transforms and log(Age) and Age$^2$. For each transition, Backwards-forwards stepwise methods were used to minimise the AIC, allowing different variables to be used for each transition.

### Validation

Each of the three models were internally validated in the development dataset using bootstrapping to adjust for optimism and then further externally validated in the validation dataset extracted from SERPR [@schomaker_bootstrap_2018]. The bootstrapping method was also used for both validations to produce confidence intervals around the performance metric estimates. To assess the performance in low eGFR patients, the models were also validated in subsets of the SKS and SERPR where patients had an eGFR < 30/ml/min/1.73m\textsuperscript{2}.

Model accuracy was assessed using the Brier Score, discrimination was assessed using the c-statistic and the calibration was assessed using the multi-dimensional intercept and slope-matrix, as described in Chapter \@ref(chap-performance-metrics). <mark>These measures were taken at One-Year, Two-Years and Five-Years after the patient's start dates, and therefore are equivalent to validation measures at that point in time after a prediction has been applied.

Further details of how the models were developed and validated is discussed in the Supplementary materials in appendix \@ref(chap-dev-paper-supp).

### Example

Once the models have been developed, we will apply them to three example patients to demonstrate their use and applicability to the general population. We will provide a direct clinical estimation of these patient outcomes based on years of nephrological experience and compare this with the results presented by our clinical prediction model.

We have chosen three (synthetic) patients to use as examples of the use of our model. Their details can be seen in table \@ref(tab:Example-Patient).


\begin{table}[!h]

\caption{(\#tab:Example-Patient){\small Details of the Example Patients}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{3.5cm}>{\raggedright\arraybackslash}p{3.5cm}>{\raggedright\arraybackslash}p{3.5cm}>{\raggedright\arraybackslash}p{3.5cm}}
\toprule
  & Patient 1 & Patient 2 & Patient 3\\
\midrule
\rowcolor{gray!6}  Age & 20 & 40 & 66\\
Gender & Female & Male & Female\\
\rowcolor{gray!6}  Smoking Status & Non-Smoker & Smoker & Non-Smoker\\
BP & 144/101 & 160/90 & 140/80\\
\rowcolor{gray!6}  Albumin & 39 & 40 & 40\\
\addlinespace
Correct Calcium & 2.3 & 3.0 & 2.6\\
\rowcolor{gray!6}  Haemoglobin & 150 & 100 & 14\\
Phosphate & 0.68 & 2.00 & 0.86\\
\rowcolor{gray!6}  eGFR & 42 & 10 & 51\\
eGFR Previous & 50 (one week ago) & 30 (one year ago) & 70 (one week ago)\\
\addlinespace
\rowcolor{gray!6}  uPCR & 0.30 & 0.20 & 0.01\\
uPCR Previous & 0.80 (one month ago) & 1.20 (one year ago) & 0.06 (one week ago)\\
\rowcolor{gray!6}  Primary Diagnosis & Glomerulonephritis & Tubular Necrosis & Diabetes\\
Comorbities & Chronic Obstructive Pulmonary Disease\newline Liver Disease\newline Solid Tumour &  & Diabetes\newline Chronic Obstructive Pulmonary Disease\newline Hypertension\\
\bottomrule
\end{tabular}
\end{table}

Out three example patients cover a broad range of ages and other covariates. A clinically guided prediction for these patients would assume that Patient 1 has a high chance of proceeding as normal (with little need for RRT), Patient 2 would be recommended to start RRT soon and Patient 3 would be predicted to have a high risk of mortality with or without RRT.


### Calculator

As part of this work, we have also  produced an online calculator to allow patients and clinicians to easily estimate outcomes without worrying about the mathematics involved.

All analysis was done in `R 3.6.2` [@r_core_team_r_nodate] using the various `tidyverse` packages [@wickham_tidy_2017], as well as the `mice` [@buuren_mice_2011-1], `flexsurv` [@jackson_flexsurv_nodate], `nnet` [@ripley_package_2016] and `furrr` [@vaughan_furrr_2018] packages. The calculator was produced using the `shiny` package [@chang_shiny_2020].

## Results

### Data Sources

As seen in table \@ref(tab:Table-One), the Age of the populations had a mean of 64.4  and 65.9 respectively with a very broad range. Due to the inclusion criteria, eGFR were capped at a maximum of 60, and was consistent across populations; however, the rate of change for eGFR was much wider in the SERPR patients than in the SKS, and it was decreasing much faster, on average ( -25 vs 0) .  The uPCR measures are presented in our results as g/mmol, rather than the more conventional g/mol, this is to better present results and coefficients of varying magnitudes.  Levels of missingness were much higher in the SERPR dataset in most continuous variables.


<br>
\begin{table}[!h]

\caption{(\#tab:Table-One){\small Patient Demographics, Continuous variables are displayed as mean (Inter-Quartile Range), and Categorical/Comorbidity data as number (percent)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{26em}>{\ttfamily\raggedright\arraybackslash}p{13em}>{\ttfamily\raggedright\arraybackslash}p{11em}>{\ttfamily\raggedright\arraybackslash}p{14em}>{\ttfamily\raggedright\arraybackslash}p{14em}>{\ttfamily\raggedright\arraybackslash}p{14em}>{\ttfamily\raggedright\arraybackslash}p{19em}}
\toprule
\multicolumn{1}{c}{ } & \multicolumn{3}{c}{SKS} & \multicolumn{3}{c}{SERPR} \\
\cmidrule(l{3pt}r{3pt}){2-4} \cmidrule(l{3pt}r{3pt}){5-7}
Variable & mean/n (IQR/p) & missing n (p) & range & mean/n (IQR/p) & missing n (p) & range\\
\midrule
\rowcolor{gray!6}  Age & 64.378 (19.000) & 0 ( 0.00\%) & [ 20.000,  94.000] & 66.064 (17.000) & 0 (  0.00\%) & [  11.000,  98.000]\\
eGFR & 30.369 (22.387) & 0 ( 0.00\%) & [  3.578,  59.966] & 35.647 (20.565) & 0 (  0.00\%) & [   1.199,  59.994]\\
\rowcolor{gray!6}  eGFR Rate & -0.016 ( 0.294) & 1,278 (42.87\%) & [-19.107,  33.782] & 1.319 (21.897) & 0 (  0.00\%) & [ -28.636,  50.653]\\
SBP & 140.193 (29.000) & 50 ( 1.68\%) & [ 77.000, 220.000] & 145.981 (30.000) & 6,345 ( 82.31\%) & [  82.000, 258.000]\\
\rowcolor{gray!6}  DBP & 74.556 (14.000) & 52 ( 1.74\%) & [ 36.000, 159.000] & 76.742 (17.000) & 6,345 ( 82.31\%) & [  35.000, 128.000]\\
\addlinespace
BMI & 28.848 ( 7.842) & 572 (19.19\%) & [ 13.182,  61.467] & 29.020 ( 6.811) & 7,491 ( 97.17\%) & [  17.073,  52.403]\\
\rowcolor{gray!6}  Albumin & 42.152 ( 5.000) & 60 ( 2.01\%) & [ 12.000,  52.000] & 36.475 ( 6.000) & 3,134 ( 40.65\%) & [   7.000,  53.000]\\
Calcium & 2.302 ( 0.180) & 68 ( 2.28\%) & [  1.210,   3.660] & 2.407 ( 0.160) & 4,513 ( 58.54\%) & [   1.455,   3.400]\\
\rowcolor{gray!6}  Haemoglobin & 122.978 (23.000) & 72 ( 2.42\%) & [ 61.000, 195.000] & 109.269 (29.000) & 3,557 ( 46.14\%) & [   7.100, 208.000]\\
Phosphate & 1.163 ( 0.320) & 87 ( 2.92\%) & [  0.430,   3.710] & 1.194 ( 0.320) & 4,510 ( 58.50\%) & [   0.320,   4.370]\\
\addlinespace
\rowcolor{gray!6}  uPCR & 0.112 ( 0.103) & 245 ( 8.22\%) & [  0.001,   2.025] & 0.178 ( 0.177) & 7,170 ( 93.01\%) & [   0.001,   1.943]\\
uPCR Rate & -0.096 ( 0.188) & 1,777 (59.61\%) & [-70.727,  28.199] & 4.621 ( 0.905) & 7,495 ( 97.22\%) & [-176.200, 952.812]\\
\rowcolor{gray!6}  Gender: &  & 0 ( 0.00\%) &  &  & 0 (  0.00\%) & \\
Male & 1,865 (62.56\%) &  &  & 3,885 (50.40\%) &  & \\
\rowcolor{gray!6}  Female & 1,116 (37.44\%) &  &  & 3,824 (49.60\%) &  & \\
\addlinespace
Ethnicity: &  & 0 ( 0.00\%) &  &  & 7,009 ( 90.92\%) & \\
\rowcolor{gray!6}  White & 2,875 (96.44\%) &  &  & 679 ( 8.81\%) &  & \\
Asian & 75 ( 2.52\%) &  &  & 12 ( 0.16\%) &  & \\
\rowcolor{gray!6}  Black & 21 ( 0.70\%) &  &  & 7 ( 0.09\%) &  & \\
Other & 10 ( 0.34\%) &  &  & 2 ( 0.03\%) &  & \\
\addlinespace
\rowcolor{gray!6}  SmokingStatus: &  & 42 ( 1.41\%) &  &  & 7,709 (100.00\%) & \\
Former & 1,535 (51.49\%) &  &  & 0 ( 0.00\%) &  & \\
\rowcolor{gray!6}  Non-Smoker & 979 (32.84\%) &  &  & 0 ( 0.00\%) &  & \\
Smoker & 379 (12.71\%) &  &  & 0 ( 0.00\%) &  & \\
\rowcolor{gray!6}  Former 3Y & 46 ( 1.54\%) &  &  & 0 ( 0.00\%) &  & \\
\addlinespace
DiagGroup: &  & 567 (19.02\%) &  &  & 6,640 ( 86.13\%) & \\
\rowcolor{gray!6}  Systemic diseases affecting the kidney & 1,304 (43.74\%) &  &  & 316 ( 4.10\%) &  & \\
Glomerular disease & 442 (14.83\%) &  &  & 278 ( 3.61\%) &  & \\
\rowcolor{gray!6}  Tubulointerstitial disease & 268 ( 8.99\%) &  &  & 173 ( 2.24\%) &  & \\
Miscellaneous renal disorders & 227 ( 7.61\%) &  &  & 198 ( 2.57\%) &  & \\
\addlinespace
\rowcolor{gray!6}  Familial / hereditary nephropathies & 173 ( 5.80\%) &  &  & 104 ( 1.35\%) &  & \\
Diabetes (DM) & 992 (33.32\%) & 4 ( 0.13\%) &  & 1,535 (19.91\%) & 0 (   0.0\%) & \\
\rowcolor{gray!6}  Congestive Cardiac Failure (CCF) & 2,414 (81.09\%) & 4 ( 0.13\%) &  & 408 ( 5.29\%) & 0 (   0.0\%) & \\
Prior Myocardial Infarction (MI) & 2,492 (83.71\%) & 4 ( 0.13\%) &  & 556 ( 7.21\%) & 0 (   0.0\%) & \\
\rowcolor{gray!6}  Ischemic Heart Disease (IHD) & 2,393 (80.38\%) & 4 ( 0.13\%) &  & 863 (11.19\%) & 0 (   0.0\%) & \\
\addlinespace
Peripheral Vascular Disease (PVA) & 2,485 (83.47\%) & 4 ( 0.13\%) &  & 376 ( 4.88\%) & 0 (   0.0\%) & \\
\rowcolor{gray!6}  Prior Cerebrovascular Accident (CVA) & 2,727 (91.60\%) & 4 ( 0.13\%) &  & 186 ( 2.41\%) & 0 (   0.0\%) & \\
Chronic Obstructive Pulmonary Disease (COPD) & 2,411 (80.99\%) & 4 ( 0.13\%) &  & 0 (     \%) & 7,709 ( 100.0\%) & \\
\rowcolor{gray!6}  Chronic Liver Disease (LD) & 2,891 (97.11\%) & 4 ( 0.13\%) &  & 0 (     \%) & 7,709 ( 100.0\%) & \\
Prior Solid Tumour (ST) & 2,570 (86.33\%) & 4 ( 0.13\%) &  & 0 (     \%) & 7,709 ( 100.0\%) & \\
\addlinespace
\rowcolor{gray!6}  Hypertension (HT) & 2,546 (91.48\%) & 198 ( 6.64\%) &  & 3,114 (40.39\%) & 0 (   0.0\%) & \\
\bottomrule
\end{tabular}
\end{table}


Table \@ref(tab:Table-One) also shows a breakdown of the categorical variables across the populations. In the development population, crude proportions of males were numerically higher than females whereas in the validation population the proportions are much more matched (62.6% male vs 50.4% male). Most patients were white in the SKS dataset, and ethnicity has extremely high missingness in SERPR, which also contributed to its omission from the model. 

Overall, there were high levels of comorbidities within the SKS population, but these levels were much lower in the SERPR population.


The median date for the date of death was 3.9 years in the SKS population and 4.9 years in the SERPR population. The median date for transition to RRT was 2.2 years and 1.5 years (in SKS and SERPR respectively). In SKS, transitions to HD happened 6 months later than PD, and in SERPR it was 3.6 months. The Maximum followup time in SKS was 15.0 years and in SERPR it was 10.1 years. This information can be seen in table \@ref(tab:Event-Median2).

\begin{table}[!h]

\caption{(\#tab:Event-Median2){\small Event times for the two populations presented as Number of Events ~ Median (Inter-Quartile Range) [Max]}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{\ttfamily}r>{\ttfamily}r}
\toprule
Transition & SKS (Development) & SERPR (Validation)\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{3}{l}{\textbf{Two}}\\
\hspace{1em}Alive to Dead & 1,427 ~ 3.9 y (4.3 y) [15.0 y] & 3,025 ~ 4.9 y (3.3 y) [10.1 y]\\
\addlinespace[0.3em]
\multicolumn{3}{l}{\textbf{Three}}\\
\hspace{1em}CKD to Dead & 1,125 ~ 3.5 y (4.2 y) [15.0 y] & 2,579 ~ 4.8 y (3.2 y) [10.1 y]\\
\rowcolor{gray!6}  \hspace{1em}CKD to RRT & 680 ~ 2.5 y (3.3 y) [14.1 y] & 1,130 ~ 3.8 y (3.8 y) [10.1 y]\\
\hspace{1em}RRT to Dead & 302 ~ 2.2 y (3.2 y) [13.5 y] & 446 ~ 1.5 y (2.4 y) [ 9.1 y]\\
\rowcolor{gray!6}  CKD to Dead & 1,125 ~ 3.5 y (4.2 y) [15.0 y] & 2,579 ~ 4.8 y (3.2 y) [10.1 y]\\
\hspace{1em}CKD to HD & 344 ~ 2.5 y (3.5 y) [14.1 y] & 887 ~ 3.8 y (3.7 y) [10.1 y]\\
\rowcolor{gray!6}  \hspace{1em}CKD to PD & 229 ~ 2.0 y (2.9 y) [12.9 y] & 149 ~ 3.5 y (4.1 y) [ 9.6 y]\\
\hspace{1em}CKD to Tx & 107 ~ 3.2 y (2.7 y) [12.1 y] & 94 ~ 4.8 y (4.5 y) [ 9.7 y]\\
\rowcolor{gray!6}  \hspace{1em}HD to Dead & 185 ~ 2.0 y (3.2 y) [11.8 y] & 398 ~ 1.5 y (2.5 y) [ 9.1 y]\\
\hspace{1em}PD to Dead & 107 ~ 2.3 y (3.2 y) [11.7 y] & 47 ~ 2.1 y (2.3 y) [ 8.5 y]\\
\bottomrule
\end{tabular}
\end{table}

### Development

Here we present the proportional hazards results for the Three-State Model. The full model description, including proportional and baseline hazards can be found in the Supplementary Materials in appendix \@ref(chap-dev-paper-supp). Older patients are predicted to be likely to transition to RRT. Increased rates of decline of eGFR were associated with the transition from CKD to RRT. The full results are shown in table \@ref(tab:PH-Three).

\begin{table}[!h]

\caption{(\#tab:PH-Three){\small Proportional Hazards for each transition in the Three-State Model}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{30em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}}
\toprule
  & CKD to Dead & CKD to RRT & RRT to Dead\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{Age}}\\
\hspace{1em}(Age-60) & 0.161 (  -0.051,   0.374) & -0.041 (  -0.051,  -0.031) & 0.063 (   0.050,   0.076)\\
\hspace{1em}(Age-60)\textsuperscript{} & -0.000 (  -0.002,   0.000) & -0.000 (  -0.000,  -0.000) & \\
\rowcolor{gray!6}  \hspace{1em}log(Age) & -5.725 ( -17.969,   6.518) &  & \\
\addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{eGFR}}\\
\hspace{1em}eGFR & -0.013 (  -0.019,  -0.006) & -0.095 (  -0.108,  -0.082) & 0.011 (  -0.001,   0.025)\\
\rowcolor{gray!6}  \hspace{1em}eGFR Rate &  & 0.055 (  -0.021,   0.131) & -0.056 (  -0.363,   0.250)\\
\hspace{1em}log(eGFR Rate) & 0.042 (  -0.125,   0.210) &  & 0.227 (  -0.770,   1.225)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{uPCR}}\\
\hspace{1em}uPCR & 0.125 (  -0.318,   0.569) & 0.700 (   0.112,   1.288) & -0.108 (  -0.736,   0.519)\\
\hspace{1em}uPCR Rate &  & -0.019 (  -0.045,   0.005) & 0.036 (  -0.062,   0.136)\\
\rowcolor{gray!6}  \hspace{1em}log(uPCR Rate) &  & 0.218 (  -0.310,   0.747) & -0.198 (  -0.534,   0.137)\\
\addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{Measures}}\\
\hspace{1em}SBP & -0.001 (  -0.004,   0.002) & 0.005 (  -0.000,   0.011) & \\
\rowcolor{gray!6}  \hspace{1em}DBP & 0.006 (   0.000,   0.013) & 0.006 (  -0.001,   0.015) & \\
\hspace{1em}BMI &  &  & \\
\rowcolor{gray!6}  \hspace{1em}Albumin & -0.044 (  -0.064,  -0.024) & -0.032 (  -0.059,  -0.004) & -0.044 (  -0.079,  -0.009)\\
\hspace{1em}Corrected Calcium & 0.280 (  -0.192,   0.752) & -0.515 (  -1.207,   0.177) & \\
\rowcolor{gray!6}  \hspace{1em}Haemoglobin & -0.013 (  -0.017,  -0.008) & -0.005 (  -0.012,   0.001) & -0.005 (  -0.014,   0.003)\\
\hspace{1em}Phosphate & 0.511 (   0.132,   0.890) & 0.869 (  -0.059,   1.799) & \\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{Gender}}\\
\hspace{1em}Female & -0.235 (  -0.371,  -0.099) & -0.277 (  -0.455,  -0.099) & \\
\addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{Smoking Status}}\\
\hspace{1em}Former (3 years+) & -0.212 (  -0.879,   0.453) & -0.133 (  -0.757,   0.490) & -0.282 (  -1.082,   0.518)\\
\rowcolor{gray!6}  \hspace{1em}Non-Smoker & -0.198 (  -0.345,  -0.051) & -0.162 (  -0.364,   0.039) & -0.294 (  -0.598,   0.009)\\
\hspace{1em}Smoker & 0.356 (   0.160,   0.551) & 0.175 (  -0.076,   0.428) & 0.387 (   0.068,   0.706)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{Primary Renal Diagnosis}}\\
\hspace{1em}Familial / hereditary nephropathies & -0.424 (  -0.854,   0.006) & 1.029 (   0.720,   1.338) & -0.562 (  -1.084,  -0.040)\\
\hspace{1em}Glomerular disease & -0.394 (  -0.635,  -0.154) & -0.165 (  -0.465,   0.134) & -0.488 (  -0.883,  -0.094)\\
\rowcolor{gray!6}  \hspace{1em}Miscellaneous renal disorders & -0.263 (  -0.505,  -0.021) & -0.649 (  -1.143,  -0.155) & 0.033 (  -0.553,   0.620)\\
\hspace{1em}Tubulointerstitial disease & -0.463 (  -0.741,  -0.184) & -0.265 (  -0.577,   0.046) & -0.310 (  -0.803,   0.181)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{4}{l}{\textbf{Comorbidity}}\\
\hspace{1em}DM & 0.122 (  -0.011,   0.255) & 0.141 (  -0.074,   0.358) & 0.200 (  -0.096,   0.496)\\
\hspace{1em}CCF & -0.394 (  -0.535,  -0.253) &  & -0.299 (  -0.597,  -0.002)\\
\rowcolor{gray!6}  \hspace{1em}MI & -0.246 (  -0.397,  -0.094) & 0.234 (  -0.061,   0.530) & 0.186 (  -0.199,   0.572)\\
\hspace{1em}IHD & 0.102 (  -0.041,   0.245) & -0.077 (  -0.334,   0.179) & -0.097 (  -0.424,   0.228)\\
\rowcolor{gray!6}  \hspace{1em}PVD & -0.248 (  -0.394,  -0.103) & -0.168 (  -0.405,   0.068) & -0.183 (  -0.492,   0.126)\\
\hspace{1em}CVA & -0.070 (  -0.252,   0.111) &  & -0.168 (  -0.577,   0.240)\\
\rowcolor{gray!6}  \hspace{1em}COPD & -0.289 (  -0.433,  -0.145) &  & \\
\hspace{1em}LD & -0.169 (  -0.578,   0.239) & -0.316 (  -0.731,   0.097) & -0.270 (  -0.858,   0.318)\\
\rowcolor{gray!6}  \hspace{1em}ST & -0.274 (  -0.431,  -0.117) & -0.181 (  -0.516,   0.153) & -0.278 (  -0.611,   0.055)\\
\hspace{1em}HT &  & 0.274 (  -0.176,   0.726) & -0.416 (  -1.104,   0.271)\\
\bottomrule
\end{tabular}
\end{table}


Female patients are predicted to be more likely to remain in the CKD state than Males, or to remain in the RRT state once there. Smokers were predicted as more likely than Non-/Former Smokers to undergo any transition, apart from CKD to Tx. Blood results had associations with all transitions in some way, and disease etiology were strongly associated with the transitions giving a wide range of predictions.

### Validation

Table \@ref(tab:IV-Three) shows the results from the internal validation in the Three-State Model. Performance was overall slightly better in patients in the <60 eGFR group than in the <30 eGFR group. All measures degraded over time, but the average scores remained strong.

\begin{table}[!h]

\caption{(\#tab:IV-Three){\small Internal Validation of the Three-State Model, results presented as Estimate (95\% CI, where possible)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{}l>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r}
\toprule
Predicting & eGFR & One Year & Two Year & Five Year & Average\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Brier}}\\
\hspace{1em}Three & < 60 & 0.74 ( 0.74,  0.75) & 0.68 ( 0.68,  0.69) & 0.64 ( 0.64,  0.65) & 0.67 ( 0.67,  0.68)\\
\hspace{1em}Three & < 30 & 0.75 ( 0.74,  0.75) & 0.73 ( 0.73,  0.73) & 0.68 ( 0.67,  0.68) & 0.68 ( 0.67,  0.68)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.75 ( 0.75,  0.75) & 0.75 ( 0.75,  0.76) & 0.67 ( 0.67,  0.67) & 0.67 ( 0.67,  0.68)\\
\hspace{1em}Two & < 30 & 0.71 ( 0.71,  0.72) & 0.72 ( 0.72,  0.73) & 0.65 ( 0.65,  0.66) & 0.67 ( 0.67,  0.68)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{c-statistic}}\\
\hspace{1em}Three & < 60 & 0.87 ( 0.87,  0.87) & 0.84 ( 0.84,  0.85) & 0.84 ( 0.84,  0.84) & 0.83 ( 0.83,  0.84)\\
\hspace{1em}Three & < 30 & 0.87 ( 0.86,  0.87) & 0.84 ( 0.84,  0.84) & 0.84 ( 0.84,  0.84) & 0.83 ( 0.83,  0.84)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.86 ( 0.86,  0.86) & 0.86 ( 0.86,  0.86) & 0.83 ( 0.83,  0.84) & 0.83 ( 0.83,  0.84)\\
\hspace{1em}Two & < 30 & 0.86 ( 0.85,  0.86) & 0.86 ( 0.85,  0.86) & 0.85 ( 0.85,  0.85) & 0.84 ( 0.83,  0.84)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Intercept}}\\
\hspace{1em}Three & < 60 & \makecell[r]{-0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.01)\\  0.00 ( 0.00,  0.00)} & \makecell[r]{0.00 (-0.00,  0.00)\\ -0.01 (-0.02, -0.01)\\  0.00 ( 0.00,  0.00)} & \makecell[r]{-0.02 (-0.02, -0.01)\\ -0.01 (-0.02, -0.01)\\ -0.00 (-0.01, -0.00)} & \makecell[r]{0.00 ( 0.00,  0.00)\\  0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)}\\
\hspace{1em}Three & < 30 & \makecell[r]{-0.01 (-0.01, -0.01)\\ -0.00 (-0.00, -0.00)\\  0.00 (-0.00,  0.00)} & \makecell[r]{0.00 (-0.00,  0.00)\\ -0.01 (-0.01, -0.00)\\  0.03 ( 0.02,  0.03)} & \makecell[r]{-0.02 (-0.02, -0.01)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.01, -0.00)} & \makecell[r]{0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & -0.00 (-0.01, -0.00) & 0.02 ( 0.01,  0.02) & 0.00 (-0.00,  0.00) & -0.00 (-0.00,  0.00)\\
\hspace{1em}Two & < 30 & -0.00 (-0.00,  0.00) & -0.04 (-0.04, -0.04) & 0.00 ( 0.00,  0.01) & -0.00 (-0.00,  0.00)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Slope}}\\
\hspace{1em}Three & < 60 & \makecell[r]{\emph{1.25},  0.00,  0.04\\ -0.03,  \emph{1.10}, -0.00\\ -0.00,  0.01,  \emph{1.16}} & \makecell[r]{\emph{1.17}, -0.06,  0.01\\  0.03,  \emph{1.25}, -0.01\\ -0.01,  0.01,  \emph{1.37}} & \makecell[r]{\emph{1.21}, -0.02, -0.01\\  0.01,  \emph{1.44}, -0.04\\ -0.02,  0.02,  \emph{1.27}} & \makecell[r]{\emph{1.32}, -0.01,  0.00\\ -0.00,  \emph{1.37}, -0.01\\ -0.00,  0.00,  \emph{1.33}}\\
\hspace{1em}Three & < 30 & \makecell[r]{\emph{1.21},  0.02,  0.07\\ -0.04,  \emph{1.24},  0.07\\  0.01,  0.01,  \emph{1.16}} & \makecell[r]{\emph{1.36}, -0.00, -0.01\\  0.00,  \emph{1.31},  0.03\\ -0.02, -0.00,  \emph{1.26}} & \makecell[r]{\emph{1.35}, -0.04, -0.01\\  0.04,  \emph{1.33},  0.04\\  0.04, -0.02,  \emph{1.34}} & \makecell[r]{\emph{1.31},  0.00,  0.00\\ -0.01,  \emph{1.33},  0.01\\ -0.00,  0.00,  \emph{1.35}}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & \emph{1.21} & \emph{1.28} & \emph{1.27} & \emph{1.31}\\
\hspace{1em}Two & < 30 & \emph{1.05} & \emph{1.21} & \emph{1.21} & \emph{1.34}\\
\bottomrule
\end{tabular}
\end{table}

Table \@ref(tab:EV-Three) shows the results from the external validation in the Three-State Model.


\begin{table}[!h]

\caption{(\#tab:EV-Three){\small External Validation of the Three-State Model, results presented as Estimate (95\% CI, where possible)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{}l>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r}
\toprule
Predicting & eGFR & One Year & Two Year & Five Year & Average\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Brier}}\\
\hspace{1em}Three & < 60 & 0.69 ( 0.68,  0.69) & 0.70 ( 0.69,  0.70) & 0.61 ( 0.60,  0.61) & 0.62 ( 0.62,  0.63)\\
\hspace{1em}Three & < 30 & 0.68 ( 0.67,  0.68) & 0.72 ( 0.71,  0.72) & 0.65 ( 0.64,  0.65) & 0.63 ( 0.62,  0.63)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.67 ( 0.67,  0.67) & 0.70 ( 0.69,  0.70) & 0.63 ( 0.63,  0.63) & 0.62 ( 0.62,  0.63)\\
\hspace{1em}Two & < 30 & 0.66 ( 0.66,  0.67) & 0.70 ( 0.70,  0.70) & 0.65 ( 0.65,  0.66) & 0.63 ( 0.62,  0.63)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{c-statistic}}\\
\hspace{1em}Three & < 60 & 0.82 ( 0.82,  0.82) & 0.83 ( 0.83,  0.83) & 0.79 ( 0.79,  0.79) & 0.81 ( 0.80,  0.81)\\
\hspace{1em}Three & < 30 & 0.85 ( 0.84,  0.85) & 0.84 ( 0.84,  0.84) & 0.83 ( 0.83,  0.83) & 0.81 ( 0.81,  0.81)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.85 ( 0.85,  0.86) & 0.84 ( 0.84,  0.85) & 0.80 ( 0.80,  0.80) & 0.81 ( 0.80,  0.81)\\
\hspace{1em}Two & < 30 & 0.83 ( 0.83,  0.83) & 0.82 ( 0.82,  0.82) & 0.80 ( 0.80,  0.81) & 0.81 ( 0.81,  0.81)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Intercept}}\\
\hspace{1em}Three & < 60 & \makecell[r]{0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.00)\\ -0.00 (-0.00, -0.00)} & \makecell[r]{0.01 ( 0.01,  0.02)\\ -0.01 (-0.01, -0.00)\\  0.00 ( 0.00,  0.01)} & \makecell[r]{0.05 ( 0.04,  0.05)\\  0.01 ( 0.00,  0.01)\\  0.00 ( 0.00,  0.00)} & \makecell[r]{-0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.01)}\\
\hspace{1em}Three & < 30 & \makecell[r]{0.04 ( 0.04,  0.05)\\  0.01 ( 0.00,  0.01)\\  0.00 ( 0.00,  0.01)} & \makecell[r]{0.02 ( 0.01,  0.02)\\ -0.00 (-0.00,  0.00)\\  0.01 ( 0.01,  0.02)} & \makecell[r]{0.01 ( 0.01,  0.01)\\ -0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.01)} & \makecell[r]{0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.00 (-0.00,  0.00) & -0.05 (-0.05, -0.04) & 0.01 ( 0.01,  0.02) & -0.00 (-0.00,  0.00)\\
\hspace{1em}Two & < 30 & 0.02 ( 0.01,  0.02) & -0.00 (-0.00,  0.00) & 0.01 ( 0.00,  0.01) & -0.00 (-0.00,  0.00)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Slope}}\\
\hspace{1em}Three & < 60 & \makecell[r]{\emph{1.35}, -0.04,  0.04\\  0.06,  \emph{1.49}, -0.03\\  0.01,  0.00,  \emph{1.25}} & \makecell[r]{\emph{1.13}, -0.00,  0.08\\ -0.02,  \emph{1.31},  0.01\\ -0.03,  0.01,  \emph{1.39}} & \makecell[r]{\emph{1.45}, -0.02,  0.03\\  0.03,  \emph{1.73},  0.03\\  0.04, -0.00,  \emph{1.47}} & \makecell[r]{\emph{1.54},  0.00, -0.00\\  0.01,  \emph{1.52},  0.00\\ -0.00,  0.00,  \emph{1.54}}\\
\hspace{1em}Three & < 30 & \makecell[r]{\emph{1.23},  0.03,  0.00\\ -0.05,  \emph{1.20}, -0.04\\ -0.00, -0.00,  \emph{1.37}} & \makecell[r]{\emph{0.99}, -0.01, -0.00\\  0.04,  \emph{1.34}, -0.03\\  0.00,  0.01,  \emph{1.46}} & \makecell[r]{\emph{1.56},  0.00,  0.00\\ -0.05,  \emph{1.49},  0.03\\  0.03,  0.01,  \emph{1.63}} & \makecell[r]{\emph{1.62}, -0.01,  0.01\\ -0.00,  \emph{1.53},  0.01\\  0.00, -0.00,  \emph{1.58}}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & \emph{1.28} & \emph{1.26} & \emph{1.64} & \emph{1.51}\\
\hspace{1em}Two & < 30 & \emph{1.18} & \emph{1.25} & \emph{1.57} & \emph{1.59}\\
\bottomrule
\end{tabular}
\end{table}


### Example

The example patients seen in Table \@ref(tab:Example-Patient) were passed through our Three-State prediction model and the results for all time-points are shown in figure \@ref(fig:Example-Predictions-trend). The prognosis for all three patients were very different. Patient 1 (20 year old) had a very high probability of survival, with only an 16% chance of mortality by year 10 and 0% chance of commencing RRT. Patient 2 (40 year old) was predicted almost 90% chance of starting RRT, and over 70% chance of dying overall (either with or without RR). Patient 3 (66 year old) had a fast acceleration towards high mortality, after 1 year from the recorded measurements, they had more than 50% chance of dying, and after 2 years that probability rises to over 85% with no chance of RRT.

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{figure/Dev_Paper_Example} 

}

\caption{Results of Example Patients}(\#fig:Example-Predictions-trend)
\end{figure}

### Calculator

The calculator is available online here:

[https://michael-barrowman.shinyapps.io/MSCPM_for_CKD_Patients/](https://michael-barrowman.shinyapps.io/MSCPM_for_CKD_Patients/).

## Discussion

We have used data provided by SKS to develop a Multi-State Clinical Prediction Model and then validated this model within the SKS and SERPR datasets. Within our Models, the cause of a patient's renal disease had the widest effect on patient outcomes meaning that outcomes are highly dependent on ERA-EDTA classification of the diagnosis. Most groupings resulted in a lowered hazard of death and an increased hazard of RRT compared to the baseline of Systemic diseases.

Models performed well in model validation with the Three-State Model slightly out performing the other two models in calibration and overall predictive ability, however the Five-State model performed marginally better in terms of discriminative ability. Both Multi-State Models outperformed the Two-State (Traditional) Model.

The application of a Multi-state clinical prediction model to this field is novel and gives a powerful tool for providing individualised predictions of different outcomes at a wide range of time points. The model can also be used to estimate an expected amount of time that a patient will be on RRT The general inclusion criteria for the development dataset, and the wide range of patient ages and measurements allows for the model to be applied to a broad spectrum of patients.

Although the inclusion criteria for SKS were broad, the demographics of the local area resulted in homogeneity of ethnicity, which may create a limitation to the applicability of our model. The Renal Department at SRFT is a tertiary care facility for CKD sufferers and is well renowned for its capabilities of care meaning that it is likely to attract less-healthy patients from a wider catchment area, making the cohort of patients in the development population in worse condition than the general population of CKD patients. 

There were also high levels of missingness in the eGFR and uPCR rates of changes would also produce a bias, due to these measures likely being missing not at random. The derivation of the validation dataset ensured that all patients had an eGFR Rate measurement; this was done to avoid data missing not at random (only negative or missing data would be available as patient's eGFR dropped to less than 60), however deriving data in this way could itself induce a survivor bias in the start date used for patients.

In the Five-State Model, We omitted the analysis of the Tx to Dead state due to the anticipated low number of events within the SKS dataset. The lowest number of events for a transition was therefore PD to Dead, which had only 107. Altogether, we considered 26 covariates (with 4 categorical covariates) and so this equates to 36 predictor parameters and an events per predictor parameter (EPP) of 2.97. This is below the recommendations of Riley et al [@riley_minimum_2019], whose calculations produce a requirement of 4.54 EPP. This requirement was also not satisfied by the CKD to PD transition (EPP = 6.36,required = 10.2) or the CKD to Tx transition (EPP = 2.97, required = 17.6). Fortunately, this limitation is confined to the Five-State Model.

We have assumed a proportional hazards relationship between the predictors and probability of survival, which is considered by some to be a strong assumption to make, however we acknowledge this limitation, and the authors believe that it is mitigated by the flexibility that the assumption permits. In addition to the general PH assumption, the R-P model requires the assumption that the log cumulative hazard function follows a cubic spline, (however this is a much weaker assumption [@royston_flexible_2002]), which is modelled as part of the regression. We did not assess the viability of these models as it was believed this assumption to make our results more understandable. 

Compared to the apparent internal validation, the model performance during the external validation was worse for all metrics. However, once adjusted for optimism, the results were much more cohesive which implies that the model is highly transportable to a new population without much alterations being required. Due to the differences in the healthcare systems of England and Scotland, it can be appreciated that despite the populations being similar, their care would be different enough to emphasise a larger difference between our populations than that shown in our (relatively homogeneous) populations.



Our paper has clearly demonstrated the accuracy of such a model. However, further research would be needed to establish the effectiveness and efficacy of its use in clinical practice [@moons_prognosis_2009-1] by comparing it to standard care and establishing whether the use of our model improves patient outcomes.

All three models produced for this work performed well in terms of accuracy, calibration and discrimination when applied internally and externally. This shows directly that the models are suitable for use in populations similar to both our development and our validation datasets. It can also be concluded that the models can be transported and applied to any population with a similar healthcare system to the UK.






<!--chapter:end:06-Dev_Paper.Rmd-->


# Conclusion {#chap-conclusion}
\chaptermark{Conclusion}
Last updated: 21 Apr

Here is where my concluding section will go.


The end.


<!--chapter:end:10-Conclusion.Rmd-->

# (APPENDIX) Appendices {-}

<!--chapter:end:appendix.Rmd-->


# How unmeasured confounding in a competing risks setting can affect treatment effect estimates in observational studies - Supplementary Material {#chap-Conf-CR-supp}
\chaptermark{Competing Risks and Unmeasured Confounding - Supp}

## Simulation Details

<!-- https://static-content.springer.com/esm/art%3A10.1186%2Fs12874-019-0808-7/MediaObjects/12874_2019_808_MOESM1_ESM.docx -->

The populations 

## Mathematics of Subdistribution Hazards

<!-- https://static-content.springer.com/esm/art%3A10.1186%2Fs12874-019-0808-7/MediaObjects/12874_2019_808_MOESM2_ESM.docx -->

Due to the relationship between the cause specific hazard functions and the subdistribution hazard functions they cannot both satisfy the proportional hazards assumption. We have defined CSH functions to be proportio

<!--chapter:end:03a-CR_Conf_Supp.Rmd-->


# Inverse Probability Weighting Adjustment of the Logistic Regression Calibration-in-the-Large - Supplementary Material {#chap-IPCW-logistic-supp}
\chaptermark{IPCW Calibration-in-the-Large - Supp}

## Calibration Slope


The main purpose of this paper was to assess the evaluation of calibration-in-the-large at different time points in a time-to-event clinical prediction model. Along with calibration-in-the-large, various methods of calibration can also produce measures of calibration slope. Calibration slope provides an insight into how well the model predicts outcomes across the range of predictions. In an ideal model, the calibration slope would be 1. The Logistic Weighted, Logistic Unweighted and Pseudo-Observation methods described above can provide estimates of the calibration slope. For each of these methods, we first estimate the calibration-in-the-large as above, using a predictor as an offset, then we use this estimate as an offset to predict the calibration slope (without an intercept term).

### Results



\includegraphics[width=54.68in]{figure/IPCW_Logistic/SlopePlot_b(1)_g(0)_e(0.5)} 

Results currently show bias/coverage/EmpsE away from 0, rather than 1. Needs fixing. Oops.

### Discussion

Brief discussion, much briefer than the main points.





<!--chapter:end:04a-IPCW_logistic_Supp.Rmd-->


# Development and External Validation of a Multi-State Clinical Prediction Model for Chronic Kidney Disease Patients Progressing onto Renal Replacement Therapy and Death - Supplementary Material{#chap-dev-paper-supp}
\chaptermark{Development and Validation of MSCPM - Supp}

## Statistical Analysis

### Development

Data was recorded in a time-updated manner, however all variables were measured at baseline to emulate the real-world application of the model (i.e. future prediction of states and not covariates).  As well as those included in \@ref(chap-dev-paper), ethnicity was assessed in the populations, but as most patients were white, it was omitted as a potential predictor from the models. 

 log(Calendar Time) was included as a covariate to adjust for secular trends in treatment preferences [@bhatnagar_epidemiology_2015]. Calendar Time was defined as length of time between start date and  1st January 2019.

Intermediate states (RRT or modality) were considered to be medically transformative, and so a semi-markov (clock reset) method for analysis was considered to be well justified [@meira-machado_multi-state_2009]. Each transition was modelled under a proportional hazards assumption using the Royston-Parmar technique [@royston_flexible_2002] to estimate coefficients for each covariate and a restricted cubic spline (on the log-time scale) for the baseline cumulative hazard. The cumulative hazards for each transition can be combined to produce estimates for the probability of a patient being in any state at any time [@putter_tutorial_2007].

For variable selection, we stacked the imputed datasets together to create a larger, pseudo-population [@wood_how_2008] and performed backwards-forwards selection based on minimising the AIC at each step. This was repeated for each transition and for different numbers of evenly spaced knots in modelling the form of the baseline hazard, K={0,1,2,3,4,5}. This allowed for different transitions to use different sets of variables and numbers of knots in the final model. Some combinations of variables resulted in models that were intractable and so these models were excluded. Once a set of variables were chosen, the R-P model was applied to each imputed dataset individually and the resulting coefficients and cubic spline parameters were aggregated across imputations using Rubin's Rules [@rubin_multiple_1984]. This gave a model fully defined by smooth cubic splines representing the cumulative cause-specific hazard and individualised proportional hazards for each transition.

All missing data were assumed to be missing at random and so were multiply imputed using chained equations with the Nelson-Aalen estimators for each relevant transition as predictors [@white_imputing_2009]. Some variables (smoking status and histories of COPD, LD and ST)  were present in the SKS (development) dataset, but were completely missing in the SERPR extract (validation) and so these were multiply imputed from the development dataset [@janssen_dealing_2009].



### Validation



For validation purposes, we consider Death and Death after RRT/HD/PD to be distinct states meaning that for the Three-State model, we have $K=4$ pathways a patient can take and for the Five-State model, we have $K=7$. To compare across models, we combined states together to collapse down to simpler versions. We collapsed the Three-State model to a two-state structure by combining the CKD and RRT states into an Alive state. We collapsed the Five-State model to a three-state structure by combining the HD, PD and Tx into an RRT state and then further down to a two-state structure as with the Three-State model. We will report performance measures at 360 days (approx. 1-year), 720 days (approx. 2-years) and 1800 days (approx. 5-years). As well as presenting the performance measures over time.

The performance metrics were chosen from those defined in chapter \ref@(chap-performance-metrics)

The overall accuracy of each model was assessed using the MSM adjusted Brier Score, which is a proper score function [@gneiting_strictly_2007] assigning 0 to a non-informative model and 1 to a perfect model, with negative numbers implying the model performs worse than assuming every patient's state predictions are the same as the overall prevalence within the population.

The discrimination of each model was assessed using the MSM extension to the c-statistic [@calster_extending_2012-1]. The c-statistic is a score between 0 and 1 with higher scores suggesting a better model and a c-statistic of 0.5 suggesting the model performs no better than a non-informative model.

The calibration of each model was assessed using MSM multinomial logistic regression (MLR)  [@hoorde_assessing_2014] which extends the logistic regression to three or more mutually exclusive outcomes [@riley_prognosis_2019]. This produces an intercept vector of length $K-1$ and a Slope-matrix of dimension $(K-1) \times (K-1)$. As with the traditional calibration intercept for a well performing model, the MLR intercept values should all be as close to 0 as possible.  The traditional calibration slope should be as close to 1 as possible and so the multi-state extension of the slope, the Slope-matrix should be as close to the identity matrix ($I$) as possible.

## Model Results

### Two State Model


Table \@ref(tab:PH-Two) shows the proportional hazard ratios for the transitions in the Two-State Model. Older patients have a higher hazard towards death, low adn decreasing eGFR increased hazard as did a history of diabetes. Patients with a primary renal diagnosis included in the ERA-EDTA [@venkat-raman_new_2012] definition of Systemic diseases affecting the kidney had the highest likelihood of death.

\begin{table}[!h]

\caption{(\#tab:PH-Two){\small Proportional Hazards for each transition in the Two-State Model}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{30em}>{\ttfamily\raggedleft\arraybackslash}p{43em}}
\toprule
  & Alive to Dead\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{Age}}\\
\hspace{1em}(Age-60) & 0.110 (  -0.055,   0.275)\\
\hspace{1em}(Age-60)\textsuperscript{} & -0.000 (  -0.001,   0.000)\\
\rowcolor{gray!6}  \hspace{1em}log(Age) & -2.853 ( -12.306,   6.599)\\
\addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{eGFR}}\\
\hspace{1em}eGFR & -0.013 (  -0.018,  -0.008)\\
\rowcolor{gray!6}  \hspace{1em}eGFR Rate & -0.007 (  -0.090,   0.075)\\
\hspace{1em}log(eGFR Rate) & 0.090 (  -0.199,   0.380)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{uPCR}}\\
\hspace{1em}uPCR & \\
\hspace{1em}uPCR Rate & \\
\rowcolor{gray!6}  \hspace{1em}log(uPCR Rate) & \\
\addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{Measures}}\\
\hspace{1em}SBP & \\
\rowcolor{gray!6}  \hspace{1em}DBP & 0.004 (  -0.000,   0.009)\\
\hspace{1em}BMI & \\
\rowcolor{gray!6}  \hspace{1em}Albumin & -0.048 (  -0.061,  -0.034)\\
\hspace{1em}Corrected Calcium & 0.222 (  -0.153,   0.599)\\
\rowcolor{gray!6}  \hspace{1em}Haemoglobin & -0.011 (  -0.015,  -0.007)\\
\hspace{1em}Phosphate & 0.338 (   0.119,   0.557)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{Gender}}\\
\hspace{1em}Female & -0.172 (  -0.291,  -0.053)\\
\addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{Smoking Status}}\\
\hspace{1em}Former (3 years+) & -0.403 (  -0.908,   0.101)\\
\rowcolor{gray!6}  \hspace{1em}Non-Smoker & -0.226 (  -0.358,  -0.095)\\
\hspace{1em}Smoker & 0.376 (   0.212,   0.539)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{Primary Renal Diagnosis}}\\
\hspace{1em}Familial / hereditary nephropathies & -0.399 (  -0.728,  -0.070)\\
\hspace{1em}Glomerular disease & -0.406 (  -0.618,  -0.193)\\
\rowcolor{gray!6}  \hspace{1em}Miscellaneous renal disorders & -0.220 (  -0.434,  -0.005)\\
\hspace{1em}Tubulointerstitial disease & -0.452 (  -0.696,  -0.208)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{2}{l}{\textbf{Comorbidity}}\\
\hspace{1em}DM & 0.144 (   0.022,   0.265)\\
\hspace{1em}CCF & -0.378 (  -0.505,  -0.252)\\
\rowcolor{gray!6}  \hspace{1em}MI & -0.165 (  -0.304,  -0.026)\\
\hspace{1em}IHD & 0.070 (  -0.059,   0.200)\\
\rowcolor{gray!6}  \hspace{1em}PVD & -0.240 (  -0.371,  -0.109)\\
\hspace{1em}CVA & -0.128 (  -0.293,   0.036)\\
\rowcolor{gray!6}  \hspace{1em}COPD & -0.203 (  -0.330,  -0.076)\\
\hspace{1em}LD & -0.241 (  -0.573,   0.091)\\
\rowcolor{gray!6}  \hspace{1em}ST & -0.299 (  -0.440,  -0.158)\\
\hspace{1em}HT & -0.080 (  -0.339,   0.177)\\
\bottomrule
\end{tabular}
\end{table}

Equation \@ref(eq:CH-Two-16) below shows the baseline cumulative hazard functions for the transition from Alive to Dead in the Two-State Model.

\begin{equation}
\Lambda_{0,16}(t)=\begin{cases} 1.15764\log(t)+6.17808 & 0 \le t < 3 \\ 0.00075\log(t)^3-0.00247\log(t)^2+1.16036\log(t)+6.17708 & 3 \le t < 520 \\ 0.13983\log(t)^3-2.61165\log(t)^2+17.47602\log(t)-27.83122 & 520 \le t < 984 \\ -0.19361\log(t)^3+4.28227\log(t)^2-30.03426\log(t)+81.30981 & 984 \le t < 1454 \\ -0.15458\log(t)^3+3.42966\log(t)^2-23.82553\log(t)+66.23901 & 1454 \le t < 2009 \\ 0.37097\log(t)^3-8.56171\log(t)^2+67.37553\log(t)-164.97265 & 2009 \le t < 2900 \\ -0.16209\log(t)^3+4.18769\log(t)^2-34.26862\log(t)+105.14551 & 2900 \le t < 5497 \\ 1.79561\log(t)+1.61764)) & 5497 \le t (\#eq:CH-Two-16)\end{cases}
\end{equation}

Table \@ref(tab:IV-Two) shows the results from the internal validation in the Two-State Model. Calibration Intercept is close to 0, implying the model is well calibrated overall with a high c-statistic and Brier Score. Calibration Slope above 1 implies that the model under-estimates outcomes.


\begin{table}[!h]

\caption{(\#tab:IV-Two){\small Internal Validation of the Two-State Model, results presented as Estimate (95\% CI, where possible)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{}l>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r}
\toprule
Predicting & eGFR & One Year & Two Year & Five Year & Average\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Brier}}\\
\hspace{1em}Two & < 60 & 0.63 ( 0.62,  0.63) & 0.69 ( 0.69,  0.69) & 0.66 ( 0.66,  0.67) & 0.63 ( 0.62,  0.63)\\
\hspace{1em}Two & < 30 & 0.71 ( 0.71,  0.72) & 0.68 ( 0.68,  0.69) & 0.66 ( 0.66,  0.66) & 0.63 ( 0.63,  0.64)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{c-statistic}}\\
\hspace{1em}Two & < 60 & 0.82 ( 0.82,  0.82) & 0.85 ( 0.84,  0.85) & 0.81 ( 0.81,  0.81) & 0.81 ( 0.81,  0.82)\\
\hspace{1em}Two & < 30 & 0.84 ( 0.84,  0.84) & 0.83 ( 0.82,  0.83) & 0.83 ( 0.82,  0.83) & 0.81 ( 0.81,  0.81)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Intercept}}\\
\hspace{1em}Two & < 60 & 0.01 ( 0.00,  0.01) & 0.01 ( 0.00,  0.01) & -0.02 (-0.02, -0.01) & -0.00 (-0.01, -0.00)\\
\hspace{1em}Two & < 30 & -0.02 (-0.02, -0.02) & 0.00 ( 0.00,  0.01) & 0.00 ( 0.00,  0.01) & -0.00 (-0.00, -0.00)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Slope}}\\
\hspace{1em}Two & < 60 & \emph{1.33} & \emph{1.46} & \emph{1.26} & \emph{1.48}\\
\hspace{1em}Two & < 30 & \emph{1.23} & \emph{1.25} & \emph{1.30} & \emph{1.51}\\
\bottomrule
\end{tabular}
\end{table}

Table \@ref(tab:EV-Two) shows the results from the external validation in the Two-State Model, which shows similar results to the internal validation with slightly impaired perfomance, which is to be expected in an external validation.


\begin{table}[!h]

\caption{(\#tab:EV-Two){\small External Validation of the Two-State Model, results presented as Estimate (95\% CI, where possible)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{}l>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r}
\toprule
Predicting & eGFR & One Year & Two Year & Five Year & Average\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Brier}}\\
\hspace{1em}Two & < 60 & 0.64 ( 0.63,  0.64) & 0.57 ( 0.56,  0.57) & 0.57 ( 0.56,  0.58) & 0.56 ( 0.56,  0.57)\\
\hspace{1em}Two & < 30 & 0.67 ( 0.66,  0.67) & 0.64 ( 0.63,  0.64) & 0.57 ( 0.56,  0.57) & 0.57 ( 0.56,  0.57)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{c-statistic}}\\
\hspace{1em}Two & < 60 & 0.81 ( 0.81,  0.82) & 0.81 ( 0.80,  0.81) & 0.80 ( 0.79,  0.80) & 0.78 ( 0.78,  0.78)\\
\hspace{1em}Two & < 30 & 0.81 ( 0.81,  0.81) & 0.80 ( 0.80,  0.81) & 0.78 ( 0.78,  0.79) & 0.78 ( 0.78,  0.78)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Intercept}}\\
\hspace{1em}Two & < 60 & -0.00 (-0.00,  0.00) & 0.02 ( 0.01,  0.02) & 0.00 ( 0.00,  0.01) & -0.00 (-0.00,  0.00)\\
\hspace{1em}Two & < 30 & 0.02 ( 0.01,  0.02) & -0.05 (-0.05, -0.04) & 0.01 ( 0.01,  0.02) & -0.00 (-0.00,  0.00)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Slope}}\\
\hspace{1em}Two & < 60 & \emph{1.29} & \emph{1.25} & \emph{1.72} & \emph{2.21}\\
\hspace{1em}Two & < 30 & \emph{1.37} & \emph{1.37} & \emph{2.05} & \emph{1.88}\\
\bottomrule
\end{tabular}
\end{table}

### Three State Model






The equations \@ref(eq:CH-Three-16), \@ref(eq:CH-Three-15) and \@ref(eq:CH-Three-56) shows the baseline cumulative hazard functions for the transition from CKD to Dead, CKD to RRT and RRT to Dead, respectively in the Three-State Model.

\begin{equation}
\Lambda_{0,16}(t)=\begin{cases} 1.19795\log(t)+17.68798 & 0 \le t < 3 \\ -9e-05\log(t)^3+3e-04\log(t)^2+1.19761\log(t)+17.68811 & 3 \le t < 443 \\ 0.15869\log(t)^3-2.9019\log(t)^2+18.88018\log(t)-18.22403 & 443 \le t < 873 \\ -0.30096\log(t)^3+6.43659\log(t)^2-44.36299\log(t)+124.54338 & 873 \le t < 1295 \\ -0.04158\log(t)^3+0.86028\log(t)^2-4.40166\log(t)+29.08554 & 1295 \le t < 1876 \\ 0.51263\log(t)^3-11.67048\log(t)^2+90.03919\log(t)-208.17245 & 1876 \le t < 2738 \\ -0.23992\log(t)^3+6.19863\log(t)^2-51.3924\log(t)+164.96467 & 2738 \le t < 5497 \\ 1.98997\log(t)+11.72244)) & 5497 \le t (\#eq:CH-Three-16)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,15}(t)=\begin{cases} 1.55753\log(t)-5.44635 & 0 \le t < 18 \\ -0.00279\log(t)^3+0.0242\log(t)^2+1.48757\log(t)-5.37894 & 18 \le t < 270 \\ -0.13576\log(t)^3+2.25776\log(t)^2-11.01817\log(t)+17.96111 & 270 \le t < 538 \\ 0.49133\log(t)^3-9.57146\log(t)^2+63.36209\log(t)-137.93609 & 538 \le t < 919 \\ -0.76978\log(t)^3+16.24541\log(t)^2-112.80782\log(t)+262.78176 & 919 \le t < 1316 \\ 0.30039\log(t)^3-6.81452\log(t)^2+52.82254\log(t)-133.77073 & 1316 \le t < 2000 \\ -0.0123\log(t)^3+0.31552\log(t)^2-1.37092\log(t)+3.53243 & 2000 \le t < 5173 \\ 1.32717\log(t)-4.15818)) & 5173 \le t (\#eq:CH-Three-15)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,56}(t)=\begin{cases} 1.35522\log(t)-7.7618 & 0 \le t < 8 \\ -0.01704\log(t)^3+0.1063\log(t)^2+1.13417\log(t)-7.60859 & 8 \le t < 196 \\ 0.21761\log(t)^3-3.6103\log(t)^2+20.75671\log(t)-42.14228 & 196 \le t < 506 \\ -0.67558\log(t)^3+13.07415\log(t)^2-83.12956\log(t)+173.47479 & 506 \le t < 816 \\ 0.8043\log(t)^3-16.69103\log(t)^2+116.42771\log(t)-272.49495 & 816 \le t < 1388 \\ -1.26732\log(t)^3+28.27738\log(t)^2-208.94656\log(t)+512.26643 & 1388 \le t < 1927 \\ 0.17019\log(t)^3-4.34244\log(t)^2+37.78861\log(t)-109.83234 & 1927 \le t < 4940 \\ 0.85568\log(t)-5.12598)) & 4940 \le t (\#eq:CH-Three-56)\end{cases}
\end{equation}

Validation results for the Three-State Model can be found in Chapter \@ref(chap-dev-paper).





### Five State Model

Table \@ref(tab:PH-Five) shows the proportional hazard ratios for the transitions in the Five-State Model.


\newgeometry{margin=2cm}
\begin{landscape}\begin{table}

\caption{(\#tab:PH-Five){\small Proportional Hazards for each transition in the Five-State Model}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{30em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}>{\ttfamily\raggedleft\arraybackslash}p{43em}}
\toprule
  & CKD to Dead & CKD to HD & CKD to PD & CKD to Tx & HD to Dead & PD to Dead\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{Age}}\\
\hspace{1em}(Age-60) & 0.161 (  -0.051,   0.374) & -0.029 (  -0.047,  -0.011) & -0.037 (  -0.057,  -0.018) & -0.099 (  -0.127,  -0.072) & 0.069 (   0.051,   0.087) & 0.046 (   0.024,   0.068)\\
\hspace{1em}(Age-60)\textsuperscript{} & -0.000 (  -0.002,   0.000) & -0.000 (  -0.001,   0.000) & -0.000 (  -0.000,   0.000) & -0.000 (  -0.001,  -0.000) &  & \\
\rowcolor{gray!6}  \hspace{1em}log(Age) & -5.725 ( -17.969,   6.518) &  &  &  &  & \\
\addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{eGFR}}\\
\hspace{1em}eGFR & -0.013 (  -0.019,  -0.006) & -0.088 (  -0.105,  -0.071) & -0.112 (  -0.135,  -0.090) & -0.097 (  -0.120,  -0.074) & 0.016 (   0.000,   0.032) & -0.006 (  -0.036,   0.023)\\
\rowcolor{gray!6}  \hspace{1em}eGFR Rate &  & 0.085 (  -0.058,   0.229) &  & -0.169 (  -0.813,   0.474) & -0.053 (  -0.701,   0.593) & 0.000 (  -0.294,   0.294)\\
\hspace{1em}log(eGFR Rate) & 0.042 (  -0.125,   0.210) & -0.261 (  -0.798,   0.276) & 0.445 (  -0.280,   1.171) & 0.440 (  -1.371,   2.252) & 0.366 (  -1.344,   2.077) & \\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{uPCR}}\\
\hspace{1em}uPCR & 0.125 (  -0.318,   0.569) & 0.738 (   0.024,   1.451) & 0.650 (  -0.906,   2.207) & 0.317 (  -0.606,   1.241) & -0.577 (  -1.317,   0.162) & 0.071 (  -1.109,   1.251)\\
\hspace{1em}uPCR Rate &  &  & -0.042 (  -0.139,   0.055) & 0.020 (  -0.050,   0.091) & 0.030 (  -0.039,   0.099) & \\
\rowcolor{gray!6}  \hspace{1em}log(uPCR Rate) &  & -0.097 (  -0.880,   0.685) & 0.740 (  -0.470,   1.950) & -0.244 (  -0.940,   0.450) &  & -0.080 (  -0.515,   0.354)\\
\addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{Measures}}\\
\hspace{1em}SBP & -0.001 (  -0.004,   0.002) & 0.003 (  -0.003,   0.010) & 0.009 (  -0.001,   0.020) &  &  & \\
\rowcolor{gray!6}  \hspace{1em}DBP & 0.006 (   0.000,   0.013) & 0.007 (  -0.005,   0.021) & 0.007 (  -0.010,   0.025) &  &  & \\
\hspace{1em}BMI &  & 0.003 (  -0.063,   0.070) &  & -0.019 (  -0.060,   0.021) &  & \\
\rowcolor{gray!6}  \hspace{1em}Albumin & -0.044 (  -0.064,  -0.024) & -0.040 (  -0.075,  -0.005) & -0.037 (  -0.100,   0.025) &  & -0.050 (  -0.096,  -0.003) & -0.021 (  -0.076,   0.032)\\
\hspace{1em}Corrected Calcium & 0.280 (  -0.192,   0.752) &  & -1.291 (  -2.494,  -0.089) &  &  & 1.243 (  -0.187,   2.674)\\
\rowcolor{gray!6}  \hspace{1em}Haemoglobin & -0.013 (  -0.017,  -0.008) & -0.009 (  -0.018,  -0.000) & -0.001 (  -0.016,   0.013) & -0.003 (  -0.016,   0.010) & -0.006 (  -0.017,   0.005) & -0.022 (  -0.037,  -0.006)\\
\hspace{1em}Phosphate & 0.511 (   0.132,   0.890) & 0.904 (   0.087,   1.721) & 1.042 (  -0.336,   2.421) & 0.578 (  -0.333,   1.491) &  & \\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{Gender}}\\
\hspace{1em}Female & -0.235 (  -0.371,  -0.099) & -0.492 (  -0.754,  -0.230) & -0.156 (  -0.466,   0.154) &  &  & \\
\addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{Smoking Status}}\\
\hspace{1em}Former (3 years+) & -0.212 (  -0.879,   0.453) & -0.121 (  -1.020,   0.776) & -0.337 (  -1.527,   0.851) & 0.599 (  -0.501,   1.701) & -0.519 (  -1.745,   0.706) & -0.026 (  -1.302,   1.249)\\
\rowcolor{gray!6}  \hspace{1em}Non-Smoker & -0.198 (  -0.345,  -0.051) & -0.168 (  -0.567,   0.230) & -0.056 (  -0.405,   0.291) & -0.161 (  -0.623,   0.299) & -0.192 (  -0.641,   0.256) & -0.481 (  -1.013,   0.049)\\
\hspace{1em}Smoker & 0.356 (   0.160,   0.551) & 0.259 (  -0.091,   0.611) & 0.374 (  -0.004,   0.753) & -0.532 (  -1.202,   0.136) & 0.686 (   0.252,   1.120) & 0.136 (  -0.400,   0.674)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{Primary Renal Diagnosis}}\\
\hspace{1em}Familial / hereditary nephropathies & -0.424 (  -0.854,   0.006) & 0.869 (   0.391,   1.348) & 0.982 (   0.466,   1.498) & 1.330 (   0.504,   2.156) & -0.775 (  -1.444,  -0.105) & -0.397 (  -1.214,   0.419)\\
\hspace{1em}Glomerular disease & -0.394 (  -0.635,  -0.154) & -0.313 (  -0.716,   0.090) & -0.263 (  -0.706,   0.178) & 0.224 (  -0.349,   0.797) & -0.683 (  -1.146,  -0.221) & -0.332 (  -0.994,   0.330)\\
\rowcolor{gray!6}  \hspace{1em}Miscellaneous renal disorders & -0.263 (  -0.505,  -0.021) & -0.375 (  -0.927,   0.176) & -1.319 (  -2.390,  -0.247) & -1.377 (  -2.859,   0.103) & -0.364 (  -1.039,   0.310) & 0.999 (  -0.340,   2.338)\\
\hspace{1em}Tubulointerstitial disease & -0.463 (  -0.741,  -0.184) & -0.307 (  -0.788,   0.173) & -0.311 (  -0.904,   0.281) & -0.232 (  -1.130,   0.666) & -0.599 (  -1.247,   0.048) & 0.428 (  -0.427,   1.284)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{7}{l}{\textbf{Comorbidity}}\\
\hspace{1em}DM & 0.122 (  -0.011,   0.255) & 0.123 (  -0.187,   0.434) &  &  &  & 0.570 (   0.017,   1.124)\\
\hspace{1em}CCF & -0.394 (  -0.535,  -0.253) & -0.144 (  -0.517,   0.228) & 0.378 (  -0.094,   0.852) & 0.341 (  -0.529,   1.213) & -0.174 (  -0.576,   0.228) & -0.389 (  -0.994,   0.216)\\
\rowcolor{gray!6}  \hspace{1em}MI & -0.246 (  -0.397,  -0.094) &  & 0.274 (  -0.313,   0.862) & 1.602 (  -0.445,   3.650) & 0.304 (  -0.152,   0.761) & \\
\hspace{1em}IHD & 0.102 (  -0.041,   0.245) &  & -0.440 (  -0.869,  -0.010) & 0.864 (  -0.634,   2.362) &  & -0.236 (  -0.852,   0.378)\\
\rowcolor{gray!6}  \hspace{1em}PVD & -0.248 (  -0.394,  -0.103) &  & -0.203 (  -0.631,   0.224) & -0.600 (  -1.318,   0.118) & -0.315 (  -0.697,   0.067) & \\
\hspace{1em}CVA & -0.070 (  -0.252,   0.111) &  &  & -0.287 (  -1.243,   0.668) &  & -0.833 (  -1.634,  -0.032)\\
\rowcolor{gray!6}  \hspace{1em}COPD & -0.289 (  -0.433,  -0.145) &  & -0.204 (  -0.563,   0.153) & 0.625 (  -0.101,   1.351) & 0.208 (  -0.189,   0.606) & \\
\hspace{1em}LD & -0.169 (  -0.578,   0.239) & -0.659 (  -1.157,  -0.160) & -0.320 (  -1.015,   0.373) & 12.426 (-521.602, 546.454) &  & -0.751 (  -1.941,   0.438)\\
\rowcolor{gray!6}  \hspace{1em}ST & -0.274 (  -0.431,  -0.117) & -0.335 (  -0.777,   0.106) &  &  & -0.184 (  -0.592,   0.223) & -0.419 (  -1.146,   0.306)\\
\hspace{1em}HT &  & 0.139 (  -0.425,   0.705) & 0.447 (  -0.535,   1.429) & 0.458 (  -0.527,   1.443) &  & -0.920 (  -2.113,   0.271)\\
\bottomrule
\end{tabular}
\end{table}
\end{landscape}
\restoregeometry

The equations \@ref(eq:CH-Five-12), \@ref(eq:CH-Five-13), \@ref(eq:CH-Five-14) and \@ref(eq:CH-Five-16) show the baseline cumulative hazard functions from the CKD state to HD, PD, Tx and Dead, respectively. Equation \@ref(eq:CH-Five-26) shows the baseline cumulative hazard function from HD to Dead and Equation \@ref(eq:CH-Five-36) shows the baseline cumulative hazard function from PD to Dead.

\begin{equation}
\Lambda_{0,16}(t)=\begin{cases} 1.19795\log(t)+17.68798 & 0 \le t < 3 \\ -9e-05\log(t)^3+3e-04\log(t)^2+1.19761\log(t)+17.68811 & 3 \le t < 443 \\ 0.15869\log(t)^3-2.9019\log(t)^2+18.88018\log(t)-18.22403 & 443 \le t < 873 \\ -0.30096\log(t)^3+6.43659\log(t)^2-44.36299\log(t)+124.54338 & 873 \le t < 1295 \\ -0.04158\log(t)^3+0.86028\log(t)^2-4.40166\log(t)+29.08554 & 1295 \le t < 1876 \\ 0.51263\log(t)^3-11.67048\log(t)^2+90.03919\log(t)-208.17245 & 1876 \le t < 2738 \\ -0.23992\log(t)^3+6.19863\log(t)^2-51.3924\log(t)+164.96467 & 2738 \le t < 5497 \\ 1.98997\log(t)+11.72244)) & 5497 \le t (\#eq:CH-Five-16)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,12}(t)=\begin{cases} 2.10248\log(t)-8.40415 & 0 \le t < 22 \\ -0.02708\log(t)^3+0.25114\log(t)^2+1.3262\log(t)-7.60432 & 22 \le t < 398 \\ 0.1382\log(t)^3-2.71684\log(t)^2+19.09196\log(t)-43.05188 & 398 \le t < 939 \\ -0.08093\log(t)^3+1.78288\log(t)^2-11.70775\log(t)+27.2208 & 939 \le t < 1680 \\ 0.00603\log(t)^3-0.15477\log(t)^2+2.68263\log(t)-8.40353 & 1680 \le t < 5173 \\ 1.35914\log(t)-4.63106)) & 5173 \le t (\#eq:CH-Five-12)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,13}(t)=\begin{cases} 1.54717\log(t)-2.95572 & 0 \le t < 18 \\ -0.0099\log(t)^3+0.08586\log(t)^2+1.29901\log(t)-2.71663 & 18 \le t < 399 \\ 0.06206\log(t)^3-1.20706\log(t)^2+9.04226\log(t)-18.17463 & 399 \le t < 1143 \\ -0.02442\log(t)^3+0.61979\log(t)^2-3.82137\log(t)+12.01805 & 1143 \le t < 4720 \\ 1.42179\log(t)-2.7669)) & 4720 \le t (\#eq:CH-Five-13)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,14}(t)=\begin{cases} 1.2532\log(t)-26.76925 & 0 \le t < 57 \\ 0.05585\log(t)^3-0.67736\log(t)^2+3.99179\log(t)-30.46001 & 57 \le t < 673 \\ -1.53678\log(t)^3+30.432\log(t)^2-198.5656\log(t)+409.16648 & 673 \le t < 968 \\ 1.6017\log(t)^3-34.30313\log(t)^2+246.5168\log(t)-610.87894 & 968 \le t < 1408 \\ -1.63794\log(t)^3+36.16075\log(t)^2-264.35866\log(t)+623.7665 & 1408 \le t < 1874 \\ 0.33702\log(t)^3-8.48952\log(t)^2+72.12758\log(t)-221.49141 & 1874 \le t < 4432 \\ 0.84439\log(t)-21.97914)) & 4432 \le t (\#eq:CH-Five-14)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,26}(t)=\begin{cases} 1.29244\log(t)-8.98979 & 0 \le t < 8 \\ -0.01397\log(t)^3+0.08716\log(t)^2+1.1112\log(t)-8.86417 & 8 \le t < 204 \\ 0.26151\log(t)^3-4.30937\log(t)^2+24.49956\log(t)-50.33752 & 204 \le t < 479 \\ -0.93294\log(t)^3+17.80365\log(t)^2-111.9599\log(t)+230.35972 & 479 \le t < 764 \\ 1.30576\log(t)^3-26.7818\log(t)^2+184.02359\log(t)-424.6091 & 764 \le t < 1217 \\ -1.24908\log(t)^3+27.66815\log(t)^2-202.79666\log(t)+491.39983 & 1217 \le t < 1828 \\ 0.18579\log(t)^3-4.66437\log(t)^2+40.05781\log(t)-116.63908 & 1828 \le t < 4310 \\ 1.02311\log(t)-7.74927)) & 4310 \le t (\#eq:CH-Five-26)\end{cases}
\end{equation}
\begin{equation}
\Lambda_{0,36}(t)=\begin{cases} 1.55188\log(t)-8.40785 & 0 \le t < 9 \\ -0.02867\log(t)^3+0.18901\log(t)^2+1.13657\log(t)-8.10367 & 9 \le t < 167 \\ 0.24473\log(t)^3-4.00711\log(t)^2+22.60308\log(t)-44.70978 & 167 \le t < 553 \\ -0.99362\log(t)^3+19.45322\log(t)^2-125.54725\log(t)+267.14313 & 553 \le t < 875 \\ 1.22972\log(t)^3-25.73085\log(t)^2+180.53981\log(t)-424.02428 & 875 \le t < 1410 \\ -1.86859\log(t)^3+41.67205\log(t)^2-308.23775\log(t)+757.44556 & 1410 \le t < 1937 \\ 0.31596\log(t)^3-7.93077\log(t)^2+67.19201\log(t)-189.72839 & 1937 \le t < 4302 \\ 0.83657\log(t)-4.66673)) & 4302 \le t (\#eq:CH-Five-36)\end{cases}
\end{equation}

Table \@ref(tab:IV-Five) shows the results from the internal validation in the Five-State Model. The calibration slope results are shown in a seperate table for both the internal and external validation.


\begin{table}[!h]

\caption{(\#tab:IV-Five){\small Internal Validation of the Five-State Model, results presented as Estimate (95\% CI, where possible)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{}l>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r}
\toprule
Predicting & eGFR & One Year & Two Year & Five Year & Average\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Brier}}\\
\hspace{1em}Five & < 60 & 0.74 ( 0.74,  0.75) & 0.72 ( 0.72,  0.72) & 0.67 ( 0.66,  0.67) & 0.69 ( 0.69,  0.69)\\
\hspace{1em}Five & < 30 & 0.76 ( 0.75,  0.76) & 0.71 ( 0.71,  0.72) & 0.65 ( 0.65,  0.66) & 0.68 ( 0.68,  0.69)\\
\rowcolor{gray!6}  \hspace{1em}Three & < 60 & 0.72 ( 0.72,  0.73) & 0.72 ( 0.72,  0.72) & 0.66 ( 0.66,  0.67) & 0.68 ( 0.68,  0.69)\\
\hspace{1em}Three & < 30 & 0.72 ( 0.71,  0.72) & 0.74 ( 0.73,  0.74) & 0.67 ( 0.67,  0.68) & 0.69 ( 0.68,  0.69)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.74 ( 0.74,  0.74) & 0.72 ( 0.72,  0.73) & 0.67 ( 0.67,  0.68) & 0.69 ( 0.68,  0.69)\\
\hspace{1em}Two & < 30 & 0.74 ( 0.73,  0.74) & 0.72 ( 0.72,  0.73) & 0.72 ( 0.71,  0.72) & 0.69 ( 0.69,  0.69)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{c-statistic}}\\
\hspace{1em}Five & < 60 & 0.88 ( 0.88,  0.88) & 0.86 ( 0.85,  0.86) & 0.83 ( 0.83,  0.84) & 0.84 ( 0.84,  0.84)\\
\hspace{1em}Five & < 30 & 0.88 ( 0.87,  0.88) & 0.87 ( 0.87,  0.87) & 0.86 ( 0.86,  0.86) & 0.84 ( 0.84,  0.85)\\
\rowcolor{gray!6}  \hspace{1em}Three & < 60 & 0.87 ( 0.87,  0.87) & 0.87 ( 0.86,  0.87) & 0.84 ( 0.84,  0.84) & 0.84 ( 0.84,  0.84)\\
\hspace{1em}Three & < 30 & 0.86 ( 0.86,  0.86) & 0.87 ( 0.87,  0.87) & 0.85 ( 0.85,  0.85) & 0.84 ( 0.84,  0.85)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.86 ( 0.86,  0.86) & 0.86 ( 0.86,  0.87) & 0.84 ( 0.84,  0.84) & 0.84 ( 0.84,  0.84)\\
\hspace{1em}Two & < 30 & 0.86 ( 0.86,  0.86) & 0.87 ( 0.87,  0.88) & 0.81 ( 0.81,  0.81) & 0.84 ( 0.84,  0.84)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Intercept}}\\
\hspace{1em}Five & < 60 & \makecell[r]{0.00 (-0.00,  0.00)\\ -0.01 (-0.01, -0.01)\\ -0.01 (-0.01, -0.01)\\  0.01 ( 0.00,  0.01)\\ -0.00 (-0.00,  0.00)\\ -0.01 (-0.01, -0.00)} & \makecell[r]{0.01 ( 0.00,  0.01)\\  0.01 ( 0.01,  0.01)\\ -0.00 (-0.00,  0.00)\\ -0.00 (-0.00, -0.00)\\  0.00 ( 0.00,  0.01)\\  0.00 ( 0.00,  0.00)} & \makecell[r]{-0.01 (-0.01, -0.00)\\ -0.00 (-0.01, -0.00)\\ -0.01 (-0.01, -0.00)\\ -0.04 (-0.05, -0.04)\\  0.01 ( 0.00,  0.01)\\ -0.00 (-0.00, -0.00)} & \makecell[r]{0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.01)}\\
\hspace{1em}Five & < 30 & \makecell[r]{-0.02 (-0.02, -0.02)\\  0.00 ( 0.00,  0.01)\\ -0.00 (-0.01, -0.00)\\ -0.00 (-0.01, -0.00)\\  0.01 ( 0.01,  0.01)\\  0.00 ( 0.00,  0.00)} & \makecell[r]{0.00 ( 0.00,  0.00)\\  0.00 ( 0.00,  0.00)\\ -0.01 (-0.02, -0.01)\\ -0.02 (-0.02, -0.01)\\ -0.00 (-0.00, -0.00)\\ -0.00 (-0.00, -0.00)} & \makecell[r]{-0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.01)\\ -0.00 (-0.00,  0.00)\\ -0.01 (-0.01, -0.01)\\ -0.01 (-0.01, -0.01)\\ -0.00 (-0.00, -0.00)} & \makecell[r]{-0.00 (-0.01, -0.00)\\  0.00 ( 0.00,  0.00)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)}\\
\rowcolor{gray!6}  \hspace{1em}Three & < 60 & \makecell[r]{-0.00 (-0.01, -0.00)\\  0.00 (-0.00,  0.00)\\ -0.01 (-0.01, -0.00)} & \makecell[r]{0.01 ( 0.01,  0.02)\\  0.00 (-0.00,  0.00)\\  0.00 ( 0.00,  0.00)} & \makecell[r]{0.02 ( 0.02,  0.02)\\ -0.02 (-0.02, -0.02)\\  0.02 ( 0.02,  0.02)} & \makecell[r]{0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\ -0.00 (-0.00, -0.00)}\\
\hspace{1em}Three & < 30 & \makecell[r]{-0.00 (-0.01, -0.00)\\  0.00 (-0.00,  0.00)\\  0.01 ( 0.00,  0.01)} & \makecell[r]{0.00 ( 0.00,  0.00)\\  0.01 ( 0.00,  0.01)\\  0.01 ( 0.01,  0.01)} & \makecell[r]{0.00 ( 0.00,  0.00)\\ -0.01 (-0.02, -0.01)\\ -0.01 (-0.01, -0.00)} & \makecell[r]{-0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & -0.01 (-0.01, -0.00) & 0.01 ( 0.00,  0.01) & 0.00 (-0.00,  0.00) & -0.00 (-0.01, -0.00)\\
\hspace{1em}Two & < 30 & -0.03 (-0.03, -0.03) & 0.02 ( 0.01,  0.02) & -0.00 (-0.00,  0.00) & 0.00 (-0.00,  0.00)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Slope}}\\
\hspace{1em}Three & < 60 & \makecell[r]{\emph{1.19},  0.01,  0.01\\ -0.01,  \emph{1.07}, -0.02\\ -0.07,  0.00,  \emph{1.11}} & \makecell[r]{\emph{1.16}, -0.01, -0.01\\ -0.00,  \emph{1.11}, -0.01\\  0.01, -0.00,  \emph{1.35}} & \makecell[r]{\emph{1.24}, -0.00,  0.00\\ -0.07,  \emph{1.28},  0.00\\ -0.03,  0.01,  \emph{1.18}} & \makecell[r]{\emph{1.30},  0.01, -0.00\\  0.00,  \emph{1.29}, -0.00\\ -0.00,  0.00,  \emph{1.32}}\\
\hspace{1em}Three & < 30 & \makecell[r]{\emph{1.21}, -0.01,  0.01\\ -0.02,  \emph{1.18}, -0.01\\  0.02, -0.01,  \emph{1.15}} & \makecell[r]{\emph{1.12},  0.01,  0.00\\ -0.02,  \emph{1.27},  0.00\\  0.03,  0.04,  \emph{1.18}} & \makecell[r]{\emph{1.34},  0.12, -0.02\\  0.02,  \emph{1.43}, -0.05\\  0.00,  0.09,  \emph{1.19}} & \makecell[r]{\emph{1.27},  0.00, -0.00\\ -0.00,  \emph{1.28},  0.00\\ -0.00, -0.00,  \emph{1.29}}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & \emph{1.21} & \emph{1.03} & \emph{1.25} & \emph{1.25}\\
\hspace{1em}Two & < 30 & \emph{1.05} & \emph{1.16} & \emph{1.38} & \emph{1.28}\\
\bottomrule
\end{tabular}
\end{table}


Table \@ref(tab:EV-Five) shows the results from the external validation in the Five-State Model.

\begin{table}[!h]

\caption{(\#tab:EV-Five){\small External Validation of the Five-State Model, results presented as Estimate (95\% CI, where possible)}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{}l>{}l>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r>{\ttfamily}r}
\toprule
Predicting & eGFR & One Year & Two Year & Five Year & Average\\
\midrule
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Brier}}\\
\hspace{1em}Five & < 60 & 0.70 ( 0.70,  0.71) & 0.72 ( 0.71,  0.72) & 0.64 ( 0.64,  0.65) & 0.63 ( 0.63,  0.64)\\
\hspace{1em}Five & < 30 & 0.73 ( 0.72,  0.73) & 0.71 ( 0.70,  0.71) & 0.67 ( 0.67,  0.68) & 0.64 ( 0.64,  0.65)\\
\rowcolor{gray!6}  \hspace{1em}Three & < 60 & 0.69 ( 0.68,  0.69) & 0.71 ( 0.71,  0.71) & 0.67 ( 0.66,  0.67) & 0.64 ( 0.63,  0.64)\\
\hspace{1em}Three & < 30 & 0.69 ( 0.68,  0.69) & 0.68 ( 0.68,  0.69) & 0.63 ( 0.63,  0.64) & 0.63 ( 0.62,  0.63)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.69 ( 0.68,  0.69) & 0.68 ( 0.68,  0.69) & 0.60 ( 0.60,  0.60) & 0.64 ( 0.63,  0.64)\\
\hspace{1em}Two & < 30 & 0.73 ( 0.72,  0.73) & 0.67 ( 0.67,  0.67) & 0.64 ( 0.63,  0.64) & 0.63 ( 0.63,  0.64)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{c-statistic}}\\
\hspace{1em}Five & < 60 & 0.85 ( 0.85,  0.85) & 0.85 ( 0.84,  0.85) & 0.82 ( 0.82,  0.82) & 0.82 ( 0.81,  0.82)\\
\hspace{1em}Five & < 30 & 0.85 ( 0.85,  0.85) & 0.83 ( 0.82,  0.83) & 0.82 ( 0.82,  0.82) & 0.81 ( 0.81,  0.82)\\
\rowcolor{gray!6}  \hspace{1em}Three & < 60 & 0.83 ( 0.83,  0.84) & 0.83 ( 0.82,  0.83) & 0.81 ( 0.81,  0.82) & 0.81 ( 0.81,  0.82)\\
\hspace{1em}Three & < 30 & 0.87 ( 0.87,  0.87) & 0.84 ( 0.84,  0.84) & 0.82 ( 0.82,  0.82) & 0.82 ( 0.81,  0.82)\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.84 ( 0.84,  0.85) & 0.85 ( 0.84,  0.85) & 0.81 ( 0.81,  0.81) & 0.82 ( 0.82,  0.82)\\
\hspace{1em}Two & < 30 & 0.84 ( 0.83,  0.84) & 0.84 ( 0.84,  0.84) & 0.81 ( 0.81,  0.82) & 0.82 ( 0.81,  0.82)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Intercept}}\\
\hspace{1em}Five & < 60 & \makecell[r]{-0.01 (-0.01, -0.01)\\ -0.02 (-0.02, -0.01)\\ -0.02 (-0.02, -0.01)\\  0.04 ( 0.03,  0.04)\\  0.00 ( 0.00,  0.00)\\ -0.01 (-0.01, -0.00)} & \makecell[r]{0.01 ( 0.00,  0.01)\\ -0.01 (-0.02, -0.01)\\ -0.01 (-0.02, -0.01)\\ -0.02 (-0.03, -0.02)\\ -0.01 (-0.01, -0.00)\\  0.01 ( 0.00,  0.01)} & \makecell[r]{0.00 ( 0.00,  0.01)\\ -0.00 (-0.01, -0.00)\\ -0.02 (-0.03, -0.02)\\  0.01 ( 0.01,  0.02)\\  0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)} & \makecell[r]{-0.00 (-0.00,  0.00)\\ -0.00 (-0.01, -0.00)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\ -0.00 (-0.01, -0.00)\\  0.00 (-0.00,  0.00)}\\
\hspace{1em}Five & < 30 & \makecell[r]{0.02 ( 0.01,  0.02)\\ -0.01 (-0.01, -0.00)\\  0.02 ( 0.01,  0.02)\\ -0.02 (-0.03, -0.02)\\  0.03 ( 0.02,  0.03)\\  0.01 ( 0.01,  0.01)} & \makecell[r]{0.02 ( 0.02,  0.03)\\ -0.02 (-0.02, -0.01)\\ -0.02 (-0.02, -0.01)\\ -0.00 (-0.00, -0.00)\\  0.02 ( 0.02,  0.02)\\ -0.01 (-0.01, -0.00)} & \makecell[r]{0.03 ( 0.02,  0.03)\\  0.00 ( 0.00,  0.01)\\ -0.02 (-0.02, -0.01)\\ -0.00 (-0.01, -0.00)\\ -0.00 (-0.00,  0.00)\\  0.02 ( 0.01,  0.02)} & \makecell[r]{0.00 (-0.00,  0.00)\\ -0.00 (-0.00, -0.00)\\  0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)\\ -0.00 (-0.00, -0.00)\\ -0.00 (-0.00,  0.00)}\\
\rowcolor{gray!6}  \hspace{1em}Three & < 60 & \makecell[r]{0.00 ( 0.00,  0.00)\\ -0.01 (-0.02, -0.01)\\ -0.02 (-0.02, -0.02)} & \makecell[r]{-0.01 (-0.01, -0.00)\\  0.02 ( 0.02,  0.03)\\  0.01 ( 0.01,  0.02)} & \makecell[r]{0.01 ( 0.00,  0.01)\\ -0.03 (-0.04, -0.03)\\ -0.02 (-0.03, -0.02)} & \makecell[r]{0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\  0.00 (-0.00,  0.00)}\\
\hspace{1em}Three & < 30 & \makecell[r]{-0.00 (-0.01, -0.00)\\ -0.02 (-0.02, -0.02)\\ -0.03 (-0.04, -0.03)} & \makecell[r]{0.01 ( 0.01,  0.02)\\ -0.00 (-0.01, -0.00)\\ -0.00 (-0.01, -0.00)} & \makecell[r]{0.02 ( 0.02,  0.02)\\ -0.05 (-0.05, -0.04)\\  0.01 ( 0.01,  0.01)} & \makecell[r]{-0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)\\ -0.00 (-0.00,  0.00)}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & 0.00 ( 0.00,  0.01) & -0.02 (-0.02, -0.02) & -0.00 (-0.00,  0.00) & 0.00 (-0.00,  0.00)\\
\hspace{1em}Two & < 30 & -0.02 (-0.02, -0.01) & 0.02 ( 0.02,  0.03) & 0.01 ( 0.01,  0.01) & -0.00 (-0.00,  0.00)\\
\rowcolor{gray!6}  \addlinespace[0.3em]
\multicolumn{6}{l}{\textbf{Slope}}\\
\hspace{1em}Three & < 60 & \makecell[r]{\emph{1.01}, -0.00, -0.00\\  0.01,  \emph{1.21}, -0.05\\  0.08, -0.05,  \emph{1.22}} & \makecell[r]{\emph{1.40},  0.02, -0.02\\ -0.03,  \emph{1.28}, -0.03\\ -0.07,  0.06,  \emph{1.12}} & \makecell[r]{\emph{1.61}, -0.03,  0.04\\  0.03,  \emph{1.76},  0.00\\  0.04, -0.00,  \emph{1.45}} & \makecell[r]{\emph{1.46}, -0.00, -0.00\\  0.00,  \emph{1.50}, -0.01\\ -0.00, -0.00,  \emph{1.45}}\\
\hspace{1em}Three & < 30 & \makecell[r]{\emph{1.24}, -0.00, -0.00\\ -0.02,  \emph{1.20}, -0.05\\ -0.01, -0.07,  \emph{1.34}} & \makecell[r]{\emph{1.39},  0.03,  0.00\\ -0.04,  \emph{1.24},  0.04\\ -0.03, -0.01,  \emph{1.18}} & \makecell[r]{\emph{1.28},  0.02,  0.03\\ -0.09,  \emph{1.38},  0.02\\ -0.07, -0.00,  \emph{1.44}} & \makecell[r]{\emph{1.51}, -0.00,  0.00\\  0.00,  \emph{1.41}, -0.00\\ -0.00, -0.00,  \emph{1.47}}\\
\rowcolor{gray!6}  \hspace{1em}Two & < 60 & \emph{1.38} & \emph{1.12} & \emph{1.25} & \emph{1.46}\\
\hspace{1em}Two & < 30 & \emph{1.26} & \emph{1.28} & \emph{1.35} & \emph{1.55}\\
\bottomrule
\end{tabular}
\end{table}

Table \@ref(tab:Five-Valid-Slope) shows the calibration slopes for the model in the internal and external datasets in both the < 60 eGFR and <30 eGFR sub-populations.


\begin{table}[!h]

\caption{(\#tab:Five-Valid-Slope){\small Calibration Slope results for both the External and Internal Validation for the Five-State Model}}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{20em}>{\ttfamily\raggedleft\arraybackslash}p{20em}>{\ttfamily\raggedleft\arraybackslash}p{20em}>{\ttfamily\raggedleft\arraybackslash}p{20em}>{\ttfamily\raggedleft\arraybackslash}p{20em}}
\toprule
  & Internal < 60 & Internal < 30 & External < 60 & External < 30\\
\midrule
\rowcolor{gray!6}  One Year & \emph{1.14}, -0.01,  0.00,  0.02,  0.00,  0.01\newline  -0.00,  \emph{1.09}, -0.05, -0.01,  0.01,  0.00\newline  -0.04,  0.06,  \emph{1.22},  0.02,  0.03,  0.00\newline  -0.06,  0.02,  0.01,  \emph{1.25},  0.00, -0.02\newline  -0.02,  0.03,  0.02, -0.02,  \emph{1.13},  0.00\newline   0.05, -0.04, -0.06, -0.02, -0.00,  \emph{1.30} & \emph{1.07},  0.03,  0.02,  0.02,  0.01, -0.00\newline   0.00,  \emph{1.18},  0.01,  0.00, -0.06,  0.01\newline   0.01,  0.00,  \emph{1.03},  0.00, -0.05,  0.00\newline  -0.04, -0.03, -0.03,  \emph{1.11},  0.01, -0.03\newline   0.00, -0.03, -0.02, -0.02,  \emph{1.15},  0.01\newline   0.02, -0.01,  0.00, -0.00, -0.01,  \emph{1.11} & \emph{1.16},  0.02, -0.00, -0.01,  0.00,  0.06\newline  -0.03,  \emph{1.08}, -0.00, -0.00,  0.04, -0.04\newline  -0.05, -0.02,  \emph{1.18}, -0.04, -0.05,  0.02\newline  -0.01, -0.04, -0.06,  \emph{1.17},  0.00, -0.00\newline  -0.01, -0.02,  0.00, -0.01,  \emph{1.14}, -0.04\newline   0.03, -0.00, -0.03,  0.00,  0.01,  \emph{1.23} & \emph{1.31},  0.02,  0.05, -0.00, -0.01, -0.00\newline   0.02,  \emph{1.16},  0.04,  0.01,  0.04, -0.03\newline   0.04,  0.01,  \emph{1.08},  0.01,  0.01, -0.04\newline  -0.04, -0.04, -0.01,  \emph{1.08}, -0.00, -0.00\newline  -0.02,  0.04, -0.03, -0.03,  \emph{1.27}, -0.00\newline  -0.01,  0.02,  0.03, -0.02,  0.07,  \emph{1.16}\\
Two Year & \emph{1.42}, -0.05,  0.03, -0.01, -0.05,  0.00\newline   0.02,  \emph{1.12},  0.03, -0.01,  0.03, -0.00\newline   0.01, -0.01,  \emph{1.22}, -0.00,  0.00,  0.04\newline  -0.03,  0.00, -0.05,  \emph{1.21}, -0.01,  0.00\newline  -0.02, -0.03, -0.00, -0.01,  \emph{1.39}, -0.00\newline  -0.03,  0.04,  0.04, -0.00,  0.03,  \emph{1.15} & \emph{1.14}, -0.02,  0.04,  0.02,  0.00, -0.09\newline  -0.01,  \emph{1.10},  0.00, -0.07, -0.01, -0.00\newline  -0.03,  0.02,  \emph{1.12},  0.03,  0.00, -0.04\newline   0.00,  0.02, -0.03,  \emph{1.11}, -0.02,  0.01\newline  -0.00, -0.06, -0.05,  0.02,  \emph{1.11}, -0.03\newline   0.07, -0.01, -0.03,  0.02,  0.04,  \emph{1.18} & \emph{1.25},  0.02,  0.01,  0.02, -0.07,  0.02\newline   0.00,  \emph{1.39},  0.08, -0.03,  0.02,  0.05\newline  -0.01, -0.01,  \emph{1.26},  0.04, -0.04,  0.03\newline  -0.00, -0.00, -0.10,  \emph{1.21}, -0.04,  0.02\newline  -0.02, -0.02,  0.02, -0.08,  \emph{1.20}, -0.00\newline  -0.04,  0.00, -0.05,  0.02, -0.06,  \emph{1.44} & \emph{1.39}, -0.04,  0.00, -0.00,  0.01, -0.01\newline  -0.06,  \emph{1.31},  0.03,  0.00,  0.02, -0.06\newline   0.00, -0.02,  \emph{1.14},  0.01, -0.04,  0.04\newline   0.01, -0.02,  0.00,  \emph{1.37}, -0.03,  0.00\newline   0.04, -0.02, -0.00, -0.01,  \emph{1.34},  0.02\newline  -0.02,  0.02, -0.03, -0.02, -0.01,  \emph{1.32}\\
\rowcolor{gray!6}  Five Year & \emph{1.22}, -0.00,  0.05, -0.00, -0.05,  0.05\newline  -0.04,  \emph{1.11}, -0.01,  0.03,  0.04,  0.03\newline   0.02, -0.03,  \emph{1.24}, -0.03, -0.03,  0.01\newline   0.02, -0.03, -0.00,  \emph{1.20}, -0.05,  0.01\newline   0.00,  0.08, -0.00,  0.01,  \emph{1.25}, -0.06\newline   0.01, -0.00, -0.00,  0.03, -0.05,  \emph{1.14} & \emph{1.27},  0.02,  0.02, -0.03,  0.04, -0.06\newline  -0.00,  \emph{1.20}, -0.00,  0.00,  0.04, -0.00\newline  -0.03, -0.02,  \emph{1.22},  0.02,  0.05,  0.03\newline   0.00, -0.02, -0.01,  \emph{1.30}, -0.00,  0.04\newline   0.00, -0.05,  0.00, -0.05,  \emph{1.31},  0.01\newline  -0.01, -0.04, -0.05,  0.02, -0.00,  \emph{1.19} & \emph{1.45}, -0.04,  0.06, -0.07,  0.00,  0.04\newline  -0.01,  \emph{1.31},  0.04,  0.01, -0.01,  0.03\newline   0.01,  0.06,  \emph{1.50},  0.01,  0.02, -0.00\newline  -0.01,  0.00,  0.08,  \emph{1.56},  0.02,  0.01\newline  -0.09,  0.01, -0.02, -0.06,  \emph{1.47}, -0.00\newline  -0.03,  0.04,  0.07,  0.08,  0.01,  \emph{1.35} & \emph{1.32},  0.04, -0.04, -0.01, -0.02,  0.03\newline  -0.06,  \emph{1.21},  0.01,  0.00, -0.06, -0.01\newline   0.01, -0.08,  \emph{1.70},  0.04, -0.03, -0.05\newline  -0.01,  0.03, -0.02,  \emph{1.35}, -0.02,  0.02\newline  -0.05, -0.03,  0.03, -0.04,  \emph{1.43},  0.07\newline   0.01,  0.04, -0.04, -0.01, -0.00,  \emph{1.28}\\
Average & \emph{1.28},  0.00, -0.00,  0.01,  0.00,  0.00\newline   0.00,  \emph{1.28},  0.00,  0.00, -0.00,  0.01\newline   0.00,  0.01,  \emph{1.25},  0.00, -0.00,  0.00\newline  -0.00,  0.00,  0.00,  \emph{1.28}, -0.00,  0.00\newline  -0.00,  0.00, -0.00,  0.01,  \emph{1.26}, -0.00\newline  -0.00,  0.01,  0.00, -0.00, -0.00,  \emph{1.31} & \emph{1.31},  0.01, -0.00,  0.00,  0.00,  0.00\newline  -0.00,  \emph{1.29}, -0.00,  0.00, -0.00,  0.00\newline  -0.00,  0.00,  \emph{1.30}, -0.00, -0.00, -0.00\newline   0.00, -0.00, -0.00,  \emph{1.28},  0.00, -0.01\newline   0.00,  0.00,  0.00,  0.00,  \emph{1.27}, -0.01\newline   0.01, -0.00, -0.00, -0.00,  0.00,  \emph{1.28} & \emph{1.46},  0.01, -0.00,  0.00, -0.01,  0.00\newline   0.01,  \emph{1.46},  0.01,  0.00, -0.00, -0.00\newline  -0.00,  0.00,  \emph{1.54}, -0.01,  0.00, -0.00\newline   0.00, -0.02,  0.00,  \emph{1.51}, -0.00,  0.01\newline  -0.01,  0.00,  0.00, -0.00,  \emph{1.47}, -0.00\newline   0.00, -0.00, -0.00, -0.00, -0.01,  \emph{1.47} & \emph{1.49}, -0.00, -0.00, -0.00, -0.01,  0.01\newline  -0.01,  \emph{1.45}, -0.00,  0.00,  0.00, -0.00\newline   0.00, -0.00,  \emph{1.44},  0.01, -0.00, -0.01\newline   0.00, -0.00,  0.01,  \emph{1.47}, -0.00,  0.00\newline  -0.00, -0.00, -0.00,  0.00,  \emph{1.47},  0.01\newline   0.00, -0.00, -0.00, -0.00,  0.00,  \emph{1.44}\\
\bottomrule
\end{tabular}
\end{table}





<!--chapter:end:06a-Dev_Paper_Supp.Rmd-->

<!--
The bib chunk below must go last in this document according to how R Markdown renders.  More info is at http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html
-->

\backmatter

<!-- 
If you'd like to change the name of the bibliography to something else,
delete "References" and replace it.
-->

# References {-}
\chaptermark{References}

<!--
This manually sets the header for this unnumbered chapter.
-->
\markboth{References}{References}
<!--
To remove the indentation of the first entry.
-->
\noindent

<!--
To create a hanging indent and spacing between entries.  These three lines may need to be removed for styles that don't require the hanging indent.
-->

\setlength{\parindent}{-0.20in}
\setlength{\leftskip}{0.20in}
\setlength{\parskip}{8pt}


<!--
This is just for testing with more citations for the bibliography at the end.  Add other entries into the list here if you'd like them to appear in the bibliography even if they weren't explicitly cited in the document.
-->

---
nocite: | 
  @angel2000, @angel2001, @angel2002a
...

<div id="refs"></div>


<!--chapter:end:99-references.rmd-->

