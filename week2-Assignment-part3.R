setwd("D:/Downloads/R")
complete <- function(directory = "specdata", id = 1:332) {
  files <- list.files(path = directory, pattern = "*.csv")
  ID <- nobs <- vector()
  for(i in id){
    temp <- read.csv(paste(directory, files[i], sep = "/"))
    ID <- c(ID, i)
    nobs <- c(nobs, sum(!is.na(temp$sulfate) & !is.na(temp$nitrate)))
  }
  return(data.frame(ID, nobs))
}

corr <- function(directory, threshold = 0) {
  files <- list.files(path = directory, pattern = "*.csv")
  x <- complete()
  y <- vector()
  for(i in 1:nrow(x)) {
    if(x$nobs[i] > threshold) {
      temp <- read.csv(paste(directory, files[i], sep = "/"))
      dat <- temp[which(!is.na(temp$sulfate) & !is.na(temp$nitrate)),]
      y <- c(y, cor(dat$sulfate, dat$nitrate))
      }
    }
  return(y)
}