## Import csv files, change format, merge files.

library(dplyr)
library(tidyr)

setwd('/Users/shevaun/Google Drive/BornToTalk-2015/Data/BornToTalk-Analysis/')

csv_folder = '/Users/shevaun/Google Drive/BornToTalk-2015/Data/Socrative/csv-fixed/'
csv_files = list.files(csv_folder)
csv_files = csv_files[2:length(csv_files)]
question_file = '/Users/shevaun/Google Drive/BornToTalk-2015/Data/Socrative/questions_raw.csv'

questions = read.csv(question_file,header=T)
questions = unique(questions)
write.csv(questions, 'questions_socrative.csv', row.names=F)

data = data_frame(quizcode=character(),day=character(),date=character(),time=character(),
                  student=character(),question=character(),response=character())
for (file in csv_files) {
  path = paste0(csv_folder,file)
  d = read.csv(path, header=T, stringsAsFactors=F)
  d.long = d %>%
    gather(question, response, -quizcode,-day, -date, -time, -student)
  data = rbind(data, d.long)
}

colnames(data)[6] <- "qid"

## import questions from edited spreadsheet
questions = read.csv('questions_edited.csv', header=T)

## import data from week1 quiz, which was hand-coded from paper
questions_w1 = read.csv('/Users/shevaun/Google Drive/BornToTalk-2015/Data/w1/w1-questions.csv', header=T)
responses_w1 = read.csv('/Users/shevaun/Google Drive/BornToTalk-2015/Data/w1/w1-responses.csv', header=T)

## merge questions
questions = merge(questions, questions_w1, all=T)

## merge data
w1 = responses_w1 %>%
  gather(student, response, -quizcode, -qid)

data = merge(data, w1, all=T)

write.csv(questions, 'questions_final.csv', row.names=F)
save(data, file="btt-all.Rdata")
rm(list=ls())
