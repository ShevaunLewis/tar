## created 6/8/2016

setwd('/Users/shevaun/Google Drive/BornToTalk-2015/Data/BornToTalk-Analysis/')

source('import_csv.r')

## import data from files, including partially-updated questions spreadsheet
load("btt-all.Rdata")
questions = read.csv('questions_final.csv', header=T)
