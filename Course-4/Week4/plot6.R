# Check to see if packages are installed. Install them if they are not, then load them into the R session.
check.packages <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}

packages<-c("ggplot2", "png", "dplyr")
check.packages(packages)

### Downloadding the required data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

### Reading the data sets to R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Preparing the data
NEI_balitimore_California <- subset(NEI, fips==c("24510", "06037")) # Data from both Baltimore City and Los Angeles County, California
motor_vehicles <- SCC[which(grepl("Vehicles", SCC$EI.Sector)),] ## Data relating to emissions from motor vehicle
motor_vehicles_emissions <- subset(NEI_balitimore_California, SCC %in% motor_vehicles$SCC) ## total emissions from motor vehicles

###Plotting the data in relevance to the asked question
##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California. Which city has seen greater changes over time in motor vehicle emissions?
png('plot6.png')
motor_vehicles_emissions %>%
  group_by(year, fips) %>%
  summarize(total_emissions = sum(Emissions)) %>%
  ggplot(aes(x = year, y = log(total_emissions), col = fips)) +
    geom_line(lwd = 1) +
    xlab("Year") +
    ylab("Total Emissions (Source = Motor Vehicles)") +
    scale_color_manual(labels = c("Los Angeles", "Baltimore City"), values = c("red", "blue"))
dev.off()
## Emissions from motor vehicle has increased slightly in Los Angeles County, whereas emissions have decreased in Baltimore City during the period 1999-2008
