# Config ----

config = list()
config$repertoire = "E:/Mes documents/Datascience/MAIF"
config$input = file.path(config$repertoire,"input")
config$output = file.path(config$repertoire,"output")
config$Rscripts = file.path(config$repertoire,"Rscripts")
config$Rfuns = file.path(config$repertoire,"Rfuns")

# Packages ----

library(data.table)
library(h2o)
library(rootSolve)
library(ggplot2)
library(xgboost)
library(dplyr)
library(psych)

# parametres

for(fonction in list.files(config$Rfuns,full.names = TRUE)){
  source(fonction)
}
