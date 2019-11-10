# %matplotlib qt : 그래프 따로 출력
# %matplotlib inline : 되돌리기


# 라이브러리 호출
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc


# 샘플 데이터
data = pd.read_csv("sample.csv", encoding = 'euc-kr')
X = data.loc[:,'X1':'X6']
Y = data.loc[:,"y"]


# 데이터 확인
plt.plot(data.y)


# 선형회귀 객체 생성
from sklearn.linear_model import ElasticNet
EN = ElasticNet()
EN.fit(X,Y)

# 가중치 및 절편 확인
print("가중치 : {}".format(EN.coef_))
print("절편 : {}".format(EN.intercept_))


# R-score
print("결정계수 : {}".format(EN.score(X,Y)))


# 예측
print("X=3.0 의 예측값 : {}".format(EN.predict(3.0)))
print("X=2.3 의 예측값 : {}".format(EN.predict(2.3)))
print("X=1.5 의 예측값 : {}".format(EN.predict(1.5)))
print("X=0.8 의 예측값 : {}".format(EN.predict(0.8)))
