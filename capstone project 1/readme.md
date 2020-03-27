## A Study on Credit Default Risk

## Summary 
In this project we build a classification model to predict the probability of default on a new loan, based on customer's bureau information, income, previous loan status, credit card balance, install payment and so on. This model will provide lenders a predicted outcome of default or non-default to guide them making decisions to approve or decline the loan application.

## Data Wrangling
There are 5 relavent datasets containing the historical loan terms, payments, demographics, bureau information etc. linking to the current applications. We implemented the basic data aggregations for each of the 5 data sources by keeping only one or two of the summary statistics such as average, sum, max or min of each group having the same previous application ID. Categorical variables are treated using one hot encoding. The major application dataset contains over 300,000 rows and due to the imbalanced nature of the data, we down sampled the non-default counts to be approximately the same as the default counts in the training data, while the test data is still a randomly held out 20% imbalanced dataset. 

<img src="https://github.com/lisalb168/Bo_project/blob/master/capstone%20project%201/figures/Default%20Distribution.png"
     alt="Default Distribution"
     style="float: left; margin-right: 10px;" />
        
## Modeling
We explored 6 commonly used classification models including tree-based methods such as Random Forest, XGboost and LightGBM, as well as classical models such as Logistic regression with regularization, K-nearest neighbors (KNN) and support vector machine / classifier (SVM). For each classification model, a 5-fold CV with RandomizedSearchCV in Scikit-learn is run on the down-sampled balanced training set to select the best combination of hyperparameters. The parameter that yields the highest average AUC on the 5 validation sets is chosen, and the standard deviation is also reported to show the variability of the AUC scores among the 5 validation sets.

<img src="https://github.com/lisalb168/Bo_project/blob/master/capstone%20project%201/figures/Model%20Performance.png"
     alt="Model Performance"
     style="float: left; margin-right: 10px;" />

## Further Readings
Link to the data source:  
https://www.kaggle.com/c/home-credit-default-risk/data

Link to the full report and ppt slides:  
https://github.com/lisalb168/Bo_project/tree/master/capstone%20project%201/reports

