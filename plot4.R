# The first three lines of this R file load the file and selects the 
# required subsets of dates.

electricity <- read.table("household_power_consumption.txt",sep=";", header=TRUE, colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
electricity$Date <- as.Date(electricity$Date, format = "%d/%m/%Y")
sub_elec <- electricity[electricity$Date ==  "2007-02-01" | electricity$Date == "2007-02-02", ]
sub_elec$datetime <- strptime(paste(sub_elec$Date,sub_elec$Time), format = "%Y-%m-%d %H:%M:%S")

# Setup four panels in the plot.

par(mfcol = c(2,2))

# Top left panel.

plot(sub_elec$datetime, sub_elec$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Bottom left panel.

plot(sub_elec$datetime, sub_elec$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(sub_elec$datetime, sub_elec$Sub_metering_1, col = "black")
lines(sub_elec$datetime, sub_elec$Sub_metering_2, col = "red")
lines(sub_elec$datetime, sub_elec$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty = "n")

# Top right panel

with(sub_elec, plot(datetime, Voltage, type = "l"))

# Bottom right panel

with(sub_elec, plot(datetime, Global_reactive_power, type = "l"))