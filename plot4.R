# This script creates a histogram for two days worth of data (02/01/07-02/02/07) from the UC Irvine 
# Learning Repository.  More information on the data set and the assignment can be found in the 
# README.md file on the github site https://github.com/syrinity/ExData_Plotting1.


# Neccessary libraries needed to run the script
library(lubridate)
library(dplyr)

# creates a directory off the current directory to download the data set to and to save the
# plot to if it doesn't already exist.
if(!file.exists("./powerConsumption")){dir.create("./powerConsumption")}

# downloads and unzips the file containing the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./powerConsumption/powerConsumption.zip")
unzip("./powerConsumption/powerConsumption.zip")

# reads the text file into a data frame it explicitly states that NA is represented as a ? so that 
# the values are correctly read in as numeric
powerConsumption <- read.table("./powerConsumption/household_power_consumption.txt", header = TRUE, sep = ";",
                               na.strings="?")

# converts the Date column into a Date data type
powerConsumption$Date <- dmy(powerConsumption$Date)

# subsets the data so that it only has the data for the sepcified 2 days
PowerDataSet <- filter(powerConsumption, Date > "2007-01-31" & Date <= "2007-02-02")

# converts the Time column using luberdate
PowerDataSet$Time <- hms(PowerDataSet$Time)

# combines the Date and Time data into one column as a POSIXct data type
PowerDataSet$datetime <- PowerDataSet$Date + PowerDataSet$Time

# opens up a png file to save the plot to
png("./powerConsumption/plot4.png")

# sets up 4 plots (2 by 2)
par(mfrow = c(2,2))

with(PowerDataSet, {
        # The first of 4 plots 
        plot(datetime, Global_active_power, type="n", 
             ylab="Global Active Power(kilowatts)", xlab="" )
        lines(datetime, Global_active_power)

        # The second of 4 plots         
        plot(datetime, Voltage, type="n")
        lines(datetime, Voltage)

        # The third of 4 plots         
        plot(datetime, Sub_metering_1, type="n", 
             ylab="Energy sub metering", xlab="" )
        lines(datetime, Sub_metering_1)
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lty=c(1,1,1), col = c("black", "red", "blue"),bty = "n")
        
        # The fourth of 4 plots         
        plot(datetime, Global_reactive_power, type="n")
        lines(datetime, Global_reactive_power)
})  

# closes the file
dev.off()

