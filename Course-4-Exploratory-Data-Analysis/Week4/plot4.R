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
coal <- SCC[which(grepl("Coal", SCC$EI.Sector)),] # Data of emissions from coal combustion-related sources
coal_emissions <- subset(NEI, SCC %in% coal$SCC) # total emissions from coal combustions

###Plotting the data in relevance to the asked question
##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
png('plot4.png')
coal_emissions %>%
  group_by(year) %>%
  summarize(total_emissions = sum(Emissions)) %>%
  ggplot(aes(x = year, y = total_emissions)) +
    geom_line()
dev.off()
## Emissions from 1999-2008 has decreased
