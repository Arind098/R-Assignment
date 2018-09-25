# preparing the corpus

library(readr)
library(stringr)

# Load all the important functions
source("functions.R")

# Load Twitter raw data
twitterData <- read_lines("en_US.twitter.txt")

# Load News raw data
newsData <- read_lines("en_US.news.txt")

# Load Blogs raw data
blogData <- read_lines("en_US.blogs.txt")

# Load the profane words list
profane.words <- read_lines("profane.txt")

# Creating sample data from Twitter, News and blogs
nlines <- 5000

tweets <- sample(twitterData, nlines, replace = FALSE)
news <- sample(newsData, nlines, replace = FALSE)
blogs <- sample(blogData, nlines, replace = FALSE)

# Removing the original datasets from the memory
rm(twitterData, newsData, blogData)
gc()


# combining the sample data sets to make a Corpus
corpus <- as.character(c(tweets, news, blogs))

## Removing unwanted objects to free memory
rm(blogs, tweets, news)
gc()

# tokenize the corpus
clean.corpus <- tokenize(corpus)

# Create 1,2,3,4 grams
tokens.1gram <- ngrams(clean.corpus, 1)
tokens.2gram <- ngrams(clean.corpus, 2)
tokens.3gram <- ngrams(clean.corpus, 3)
tokens.4gram <- ngrams(clean.corpus, 4)
tokens.5gram <- ngrams(clean.corpus, 5)

# Create the word frequency data table
df.1gram <- freq.df(tokens.1gram)
df.2gram <- freq.df(tokens.2gram)
df.3gram <- freq.df(tokens.3gram)
df.4gram <- freq.df(tokens.4gram)
df.5gram <- freq.df(tokens.5gram)

# putting all the N-grams data frames into  a list
ngrams.df <- list(df.1gram, df.2gram, df.3gram, df.4gram, df.5gram)

rm(tokens.1gram, tokens.2gram, tokens.3gram, tokens.4gram, tokens.5gram)
