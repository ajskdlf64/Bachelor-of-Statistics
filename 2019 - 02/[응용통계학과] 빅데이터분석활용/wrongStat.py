import pandas as pd
import numpy as np

def wrongStat(pdDFrame):
    varName = pdDFrame.keys()        # get keys(variable name)
    npArray = pdDFrame.to_numpy()    # convert to numpy array
    
    n, k = npArray.shape             #  n = # of cases; k = # of features 
    
    xbar = np.zeros(k)               # initialize for summation
    S2 = np.zeros(k)

    for i in range(n):
        xbar = xbar + npArray[i,:]   # sum
        
    xbar = xbar / n                  # sample mean

    for i in range(n):
        S2 = S2 + (npArray[i,:] - xbar) ** 2.

    S2 = S2/(n-1)                    # sample variance

    return(pd.DataFrame({"variable": varName, "xvar": xbar, "S^2": S2}))


data = pd.read_csv("MLB.csv", sep=',', na_values=".", encoding='utf-8')
print(wrongStat(data))