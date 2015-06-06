# Exploratory Data Analysis - Course Project 1

# Download dataset from course website
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "powerdata.zip", mode = 'wb')
con <- unz("powerdata.zip", fileName)
fileName <- unzip("powerdata.zip")
close(con)

# Source dataset is huge so:
#       1. only read data for
#               Date = 01/02/2007 and 02/02/2007
## COULD NOT FIGURE THIS OUT
#       2. Convert Date and Time using strptime() and as.Date()
## COULD NOT FIGURE THIS OUT AND NOT SURE strptime() NEEDED
#       3. na.strings = "?"
library(data.table)
DT <- fread(fileName, na.strings = "?")
DTuse <- DT[Date == "1/2/2007" | Date == "2/2/2007"]
rm(DT)
# Convert column to numeric from character
DTuse$Global_active_power <- as.numeric(DTuse$Global_active_power)

# Examine how household energy usage varies over a 2-day period in Feb 2007.
# Use the Base Plotting System to construct 4 plots:
#       1. Constuct plot and save in PNG file (480 x 480 pixels)
#       2. Name each plot file: plot1.png...
#       3. Construct R code file (plot1.R, ...) that constucts the plot.
#               - include code for reading the data
#               - include code that creates the PNG file

# PLOT 1:       histogram
#               Global Active Power (kilowatts) vs Frequency
#               red bars (col = 2)
#               title = Global Active Power
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(DTuse$Global_active_power, xlab = "Global Active Power (kilowatts)",
     col = 2, main = "Global Active Power")
dev.off()
