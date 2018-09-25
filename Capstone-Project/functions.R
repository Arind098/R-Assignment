## Tokenize and clean the data
library(quanteda)
library(dplyr)
library(stringr)
tokenize <- function(x) {
    y <- x %>% 
            tokens(what = "word", 
                    remove_numbers = TRUE,
                    remove_punct = TRUE,
                    remove_symbols = TRUE,
                    remove_hyphens = TRUE,
                    remove_separators = TRUE,
                    remove_twitter = TRUE, 
                    remove_url = TRUE
                    ) %>%
                        tokens_tolower() %>%
                            #tokens_select(stopwords(), selection = "remove") %>% # Remove stop words
                                #tokens_wordstem(language = "english") %>% # Stem words
                                    tokens_remove(profane.words, padding = TRUE)
    return(y)                                    
}

## split into N-grams
ngrams <- function(x, n) {
    y <- tokens_ngrams(x, n = n, concatenator = " ")
}

## Create a word frequency data table
freq.df <- function(x) {
    y <- x %>%
            dfm(tolower = FALSE)
    y <- data.frame(Content = featnames(y), Frequency = colSums(y), stringsAsFactors = FALSE)
    y <- y[with(y, order(-Frequency)), ]
    row.names(y) <- NULL
    return(y)
}

## Words to be considered
clean.words <- function(x, n=1) {
    terms <- str_split(x, pattern=" ")[[1]]
    terms <- tokenize(terms)
    return(paste(terms, sep=" ", collapse=" "))
}

words.considered <- function(x, n=1) {
    word <- tail(str_split(x, pattern=" ")[[1]], n)
    return(paste(word, sep=" ", collapse=" "))
}
## search input in ngrams tokens
search.ngram <- function(x, n) {
    matched <- grepl(paste0("^",x), total[[n]]$Content)
    matched <- total[[n]][matched, ]
    return(matched)
}

wordcount <- function(x) {
    count <- length(str_split(x, pattern=" ")[[1]])
    return(count)
}
