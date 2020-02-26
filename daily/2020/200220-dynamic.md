# 다이나믹(MEMORIZATION)

## 개요
- 분할정복은 서로 겹치지 않는 부분 문제로 분할하고 재귀적으로 그 문제를 해결하는 것이고, 다이나믹은 부분 문제가 서로 중복될 때 적용하여 중복연산을 피한다

## 막대 자르기
- n인치의 막대와 i...n에 대한 가격표가 주어지면, 해당 막대를 잘라서 판매하여 얻을 수 있는 최대수익 Rn을 결정하라.
    - 점화식 Pn = max(Pi + Rn-i)
- 구현하기

```c++
// ref : https://doorbw.tistory.com/43?category=677963
#include <iostream>
#include <cstdlib>
#include <time.h>
#define max(a,b) {a>b?a:b};
using namespace std;

struct Bubble{
	int t1;
	int n1;
	int t2;
	int n2;
};

//점화식 : Pn = max(Pi + Rn-i), i range 1...n
//단, 가격표는 단조증가한다고 가정한다.
int cutRod(int price[], int n) {
	if (n == 0) return 0;
	int q = INT_MIN;
	for (int i = 1; i <= n; i++) {
		q = max(q, price[i] + cutRod(price, n-i));
	}
	return q;
}

//기억하며 풀기!
int dynamicCutRod(int price[], int n) {
	try {
		int* memo = (int*)calloc(n+1, sizeof(int));
		if (memo == NULL) throw "null pointer err!! memory is full!!";
		int q;
		for (int j = 1; j <= n; j++) {
			q = INT_MIN;
			for (int i = 1; i <= j; i++) {
				q = max(q, price[i] + memo[j - i]);
			}
			*(memo + j) = q;
		}
		return *(memo + n);
	}
	catch (string e) {
		cout << e << endl;
		return INT_MIN;
	}
}

Bubble timeChk(int price[], int n) {
	int start, end;
	Bubble b = {-1, -1};

	start = time(0);
	b.n1= cutRod(price, n);
	end = time(0);
	b.t1 = end - start;

	start = time(0);
	b.n2 = dynamicCutRod(price, n);
	b.t2 = end - start;

	return b;
}

int main() {
	//단조 증가하는 랜덤값
	int price[2001];
	srand(time(NULL));
	price[0] = 0;
	for (int i = 1; i < 2001; i++) {
		int tmp;
		do {
			tmp = rand() % 10000;
		} while (tmp < price[i - 1]);
		price[i] = tmp;
	}
	
	Bubble tmp;
	cout << "Brute-force / Bottom-up" << endl;
	for (int i = 1; i < 1000; i++) {
		tmp = timeChk(price, i);
		cout << "(시간) n=" << i << " : " << tmp.t1 << " , " << tmp.t2 << endl;
		cout << "(결과) n=" << i << " : " << tmp.n1 << " , " << tmp.n2 << endl;
	}

	return 0;
}
```

결과테슽흐
```
Brute-force / Bottom-up
(시간) n=1 : 0 , 0
(결과) n=1 : 8113 , 8113
(시간) n=2 : 0 , 0
(결과) n=2 : 16226 , 16226
(시간) n=3 : 0 , 0
(결과) n=3 : 24339 , 24339
(시간) n=4 : 0 , 0
(결과) n=4 : 32452 , 32452
(시간) n=5 : 0 , 0
(결과) n=5 : 40565 , 40565
(시간) n=6 : 0 , 0
(결과) n=6 : 48678 , 48678
(시간) n=7 : 0 , 0
(결과) n=7 : 56791 , 56791
(시간) n=8 : 0 , 0
(결과) n=8 : 64904 , 64904
(시간) n=9 : 0 , 0
(결과) n=9 : 73017 , 73017
(시간) n=10 : 0 , 0
(결과) n=10 : 81130 , 81130
(시간) n=11 : 0 , 0
(결과) n=11 : 89243 , 89243
(시간) n=12 : 0 , 0
(결과) n=12 : 97356 , 97356
(시간) n=13 : 0 , 0
(결과) n=13 : 105469 , 105469
(시간) n=14 : 0 , 0
(결과) n=14 : 113582 , 113582
(시간) n=15 : 0 , 0
(결과) n=15 : 121695 , 121695
(시간) n=16 : 1 , 0
(결과) n=16 : 129808 , 129808
(시간) n=17 : 0 , 0
(결과) n=17 : 137921 , 137921
(시간) n=18 : 1 , 0
(결과) n=18 : 146034 , 146034
(시간) n=19 : 2 , 0
(결과) n=19 : 154147 , 154147
(시간) n=20 : 6 , 0
(결과) n=20 : 162260 , 162260
(시간) n=21 : 17 , 0
(결과) n=21 : 170373 , 170373
(시간) n=22 : 43 , 0
(결과) n=22 : 178486 , 178486
```

## 행렬 체인 곱셈
- 문제내용 : n개의 행렬들의 체인이 주어졌을 때, i=1...n에 대하여 Ai의 차원은 Pi-1 X Pi를 가지는데, 행렬의 스칼라 곱 개수를 최소화하도록 괄호로 묶어라.
    - https://doorbw.tistory.com/50
    - https://mygumi.tistory.com/258
    - https://www.acmicpc.net/problem/11049 (행렬 곱셈 문제)
    - https://www.acmicpc.net/problem/11066 (파일 합치기)
    - https://youtu.be/Tdl6VP4bS90 (백준 행렬 곱셈 문제 해설 강의) 

- 구현하기

```c++
//BOJ 11049
#include<iostream>
#define ARRAY_SIZE 600
#define len(arr) sizeof(arr)/sizeof(arr[0])
using namespace std;

struct Matrix {
	int rownum;
	int colnum;
};

int main() {
	Matrix arr[ARRAY_SIZE];
	arr[1] = { 5, 3 };
	for (int i = 2; i < ARRAY_SIZE; i++) {
		arr[i].rownum = arr[i - 1].colnum;
		arr[i].colnum = rand() % 100;
	}

	int memo[ARRAY_SIZE];
	memo[1] = 1;
	memo[2] = arr[1].rownum * arr[1].colnum * arr[2].colnum;
	for (int i = 3; i < ARRAY_SIZE; i++) {
		int min = INT_MAX, tmp = 0;
		for (int j = 1; j < i; j++) {
			tmp = memo[j] + memo[i - j];
			min = (min < tmp) ? min : tmp;
		}
		memo[i] = min;
	}

	cout << memo[ARRAY_SIZE - 1];
	return 0;
}
```

결과는

```
YEAH!
```

왜?
- C++에서 다차원배열을 함수매개인자로 넘길 때는 열크기를 지정해줘야 한다. 

```c++
void foo(int arr[][10]);
void foo(int (*arr)[10]);
```

- 아니다. 접근법이 틀렸다.

## TOO DEEP
- 최장 공통 부분 시퀀스
- 최적 이진 검색 트리
- [카탈란 수](https://suhak.tistory.com/77)
