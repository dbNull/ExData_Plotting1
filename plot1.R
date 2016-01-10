# Load Library
library(data.table)

# Load file from disk to data table
dt <- fread("household_power_consumption.txt"
           , na.strings="?"
           , stringsAsFactors = FALSE
           , data.table = TRUE
           )

# Subset for dates 2007-02-01 and 2007-02-02 
dt <- subset(dt, dt$Date %in% c("1/2/2007", "2/2/2007"))

# Set data classes
dt$Global_active_power <- as.numeric(dt$Global_active_power)

# Open Graphics Device 
png("plot1.png", width=480, height= 480)

# Global Active Power histogram
hist(
    dt$Global_active_power
    , main = "Global Active Power"
    , xlab = "Global Active Power (kilowatts)"
    , ylab= "Frequency"
    , col = "red"
)

# Close Graphics Device
dev.off()