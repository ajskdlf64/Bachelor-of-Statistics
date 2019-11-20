import pandas as pd
import numpy as np

def reg(pdDFrame, dependent):
    varName = pdDFrame.keys()                 # get keys(variable name)
    y = pdDFrame[dependent].to_numpy()        # np.array of dependent variable

    xName = varName[varName != dependent]     # variable names of independent variables    
    X = pdDFrame[xName].to_numpy()            # np.array of independent variable
    
    n, k = X.shape
    
    intercept = np.ones((n,1))
    X = np.append(intercept, X, axis=1)      # add column of 1's to X matrix for intercept
    
    xName = xName.insert(0, 'intercept')     # variable names of independent variables with intercept   
    
    XpX = X.T.dot(X)                         # X'X matrix
    XpXInv = np.linalg.inv(XpX)              # (X'X)^{-1} : inverse matrix of X'X
    Xpy = X.T.dot(y)                         # X'y
    
    parm = XpXInv.dot(Xpy)                   # B = (X'X)^{-1} X'y
    
    return(pd.DataFrame({"variable": xName, "Estimate": parm}))

data = pd.read_csv("MLB.csv", sep=',', na_values=".", encoding='utf-8')

print(reg(data, "attendance"))