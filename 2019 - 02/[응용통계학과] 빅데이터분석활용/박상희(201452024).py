# 1번
import numpy as np
np.random.seed(1234)

x = np.random.normal(170., 5.0, size=1000)    

MAX_X = x[0]
for i in range(1, len(x)):
    if MAX_X < x[i]:
        MAX_X = x[i]
MAX_X





# 2번
import numpy as np
np.random.seed(1234)

def piEstimate (n):
    
    SUM = 0
    x = np.random.uniform(low=0.0, high=1.0, size=n)
    y= np.random.uniform(low=0.0, high=1.0, size=n)
        
    for i in range(n) : 
        if ((x[i]*x[i] + y[i]*y[i])**0.5) <= 1 : 
            SUM = SUM + 1
    
    ESIMATE_PI = 4 * (SUM / n)
    
    print("Estimate of pi = {:.3f} after {} iterations" .format(ESIMATE_PI, n))
    
    return None

piEstimate(10000)





# 3번
import pandas as pd
data = pd.read_csv('./MLBattend.csv',sep=',',na_values=".")
data.groupby("league")["attendance", "runs.scored", "runs.allowed"].mean()
data.groupby("league")["attendance", "runs.scored", "runs.allowed"].corr()






# 4 번
import numpy as np
X = np.array(data[['attendance', 'runs.scored', 'runs.allowed']])
n, k  = X.shape         # n: number of observations, k: number of variables

S = (1/n-1) * np.dot(np.dot(np.transpose(X),(np.eye(n) - (1/n)*np.ones(n))),X)
S