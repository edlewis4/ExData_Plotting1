## plot4.R
## edward.lewis -Exploratory Data Analysis
## Dataset: Electric power consumption [20Mb]

## Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

## The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

## Date: Date in format dd/mm/yyyy
## Time: time in format hh:mm:ss
## Global_active_power: household global minute-averaged active power (in kilowatt)
## Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## Voltage: minute-averaged voltage (in volt)
## Global_intensity: household global minute-averaged current intensity (in ampere)
## Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
## Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Read in data
infile <- "household_power_consumption.txt"
col.types <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
df <- read.table(infile, header = TRUE, sep = ";", quote = "\"'", dec = ".", na.strings = "?", colClasses = col.types)

## Convert Date to date format
df$Date <- as.Date(df[,1], format = "%d/%m/%Y")
newDateTime <-paste(df$Date, df$Time)
posixDateTime <- strptime(newDateTime, "%Y-%m-%d %H:%M:%S")
df <- cbind(df, posixDateTime)


## Subset for just 2 days in Febrary 2007-02-01 and 2007-02-02
newdf <- subset(df, Date == "2007-02-01" | Date == "2007-02-02")

## Plot 2x2 charts 
png("plot4.png")
par(mfrow = c(2,2))

## chart1 
plot(newdf$posixDateTime,newdf$Global_active_power, type="l", xlab ="", ylab = "Global Active Power (kilowatts)")

## chart2
with(newdf, plot(posixDateTime, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

## chart3
with(newdf, plot(posixDateTime, Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering"))
with(newdf, lines(posixDateTime,Sub_metering_1, col="black"))
with(newdf, lines(posixDateTime,Sub_metering_2, col="red"))
with(newdf, lines(posixDateTime,Sub_metering_3, col="blue"))
legend("topright", lty = c(1,1,1), cex = 0.7, bty="n", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## chart4
with(newdf, plot(posixDateTime, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()      ## Close png device



