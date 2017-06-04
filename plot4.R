## Coursera:    Data Science Specialization:     
## Course:      Exploratory Data Analysis
## Assignment:  Course Project 1 - Peer-graded
## Student:     Monika Hunkeler
## Date:        04.06.2017

## The R script 'plot4.R' reads electric power consumption data from 
## the UC Irvine Machine Learning Repository and plots the 4 diagrams:
##      Global active power
##      Energy sub metering
##      Voltage
##      Global reactive power
##
## for the first and second february 2007 
## on screen device and file 'plot4.png'.

## set environment workspace, change setting to your PC directory!!
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
        
        par(mfcol = c(2,2))
        
        ## 1.) plot2: Global_active_power on screen device
        plot(x, plotdata$Global_active_power, type = "l", 
             xlab = " ", ylab = "Global Active Power (kilowatts)",
             mar = c(5, 4, 4, 2), pin = c(480, 480))
        
        ## 2.) plot3: Energy sub metering on screen device
        plot(x, plotdata$Sub_metering_1, type = "l", 
                xlab = " ", ylab = "Energy sub metering", 
                mar = c(5, 4, 4, 2), pin = c(480, 480))
        lines(x, plotdata$Sub_metering_2, col = "red")
        lines(x, plotdata$Sub_metering_3, col = "blue")
        temp <- legend("topright", legend = c("", "", ""),
                text.width = strwidth("1,000,000"), col = c("black", "red", "blue"), bty = "n", cex = 0.6,
                lty = c(1,1), xjust = 1, yjust = 1, y.intersp = 0.6)
        ## Read setting of the legend box and write legend text
        text(temp$rect$left + temp$rect$w, temp$text$y,
                c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pos = 2)
        
        ## 3.) plot4: Voltage on screen device
        plot(x, plotdata$Voltage, type = "l", 
             xlab = "datetime", ylab = "Voltage",
             mar = c(5, 4, 4, 2), pin = c(480, 480))
        
        ## 4.) plot5: Global_reactive_power on screen device
        plot(x, plotdata$Global_reactive_power, type = "l", 
             xlab = "datetime", ylab = "Global_reactive_power", 
             mar = c(5, 4, 4, 2), pin = c(480, 480))
        
      
        ## Copy histogram to file device png
        dev.copy(png, file = "plot4.png") 
        dev.off()
        
        ## Set the system back to original german time labels
        Sys.setlocale("LC_TIME",curr_locale)