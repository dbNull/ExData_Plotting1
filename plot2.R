# Load Library
library(data.table)

# Load file from disk to data table
dt <- fread("household_power_consumption.txt"
            , na.strings="?"
            , stringsAsFactors = FALSE
            , data.table = TRUE
            , sep=";"
            , dec="."
)

# Subset for dates 2007-02-01 and 2007-02-02 
dt <- subset(dt, dt$Date %in% c("1/2/2007", "2/2/2007"))

# Add new DateTime Column
dt[, DateTime := paste(dt$Date, dt$Time, ssep = " ")]

# Set data classes
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt$Global_active_power <- as.numeric(dt$Global_active_power)

# Open Graphics Device 
png("plot2.png", width=480, height= 480)

# Global active power over time
plot(x = strptime(dt$DateTime, "%d/%m/%Y %H:%M:%S")
   , y = dt$Global_active_power
   , xlab=""
   , ylab= "Global Active Power (kilowatts)"
   , type= "l"
   , lwd=1
)

# Close Graphics Device
dev.off()
