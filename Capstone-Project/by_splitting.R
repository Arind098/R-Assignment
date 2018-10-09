files <- c("en_US.twitter.txt", "en_US.news.txt", "en_US.blogs.txt")

files.prt <- file.split("../en_US.blogs.txt", size = 50000, same.dir = FALSE, verbose = TRUE, suf = "part", win = TRUE)
