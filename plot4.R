library(lubridate)
library(dplyr)

if(!file.exists("./powerConsumption")){dir.create("./powerConsumption")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl,destfile="./powerConsumption/powerConsumption.zip")

unzip("./powerConsumption/powerConsumption.zip")

powerConsumption <- read.table("./powerConsumption/household_power_consumption.txt", header = TRUE, sep = ";",
                               na.strings="?")

powerConsumption$Date <- dmy(powerConsumption$Date)

PowerDataSet <- filter(powerConsumption, Date > "2007-01-31" & Date < "2007-02-02")

PowerDataSet$Time <- hms(PowerDataSet$Time)

PowerDataSet$datetime <- PowerDataSet$Date + PowerDataSet$Time

#png("./powerConsumption/plot4.png")

par(mfrow = c(2,2))
with(PowerDataSet, {
        plot(datetime, Global_active_power, type="n", 
             ylab="Global Active Power(kilowatts)", xlab="" )
        lines(datetime, Global_active_power)
        
        plot(datetime, Voltage, type="n")
        lines(datetime, Voltage)

        plot(datetime, Sub_metering_1, type="n", 
             ylab="Energy sub metering", xlab="" )
        lines(datetime, Sub_metering_1)
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lty=c(1,1,1), col = c("black", "red", "blue"),bty = "n")
        
        plot(datetime, Global_reactive_power, type="n")
        lines(datetime, Global_reactive_power)
})  
        
#dev.off()
