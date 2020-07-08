# Reading file as table. Setting "?"as NAs.
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

# Loading date and time libraries
library(hms)
library(lubridate)

data$Date <- as.Date(data$Date, "%d/%m/%Y") # formating dates

# Picking observations within defined dates
subsetdata <- subset(data, data$Date >= "2007-02-01" &  data$Date <= "2007-02-02")

subsetdata$Time <- as_hms(subsetdata$Time) # formating time

# Creating file PLOT 2
png(filename = "plot3.png", width = 480, height = 480) # starting PNG device with proper dims

par(bg = "transparent") # background colour


# Creates an empty plot with proper axis
with(subsetdata,plot(ymd_hms(paste(Date,Time)),Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))

# Creates sub metering lines 1, 2, 3 respectively
with(subsetdata,(lines(ymd_hms(paste(Date,Time)),Sub_metering_1, col = "black")))

with(subsetdata,(lines(ymd_hms(paste(Date,Time)),Sub_metering_2, col = "red")))

with(subsetdata,(lines(ymd_hms(paste(Date,Time)),Sub_metering_3, col = "blue")))

# Creates legend
legend("topright",lty = 1,col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()

