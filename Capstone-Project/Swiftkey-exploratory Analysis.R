## Loading the required packages
# List of packages
required.packages <- c("ggplot2", "quanteda", "readr", "stringr", "kableExtra")

for (pakg in required.packages) {
  if (pakg %in% installed.packages()){
    require(pakg, character.only = TRUE)
  } else {
    install.packages(pakg)
    require(pakg, character.only = TRUE)
  }
}

# Load Twitter raw data
twitterData <- read_lines("en_US.twitter.txt")


# Load News raw data
newsData <- read_lines("en_US.news.txt")


# Load Blogs raw data
blogData <- read_lines("en_US.blogs.txt")

# Explorint the raw datasets
news.length <- length(newsData)
blogs.length <- length(blogData)
twitter.length <- length(twitterData)

news.char <- sum(nchar(newsData))
blogs.char <- sum(nchar(blogData))
twitter.char <- sum(nchar(twitterData))

news.words <- sum(str_count(newsData, '\\w+'))
blogs.words <- sum(str_count(blogData, '\\w+'))
twitter.words <- sum(str_count(twitterData, '\\w+'))

news.mem <- object.size(newsData)
blogs.mem <- object.size(blogData)
twitter.mem <- object.size(twitterData)

tab <- data.frame(
    "Words" = c(news.words, blogs.words, twitter.words),
    "Charaters" = c(news.char, blogs.char, twitter.char),
    "Lines" = c(news.length, blogs.length, twitter.length),
    "Memory" = c(news.mem, blogs.mem, twitter.mem)
    )

row.names(tab) <- c("News", "Blogs", "Twitter")

# Creating sample data from Twitter, News and blogs

nlines <- 5000

tweets <- sample(twitterData, nlines, replace = FALSE)
news <- sample(newsData, nlines, replace = FALSE)
blogs <- sample(blogData, nlines, replace = FALSE)

# Removing the original datasets from the memory

rm(twitterData, newsData, blogData)
gc()

# Explorint the Sampled data
news.length <- length(news)
blogs.length <- length(blogs)
twitter.length <- length(tweets)

news.char <- sum(nchar(news))
blogs.char <- sum(nchar(blogs))
twitter.char <- sum(nchar(tweets))

news.words <- sum(str_count(news, '\\w+'))
blogs.words <- sum(str_count(blogs, '\\w+'))
twitter.words <- sum(str_count(tweets, '\\w+'))

news.mem <- object.size(news)
blogs.mem <- object.size(blogs)
twitter.mem <- object.size(tweets)

tab <- data.frame(
    "Words" = c(news.words, blogs.words, twitter.words),
    "Charaters" = c(news.char, blogs.char, twitter.char),
    "Lines" = c(news.length, blogs.length, twitter.length),
    "Memory" = c(news.mem, blogs.mem, twitter.mem)
    )

row.names(tab) <- c("News", "Blogs", "Twitter")
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
#sample.tokens <- tokens_select(sample.tokens, stopwords(), selection = "remove")

# Perform stemming on the tokens.
#sample.tokens <- tokens_wordstem(sample.tokens, language = "english")

# Remove profane words
profane.words <- readLines("./profane.txt")
sample.tokens <- tokens_remove(sample.tokens, profane.words, padding = TRUE)


sample.1gram <- tokens_ngrams(sample.tokens, n = 1)
sample.2gram <- tokens_ngrams(sample.tokens, n = 2)
sample.3gram <- tokens_ngrams(sample.tokens, n = 3)

# Create our first bag-of-words model.
tokens.1gram.dfm <- dfm(sample.1gram, tolower = FALSE)
tokens.2gram.dfm <- dfm(sample.2gram, tolower = FALSE)
tokens.3gram.dfm <- dfm(sample.3gram, tolower = FALSE)


# Converting dfm into data frame

dfm_to_df <- function(x) {
    x.df <- data.frame(Content = featnames(x), Frequency = colSums(x), stringsAsFactors = FALSE)
    x.df <- x.df[with(x.df, order(-Frequency)),]
    row.names(x.df) <- NULL
    return(x.df)
}

tokens.1gram.df <- dfm_to_df(tokens.1gram.dfm)
tokens.2gram.df <- dfm_to_df(tokens.2gram.dfm)
tokens.3gram.df <- dfm_to_df(tokens.3gram.dfm)


#######################################################################################

# Exploration of top 20 tokens

par(mar=c(8,4,4,4))
barplot(
    tokens.1gram.df[1:50,]$Frequency, las = 2, names.arg = tokens.1gram.df[1:50,]$Content,
    col ="lightgreen", main ="Most frequent mono-gram words",
    ylab = "Word frequencies"
    )

par(mar=c(8,4,4,4))
barplot(
    tokens.2gram.df[1:50,]$Frequency, las = 2, names.arg = gsub("_", " ", tokens.2gram.df[1:50,]$Content),
    col ="lightgreen", main ="Most frequent Bi-gram words",
    ylab = "Word frequencies"
    )

par(mar=c(8,4,4,4))
barplot(
    tokens.3gram.df[1:50,]$Frequency, las = 2, names.arg = gsub("_", " ", tokens.3gram.df[1:50,]$Content),
    col ="lightgreen", main ="Most frequent Tri-gram words",
    ylab = "Word frequencies"
    )
