#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, random, time

# %%
def fit(ind):
    URL = "https://aydanomachado.com/mlclass/02_Optimization.php?phi1=%d&theta1=%d&phi2=%d&theta2=%d&phi3=%d&theta3=%d&dev_key=if's"%(ind[0],ind[1], ind[2], ind[3], ind[4], ind[5])
    r = requests.post(url = URL)
    fitness = r.text.split('"gain":', 1)[1]
    fitness = fitness.split(',', 1)[0]
    fitness = float(fitness)
    return fitness
# %%
def breed(parent1, parent2):
    children = [[0 for y in range(7)] for x in range(2)]
    for i in range(6):
        if(random.random()>50):
            children[0][i]=parent1[i]
            children[1][i]=parent2[i]
        else:
            children[1][i]=parent1[i]
            children[0][i]=parent2[i]
        if(random.random()>0.80):
            children[0][i]=random.randint(1,360)
        if(random.random()<0.20):
            children[1][i]=random.randint(1,360)
    return children
# %%
def breeding(selected, limit=100):
    children = []
    while(len(selected)+len(children) < limit):
        ran1 = random.randint(0,len(selected)-1)
        ran2 = random.randint(0,len(selected)-1)
        if(len(selected)+len(children) == limit+1):
            children.append(breed(selected[ran1],selected[ran2])[0])
        else:
            children += breed(selected[ran1],selected[ran2])

    return children
# %%
def getFit(ind):
    return ind[6]
def updateFit(pop):
    for ind in pop:
        ind[6] = fit(ind)
    return pop
def select(pop, num=20):
    pop = updateFit(pop)
    pop.sort(key = getFit,reverse = True)
    return pop[0:20]


    
# %%
def genAlg(nPop, nGen):
    pop = [[random.randint(1,360) for y in range(7)] for x in range(nPop)]
    pop[0] = [10, 180, 359, 60, 180, 155, 0]
    for _ in range(nGen):
        selection = select(pop)
        breeds = breeding(selection)
        newGen = selection + breeds
        pop = newGen

    return pop
# %%
while(True):
 timer = time.localtime()
    if(timer.tm_hour == 17):
        pop=genAlg(100,100)

