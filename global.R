library(dplyr)
library(readxl)
library(shiny)
library(shinydashboard)
library(d3heatmap)

# See https://ttso.shinyapps.io/altm2016top100

# Read in downloaded Altmetric article data and merge affiliation data
top <- read_excel("Top1002016articledata.xlsx")
top <- top[!is.na(top$Position),]

aff <- read_excel("Top1002016affiliationdata.xlsx")
aff <- aff[!is.na(aff$DOI),]

top_aff <- merge(top, aff, by.x = "DOI", by.y = "DOI")
top_aff$grid_country[is.na(top_aff$grid_country)] <- "N/A"

# Sorted list of country names, for selection
countries <- sort(unique(top_aff$grid_country))

top100 <- top %>%
  group_by(Subject) %>%
  summarise(score = round(mean(Score), digits=2),
            news = round(mean(total_posts_msm), digits=2),
            blogs = round(mean(total_posts_blog), digits=2),
            twitter = round(mean(total_posts_tweet), digits=2), 
            f1000 = round(mean(total_posts_f1000), digits=2),
            facebook = round(mean(total_posts_fbwall), digits=2),
            linkedin = round(mean(total_posts_linkedin), digits=2),
            pinterest = round(mean(total_posts_pinterest), digits=2),
            qna = round(mean(total_posts_qna), digits=2),
            peerReview = round(mean(total_posts_peer_review), digits=2),
            weibo = round(mean(total_posts_weibo), digits=2),
            googlePlus = round(mean(total_posts_gplus), digits=2),
            reddit = round(mean(total_posts_rdt), digits=2),
            policy = round(mean(total_posts_policy), digits=2),
            video = round(mean(total_posts_video), digits=2),
            wikipedia = round(mean(total_posts_wikipedia), digits=2))

row.names(top100) <- top100$Subject
top100 <- top100 %>%
  select(-Subject)


# Data for heatmap by country
top100c <- top_aff %>%
  group_by(grid_country) %>%
  summarise(score = round(mean(Score), digits=2),
            news = round(mean(total_posts_msm), digits=2),
            blogs = round(mean(total_posts_blog), digits=2),
            twitter = round(mean(total_posts_tweet), digits=2), 
            f1000 = round(mean(total_posts_f1000), digits=2),
            facebook = round(mean(total_posts_fbwall), digits=2),
            linkedin = round(mean(total_posts_linkedin), digits=2),
            pinterest = round(mean(total_posts_pinterest), digits=2),
            qna = round(mean(total_posts_qna), digits=2),
            peerReview = round(mean(total_posts_peer_review), digits=2),
            weibo = round(mean(total_posts_weibo), digits=2),
            googlePlus = round(mean(total_posts_gplus), digits=2),
            reddit = round(mean(total_posts_rdt), digits=2),
            policy = round(mean(total_posts_policy), digits=2),
            video = round(mean(total_posts_video), digits=2),
            wikipedia = round(mean(total_posts_wikipedia), digits=2))

row.names(top100c) <- top100c$grid_country

top100c <- top100c %>%
  select(-grid_country)


# Data for reactive heatmap by country and category
top100cat <- top_aff %>%
  group_by(grid_country, Subject) %>%
  summarise(score = round(mean(Score), digits=2),
            news = round(mean(total_posts_msm), digits=2),
            blogs = round(mean(total_posts_blog), digits=2),
            twitter = round(mean(total_posts_tweet), digits=2), 
            f1000 = round(mean(total_posts_f1000), digits=2),
            facebook = round(mean(total_posts_fbwall), digits=2),
            linkedin = round(mean(total_posts_linkedin), digits=2),
            pinterest = round(mean(total_posts_pinterest), digits=2),
            qna = round(mean(total_posts_qna), digits=2),
            peerReview = round(mean(total_posts_peer_review), digits=2),
            weibo = round(mean(total_posts_weibo), digits=2),
            googlePlus = round(mean(total_posts_gplus), digits=2),
            reddit = round(mean(total_posts_rdt), digits=2),
            policy = round(mean(total_posts_policy), digits=2),
            video = round(mean(total_posts_video), digits=2),
            wikipedia = round(mean(total_posts_wikipedia), digits=2))

