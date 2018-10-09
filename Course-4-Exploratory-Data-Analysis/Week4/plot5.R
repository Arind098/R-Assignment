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
NEI_balitimore <- NEI[NEI$fips=="24510",] # Data for Baltimore City
motor_vehicles <- SCC[which(grepl("Vehicles", SCC$EI.Sector)),] # Data relating to emissions from motor vehicle
motor_vehicles_emissions <- subset(NEI_balitimore, SCC %in% motor_vehicles$SCC) # total emissions from motor vehicles

###Plotting the data in relevance to the asked question
##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
png('plot5.png')
motor_vehicles_emissions %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions)) %>%
  ggplot(aes(x = year, y = log(total_emissions))) +
    geom_line() +
    xlab("Year") +
    ylab("Total Emissions (Source = Motor Vehicles)")
dev.off()
## Emissions from motor vehicle emissions has decreased eventually with a slight peak around 2005
