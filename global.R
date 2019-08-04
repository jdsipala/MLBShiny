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

# source("./helpers.R")
# # 
# dbname <- "./test"