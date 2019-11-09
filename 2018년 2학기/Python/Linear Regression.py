# %matplotlib qt : 그래프 따로 출력
# %matplotlib inline : 되돌리기

# 임의의 난수 생성
import numpy as np
import matplotlib.pyplot as plt
X = 2 * np.random.rand(100,1)
Y = 4 + 3*X + np.random.randn(100,1)
plt.scatter(X,Y)


# 선형회귀 객체 생성
from sklearn.linear_model import LinearRegression
LR = LinearRegression(fit_intercept=True, normalize=True, copy_X=True, n_jobs=1)
LR.fit(X,Y)

# 가중치 및 절편 확인
print("가중치 : {}".format(LR.coef_))
print("절편 : {}".format(LR.intercept_))


# R-score
print("결정계수 : {}".format(LR.score(X,Y)))


# 예측
print("X=3.0 의 예측값 : {}".format(LR.predict(3.0)))
print("X=2.3 의 예측값 : {}".format(LR.predict(2.3)))
print("X=1.5 의 예측값 : {}".format(LR.predict(1.5)))
print("X=0.8 의 예측값 : {}".format(LR.predict(0.8)))


