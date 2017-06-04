## Coursera:    Data Science Specialization:     
## Course:      Exploratory Data Analysis
## Assignment:  Course Project 1 - Peer-graded
## Student:     Monika Hunkeler
## Date:        04.06.2017

## The R script 'plot1.R' reads electric power consumption data from 
## the UC Irvine Machine Learning Repository and plots the 
## household power consumptionen for the first and second february 2007 
## on screen device and file 'plot1.png'.

## set environment workspace, change setting to your PC !!
        setwd("C:/Users/acer17/Desktop/coursera/EDA_Assign_1")

## set libraries
        library(readr)

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

## Plot Histogram Global Active Power (kilowatts) on screen device
        gapHist <- hist(plotdata$Global_active_power)
        plot(gapHist, col = "red", pin = c(480, 480),
             main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Copy histogram to file device png
        dev.copy(png, file = "plot1.png") 
        dev.off()