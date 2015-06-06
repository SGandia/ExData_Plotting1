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
#       3. na.strings = "?"
library(data.table)
DT <- fread(fileName, na.strings = "?")
DTuse <- DT[Date == "1/2/2007" | Date == "2/2/2007"]
rm(DT)
# Combine and convert Date and Time columns
datetime <- paste(DTuse$Date, DTuse$Time, sep = " ")
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
# Convert columns to numeric from character
DTuse$Global_active_power <- as.numeric(DTuse$Global_active_power)

# Examine how household energy usage varies over a 2-day period in Feb 2007.
# Use the Base Plotting System to construct 4 plots:
#       1. Constuct plot and save in PNG file (480 x 480 pixels)
#       2. Name each plot file: plot1.png...
#       3. Construct R code file (plot1.R, ...) that constucts the plot.
#               - include code for reading the data
#               - include code that creates the PNG file

# PLOT 2:       line graph ??
#               Day of week vs Global Active Power (kilowatts)
png(file = "plot2.png", width = 480, height = 480, units = "px")
par(mar = c(4, 5, 2, 2))
plot(datetime, DTuse$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
