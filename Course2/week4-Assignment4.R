rankall <- function(outcome, num = "best") {
  data <- read.csv("outcome-of-care-measures.csv")
  
  if(!outcome %in% c("pneumonia", "heart failure", "heart attack")){
    stop("invalid outcome")
  }
  
  ##Calculate the best Hospital
  colNames <- names(data) <- tolower(names(data))
  outcome <- gsub(" ", ".", outcome)
  x <- paste("^hospital.30.day.death..mortality..rates.from.", outcome, "$", sep = "")
  y <- grep(x, colNames)
  df <- data.frame("Death.Rate" = data[, y],
                   "Hospital" = data$hospital.name,
                   "State" = data$state, stringsAsFactors = FALSE)
  df$Death.Rate <- as.numeric(df$Death.Rate)
  
  outcome_df <- df[order(df$State, df$Death.Rate, df$Hospital), ]
  result <- data.frame()
  for(i in levels(outcome_df$State)) {
    t1 <- subset(outcome_df, State == i)
    result <- rbind(result, data.frame("Hospital" = t1$Hospital[num],
                                 "State" = i))
  }
  return(result)
}
