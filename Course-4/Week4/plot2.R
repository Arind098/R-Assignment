total_emissions_balitimore <- with(NEI[NEI$fips=="24510",], tapply(Emissions, year, sum, na.rm = TRUE))

plot(x = levels(as.factor(NEI$year)), y = log(total_emissions_balitimore), pch = 1, cex = 1.3, xlab = "Year", ylab = "Total Emissions (in Tons)")
lines(x = levels(as.factor(NEI$year)), y = log(total_emissions_balitimore), lwd = 2)