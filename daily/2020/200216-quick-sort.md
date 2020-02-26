# 퀵정렬
## 설명
- 임의의 피벗을 선택하여, 피벗보다 작은 요소를 왼쪽으로 크면 오른쪽으로 옮긴다.
- 피벗을 제외한 각각 리스트를 다시 정렬한다.

## 구현하기

```c++
#include <iostream>
#define ARRAY_SIZE 20
#define swap(a, b) {int t=a; a=b; b=t;}
using namespace std;

int partition(int arr[], int head, int tail) {
	int x = arr[tail], i = head - 1, j = head;
	while (j < tail) {
		if (arr[j] <= x) {
			i++;
			swap(arr[i], arr[j]);
		}
		j++;
	}
	swap(arr[i + 1], arr[tail]);

	cout << "pivot : " << i+1 << ", head : " << head << ", tail : " << tail << endl;
	for (int i = 0; i < ARRAY_SIZE; i++) cout << arr[i] << " ";
	cout << endl;

	return i + 1;
}

// head <= x <= tail
void qsort(int arr[], int head, int tail) {
	if (head < tail) {
		int pivot = partition(arr, head, tail);
		qsort(arr, head, pivot - 1);
		qsort(arr, pivot + 1, tail);
	}
}

int main() {
	int arr[ARRAY_SIZE] = {3,4,5,12,534,1534,31,7756,34,8,1,3,3,5,8654,342,64,35325,20,43};
	//int arr[ARRAY_SIZE] = { 0,5,2,1,4 };
	for (int i = 0; i < ARRAY_SIZE; i++) cout << arr[i] << " ";
	return 0;
}
```

결과는

```
COMPLETE!
pivot : 12, head : 0, tail : 19
3 4 5 12 31 34 8 1 3 3 5 20 43 7756 8654 342 64 35325 1534 534
pivot : 9, head : 0, tail : 11
3 4 5 12 8 1 3 3 5 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 6, head : 0, tail : 8
3 4 5 1 3 3 5 12 8 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 3, head : 0, tail : 5
3 1 3 3 5 4 5 12 8 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 2, head : 0, tail : 2
3 1 3 3 5 4 5 12 8 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 0, head : 0, tail : 1
1 3 3 3 5 4 5 12 8 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 4, head : 4, tail : 5
1 3 3 3 4 5 5 12 8 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 7, head : 7, tail : 8
1 3 3 3 4 5 5 8 12 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 11, head : 10, tail : 11
1 3 3 3 4 5 5 8 12 20 31 34 43 7756 8654 342 64 35325 1534 534
pivot : 15, head : 13, tail : 19
1 3 3 3 4 5 5 8 12 20 31 34 43 342 64 534 8654 35325 1534 7756
pivot : 13, head : 13, tail : 14
1 3 3 3 4 5 5 8 12 20 31 34 43 64 342 534 8654 35325 1534 7756
pivot : 17, head : 16, tail : 19
1 3 3 3 4 5 5 8 12 20 31 34 43 64 342 534 1534 7756 8654 35325
pivot : 19, head : 18, tail : 19
1 3 3 3 4 5 5 8 12 20 31 34 43 64 342 534 1534 7756 8654 35325
1 3 3 3 4 5 5 8 12 20 31 34 43 64 342 534 1534 7756 8654 35325
```

- 왜 틀렸냐하면  
- SWAP에서 T=A, A=B, B=A라고 썼다..  
- 매개인자로 넘긴 배열 인덱스의 이상/미만을 헷갈렸다..  
- 애초에 이해를 못했다  
    - i=0, j=0일때, arr[j]가 pivot보다 작다면. 자기자신과 교환하여 pivot이하 값을 정렬한다.  
    - i=1, j=1일때, arr[j]가 pivot보다 크다면. 냅둔다.  
    - i=1, j=2일때, arr[j]가 pivot보다 크다면. 냅둔다.  
    - i=1, j=3일때, arr[j]가 pivot보다 작다면. 교환하여 pivot이하 값을 정렬한다.  
    - i=2, j=4일때, arr[j]가 pivot보다 작다면. 교환하여 pivot이하 값을 정렬한다.  
    - 결론, j는 0부터 tail까지 모든 원소를 순회한다. i-1은 정렬된 배열의 마지막 인덱스며, i는 정렬되지 않은 배열의 첫 인덱스다.  

