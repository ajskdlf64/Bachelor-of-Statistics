import pandas
data=pandas.read_csv('j:/Lectures/LargeScaleData/Data/brain_size.csv',sep=';',na_values='.')
data


import pandas as pd
import numpy as np
t = np.linspace(-6, 6, 20) # -6에서 6까지 등 간격으로 20
sin_t = np.sin(t)
cos_t = np.cos(t)
pd.DataFrame({'t': t, 'sin': sin_t, 'cos': cos_t})


data.shape              # 40 rows and 8 columns
data.columns            # It has columns
print(data['Gender'])   # Columns can be addressed by name

data[data['Gender'] == 'Female']['VIQ'].mean()    # Gender == female인 데이터에서 VIQ의 평균

data['Gender'] == 'Female'
data[data['Gender'] == 'Female']
data[data['Gender'] == 'Female']['VIQ']


data.describe()          # summary of panda.DataFrame



#  groupby: splitting a dataframe on values of categorical variables:
    
groupby_gender = data.groupby("Gender")

groupby_gender

groupby_gender.mean()

for gender, value in groupby_gender["VIQ"]:
    print((gender, value))    

for gender, value in groupby_gender["VIQ"]:
    print((gender, value.mean()))
    

# Box plots of different columns for each gender
groupby_gender.boxplot(column=['FSIQ', 'VIQ', 'PIQ'])



from pandas.tools import plotting              # version problem
plotting.scatter_matrix(data[['Weight','Height','MRI_Count']])

from pandas.plotting import scatter_matrix
scatter_matrix(data[['Weight','Height','MRI_Count']])

# Homework
# 1. 전체 표본에서 VIQ의 평균
# 2. 남자와 여자의 수
# 3. 남여 각각에서 log(MRI)의 평균  