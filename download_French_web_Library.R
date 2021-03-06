# title  : R - Download ken.french data library
# date   : 2015.10.21
# author : Chin-Wei Lu
# email  : cwlu1987@gmail.com
# encoding: UTF8

rm(list=ls()) #刪除內存物件

#### install packages ####

if (!require(XML)) install.packages("XML")
if (!require(stringr)) install.packages("stringr")

library(XML)
library(stringr)

#### setting URL and xpath ####

url = "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html"
html = htmlParse((url),encoding='UTF-8')
xpath = "//a"
url.node = getNodeSet(html,xpath)

#### Find XML node ####

url_vector<- c()
for(i in 1:length(url.node)){
  url_vector<-c(url_vector,xmlGetAttr(url.node[[i]],'href'))  
}

url_ZIP <- url_vector[str_detect(string = url_vector, pattern = ".zip")]
url_CSV <- url_vector[str_detect(string = url_vector, pattern = "CSV.zip")]
url_TXT <- url_vector[str_detect(string = url_vector, pattern = "TXT.zip")]

#### The URL for the data ####
ff.url.partial <- paste("http://mba.tuck.dartmouth.edu/pages/faculty/ken.french", sep="/")
ff.url.ZIP <- paste(ff.url.partial, url_ZIP, sep="/")
ff.url.CSV <- paste(ff.url.partial, url_CSV, sep="/")
ff.url.TXT <- paste(ff.url.partial, url_TXT, sep="/")

#example like "ftp/F-F_Research_Data_5_Factors_2x3_daily_CSV.zip"

#### setting Download data URL ####

destfile.ZIP<-do.call(rbind,strsplit(ff.url.ZIP,split="ftp/"))[,2]
destfile.CSV<-do.call(rbind,strsplit(ff.url.CSV,split="ftp/"))[,2]
destfile.TXT<-do.call(rbind,strsplit(ff.url.TXT,split="ftp/"))[,2]


#Downlaoading CSV file
#length(destfile.CSV)

#example
#download.file("http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_CSV.zip", "F-F_Research_Data_Factors_CSV.zip")

for(i in 1:length(destfile.CSV)){
  download.file(ff.url.CSV[[i]], destfile.CSV[i])
}

#Downlaoading TXT file
#length(destfile.TXT)

for(i in 1:length(destfile.TXT)){
  download.file(ff.url.TXT[[i]], destfile.TXT[i])
}
