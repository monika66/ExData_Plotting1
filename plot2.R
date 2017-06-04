## Coursera:    Data Science Specialization:     
## Course:      Exploratory Data Analysis
## Assignment:  Course Project 1 - Peer-graded
## Student:     Monika Hunkeler
## Date:        04.06.2017

## The R script 'plot2.R' reads electric power consumption data from 
## the UC Irvine Machine Learning Repository and plots the 
## Global Active Power for the first and second february 2007 
## on screen device and file 'plot2.png'.

## set environment workspace, change setting to your PC !!
setwd("C:/Users/acer17/Desktop/coursera/EDA_Assign_1")

## set libraries
library(readr)
library(lubridate)
library(data.table)

        ## Download and enzip file.zip if enzipped file.txt not exist
        if (!file.exists("household_power_consumption.txt")) { 
                fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                filename <- "household_power_consumption.zip"
                download.file(fileURL, destfile = filename)
                unzip(zipfile="./household_power_consumption.zip")
        }

        ## Use entzipped file.txt and read subset of plot data to R console
        filename <- "./household_power_consumption.txt"
        powerConsumption <- read.table(filename, sep=";", header = TRUE,  stringsAsFactors=FALSE, na.strings="?")
        plotdata <- subset(powerConsumption, powerConsumption$Date=="1/2/2007" | powerConsumption$Date=="2/2/2007")
        
        ## x-axis measured datetime
        x <- paste(plotdata$Date, plotdata$Time)
        x <- strptime(x,"%d/%m/%Y %H:%M:%S")
        curr_locale <- Sys.getlocale("LC_TIME")
        Sys.setlocale("LC_TIME", "English") # Windows

        ## Plot on screen device
        plot(x, plotdata$Global_active_power, type = "l", 
             xlab = " ", ylab = "Global Active Power (kilowatts)",
             mar = c(5, 4, 4, 2), pin = c(480, 480))
      
        ## Copy histogram to file device png and close device
        dev.copy(png, file = "plot2.png") 
        dev.off()
        
        ## Set the system back to original german time labels
        Sys.setlocale("LC_TIME",curr_locale)