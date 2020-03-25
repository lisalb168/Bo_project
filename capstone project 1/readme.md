## A Study on Credit Default Risk

## Summary 
In this project we build a classification model to predict the probability of default on a new loan, based on customer's bureau information, income, previous loan status, credit card balance, install payment and so on. This model will provide lenders a predicted outcome of default or non-default to guide them making decisions to approve or decline the loan application.

## Data Wrangling
There are 5 relavent datasets containing the historical loan terms, payments, demographics, bureau information etc. linking to the current applications. We implemented the basic data aggregations for each of the 5 data sources by keeping only one or two of the summary statistics such as average, sum, max or min of each group having the same previous application ID. Categorical variables are treated using one hot encoding. The major application dataset contains over 300,000 rows and due to the imbalanced nature of the data, we down sampled the non-default counts to be approximately the same as the default counts in the training data, while the test data is still a randomly held out 20% imbalanced dataset. 

<img src="https://github.com/lisalb168/Bo_project/blob/master/capstone%20project%202/figures/Airline%20Company%20by%20Sentiment.png"
     alt="Airline Company by Sentiment"
     style="float: left; margin-right: 10px;" />
        
## Modeling
We explored 6 commonly used classification models including tree-based methods such as Random Forest, XGboost and LightGBM, as well as classical models such as Logistic regression with regularization, K-nearest neighbors (KNN) and support vector machine / classifier (SVM). For each model, first a K-fold CV with RandomizedSearchCV is run on the training set to select the best combination of parameters using accuracy as criteria. Next, each model is fit on the entire training set using the chosen best parameters, and performance metrics such as accuracy, confusion matrix and AUC are reported. Finally, we applied the best selected model to the test dataset and reported the accuracy measures.



## Further Readings
Link to the data source:  
https://www.kaggle.com/c/home-credit-default-risk/data

Link to the full report and ppt slides:  
https://github.com/lisalb168/Bo_project/tree/master/capstone%20project%201/notebook

