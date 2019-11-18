import numpy as np

L = range(1000)
%timeit [ i ** 2 for i in L]


a = np . arange(1000)
%timeit a ** 2


print(a ** 2)


# Creating arrays
# 1-D

a = np.array([0, 1, 2, 3])

a

a.ndim         # dimension 1-D

a.shape        # (4,)

len(a)         # n

# 2-D

b = np.array([[0, 1, 2], [3, 4, 5]])    # 2 x 3 array

b

b.ndim        # dimensiion 2-D

b.shape       # (2, 3)  2 X 3 

len(b)        # returns the size of the first dimension

# 3-D
c = np.array([[[1], [2]], [[3], [4]]])   # 3-D
c

c.shape       # (2, 2, 1)  2 x 2 X 1


#  Functions for creating arrays
#  Evenly spaced:

a = np.arange(10)     # 0 .. n-1 (!)
a

b = np.arange(1, 9, 2)    # start, end (exclusive), step
b

# By number of points:
c = np.linspace(0, 1, 6)                # start, end, num-points
c


d = np.linspace(0, 1, 5, endpoint=False)
d


#  Common arrays:

a = np.ones((2, 2))         # reminder: (2, 2) is a tuple
a                           # 2 x 2 matrix of 1's

b = np.zeros((2, 2))        # 2 x 2 matrix of 0's
b

c = np.eye(2)               # 2 x 2 identity(square) matrix 
c

d = np.diag(np.array([1, 2, 3, 4]))  # digonal matrix
d

# Random numbers
a = np.random.rand(4)              # uniform in [0, 1]
a


b = np.random.randn(4)             # Gaussian
b

np.random.seed(1234)               # Setting the random seed


# Indexing and slicing
# The items of an array can be accessed and assigned to the
# same way as other Python sequences (e.g. lists)

a = np.arange(10)
a

a[0], a[2], a[-1]           # (0, 2, 9)

a[::-1]


# For multidimensional arrays, indexes are tuples of integers:

a = np.diag(np.arange(2))
a

a[1, 1]                        # 1

a[1, 1] = 10 # second line, second column
a

a[1]           # a[1,:] is better  i-th row

a[:,1]         # j-th column



#  Copies and views
# When modifying the view, the original array is modified as well:

a = np.arange(10)
a

b = a[::2]
b

np.may_share_memory(a, b)   # True


b[0] = 12
b

a                          # (?)

#  To force a copy
a = np.arange(10)
c = a[::2].copy()           # force a copy
c[0] = 12
a

np.may_share_memory(a, c)   # False


#  Fancy indexing
# Numpy arrays can be indexed with slices, but also with
#  boolean or integer arrays (masks) just like R. This method
#  is called fancy indexing. It creates copies not views.

# Using boolean masks
a = np.random.random_integers(0, 20, 7)
a

(a % 3 == 0)

# array([False, False, False,True,True, False,True])

mask = (a % 3 == 0)

extract_from_a = a[mask] # or, a[a%3==0]
extract_from_a           # extract a sub-array with the mask


#  Indexing with an array of integers

a = np.arange(0, 10, 10)
a

a[[2, 3, 2, 4, 2]]              # [2, 3, 2, 4, 2] is a list

a[[9, 7]] = -1                  # New values can be assigned
a

#  Numerical operations on arrays
#  Elementwise operations:
#  All arithmetic operates elementwise
#  These operations are of course much faster than if you did them in pure python.

a = np.array([1, 2, 3, 4]) 
a + 1

2**a

b = np.ones(4) + 1 
a - b

a * b

j = np.arange(5)  
2**(j + 1) - j


# As R, array multiplication is not matrix multiplication:
c = np.ones((2, 2))

c * c                  # elementwise multiplication

c.dot(c)               # matrix multiplication

#  Comparison element-wisely

a = np.array([1, 2, 3, 4])
b = np.array([4, 2, 2, 4])

a == b

a > b

# Array-wise comparison:

a = np.array([1, 2, 3, 4])
b = np.array([4, 2, 2, 4])
c = np.array([1, 2, 3, 4])
np.array_equal(a, b)
np.array_equal(a, c)


# Logical operations:

a = np.array([1, 1, 0, 0], dtype=bool)
b = np.array([1, 0, 1, 0], dtype=bool)

np.logical_or(a, b)

np.logical_and(a, b)


# Reduction
#  Computing sums:

x = np.array([1, 2, 3, 4])
np.sum(x)

x = np.array([[1, 2], [3, 4]])

x.sum(axis=0)                   # columns (first dimension)

x[:, 0].sum(), x[:, 1].sum()    # same as above


x.sum(axis=1)                  # rows (second dimension)

x[0, :].sum(), x[1, :].sum()   # same as above

# Same idea in higher dimensions:

x = np.random.rand(2, 2, 2)
x

x.sum(axis=2)[0, 1]

x[0, 1, :].sum()


# Other reductions: works the same way(take axis=)
# min, max, argmax, argmin etc.

# Statistics:

x = np.array([1, 2, 3, 1])
y = np.array([[1, 2, 3], [5, 6, 1]])

x.mean()

np.median(x)

np.median(y, axis=-1) # last axis
x.std()               # full population standard dev.
