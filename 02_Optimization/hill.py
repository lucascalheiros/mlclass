#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jan 27 11:04:15 2019

@author: dayvsonsales
"""

import requests, random

goal = 32

max = -99999

def fit(ind):
    global max
    URL = "http://localhost:8080/antenna/simulate?phi1=%d&theta1=%d&phi2=%d&theta2=%d&phi3=%d&theta3=%d"%(ind[0],ind[1], ind[2], ind[3], ind[4], ind[5])
    r = requests.post(url = URL)
    fitness = r.text.split('\n', 1)[0]
    fitness = float(fitness)
    
    if(fitness > max):
        max = fitness
        print(max)
    
    return fitness

def gen_new_state(cur):
    
    atr = random.randint(0, 7)
    phi1 = phi2 = phi3 = theta1 = theta2 = theta3 = 0
    
    phi1 = cur[0] + random.randint(-1, 2)
    phi2 = cur[2] + random.randint(-1, 2)
    phi3 = cur[4] + random.randint(-1, 2)
    theta1 = cur[1] + random.randint(-1, 2)
    theta2 = cur[3] + random.randint(-1, 2)
    theta3 = cur[5] + random.randint(-1, 2)

    new_state = [abs(phi1), abs(theta1), abs(phi2), abs(theta2), abs(phi3), abs(theta3)]
    
    return new_state

def initial(nPop):
    global max
    cur_state = [random.uniform(0, 360) for y in range(7)]
    
    fit(cur_state)
    
    while(max < goal):
        new_state = gen_new_state(cur_state)
        if(fit(cur_state) < fit(new_state)):
            cur_state = new_state
    
    return cur_state
    
state = initial(1000)
state