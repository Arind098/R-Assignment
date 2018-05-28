df <- z <- data.frame()
rankhospital <- function(state, outcome, num = "best") {
  ##Read outcome data
  
  out <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE)
  
  ##Check that state and outcome are valid
  
  if(!state %in% out$State) {
    stop("invalid state")
  }
  
  if(!outcome %in% c("pneumonia", "heart failure", "heart attack")) {
    stop("invalid outcome")
  }
  
  ##Calculate the best Hospital
  colNames <- names(out) <- tolower(names(out))
  outcome <- gsub(" ", ".", outcome)
  x <- paste("^hospital.30.day.death..mortality..rates.from.", outcome, "$", sep = "")
  y <- grep(x, colNames)
  df <- data.frame(cbind("Death.Rate" = out[, y],
                                          "Hospital" = out$hospital.name,
                                          "State" = out$state), stringsAsFactors = FALSE)
  df$Death.Rate <- as.numeric(df$Death.Rate)
  z <<- subset(df, State == state & !is.na(Death.Rate))
  w <- z[order(z$Death.Rate, z$Hospital), ]
  
  if(is.numeric(num)){
    return(w[num, "Hospital"])   
  } else if(num == "best") {
    return(w[1, "Hospital"])
  } else if(num == "worst") {
    return(w[nrow(w), "Hospital"])
  }
}