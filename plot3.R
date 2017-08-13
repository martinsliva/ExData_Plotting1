####### Cleaning environment 

rm(list=ls()) 


####### Loading library
library(lubridate)



###### Download and unzip data  

if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/dataset.zip")
unzip("./data/dataset.zip")

####### Reading data
dataset<-read.table("household_power_consumption.txt", sep = ";" , header = T, as.is = T, na.strings = "?")

###### Changing format of Date
dataset$Date<-dmy(dataset$Date)

####### Creating new dataset for dates: 2007-02-01 and 2007-02-01
dataset_new<-subset(dataset, dataset$Date==ymd("2007-02-01") | dataset$Date== ymd("2007-02-02"))

####### Preparing Variable with date and time
dataset_new$Time<-hms(dataset_new$Time)
dataset_new$Time2=dataset_new$Date+dataset_new$Time

####### Opening file for writing

png(filename = "plot3.png", width = 480, height = 480, units = "px")


####### Plot 3
with(dataset_new, plot(Time2,Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = ""))
with(dataset_new, lines(Time2,Sub_metering_1))
with(dataset_new, lines(Time2,Sub_metering_2, col="red"))
with(dataset_new, lines(Time2,Sub_metering_3, col="blue"))
legend("topright",pch=c("-","-","-"),col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

####### Closing file

dev.off()

####### Cleaning environment

rm(list = ls())