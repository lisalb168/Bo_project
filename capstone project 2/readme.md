# Prediction of Airline Sentiments
## Summary 
Social media such as Facebook and Twitter play an important role in people’s lives today. 
Many companies take advantage of the user product and service reviews data scraped from these platforms to help making 
marketing decisions or find opportunities to improve customer experience, which will eventually increase customer retention 
rate. In this project, we perform sentiment classification leveraging an airline sentiment dataset provided by figure-eight 
website in the url given in the last section.
## Data Visualization


<img src="Airline Company by Sentiment.png"
     alt="Airline Company by Sentiment"
     style="float: left; margin-right: 10px;" />
     

## Modeling
Some commonly used NLP feature extraction techniques such as CountVectorizer and N-Grams, TF-IDF Vectorizer from Scikit-learn, 
and Word2Vec from Gensim are explored. Within each framework, we fit classification models such as Random Forest, 
Multinomial Naïve Bayes, LightGBM and Logistic regression with regularizations. For each feature model combination, 
the same pre-defined 5-fold cross validation object is passed to RandomizedSearchCV in Scikit-learn on the training 
set to select the best combination of hyperparameters, the 5 validation accuracy scores will be recorded and average 
validation score will be compared among different feature model combinations.


## Further Readings
Link to the data source:  
https://www.figure-eight.com/data-for-everyone/

Link to the full report and ppt slides:  
https://github.com/lisalb168/Bo_project/tree/master/capstone%20project%202/report

