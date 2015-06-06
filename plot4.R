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
# Combine and convert Date and Time columns
datetime <- paste(DTuse$Date, DTuse$Time, sep = " ")
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
# Convert columns to numeric from character
DTuse$Global_active_power <- as.numeric(DTuse$Global_active_power)
DTuse$Global_reactive_power <- as.numeric(DTuse$Global_reactive_power)
DTuse$Voltage <- as.numeric(DTuse$Voltage)
DTuse$Global_intensity <- as.numeric(DTuse$Global_intensity)
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

# PLOT 4:       4 line graphs (2, 2)
#                       1. upper left: Plot 2
#                       2. lower left: Plot 3
#                       3. upper right: 
#                               Day of Week vs Voltage
#                               x-axis label = datetime
#                       4. lower right:
#                               Days of week vs Global_reactive_power
#                               x-axix label = datetime
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1))
with(DTuse, {
        # Upper Left = PLOT 2:       
        plot(datetime, DTuse$Global_active_power, type = "l", xlab = "", 
             ylab = "Global Active Power (kilowatts)")
        # Lower Left = PLOT 3:       
        plot(datetime, DTuse$Sub_metering_1, type = "l", xlab = "",
             ylab = "Energy sub metering")
        lines(datetime, DTuse$Sub_metering_2, type = "l", col = "red")
        lines(datetime, DTuse$Sub_metering_3, type = "l", col = "blue")
        leg.text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend("topright", leg.text, lty = 1, col = c("black", "red", "blue"), 
               cex = 0.75, bty = "n")
        # Upper Right:
        plot(datetime, DTuse$Voltage, type = "l", ylab = "Voltage")
        # Lower Right:
        plot(datetime, DTuse$Global_reactive_power, type = "l",
             ylab = "Global_reactive_power")
})
dev.off()
