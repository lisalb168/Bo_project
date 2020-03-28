# Prediction of Airline Sentiments

## Summary 
Social media such as Facebook and Twitter play an important role in people’s lives today. 
Many companies take advantage of the user product and service reviews data scraped from these platforms to help making 
marketing decisions or find opportunities to improve customer experience, which will eventually increase customer retention 
rate. In this project, we perform sentiment classification leveraging an airline sentiment dataset provided by figure-eight 
website in the url given in the last section.

## Data Visualization
The dataset contains over 14,000 reviews and sentiments are classified into 3 categories: Positive, Negative and Neutral. 
A visual inspection shows that majority of the sentiments are negative.

<img src="https://github.com/lisalb168/Bo_project/blob/master/capstone%20project%202/figures/Airline%20Company%20by%20Sentiment.png"
     alt="Airline Company by Sentiment"
     style="float: left; margin-right: 10px;" />
        
## Modeling
Some commonly used NLP feature extraction techniques such as CountVectorizer and N-Grams, TF-IDF Vectorizer, and Word2Vec 
are explored. Within each framework, we fit classification models such as Random Forest, Multinomial Naïve Bayes, 
LightGBM and Logistic regression with regularizations. For each feature model combination, the same pre-defined 5-fold cross validation object is passed to RandomizedSearchCV on the training set to select the best combination of hyperparameters, the 5 validation accuracy scores are recorded and average validation score are compared among different feature model combinations.

## Further Readings
Link to the data source:  
https://www.figure-eight.com/data-for-everyone/

Link to the full report and ppt slides:  
https://github.com/lisalb168/Bo_project/tree/master/capstone%20project%202/report

