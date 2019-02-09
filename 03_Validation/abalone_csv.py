#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  4 17:52:50 2019

@author: lucas
"""
import numpy as np
import pandas as pd
import requests
from optimizer import Genetic, weight
from keras.models import Sequential
from keras.layers import Dense
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.neighbors import KNeighborsClassifier

# %% loading dataset for training and applying hot encoding
dataframe = pd.read_csv('abalone_dataset.csv', header=0)
dataframe = pd.concat([dataframe,pd.get_dummies(dataframe.sex)],axis=1).drop(['sex'],axis=1)
dataframe_type = dataframe.type
dataframe = dataframe.drop(['type'],axis=1)
dataframe = pd.concat([dataframe,dataframe_type], axis=1)

# %% loading dataset for prediction and applying hot encoding
data_pred = pd.read_csv('abalone_app.csv', header=0)
data_pred = pd.concat([data_pred,pd.get_dummies(data_pred.sex)],axis=1).drop(['sex'],axis=1)
# %% defining weights
weights = [
        1,      # length
        2,      # diameter
        1,      # height
        1.5,      # whole_weight
        1,      # shucked_weight
        1,      # viscera_weight
        0.5,      # shell_weigth
        0,      # F
        0,      # I
        0       # M
        ]

# %% normalizing data
dataset = dataframe.values
dataset_pred = data_pred.values

scaler_param_dataset = np.concatenate((dataset[:,0:10],dataset_pred[:,0:10]), axis=0)
scaler = MinMaxScaler()
scaler.fit(scaler_param_dataset)

x = scaler.transform(dataset[:,0:10])
y = dataset[:,10]

x_pred = scaler.transform(dataset_pred[:,0:10])

# %% defining functions for the learning models
def knn_model(n, x_train, y_train):
    neigh = KNeighborsClassifier(n_neighbors=n)
    neigh.fit(x_train, y_train)
    return neigh

# %% spliting data in training and test sets
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)

# %% testing and evaluating weights
gen_alg = Genetic(x_train, y_train, x_test, y_test)
pop = gen_alg.genAlg(100,50)

# %% applying weights and knn model on data
x = weight(weights, x)
x_pred = weight(weights,x_pred)
neigh = knn_model(8, x, y)
y_pred = neigh.predict(x_pred)

#%%
URL = "https://aydanomachado.com/mlclass/03_Validation.php"
DEV_KEY = "if's"
data = {'dev_key':DEV_KEY,
        'predictions':pd.Series(y_pred).to_json(orient='values')}

r = requests.post(url = URL, data = data)

pastebin_url = r.text
print(" - Resposta do servidor:\n", r.text, "\n")
