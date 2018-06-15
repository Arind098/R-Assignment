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
total_emissions_balitimore <- with(NEI[NEI$fips=="24510",], tapply(Emissions, year, sum, na.rm = TRUE)) #total_emissions_balitimore represents total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008

###Plotting the data in relevance to the asked question
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008?
png('plot2.png')
plot(x = levels(as.factor(NEI$year)), y = log(total_emissions_balitimore), pch = 1, cex = 1.3, xlab = "Year", ylab = "Total Emissions (in Tons)")
lines(x = levels(as.factor(NEI$year)), y = log(total_emissions_balitimore), lwd = 2)
dev.off()
## Total Emissions from PM2.5 has decrease in Baltimore City, Maryland
