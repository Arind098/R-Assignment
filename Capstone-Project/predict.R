source("functions.R")

# create a predictive model for predicting words
library(readr)
profane.words <- read_lines("profane.txt")

pred.boff <- function(input, k=2) {
    input <- clean.words(input)
    count <- wordcount(input)
    matched <- data.frame()
    
    if (count >= 4) {
        for (n in 4:1) {
            input.considered <- words.considered(input, n)
            matched <- rbind(matched, search.ngram(input.considered, n + 1))
            break
        }
    } 
    
    if (count <=3 & count >0) {
        for (n in count:1) {
            input.considered <- words.considered(input, n)
            matched <- rbind(matched, search.ngram(input.considered, n + 1))
            break
        }
     } 
    #else {
    #     print("Enter something!!!")
    # }
    # Predict "k" words as per the input
    prediction <- stringi::stri_extract_last_words(matched[1:k, ]$Content)
    # prediction <- matched
    return(prediction)
}

