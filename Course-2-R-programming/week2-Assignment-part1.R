setwd("D:/Downloads/R")
data <- data.frame()
pollutantmean <- function(directory, pollutant, id = 1:332) {
  files <- list.files(path = directory, pattern = "*.csv")
  for(i in id){
    data <- rbind(data, read.csv(paste(directory, files[i], sep = "/")))
  }
  mean(data[[pollutant]], na.rm = TRUE)
}
