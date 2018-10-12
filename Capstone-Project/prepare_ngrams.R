df.1gram <- read.table("df.1gram.txt", header = TRUE, stringsAsFactors = FALSE)
row.names(df.1gram) <- NULL
df.2gram <- read.table("df.2gram.txt", header = TRUE, stringsAsFactors = FALSE)
row.names(df.2gram) <- NULL
df.3gram <- read.table("df.3gram.txt", header = TRUE, stringsAsFactors = FALSE)
row.names(df.3gram) <- NULL
df.4gram <- read.table("df.4gram.txt", header = TRUE, stringsAsFactors = FALSE)
row.names(df.4gram) <- NULL
df.5gram <- read.table("df.5gram.txt", header = TRUE, stringsAsFactors = FALSE)
row.names(df.5gram) <- NULL
ngrams.df <- list(df.1gram, df.2gram, df.3gram, df.4gram, df.5gram)
