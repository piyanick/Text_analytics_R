#Import library
library(dplyr)
library(tidytext)
library(tidyr)

#set working directory
setwd("~/Documents/Hult/Dual Degree/Module B/Text analytics/Class 1")


#create a dictionary for custom stop words
cust_stop <- data_frame(
  word = c('https', 't.co', 'rt', 'gt', 'lt', 'i1bqridqnt'), 
  lexicon = rep('custom', each = 6)
) #closing dataframe


# Tokenizing, delete stop words, and count the frequency of USA
usa_df <- read.csv("usa_travel.csv", stringsAsFactors = FALSE)
usa_dtm <- usa_df %>%
  group_by(id) %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  count(word, sort = TRUE) %>%
  cast_dtm(id,word,n)
print(usa_dtm)


# Tokenizing, delete stop words, and count the frequency of Europe
europe_df <- read.csv("eu_travel.csv", stringsAsFactors = FALSE)
europe_dtm <- europe_df %>%
  group_by(id) %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  count(word, sort = TRUE)%>%
  cast_dtm(id,word,n)
print(europe_dtm)


# Tokenizing, delete stop words, and count the frequency of Asia
asia_df <- read.csv("asia_travel.csv", stringsAsFactors = FALSE)
asia_dtm <- asia_df %>%
  group_by(id) %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  count(word, sort = TRUE) %>%
  cast_dtm(id,word,n)
print(asia_dtm)

