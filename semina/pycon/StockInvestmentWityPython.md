# Stock Investment with Python

[김대현 : 파이썬을 활용한 똑똑한 주식투자 (시스템 트레이딩) - PyCon APAC 2016](https://www.youtube.com/watch?v=ED04jGkp4Sg&ab_channel=PyConKorea)

- 시스템 트레이딩: 정해진 전략에 기반한 투자로, 데이터를 모아 전략을 수립하고 이행하는 세 단계가 있다.
- 관련 데이터수집(종목코드/지난데이터 등), 시점/종목/비중을 정해서 구매하고, 그 성과를 분석
- 주의: 과적합(지난데이터로 추정한 경향이 미래에는 맞지 않을수 있음), 거래비용(세금, 가격상승/하강)

- API: 키움, 대신증권 사이보스 트레이더, 이베스트 투자증권 씽



[김도형: 파이썬 기반의 대규모 알고리즘 트레이딩 시스템 소개 - PyCon Korea 2015](https://www.youtube.com/watch?v=oEvWO_37rnc&ab_channel=PyConKorea)

- 알고리즘 트레이딩 = 증권 업무 자동화 != 혼자서 돈을 버는 기계
- 시장미시구조론, 금융수학이란 학문을 바탕으로 전략을 수립
- 참고: 대량 최적 매매 전략 Peg, Hidden Sniper, TWAP(시간분할) 등 / 지정가주문, 시장가주문 / 틱데이터, 일중데이터, 일간데이터

- 구성
  - 분석라이브러리: numpy, pandas, statsmodels
  - 파이썬시스템 anaconda, 데이터베이스 redis-py, pytables, pymongo, log4mongo, 자료관리및분석 numpy, pandas, statsmodels, ta-lib, 시각화 matplotlib, seaborn, 실시간 시장분석 ipython, jupyter, 메시지 미들웨어 simplejson, ujson, pyzmq, FiniteStateMachine fysom, 프로세스관리 psutil, apscheduler, fabric, supervisord, 인터페이스 tornado, django
  - [시장정보 데이터베이스&API](https://youtu.be/oEvWO_37rnc?t=2434)

  

```
1. 위에서 설명한 프로그램을 모사한 클론 프로젝트를 진행해보자
2. 목표는 서버 및 DB의 구성과 운영관리이며 수익이 아님
3. 성능이 잘 작동하는지 매수, 매도를 간단한 전략에 기반해 1달간 운영
4. 코드 및 프로젝트 문서를 깃헙으로 관리
```

