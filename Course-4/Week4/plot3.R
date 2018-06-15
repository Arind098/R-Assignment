download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
NEI_balitimore <- NEI[NEI$fips=="24510",]

NEI_balitimore %>% 
  group_by(type, year) %>% 
  summarize(total_emissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = total_emissions, col = type)) + 
    geom_line() +
    xlab("Year") +
    ylab("Total Emissions in Baltimore")
