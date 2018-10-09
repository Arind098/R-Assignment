best <- function(state, outcome) {
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
  suppressWarnings(df <- data.frame(cbind("Death.Rate" = as.numeric(out[, y]),
                          "Hospital" = out$hospital.name,
                          "State" = out$state), stringsAsFactors = FALSE))
  z <- subset(df, State == state)
  w <- z[which.min(z$Death.Rate), ]
  return(w$Hospital)
}
