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

png("./powerConsumption/plot2.png")
with(PowerDataSet, plot(DateTime, Global_active_power, type="n", 
     ylab="Global Active Power(kilowatts)", xlab="" ))
with(PowerDataSet, lines(DateTime, Global_active_power))
dev.off()
