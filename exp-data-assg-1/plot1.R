
# The first three lines of this R file load the file and selects the 
# required subsets of dates.

electricity <- read.table("household_power_consumption.txt",sep=";", header=TRUE, colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
electricity$Date <- as.Date(electricity$Date, format = "%d/%m/%Y")
sub_elec <- electricity[electricity$Date ==  "2007-02-01" | electricity$Date == "2007-02-02", ]

# Now, produce the diagram.

png("plot1.png")
hist(sub_elec$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()