#import library
library("twitteR")
library("tm")


#Assign consumerKey and consumerSecret in the variables
consumer_key <- 'XtgkqnJzJ7BbpReb04T4niSkp'
consumer_secret <- 'IQnGLgCp6UthYOAW8QyNpsN7WRwIjRVZPq8e8GXnrrudrdCqe7'
access_token <- '1009649886445297664-LHWJDFTw6yqIpNORg7BKXWlXpqVjrm'
access_secret <- 'gTsUsc5zlfOGqo0swuAQloTMFTddDrRVyD1cVvnGWVKmX'


#get tweets from hashtags #USA and #travel
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
usa <- twitteR::searchTwitter('#USA + #travel', n = 300, since = '2019-01-12', retryOnRateLimit = 1e3)
usa = twitteR::twListToDF(usa)
write.csv(usa, file='/Users/piya/Documents/Hult/Dual Degree/Module B/Text analytics/Class 1/usa_travel.csv')


#get tweets from hashtags #Europe and #travel
eu <- twitteR::searchTwitter('#Europe + #travel', n = 300, since = '2019-01-12', retryOnRateLimit = 1e3)
eu = twitteR::twListToDF(eu)
write.csv(eu, file='/Users/piya/Documents/Hult/Dual Degree/Module B/Text analytics/Class 1/eu_travel.csv')


#get tweets from hashtags #Asia and #travel
asia <- twitteR::searchTwitter('#Asia + #travel', n = 300, since = '2019-01-12', retryOnRateLimit = 1e3)
asia = twitteR::twListToDF(asia)
write.csv(asia, file='/Users/piya/Documents/Hult/Dual Degree/Module B/Text analytics/Class 1/asia_travel.csv')

