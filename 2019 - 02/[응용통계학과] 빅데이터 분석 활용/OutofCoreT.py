import pandas as pd
import numpy as np
import csv
#data = pd.read_csv('~/Documents/Data/example.csv', sep=',', na_values=".", encoding='utf-8')

def outofCore_Stat(file):
    f = open(file, 'r', encoding='utf-8')    
    rdr = csv.reader(f)
    varName = next(rdr)  # first line: names of feature
    
    k = len(varName)
    xbar = np.zeros(k)
    S2 = np.zeros(k)

    for n, row in enumerate(rdr):  # enumerate object 
        
#       change str to float and make numpy arry         

        xValues = np.array(row, dtype = np.float32)
        xbar = xbar + xValues         # calculate sum X
        S2 = S2 + xValues * xValues   # calcualte sum X^2
        
    f.close()        
    n += 1
    xbar = xbar/n
    S2 = (S2 - n * xbar * xbar) /(n-1)
    
    return(pd.DataFrame({"variable": varName, "xbar": xbar, "S^2": S2}))

file = 'MLB.csv'
print(outofCore_Stat(file))
