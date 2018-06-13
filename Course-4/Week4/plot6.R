download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
NEI_balitimore_California <- subset(NEI, fips==c("24510", "06037"))
motor_vehicles <- SCC[which(grepl("Vehicles", SCC$EI.Sector)),]

motor_vehicles_emissions <- subset(NEI_balitimore_California, SCC %in% motor_vehicles$SCC)

motor_vehicles_emissions %>% 
  group_by(year, fips) %>% 
  summarize(total_emissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = total_emissions, col = fips)) + 
  geom_line(lwd = 1) +
  scale_color_manual(labels = c("Los Angeles", "Baltimore City"), values = c("red", "blue"))