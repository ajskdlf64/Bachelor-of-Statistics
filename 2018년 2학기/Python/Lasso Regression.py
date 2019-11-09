# %matplotlib qt : 그래프 따로 출력
# %matplotlib inline : 되돌리기

# 임의의 난수 생성
import numpy as np
import matplotlib.pyplot as plt
X = 14 * np.random.rand(1500,1)
Y = 3 + 8*X + np.random.randn(1500,1)
plt.scatter(X,Y)


# Ridge 객체 생성
from sklearn.linear_model import Lasso
Lasso = Lasso(alpha=0.1, fit_intercept=True, normalize=True, copy_X=True, random_state=42)
Lasso.fit(X,Y)


# 가중치 및 절편 확인
print("가중치 : {}".format(Lasso.coef_))
print("절편 : {}".format(Lasso.intercept_))


# R-score
print("결정계수 : {}".format(Lasso.score(X,Y)))


# 예측
print("X=3.0 의 예측값 : {}".format(Lasso.predict(3.0)))
print("X=2.3 의 예측값 : {}".format(Lasso.predict(2.3)))
print("X=1.5 의 예측값 : {}".format(Lasso.predict(1.5)))
print("X=0.8 의 예측값 : {}".format(Lasso.predict(0.8)))