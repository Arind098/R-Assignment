## Loading the required packages
# List of packages
required.packages <- c("ggplot2", "quanteda", "readr", "stringr")

for (pakg in required.packages) {
  if (pakg %in% installed.packages()){
    require(pakg, character.only = TRUE)
  } else {
    install.packages(pakg)
    require(pakg, character.only = TRUE)
  }
}

#Creating connection to Twitter data from Swift Key Corp.
twitterData <- read_lines("en_US.twitter.txt")


#Creating connection to News data from Swift Key Corp.
newsData <- read_lines("en_US.news.txt")


#Creating connection to blog data from Swift Key Corp.
blogData <- read_lines("en_US.blogs.txt")

# Creating sample data from Twitter, News and blogs

nlines <- 5000

tweets <- sample(twitterData, nlines, replace = FALSE)
news <- sample(newsData, nlines, replace = FALSE)
blogs <- sample(blogData, nlines, replace = FALSE)

# Removing the original datasets from the memory

rm(twitterData, newsData, blogData)
gc()

# combining the sample data sets to make a Corpus
combined.corpus <- as.character(c(tweets, news, blogs))

# Save the corpus
write_lines(combined.corpus, "./corpus.txt")
rm(blogs, tweets, news)
gc()

#################################################################################

## Loading the corpus into the R seession
sample.corpus <- read_lines("./corpus.txt")

## Creating clean tokens
# Tokenize tweets messages.
sample.tokens <- tokens(sample.corpus, what = "word", 
                       remove_numbers = TRUE,
                       remove_punct = TRUE,
                       remove_symbols = TRUE,
                       remove_hyphens = TRUE,
                       remove_separators = TRUE,
                       remove_twitter = TRUE, 
                       remove_url = TRUE)
                       
# Lower case the tokens.
sample.tokens <- tokens_tolower(sample.tokens)

# Remove stopwords
#sample.tokens <- tokens_select(sample.tokens, stopwords(), 
                              selection = "remove")

# Perform stemming on the tokens.
#sample.tokens <- tokens_wordstem(sample.tokens, language = "english")

# Remove profane words
profane.words <- readLines("profane.list.txt")
sample.tokens <- tokens_remove(sample.tokens, profane.words, padding = TRUE)


sample.1gram <- tokens_ngrams(sample.tokens, n = 1)
sample.2gram <- tokens_ngrams(sample.tokens, n = 2)
sample.3gram <- tokens_ngrams(sample.tokens, n = 3)

# Create our first bag-of-words model.
tokens.1gram.dfm <- dfm(sample.1gram, tolower = FALSE)
tokens.2gram.dfm <- dfm(sample.2gram, tolower = FALSE)
tokens.3gram.dfm <- dfm(sample.3gram, tolower = FALSE)


# Converting into data frame

dfm_to_df <- function(x) {
     x.df <- data.frame(Content = featnames(x), Frequency = colSums(x), 
                 row.names = NULL, stringsAsFactors = FALSE)
     x.df <- x.df[with(x.df, order(-Frequency)),]
     return(x.df)
}

tokens.1gram.df <- dfm_to_df(tokens.1gram.dfm)
tokens.2gram.df <- dfm_to_df(tokens.2gram.dfm)
tokens.3gram.df <- dfm_to_df(tokens.3gram.dfm)


#######################################################################################

# Exploration of top 20 tokens

ggplot(tokens.1gram.df[1:20,], aes(x = Content, y = Frequency)) +
  theme_bw() +
  geom_histogram(binwidth = 5)
  
par(mar=c(8,4,4,4))
barplot(tokens.1gram.df[1:20,]$Frequency, las = 2, names.arg = tokens.1gram.df[1:20,]$Content,
        col ="lightblue", main ="Most frequent mono-gram words",
        ylab = "Word frequencies")