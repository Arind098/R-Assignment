source("functions.R")

#begin parallel processing
library(doSNOW)
library(readr)

# Load the profane words list
profane.words <- read_lines("profane.txt")

start.time <- Sys.time()

# Create a cluster to work on 10 logical cores.
cl <- makeCluster(5, type = "SOCK")
registerDoSNOW(cl)

files <- c("en_US.news.txt", "en_US.blogs.txt", "en_US.twitter.txt")
label <- c("news", "blogs", "tweets")
ln <- c(1010242, 899288, 2360150)
df.1gram <- df.2gram <- df.3gram <- df.4gram <- df.5gram <- NULL

for(i in 1:3) {
    l <- seq(0, ln[i], by = 50000)
    for (x in l){
        data.tmp <- as.character(read_lines(files[i], skip = x, n_max = 50000))
        corpus.tmp <- tokenize(data.tmp)
        rm(data.tmp)

        # Create 1,2,3,4,5 grams
        tokens.1gram <- ngrams(corpus.tmp, 1)
        df.1gram <- rbind(df.1gram, freq.df(tokens.1gram))
        print(paste("1 gram tokens for ", files[i], ".....", toString(x), " lines finished......"))
        rm(tokens.1gram)
    
        tokens.2gram <- ngrams(corpus.tmp, 2)
        df.2gram <- rbind(df.2gram, freq.df(tokens.2gram))
        print(paste("2 gram tokens for ", files[i], ".....", toString(x), " lines finished......"))
        rm(tokens.2gram)
    
        tokens.3gram <- ngrams(corpus.tmp, 3)
        df.3gram <- rbind(df.3gram, freq.df(tokens.3gram))
        print(paste("3 gram tokens for ", files[i], ".....", toString(x), " lines finished......"))
        rm(tokens.3gram)
    
        tokens.4gram <- ngrams(corpus.tmp, 4)
        df.4gram <- rbind(df.4gram, freq.df(tokens.4gram))
        print(paste("4 gram tokens for ", files[i], ".....", toString(x), " lines finished......"))
        rm(tokens.4gram)
        
        tokens.5gram <- ngrams(corpus.tmp, 5)
        df.5gram <- rbind(df.5gram, freq.df(tokens.5gram))
        print(paste("5 gram tokens for ", [i], ".....", toString(x), " lines finished......"))
        rm(tokens.5gram)
        rm(corpus.tmp)
        gc()
    }
    write.table(df.1gram, paste("df.1gram", label[i], ".RDS", sep = ""),sep="\t",row.names=FALSE)
    rm(df.1gram)
    write.table(df.2gram, paste("df.2gram", label[i], ".RDS", sep = ""),sep="\t",row.names=FALSE)
    rm(df.2gram)
    write.table(df.3gram, paste("df.3gram", label[i], ".RDS", sep = ""),sep="\t",row.names=FALSE)
    rm(df.3gram)
    write.table(df.4gram, paste("df.4gram", label[i], ".RDS", sep = ""),sep="\t",row.names=FALSE)
    rm(df.4gram)
    write.table(df.5gram, paste("df.5gram", label[i], ".RDS", sep = ""),sep="\t",row.names=FALSE)
    rm(df.5gram)

    gc()
}

cmp.df.1gram <- df.1gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Frequency)) %>% filter(Tot.Freq != 1 ) %>% arrange(desc(Tot.Freq))
rm(df.1gram)
cmp.df.2gram <- df.2gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Frequency)) %>% filter(Tot.Freq != 1 ) %>% arrange(desc(Tot.Freq))
rm(df.2gram)
cmp.df.3gram <- df.3gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Frequency)) %>% filter(Tot.Freq != 1 ) %>% arrange(desc(Tot.Freq))
rm(df.3gram)
cmp.df.4gram <- df.4gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Frequency)) %>% filter(Tot.Freq != 1 ) %>% arrange(desc(Tot.Freq))
rm(df.4gram)
cmp.df.5gram <- df.5gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Frequency)) %>% filter(Tot.Freq != 1 ) %>% arrange(desc(Tot.Freq))
rm(df.5gram)


# write.table(cmp.df.1gram,"cmp.df.1gram.txt",sep="\t",row.names=FALSE)
# write.table(cmp.df.2gram,"cmp.df.2gram.txt",sep="\t",row.names=FALSE)
# write.table(cmp.df.3gram,"cmp.df.3gram.txt",sep="\t",row.names=FALSE)
# write.table(cmp.df.4gram,"cmp.df.4gram.txt",sep="\t",row.names=FALSE)

# Processing is done, stop cluster.
stopCluster(cl)

# Total time of execution on workstation was approximately 4 minutes. 
total.time <- Sys.time() - start.time
total.time

library(dplyr)
df.1gram <- df.2gram <- df.3gram <- df.4gram <- df.5gram <- NULL
temp <- list.files(pattern = "df.1gram*")
for(i in 1:3) {
  tmp <- readRDS(temp[i])
  df.1gram <- rbind(df.1gram, tmp)
}

temp <- list.files(pattern = "df.2gram*")
for(i in 1:3) {
  tmp <- readRDS(temp[i])
  df.2gram <- rbind(df.2gram, tmp)
}

temp <- list.files(pattern = "df.3gram*")
for(i in 1:3) {
  tmp <- readRDS(temp[i])
  df.3gram <- rbind(df.3gram, tmp)
}

temp <- list.files(pattern = "df.4gram*")
for(i in 1:3) {
  tmp <- readRDS(temp[i])
  df.4gram <- rbind(df.4gram, tmp)
}

temp <- list.files(pattern = "df.5gram*")
for(i in 1:3) {
  tmp <- readRDS(temp[i])
  df.5gram <- rbind(df.5gram, tmp)
}

df.1gram <- df.1gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Tot.Freq)) %>% filter(Tot.Freq > 2 ) %>% arrange(desc(Tot.Freq))

df.2gram <- df.2gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Tot.Freq)) %>% filter(Tot.Freq > 2 ) %>% arrange(desc(Tot.Freq))

df.3gram <- df.3gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Tot.Freq)) %>% filter(Tot.Freq > 2 ) %>% arrange(desc(Tot.Freq))

df.4gram <- df.4gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Tot.Freq)) %>% filter(Tot.Freq > 2 ) %>% arrange(desc(Tot.Freq))

df.5gram <- df.5gram %>% group_by(Content) %>% summarize(Tot.Freq = sum(Tot.Freq)) %>% filter(Tot.Freq > 2 ) %>% arrange(desc(Tot.Freq))
