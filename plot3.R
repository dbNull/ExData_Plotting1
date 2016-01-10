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
dt$subMetering1 <- as.numeric(dt$Sub_metering_1)
dt$subMetering2 <- as.numeric(dt$Sub_metering_2)
dt$subMetering3 <- as.numeric(dt$Sub_metering_3)

# Open Graphics Device 
png("plot3.png", width=480, height= 480)

# Energy sub-metering over time
plot(strptime(dt$DateTime, "%d/%m/%Y %H:%M:%S"), dt$subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(strptime(dt$DateTime, "%d/%m/%Y %H:%M:%S"), dt$subMetering2, type="l", col="red")
lines(strptime(dt$DateTime, "%d/%m/%Y %H:%M:%S"), dt$subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))


# Close Graphics Device
dev.off()
