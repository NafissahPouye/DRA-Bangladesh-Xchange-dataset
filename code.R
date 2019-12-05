library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/R scripts/DRA-Bangladesh-dataset")
data <- read_excel("data.xlsx")
col  <- colnames(data)
selectedKeyVars <- c(col[2], col[3], col[4])
weights <- c(col[38])

#Convert variables into factors
data[,selectedKeyVars] <- lapply(data[,selectedKeyVars], factor)

#Convert subfile into dataframe
subVars <- c(selectedKeyVars, weights)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)

#Assess the disclosure risk
objSDC <- createSdcObj(dat = fileRes, keyVars = selectedKeyVars, 
                       weightVar = weights)

#Disclosure risk assessment 
print(objSDC, "risk")

#Generating an internal (extensive) report
report(objSDC, filename = "index", internal = TRUE) 


