#'---
#' title: "Spin demo"
#' author: "Nick Shrine"
#' date: "January, 2017"
#'---

#' # 1 Introduction
#' We can type the introduction to our report here.
#'
#' # 2 Some calculations
x<-4
x
x*2

#' What if we just want to print the output of the R code, but not the code itself?
#+ echo=F
x^2

    
#' Or perhaps we want to give some code but don't want to include the output - perhaps it is lengthy or we want students to fill in the answer.
#+ eval=FALSE
x+20

#' # 3 Some Plots
#' Lets make a plot
year<-seq(1990,2015)
value<-rnorm(26)
plot(year,value)

#' # 4 Conclusion
#' Using a few relatively simple commands, we can combine text and R code and generate a report.
