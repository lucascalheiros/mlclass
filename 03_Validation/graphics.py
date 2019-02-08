#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  7 18:39:27 2019

@author: lucas
"""

import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages


# %% loading dataset and applying hot encoding
df = pd.read_csv('abalone_dataset.csv', header=0)
df = pd.concat([df,pd.get_dummies(df.sex)],axis=1).drop(['sex'],axis=1)
df_type = df.type
df = df.drop(['type'],axis=1)
df = pd.concat([df,df_type], axis=1)

# %% spliting in group types
gb = df.groupby('type')
df1 = gb.get_group(1)
df2 = gb.get_group(2)
df3 = gb.get_group(3)

# %%
df1.plot.hist()
df2.plot.hist()
df3.plot.hist()

# %%

with PdfPages('graphics.pdf') as pdf:

    df1.plot.box()
    pdf.savefig()
    plt.close()
    df2.plot.box()
    pdf.savefig()
    plt.close()
    df3.plot.box()
    pdf.savefig()
    plt.close()
