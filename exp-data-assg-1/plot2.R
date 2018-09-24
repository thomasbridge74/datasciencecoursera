# The first three lines of this R file load the file and selects the 
# required subsets of dates.

electricity <- read.table("household_power_consumption.txt",sep=";", header=TRUE, colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
electricity$Date <- as.Date(electricity$Date, format = "%d/%m/%Y")
sub_elec <- electricity[electricity$Date ==  "2007-02-01" | electricity$Date == "2007-02-02", ]
sub_elec$datetime <- strptime(paste(sub_elec$Date,sub_elec$Time), format = "%Y-%m-%d %H:%M:%S")

# Now, produce the diagram.

png("plot2.png")
plot(sub_elec$datetime, sub_elec$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()