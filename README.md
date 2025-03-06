# IMDB Sentiment Analysis

## Overview
This project performs sentiment analysis on the IMDB movie review dataset using Natural Language Processing (NLP) techniques and the Naive Bayes classification algorithm. The dataset contains movie reviews labeled as either "positive" or "negative." The goal is to train a model to classify sentiment based on the text of the reviews.

## Dataset
The dataset used in this project is the **IMDB Dataset (https://ai.stanford.edu/~amaas/data/sentiment), which contains:
- `Review`: The text of the movie review.
- `Sentiment`: The sentiment label (either "positive" or "negative").

## Features
- Data Preprocessing:
  - Text cleaning (lowercasing, punctuation removal, stopword removal, whitespace stripping).
  - Document-Term Matrix (DTM) conversion.
- Model Training:
  - Naive Bayes classifier.
- Model Evaluation:
  - Confusion matrix visualization.
  - Accuracy, precision, recall, and F1-score.
- Sentiment Prediction on New Reviews.

## Dependencies
Make sure you have the following R packages installed:
```r
install.packages(c("dplyr", "ggplot2", "tm", "caret", "e1071"))
```

## How to Run
1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/imdb-sentiment-analysis.git
   cd imdb-sentiment-analysis
   ```
2. Open R or RStudio.
3. Load the dataset by updating the file path in `read.csv()`.
4. Run the script.

## Results
- The trained Naive Bayes model predicts sentiment with reasonable accuracy.
- Visualization includes:
  - Sentiment distribution.
  - Review length distribution.
  - Confusion matrix visualization.

## Example Predictions
New reviews tested:
1. "The movie was fantastic! I loved it." → Positive
2. "The plot was boring and predictable." → Negative
3. "Great acting, but the story lacked depth." → Mixed (depends on model training)


## Author
Mrinal Ashwith S P
Vigneshwaran M
Yuvan Kalyan U


