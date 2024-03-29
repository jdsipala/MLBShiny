# install.packages("plotly")
library(plotly)
library(shiny)
library(DT)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(dplyr)

KsDF <- read.csv(file = "./avgKsDF.csv")
noHitters <- read.csv(file = "./noHitters.csv")
pitcherWins <- read.csv(file = "./pitcherWins.csv")
seasonWins <- read.csv(file = "./seasonWins.csv")
finalbatting <- read.csv(file = "./finalbatting.csv")
# source("./helpers.R")
# # 
# dbname <- "./test"