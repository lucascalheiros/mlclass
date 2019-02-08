#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  4 17:52:50 2019

@author: lucas
"""

import pandas as pd
import requests
from keras.models import Sequential
from keras.layers import Dense
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.neighbors import KNeighborsClassifier

# %% loading dataset and applying hot encoding
df = pd.read_csv('abalone_dataset.csv', header=0)
df = pd.concat([df,pd.get_dummies(df.sex)],axis=1).drop(['sex'],axis=1)
df_type = df.type
df = df.drop(['type'],axis=1)
df = pd.concat([df,df_type], axis=1)

# %% reorganizing dataset
dataset = df.values
X = dataset[:,0:10]
Y = dataset[:,10]

# %% spliting data in training and test sets
x_train, x_test, y_train, y_test = train_test_split(X, Y, test_size=0.2, random_state=0)



# %% defining functions for the learning models
def knn_model(n, x_train, y_train):
    neigh = KNeighborsClassifier(n_neighbors=n)
    neigh.fit(x_train, y_train)
    return neigh

# %%
neigh = knn_model(8,x_train, y_train)
y_pred = neigh.predict(x_test)
c=0
for i in range(y_test.size):
    if(int(y_test[i]) == int(y_pred[i])):
        c+=1
result = c/y_test.size

# %% loding and applying a predictive model
data_app = pd.read_csv('abalone_app.csv')
# y_pred = some function


URL = "https://aydanomachado.com/mlclass/03_Validation.php"
DEV_KEY = "if's"
data = {'dev_key':DEV_KEY,
        'predictions':pd.Series(y_pred).to_json(orient='values')}

r = requests.post(url = URL, data = data)

pastebin_url = r.text
print(" - Resposta do servidor:\n", r.text, "\n")

