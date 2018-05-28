rankall <- function(outcome, num = "best") {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip",temp)
  data <- read.csv(unz(temp, "outcome-of-care-measures.csv"))
  unlink(temp)
  
  if(!outcome %in% c("pneumonia", "heart failure", "heart attack")){
    stop("invalid outcome")
  }
  
  ##Calculate the best Hospital
  colNames <- names(data) <- tolower(names(out))
  outcome <- gsub(" ", ".", outcome)
  x <- paste("^hospital.30.day.death..mortality..rates.from.", outcome, "$", sep = "")
  y <- grep(x, colNames)
  df <- data.frame(cbind("Death.Rate" = data[, y],
                         "Hospital" = data$hospital.name,
                         "State" = data$state), stringsAsFactors = FALSE)
  df$Death.Rate <- as.numeric(Death.Rate)
  result <- df %>% 
    group_by(State) %>%
    arrange(Death.Rate)
  
  print(result)   
}