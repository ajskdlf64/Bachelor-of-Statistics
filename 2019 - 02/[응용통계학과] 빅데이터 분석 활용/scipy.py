from scipy import io as spio
a = np.ones((3, 3))

spio.savemat('j:/file.mat',{'a': a})                        # savemat expects a dictionary

data = spio.loadmat('j:/file.mat', struct_as_record=True)
data

data['a']

# Reading images:

from scipy import misc
image1 = misc.imread('j:/Lectures/LargeScaleData/figures/Lenna.png')

import matplotlib.pyplot as plt
image2 = plt.imread('j:/Lectures/LargeScaleData/figures/Lenna.png')

plt.imshow(image1)
plt.show()

plt.imshow(image2)
plt.show()


# scipy linear algebra

import numpy as np
from scipy import linalg
arr = np.array([[1, 2], [3, 4]])
linalg.det(arr)                       # determinat

arr = np.array([[3, 2], [6, 4]])
linalg.det(arr)

linalg.det(np.ones((3, 4)))


arr = np.array([[1, 2], [3, 4]])
iarr = linalg.inv(arr)               # inverse matrix
iarr


# allclose: Returns True if two arrays are element-wise equal within a tolerance.
np.allclose(np.dot(arr, iarr), np.eye(2))  


# scipy stat
from scipy import stats

import pandas
data=pandas.read_csv('j:/Lectures/LargeScaleData/Data/brain_size.csv',sep=';',na_values='.')


# 1-sample t-test: testing the value of a population mean
stats.ttest_1samp(data['VIQ'], 0)

#  2-sample t-test: testing for difference across populations
female_viq = data[data['Gender'] == 'Female']['VIQ']
male_viq = data[data['Gender'] == 'Male']['VIQ']
stats.ttest_ind(female_viq, male_viq)

# Paired t-test: repeated measurements on the same individuals
stats.ttest_rel(data['FSIQ'], data['PIQ'])


# Linear models
# First, we generate simulated data according to the model:

import numpy as np
x = np.linspace(-5, 5, 20)


# normal distributed noise
np.random.seed(1)
y = -5 + 3*x + 4 * np.random.normal(size=x.shape)

# Create a data frame containing all the relevant variables
data = pandas.DataFrame({'x': x, 'y': y})

#  OLS fit:
from statsmodels.formula.api import ols
model = ols("y ~ x", data).fit()
print(model.summary())

model.params               # coefficient estimates 