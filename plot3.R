##Preparing the dataset

#download and unzip the Zip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# Read the file and create the appropriate data frame object

data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
data$Date <- as.Date(strptime(data$Date, format = "%d/%m/%Y"))
data$Time <- with(data, as.POSIXct(paste(Date, Time), tz = "GMT", format = "%F %T"))
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
for(i in 3:ncol(data)) {
  data[[i]] <- as.numeric(data[[i]])
}

# Creating the Plot
plot(x = data$Time, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = data$Time, y = data$Sub_metering_2, col = "red")
lines(x = data$Time, y = data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), cex = 0.8)
dev.copy(png,'plot3.png', width = 480, height = 480)
dev.off()