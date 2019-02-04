#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  4 17:52:50 2019

@author: lucas
"""

import pandas as pd
import requests

# %% loading and training dataset
data = pd.read_csv('abalone_dataset.csv')

feature_cols = ['sex','length','diameter','height','whole_weight','shucked_weight','viscera_weight','shell_weight']
X = data[feature_cols]
y = data.type

# %% defining functions for the learning models


# %% loding and applying a predictivemodel
data_app = pd.read_csv('abalone_app.csv')
# y_pred = some function


URL = "https://aydanomachado.com/mlclass/03_Validation.php"
DEV_KEY = "if's"
data = {'dev_key':DEV_KEY,
        'predictions':pd.Series(y_pred).to_json(orient='values')}

r = requests.post(url = URL, data = data)

pastebin_url = r.text
print(" - Resposta do servidor:\n", r.text, "\n")

