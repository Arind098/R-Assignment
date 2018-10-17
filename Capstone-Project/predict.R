source("functions.R")

# create a predictive model for predicting words
library(readr)
profane.words <- read_lines("profane.txt")

df.1gram <- readRDS("data/data1.rds")

df.2gram <- readRDS("data/data2.rds")

df.3gram <- readRDS("data/data3.rds")

df.4gram <- readRDS("data/data4.rds")

# df.5gram <- readRDS("./df.5gram.rds")

ngrams.df <- list(df.1gram, df.2gram, df.3gram, df.4gram)
rm(df.1gram, df.2gram, df.3gram, df.4gram)


pred.boff <- function(input, k=2) {
    input <- clean.words(input)
    count <- wordcount(input)
    matched <- data.frame()
    
    if (count==0){
        prediction <- "Enter something"
    }
    
    if (count >= 4) {
        for (n in 3:1) {
            input.considered <- words.considered(input, n)
            matched <- rbind(matched, search.ngram(input.considered, n + 1))
            if(nrow(matched) == k) break
        }
        prediction <- stringi::stri_extract_last_words(matched[1:k, ]$Content)
    }
    if (count <=3 & count >0) {
        for (n in count:1) {
            input.considered <- words.considered(input, n)
            matched <- rbind(matched, search.ngram(input.considered, n + 1))
            if(nrow(matched) == k) break
        }
        prediction <- stringi::stri_extract_last_words(matched[1:k, ]$Content)
     }
    # Predict "k" words as per the input
    # prediction <- matched
    return(prediction)
}

