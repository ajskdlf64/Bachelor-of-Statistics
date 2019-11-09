# %matplotlib qt : 그래프 따로 출력
# %matplotlib inline : 되돌리기



# 라이브러리 호출
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc



# 샘플 데이터
X = 2*np.random.rand(100,1)
Y = 2 + 4*X + np.random.randn(100,1)
plt.scatter(X,Y)



# Train 과 Test 로 분리
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X,Y,random_state=42)



# SVR 객체 생성
from sklearn.svm import SVR
SVR = SVR()
SVR.fit(X_train,Y_train)



# 예측력 확인
print("Train set 정확도 : {:.4f}".format(SVR.score(X_train,Y_train)))
print("Test set 정확도 : {:.4f}".format(SVR.score(X_test,Y_test)))



# 그래프 그리기


