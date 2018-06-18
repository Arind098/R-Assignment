setwd("D:/Downloads/R")
complete <- function(directory, id) {
  files <- list.files(path = directory, pattern = "*.csv")
  ID <- nobs <- vector()
  for(i in id){
    temp <- read.csv(paste(directory, files[i], sep = "/"))
    ID <- c(ID, i)
    nobs <- c(nobs, sum(!is.na(temp$sulfate) & !is.na(temp$nitrate)))
  }
  return(data.frame(ID, nobs))
}
