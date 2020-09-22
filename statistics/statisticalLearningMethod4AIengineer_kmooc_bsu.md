## 1 Introduction

- **main concepts** : activation function, back propagation, bayesian statistics, classification, clustering, convolution, cross validation, ensemble, gibbs sampler, gradient boosting, gradient decent, k-NN, logistic regression, loss function, MCMC, regularization, restricted Boltzman machine, supervised and unsupervised learning, tensor, training and test data
- `Y = F(X1, X2, ..., Xp)`에서 F를 추정하는 것이 우리의 목표이다.  `E = mc^2` 과 같이 입력을 알면 결과를 알 수 있는 deterministic한 모델은 이미 밝혀져 있으니, 우리의 관심은 `혈압 = 나이, 몸무게, E`와 같이 오류가 있는 모델에서 F를 추정하는 것이다. 이때 `Y = F(F(F(X1, ..., Xp)))`와 같이 여러 layer/filter를 거치는 것이 *Deep Learning*이다.
- DataSet은 Y가 이산적인 경우와 연속적인 경우로 나눌 수 있고, X의 수가 Y보다 많은 경우를 *high dimensional problem*이라 한다. 데이터에 맞는 기법으로 분석해야하겠다.

  

## 2 preliminary

- 행렬대수(??????)













수리통계학, 회귀분석을 먼저 듣고 다시오자.

- 수리통계학 : 확률, 확률분포, 확률벡터, 점근분석, 통계적추론 등 기본개념

http://www.kocw.net/home/search/kemView.do?kemId=981055

http://www.kocw.net/home/search/kemView.do?kemId=1040366

- 회귀분석

http://www.kocw.net/home/search/kemView.do?kemId=703282

http://www.kocw.net/home/search/kemView.do?kemId=736173