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

PowerDataSet$DateTime <- PowerDataSet$Date + PowerDataSet$Time

png("./powerConsumption/plot3.png")
with(PowerDataSet, plot(DateTime, Sub_metering_1, type="n", 
                        ylab="Energy sub metering", xlab="" ))
with(PowerDataSet, lines(DateTime, Sub_metering_1))
with(PowerDataSet, lines(DateTime, Sub_metering_2, col="red"))
with(PowerDataSet, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col = c("black", "red", "blue" ))
dev.off()