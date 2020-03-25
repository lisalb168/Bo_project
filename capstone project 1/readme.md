## A Study on Credit Default Risk

## Summary 
In this project we build a classification model to predict the probability of default on a new loan, based on customer's bureau information, income, previous loan status, credit card balance, install payment and so on. This model will provide lenders a predicted outcome of default or non-default to guide them making decisions to approve or decline the loan application.

## Data Wrangling
There are 5 relavent datasets containing the historical loan terms, payments, demographics, bureau information etc. linking to the current applications. We implemented the basic data aggregations for each of the 5 data sources by keeping only one or two of the summary statistics such as average, sum, max or min of each group having the same previous application ID. Categorical variables are treated using one hot encoding. The major application dataset contains over 300,000 rows and due to the imbalanced nature of the data, we down sampled the non-default counts to be approximately the same as the default counts in the training data, while the test data is still a randomly held out 20% imbalanced dataset. 

<img src="https://github.com/lisalb168/Bo_project/blob/master/capstone%20project%202/figures/Airline%20Company%20by%20Sentiment.png"
     alt="Airline Company by Sentiment"
     style="float: left; margin-right: 10px;" />
        
## Modeling
Some commonly used NLP feature extraction techniques such as CountVectorizer and N-Grams, TF-IDF Vectorizer, and Word2Vec 
are explored. Within each framework, we fit classification models such as Random Forest, Multinomial Naïve Bayes, 
LightGBM and Logistic regression with regularizations. For each feature model combination, the same pre-defined 5-fold cross validation object is passed to RandomizedSearchCV in Scikit-learn on the training set to select the best combination of hyperparameters, the 5 validation accuracy scores will be recorded and average validation score will be compared among different feature model combinations.

## Further Readings
Link to the data source:  
https://www.kaggle.com/c/home-credit-default-risk/data

Link to the full report and ppt slides:  
https://github.com/lisalb168/Bo_project/tree/master/capstone%20project%201/notebook

