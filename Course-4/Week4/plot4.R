download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")
unzip("NEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal <- SCC[which(grepl("coal", SCC$EI.Sector)),]
coal_emissions <- subset(NEI, SCC %in% coal$SCC)

coal_emissions %>% group_by(year) %>% summarize(total_emissions = sum(Emissions)) %>% ggplot(aes(x = year, y = total_emissions)) + geom_line()