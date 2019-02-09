#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb  9 12:05:45 2019

@author: lucas 
"""
import random
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

def weight(weights, dataset):
    new_datasetT = dataset.T
    
    for i in range(len(weights)):
        new_datasetT[i]*=weights[i]
    return new_datasetT.T


class Genetic:
    def __init__(self, x, y, x_test, y_test):
        self.x = x
        self.y = y
        self.x_test = x_test
        self.y_test = y_test
    
    def fit(self, weights):
        weights = weights[0:9]
        x1 = weight(weights, self.x.copy())
        x_test1 = weight(weights, self.x_test.copy())
        y = self.y
        y_test = self.y_test
        neigh = KNeighborsClassifier(n_neighbors=8)
        neigh.fit(x1, y)
        y_pred = neigh.predict(x_test1)
        c=0
        for i in range(y_test.size):
            if(int(y_test[i]) == int(y_pred[i])):
                c+=1
        return c/y_test.size
    
    def breed(self, parent1, parent2):
        children = [[0 for y in range(11)] for x in range(2)]
        for i in range(6):
            if(random.random()>50):
                children[0][i]=parent1[i]
                children[1][i]=parent2[i]
            else:
                children[1][i]=parent1[i]
                children[0][i]=parent2[i]
            if(random.random()>0.80):
                children[0][i]=random.randint(1,50)
            if(random.random()<0.20):
                children[1][i]=random.randint(1,50)
        return children

    def breeding(self, selected, limit=100):
        children = []
        while(len(selected)+len(children) < limit):
            ran1 = random.randint(0,len(selected)-1)
            ran2 = random.randint(0,len(selected)-1)
            if(len(selected)+len(children) == limit+1):
                children.append(self.breed(selected[ran1],selected[ran2])[0])
            else:
                children += self.breed(selected[ran1],selected[ran2])
    
        return children
    
    def getFit(self, weights):
        return weights[10]
    
    def updateFit(self, pop):
        for weights in pop:
            weights[10] = self.fit(weights)
        return pop
    
    def select(self, pop, num=20):
        pop = self.updateFit(pop)
        pop.sort(key = self.getFit,reverse = True)
        return pop[0:20]
    
        
    def genAlg(self, nPop, nGen):
        pop = [[random.randint(1,50) for y in range(11)] for x in range(nPop)]

        for i in range(nGen):
            print(" GEN: ",i )
            selection = self.select(pop)
            breeds = self.breeding(selection)
            newGen = selection + breeds
            pop = newGen
    
        return pop
        

    
    
    
    
    