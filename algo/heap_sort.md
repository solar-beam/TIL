# 힙정렬

## HEAP
- 친절하고 게다가 한국어인 힙정렬 설명글 : [gmlwjd9405 : heap](https://gmlwjd9405.github.io/2018/05/10/data-structure-heap.html)
- 영어이긴한데 그림으로 설명해주는 글 : [tutorialhorizon : binary-min-max-heap](https://algorithms.tutorialhorizon.com/binary-min-max-heap/)
- 힙은 중복값을 허용한다(이진트리는 허용하지 않음)
- 힙은 반정렬된 상태로, 부모/자식간 정렬되어 있으나 형제끼리는 정렬되어있지 않다.
- 힙에서 부모 자식 노드의 관계
    - 왼쪽 자식 인덱스 = 부모*2
    - 오른쪽 자식 인덱스 = 부모*2+1
    - 부모 인덱스 = 자식 인덱스/2

## 구현하기

```c++
//ref: introduction to algorithm pseudo code
#include <iostream>
#define HEAP_SIZE 15
#define parent(i) i>>1
#define left(i) i<<1
#define right(i) (i<<1)+1
#define swap(a,b) {int t=a; a=b; b=t;}
using namespace std;

struct heap {
	int arr[HEAP_SIZE];
	int value[HEAP_SIZE]; //priority que, arr : work load = value : work
	int length=0;
	int heap_size=0;
};

/** ##HEAP_SORT */
//compare idx node with child node, 
//change idx node to max value node
void max_heapify(struct heap* h, int idx) {
	int l = left(idx), r = right(idx), max=-1;
	cout << "l : " << l << ", r : " << r << ", m : " << max << endl;
	
	if (l <= h->heap_size && h->arr[l] > h->arr[idx]) max = l;
	else max = idx;
	if (r <= h->heap_size && h->arr[r] > h->arr[max]) max = r;

	if (max != idx) {
		cout << "swap(" << h->arr[idx] << ", " << h->arr[max] << ")" << endl;
		swap(h->arr[idx], h->arr[max]);
		max_heapify(h, max);
	}
}

//max heap's parent node is same or larger than child node
//children nodes are not related to its size comparison
void build_max_heap(struct heap* h) {
	h->heap_size = h->length;
	for (int i = h->length / 2; i >= 1; i--) {
		max_heapify(h, i);
	}
}

//to set max value as arrray last eleement
void heap_sort(struct heap* h) {
	build_max_heap(h);
	for (int i = (h->length); i >= 2; i--) {
		swap(h->arr[1], h->arr[i]);
		h->heap_size--;
		max_heapify(h, 1);
	}
}

/** ##PRIORITY QUE */

int heap_extract_max(struct heap* h) {
	//could replace it to try/catch
	if (h->heap_size < 1) {
		cout << "heap underflow" << endl;
		return -1;
	}
	int max = h->arr[1];
	h->arr[1] = h->arr[h->heap_size];
	(h->heap_size)--;
	max_heapify(h, 1);
	return max;
}

int max_heap_delete(struct heap* h) {
	return heap_extract_max(h);
}

void heap_increase_key(struct heap* h, int idx, int key) {
	if (key < h->arr[idx]) {
		cout << "smaller than current value" << endl;
		return;
	}
	h->arr[idx] = key;
	//[idx...root], if key<current -> swap[idx...leaf]
	while (idx > 1 && h->arr[parent(idx)] < h->arr[idx]){
		swap(h->arr[idx], h->arr[parent(idx)]);
		idx = parent(idx);
	}
}

void max_heap_insert(struct heap* h, int key) {
	(h->heap_size)++;
	h->arr[h->heap_size] = -2147483648;
	heap_increase_key(h, h->heap_size, key);
}


int heap_maximum(struct heap* h) {
	return h->arr[1];
}

//to check whether it is max heap
//to set heap_size
bool is_max_heap(struct heap* h) {
	bool flag = true;
	for (int i = h->length; i > 1; i--) {
		if (h->arr[i] > h->arr[parent(i)]) {
			cout << "FALSE, arr[" << i << "] : " << h->arr[i] << ", arr[p] : " << h->arr[parent(i)] << endl;
			flag = false;
			//return false;
		}
	}
	if (flag) {
		h->heap_size = h->length;
		cout << h->heap_size << endl;
		return true;
	}
	else return false;
}

int main() {
	struct heap maxh = {
		//{-1, 27, 17, 16, 13, 10, 7, 8, 3, 1, 4, 9, 1, 5, 0}, //sorted
		{-1, 1, 4, 8, 9, 27, 7, 17, 3, 16, 13, 10, 1, 5, 0}, //unsorted
		{},
		HEAP_SIZE,
		0
	};
	struct heap* ptrh = &maxh;
	is_max_heap(ptrh);

	//max_heapify(ptrh, 1);
	//build_max_heap(ptrh);
	//heap_sort(ptrh);

	for (int i = 1; i < maxh.length; i++)cout << maxh.arr[i] << " ";
	return 0;
}
```

결과는?

```
COMPLETE!
```


## NOTE
- C++에서 난수생성하는 여러가지 방법 : [boycoding : 난수생성](https://boycoding.tistory.com/192)
- 등차수열의 합 : a는 첫항 d는 공차일 때 n(2a+(n-1)d)/2
- 등비수열의 합 : a는 첫항 r이 공비일 때 a(r^n-1)/(r-1)  *r!=1

## TOO DEEP
- Bottom-up 방식에서는 가장 아랫단부터 시작하기 때문에, 최소한 2/n 개 만큼은 sift-down 을 할 필요가 없습니다. left-node 니까요. 따라서 성능상의 이득이 더 있습니다. 여기 에 의하면 Top-down 방식의 Heapify 는 O(nlogn) 의 성능이 나온다고 합니다. N 개의 원소를 O(logn) 의 복잡도를 가진 삽입 연산으로 넣기 때문이지요. 반면 Bottom-up 방식의 Heapify 는 O(n) 의 성능이 나오는데, 사실 힙소트는 Heapify 뿐만 아니라 Extraction 시간도 고려해야 하기 때문에 두 경우 모두 O(nlogn) 라고 합니다. 왜냐하면, O(nlogn) + O(nlogn)(Top-down) 이나 O(n) + O(nlogn) 이나, O(nlogn) 이기 때문이지요. (Bottom-up 에 대한 성능 증명은 여기로. 간단히 말씀드리면, 높이가 0부터 h까지 있는 힙에서 바텀 업 힙 구성은 2^(h+1) 번의 연산이 필요한데, 이것은 n+1 보다 작으므로 O(n)입니다.)
