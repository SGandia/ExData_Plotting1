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
DTuse$Sub_metering_1 <- as.numeric(DTuse$Sub_metering_1)
DTuse$Sub_metering_2 <- as.numeric(DTuse$Sub_metering_2)
DTuse$Sub_metering_3 <- as.numeric(DTuse$Sub_metering_3)

# Examine how household energy usage varies over a 2-day period in Feb 2007.
# Use the Base Plotting System to construct 4 plots:
#       1. Constuct plot and save in PNG file (480 x 480 pixels)
#       2. Name each plot file: plot1.png...
#       3. Construct R code file (plot1.R, ...) that constucts the plot.
#               - include code for reading the data
#               - include code that creates the PNG file

# PLOT 3:       line graph
#               Day of week vs Energy sub metering
#               legend - topright
#                       Sub_metering_1 = black line
#                       Sub_metering_2 = red line
#                       Sub_metering_3 = blue line
png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(datetime, DTuse$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(datetime, DTuse$Sub_metering_2, type = "l", col = "red")
lines(datetime, DTuse$Sub_metering_3, type = "l", col = "blue")
leg.text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", leg.text, lty = 1, col = c("black", "red", "blue"), 
       cex = 0.75)
dev.off()
