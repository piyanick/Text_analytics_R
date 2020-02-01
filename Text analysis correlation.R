#Import library
library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(scales)
library(ggplot2)

#set working directory
setwd("~/Documents/Hult/Dual Degree/Module B/Text analytics/Class 1")


#create a dictionary for custom stop words
cust_stop <- data_frame(
  word = c('https', 't.co', 'rt', 'gt', 'lt', 'i1bqridqnt'), 
  lexicon = rep('custom', each = 6)
) #closing dataframe


# Tokenizing, delete stop words, and count the frequency of USA
usa_df <- read.csv("usa_travel.csv", stringsAsFactors = FALSE)
usa_struc <- usa_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  count(word, sort = TRUE)
print(usa_struc)


# Tokenizing, delete stop words, and count the frequency of Europe
europe_df <- read.csv("eu_travel.csv", stringsAsFactors = FALSE)
europe_struc <- europe_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  count(word, sort = TRUE)
print(europe_struc)


# Tokenizing, delete stop words, and count the frequency of Asia
asia_df <- read.csv("asia_travel.csv", stringsAsFactors = FALSE)
asia_struc <- asia_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  anti_join(cust_stop) %>%
  count(word, sort = TRUE)
print(asia_struc)


#plotting the token frequencies of USA:
freq_hist_usa <-usa_struc %>%
  filter(n > 150) %>% # we need this to eliminate all the low count words
  mutate(word = reorder(word,n )) %>%
  ggplot(aes(word, n))+
  geom_col()+
  xlab(NULL)+
  coord_flip()
print(freq_hist_usa)


#plotting the token frequencies of Europe:
freq_hist_europe <-europe_struc %>%
  filter(n > 30) %>% # we need this to eliminate all the low count words
  mutate(word = reorder(word,n )) %>%
  ggplot(aes(word, n))+
  geom_col()+
  xlab(NULL)+
  coord_flip()
print(freq_hist_europe)


#plotting the token frequencies of Asia:
freq_hist_asia <-asia_struc %>%
  filter(n > 20) %>% # we need this to eliminate all the low count words
  mutate(word = reorder(word,n )) %>%
  ggplot(aes(word, n))+
  geom_col()+
  xlab(NULL)+
  coord_flip()
print(freq_hist_asia)



# Combine USA, Europe, and Asia together by using USA as a benchmark and create a country variable for Europe and Asia
frequency <- bind_rows(mutate(usa_struc, country="USA"),
                       mutate(europe_struc, country= "Europe"),
                       mutate(asia_struc, country="Asia")
                        )%>%#closing bind_rows
              mutate(word=str_extract(word, "[a-z']+")) %>%
              count(country, word) %>%
              group_by(country) %>%
              mutate(proportion = n/sum(n))%>%
              select(-n) %>%
              spread(country, proportion) %>%
              gather(country, proportion, `Europe`, `Asia`)


# Plot the see the proportion of words in Asia and Europe comparing to USA
ggplot(frequency, aes(x=proportion, y=`USA`, 
                      color = abs(`USA`- proportion)))+
              geom_abline(color="grey40", lty=2)+
              geom_jitter(alpha=.1, size=2.5, width=0.3, height=0.3)+
              geom_text(aes(label=word), check_overlap = TRUE, vjust=1.5) +
              scale_x_log10(labels = percent_format())+
              scale_y_log10(labels= percent_format())+
              scale_color_gradient(limits = c(0,0.001), low = "darkslategray4", high = "gray75")+
              facet_wrap(~country, ncol=2)+
              theme(legend.position = "none")+
              labs(y= "USA", x=NULL)


# See the correlation of words using between USA and Europe
cor.test(data=frequency[frequency$country == "Europe",],
         ~proportion + `USA`)

# See the correlation of words using between USA and Asia
cor.test(data=frequency[frequency$country == "Asia",],
         ~proportion + `USA`)