# %matplotlib qt : 그래프 따로 출력
# %matplotlib inline : 되돌리기

# 임의의 난수 생성
import numpy as np
import matplotlib.pyplot as plt
X = 16 * np.random.rand(1000,1)
Y = 23 - 15*X + np.random.randn(1000,1)
plt.scatter(X,Y)


# Ridge 객체 생성
from sklearn.linear_model import Ridge
Ridge = Ridge(alpha=0.1, fit_intercept=True, normalize=True, copy_X=True, random_state=42)
Ridge.fit(X,Y)


# 가중치 및 절편 확인
print("가중치 : {}".format(Ridge.coef_))
print("절편 : {}".format(Ridge.intercept_))


# R-score
print("결정계수 : {}".format(Ridge.score(X,Y)))


# 예측
print("X=3.0 의 예측값 : {}".format(Ridge.predict(3.0)))
print("X=2.3 의 예측값 : {}".format(Ridge.predict(2.3)))
print("X=1.5 의 예측값 : {}".format(Ridge.predict(1.5)))
print("X=0.8 의 예측값 : {}".format(Ridge.predict(0.8)))
