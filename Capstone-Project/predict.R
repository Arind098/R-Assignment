# create a predictive model for predicting words
source("functions.R")


pred.boff <- function(input, k=2) {
    input <- clean.words(input)
    count <- wordcount(input)
    matched <- data.frame()
    # Case 1: if there is only single input
    # if(wordcount(input) == ){
    #     mathced <- search.ngram(input, wordcount(input)+1)
    # }

    # if(wordcount(input) == 2) {
    #     matched <- search.ngram(input, 3)
    # }
    
    # if(wordcount(input) == 3) {
    #     matched <- search.ngram(input, 4)
    # }

    # if(wordcount(input) == 4) {

    # }
    # # only search if three words input
    # if(wordcount(input) >=4){
    #     matched <- search.ngram(input, 5)
    # }
    
    if (count >= 4) {
        for (n in 3:1) {
            input.considered <- words.considered(input, n)
            matched <- rbind(matched, search.ngram(input.considered, n + 1))
        }
    } 
    
    if (count <=3 & count >0) {
        for (n in count:1) {
            input.considered <- words.considered(input, n)
            matched <- rbind(matched, search.ngram(input.considered, n + 1))
        }
     } 
    #else {
    #     print("Enter something!!!")
    # }
    # Predict "k" words as per the input
    # prediction <- stringi::stri_extract_last_words(matched[1:k, ]$Content)
    prediction <- matched
    return(prediction)

    # if no match, backoff and search from fourgram
    # if(nrow(matched) == 0) {
    #     input <- words(input, 3)
    #     # only search if three words input
    #     if(wordcount(input) >=3){
    #         search.ngram(input, 4)
    #     }
        
    #     # if no match, backoff and search from trigram
    #     if(nrow(r) == 0) {
    #         input <- words(input, 2)
    #         # only search if two words input
    #         if(wordcount(input) >=2){
    #             search.ngram(input, 3)  
    #         }
    #         # if no match, backoff and search from bigram
    #         if(nrow(r) == 0) {
    #             search.ngram(input, 2)
    #             # if no match, backoff and search from unigram
    #             if(nrow(r) == 0) {
    #                 search.ngram(input, 1)
    #             }
    #         } 
            
    #     }
    # } 
    # words <- r[,1]
    # score <- r$score
    # prediction <- data.frame(next.word = words, score=score, stringsAsFactors = F)
    # prediction <- unique(prediction)
    # # choose k results
    # prediction <- prediction[1:k,]   
    # prediction <- stringi::stri_extract_last_words(prediction$next.word)
    # prediction <- prediction[!is.na(prediction)]
}

