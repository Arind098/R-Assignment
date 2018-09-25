# library(sqldf)

# # Load Twitter raw data
twitterData <- file("en_US.twitter.txt")
newsData <- file("en_US.news.txt")
blogData <- file("en_US.blogs.txt")
profane.words <- file("profane.txt")

# tweets <- sqldf("select * from twitterData", dbname = tempfile(), file.format = list(header = T, row.names = F))
# news <- sqldf("select * from newsData", dbname = tempfile(), file.format = list(header = T, row.names = F))
# blogs <- sqldf("select * from blogData", dbname = tempfile(), file.format = list(header = T, row.names = F))

# corpus <- as.character(c(tweets, news, blogs))

# rm(tweets, news, blogs)
# gc()

file.split(twitterData, size = 50000, same.dir = FALSE, verbose = TRUE, suf = "part", win = TRUE)
