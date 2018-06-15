download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
NEI_balitimore <- NEI[NEI$fips=="24510",]
motor_vehicles <- SCC[which(grepl("Vehicles", SCC$EI.Sector)),]

motor_vehicles_emissions <- subset(NEI_balitimore, SCC %in% motor_vehicles$SCC)

motor_vehicles_emissions %>% 
  group_by(year) %>% 
  summarize(total_emissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = log(total_emissions))) + 
  geom_line()