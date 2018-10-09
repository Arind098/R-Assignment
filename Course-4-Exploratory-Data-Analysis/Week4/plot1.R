### installing and loading required packages
if(!require(png)) install.packages("png")
library(png)

### Downloadding the required data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

### Reading the data sets to R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Preparing the data
total_emissions <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE)) ## total_emissions is the total PM2.5 emission from all sources grouped by year (1999, 2002, 2005, and 2008)

###Plotting the data in relevance to the asked question
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
png('plot1.png')
plot(x = levels(as.factor(NEI$year)), y = log(total_emissions), pch = 1, cex = 1.3, xlab = "Year", ylab = "Total Emissions (in Tons)")
lines(x = levels(as.factor(NEI$year)), y = log(total_emissions), lwd = 2)
dev.off()
## From the plot it is evident that total emissions from PM2.5 has decreased in United States from 1999-2008 
