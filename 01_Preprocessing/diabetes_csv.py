#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec  5 21:51:52 2018

@author: dayvsonsales
"""
import numpy as np
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
import requests

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import accuracy_score

from sklearn.impute import SimpleImputer

print('\n - Lendo o arquivo com o dataset sobre diabetes')
data = pd.read_csv('/Users/dayvsonsales/mlclass/01_Preprocessing/diabetes_dataset.csv')

zero = ['Glucose','BloodPressure','SkinThickness','BMI','Insulin']

# Criando X and y par ao algorítmo de aprendizagem de máquina.\
print(' - Criando X e y para o algoritmo de aprendizagem a partir do arquivo diabetes_dataset')

# Caso queira modificar as colunas consideradas basta algera o array a seguir.
feature_cols = ['Glucose', 'Insulin', 'BMI']

X = data[feature_cols]
y = data.Outcome

#se colocar test_size = 0.0001 ele dá 100% mas fica viciado
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.223, random_state = 11)

imp = SimpleImputer(missing_values=np.nan, strategy='mean')
X_train = imp.fit_transform(X_train)
X_test = imp.fit_transform(X_test)

#há varios escalares esse pega o maior absoluto
sc = MinMaxScaler()

X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

# Criando o modelo preditivo para a base trabalhada
print(' - Criando modelo preditivo')
neigh = KNeighborsClassifier(n_neighbors = 3)
neigh.fit(X_train, y_train)

#realizando previsões com o arquivo de
print(' - Aplicando modelo e enviando para o servidor')

#data_app = pd.read_csv('/Users/dayvsonsales/mlclass/01_Preprocessing/diabetes_app.csv')
#y_pred = neigh.predict(data_app)
y_pred = neigh.predict(X_test)

print(accuracy_score(y_test,y_pred))

data_app = pd.read_csv('/Users/dayvsonsales/mlclass/01_Preprocessing/diabetes_app.csv')
##se mudar os atributos, tem que mudar aqui
data_app = data_app[feature_cols]
data_app = sc.transform(data_app)
y_pred = neigh.predict(data_app)

# Enviando previsões realizadas com o modelo para o servidor
URL = "https://aydanomachado.com/mlclass/01_Preprocessing.php"

#TODO Substituir pela sua chave aqui
DEV_KEY = "COLOCAR_SUA_KEY_AQUI"

# json para ser enviado para o servidor
data = {'dev_key':'if\'s',
        'predictions':pd.Series(y_pred).to_json(orient='values')}

# Enviando requisição e salvando o objeto resposta

r = requests.post(url = URL, data = data)

# Extraindo e imprimindo o texto da resposta
print(" - Resposta do servidor:\n", r.text, "\n")