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
NEI_balitimore <- NEI[NEI$fips=="24510",] ## Data only for Baltimore City

###Plotting the data in relevance to the asked question
##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
png('plot3.png')
NEI_balitimore %>%
  group_by(type, year) %>%
  summarize(total_emissions = sum(Emissions)) %>%
  ggplot(aes(x = year, y = total_emissions, col = type)) +
    geom_line() +
    xlab("Year") +
    ylab("Total Emissions in Baltimore")
dev.off()
# Of the four types of sources indicated type, we observe that total emissions of Non-Road, Non-point, On-road sources have decrease whereas point source emissions have increased.
