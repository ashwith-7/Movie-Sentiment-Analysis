library(dplyr)
library(ggplot2)
library(tm)
library(caret)
library(e1071)

imdb_data <- read.csv("~/Desktop/uni/DataMining/ca4/dataset/IMDB Dataset.csv", stringsAsFactors = FALSE)

str(imdb_data)
head(imdb_data)
colnames(imdb_data) <- c("Review", "Sentiment")
summary(imdb_data)
table(imdb_data$Sentiment)

ggplot(imdb_data, aes(x = Sentiment)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Sentiment Distribution", x = "Sentiment", y = "Count")

colSums(is.na(imdb_data))
imdb_data <- na.omit(imdb_data)

corpus <- Corpus(VectorSource(imdb_data$Review))
corpus <- corpus %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removePunctuation) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(stripWhitespace)

dtm <- DocumentTermMatrix(corpus)
dtm <- removeSparseTerms(dtm, 0.99)
dtm_data <- as.data.frame(as.matrix(dtm))
dtm_data$Sentiment <- imdb_data$Sentiment

review_length <- nchar(imdb_data$Review)
ggplot(data.frame(review_length), aes(x = review_length)) +
  geom_histogram(fill = "lightblue", bins = 30) +
  labs(title = "Distribution of Review Lengths", x = "Length of Reviews", y = "Frequency")

set.seed(123)
trainIndex <- createDataPartition(dtm_data$Sentiment, p = 0.8, list = FALSE)
trainSet <- dtm_data[trainIndex, ]
testSet <- dtm_data[-trainIndex, ]

trainSet$Sentiment <- factor(trainSet$Sentiment)
testSet$Sentiment <- factor(testSet$Sentiment)

model <- naiveBayes(Sentiment ~ ., data = trainSet)

predictions <- predict(model, testSet)
predictions <- factor(predictions, levels = levels(testSet$Sentiment))

cm <- confusionMatrix(predictions, testSet$Sentiment)
print(cm)

cm_table <- as.data.frame(cm$table)
ggplot(cm_table, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "lightblue", high = "steelblue") +
  labs(title = "Confusion Matrix Visualization", x = "Actual", y = "Predicted") +
  geom_text(aes(label = Freq), color = "black", size = 4)

new_reviews <- c("The movie was fantastic! I loved it.", 
                 "The plot was boring and predictable.", 
                 "Great acting, but the story lacked depth.")

new_corpus <- Corpus(VectorSource(new_reviews))
new_corpus <- new_corpus %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removePunctuation) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(stripWhitespace)

new_dtm <- DocumentTermMatrix(new_corpus, control = list(dictionary = Terms(dtm)))
new_dtm_data <- as.data.frame(as.matrix(new_dtm))

new_predictions <- predict(model, new_dtm_data)
new_results <- data.frame(Review = new_reviews, Predicted_Sentiment = new_predictions)

print(new_results)
