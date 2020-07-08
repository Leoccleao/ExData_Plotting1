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
png(filename = "plot4.png", width = 480, height = 480) # starting PNG device with proper dims

par(bg = "transparent",mfrow = c(2,2)) # background colour and a 2x2 graphs PNG file

with(subsetdata,{ # Sets subsetdata as the source data for all graphs
  
  # Creating graph 1,1
    plot(ymd_hms(paste(Date,Time)),Global_active_power,xlab = "", ylab = "Global Active Power", type = "l")

  # Creating graph 1,2
  
    plot(ymd_hms(paste(Date,Time)),Voltage,xlab = "datetime", ylab = "Voltage", type = "l")

    # Creating graph 2,1
    plot(ymd_hms(paste(Date,Time)),Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    lines(ymd_hms(paste(Date,Time)),Sub_metering_1, col = "black")
    lines(ymd_hms(paste(Date,Time)),Sub_metering_2, col = "red")
    lines(ymd_hms(paste(Date,Time)),Sub_metering_3, col = "blue")
    legend("topright",lty = 1,col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    
    # Creating graph 2,2
    plot(ymd_hms(paste(Date,Time)),Global_reactive_power,xlab = "datetime", type = "l")

                }
    )
    
dev.off()
