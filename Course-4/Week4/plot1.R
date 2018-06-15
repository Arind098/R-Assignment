download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


total_emissions <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))
plot(x = levels(as.factor(NEI$year)), y = log(total_emissions), pch = 1, cex = 1.3, xlab = "Year", ylab = "Total Emissions (in Tons)")
lines(x = levels(as.factor(NEI$year)), y = log(total_emissions), lwd = 2)