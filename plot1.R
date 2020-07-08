# Reading file as table. Setting "?"as NAs.
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

# Loading date and time libraries
library(hms)
library(lubridate)

data$Date <- as.Date(data$Date, "%d/%m/%Y") # formating dates

# Picking observations within defined dates
subsetdata <- subset(data, data$Date >= "2007-02-01" &  data$Date <= "2007-02-02")

subsetdata$Time <- as_hms(subsetdata$Time) # formating time

# Creating file PLOT 1
png(filename = "plot1.png", width = 480, height = 480) # starting PNG device with proper dims

par(bg = "transparent") # background colour

# Creating histogram, with title, axis names and colours
with(subsetdata,hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red"))
dev.off()

