#Import library
library(dplyr)
library(tidytext)
library(tidyr)
library(ggplot2)

#set working directory
setwd("~/Documents/Hult/Dual Degree/Module B/Text analytics/Class 1")


#create a dictionary for custom stop words
cust_stop <- data_frame(
  word = c('https', 't.co', 'rt', 'gt', 'lt', 'i1bqridqnt'), 
  lexicon = rep('custom', each = 6)
) #closing dataframe


# Tokenizing, delete stop words, join the sentiment dictionary, and calculate the score of USA
usa_df <- read.csv("usa_travel.csv", stringsAsFactors = FALSE)
usa_score <- usa_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  inner_join(get_sentiments('afinn')) %>%
  summarise(mean(value))
print(usa_score)


# Tokenizing, delete stop words, join the sentiment dictionary, and calculate the score of Europe
europe_df <- read.csv("eu_travel.csv", stringsAsFactors = FALSE)
europe_score <- europe_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  inner_join(get_sentiments('afinn')) %>%
  summarise(mean(value))
print(europe_score)


# Tokenizing, delete stop words, join the sentiment dictionary, and calculate the score of Asia
asia_df <- read.csv("asia_travel.csv", stringsAsFactors = FALSE)
asia_score <- asia_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  inner_join(get_sentiments('afinn')) %>%
  summarise(mean(value))
print(asia_score)


# Create a dataframe of score and country
total_score <- rbind(usa_score,europe_score,asia_score)
total_score$country <- c('USA','Europe','Asia')
colnames(total_score)[1] <- "mean_value"


#plotting the the score of each countries to compare how good or bad:
freq_hist_usa <-total_score %>%
  ggplot(aes(country, mean_value))+
  geom_col()+
  xlab(NULL)+
  coord_flip()
print(freq_hist_usa)


