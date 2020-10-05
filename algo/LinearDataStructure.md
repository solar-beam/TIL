# 자료구조

## 연결리스트
- 구조체/포인터로 구현할 수 있으며, 배열과 비교해 삽입삭제가 간편하고 동적할당이 가능
    1. (포인터) 함수 매개인자로 전달되면 값에 의한 복사를 한다. 변경이 불가할 뿐만 아니라 메모리공간이 낭비된다.
    2. (동적할당) 연결리스트 자료구조는 추가는 물론 삭제도 가능하기 때문에, 메모리를 유연하게 해제할 수 있는 동적할당으로 구현한다.
- `malloc()` : 동적할당된 메모리는 이름없는 변수와 같다. 독점적인 메모리 영역을 차지하고 있으나 이름이 없으므로 오로지 포인터로만 접근할 수 있다. 힙에 저장되므로, 함수콜스택이 해제되도 메모리는 그대로 유지된다. void*포인터로 반환되며, 형변환하여 사용한다. 사용후에는 `free()`함수로 메모리를 해제한다.
    - `void* malloc(size_t size)` 10byte할당해주세요
    - `void* calloc(size_t num, size_t size)` 1byte 10개 할당하고 0으로 초기화해주세요
    - `void* realloc(void* memblock, size_t size)` memblock을 키우거나 줄여주세요
    - `void* _msize(void* memblock)` 메모리크기를 알고싶다
    - c++에서는 `new`와 `delete`로도 메모리를 할당할 수 있으며 객체 생성자/파괴자 호출도 가능하다
- 스킵 : 여러층위를 둬서 바이너리 탐색처럼 스킵이 가능토록 함, [후로린 advanced data structure : skip list](https://hoororyn.tistory.com/14), [김종우 skip list 발표자료](https://www.slideshare.net/jongwookkim/skip-list)
> Redis, java1.6 ConcurrentSkipListMap/Set, Skipdb, Qt Qmap
- 양방향 : head와 tail이 연결됨

```
#include<iostream>
#include <string>
using namespace std;

struct Node {
	int data;
	Node* head;
	Node* tail;
};

//N에 선행노드 추가
void addHead(Node* n, int d) {
	Node* newNode = (Node*)malloc(sizeof(Node));
	try {
		if (newNode == NULL)throw "memory lackage error";
		newNode->data = d;
		newNode->head = n->head;
		newNode->tail = n;
		n->head = newNode;
		if (newNode->head != NULL) newNode->head->tail = newNode;
	}
	catch (string err) {
		cout << err << endl;
	}
}

void addTail() {/*반대로 하면 된다*/}

//N의 선행노드 삭제
void removeHead(Node* n) {
	n->head = NULL;
}

void removeTail() {/*반대로 하면 된다*/ }

void show(Node* n, bool flag) {
	if (flag) { //앞으로
		Node* currentNode = n;
		while (currentNode!=NULL) { //자기자신도 출력해야해서
			cout << currentNode->data << " ";
			currentNode = currentNode->head;
		}
	}
	else { //뒤로출력
		cout << "잘된다";
	}
}

void showAll(Node* n) {
	Node* currentNode = n;
	while (currentNode->head!=NULL) { //맨앞으로가기
		currentNode = currentNode->head;
	}
	show(currentNode, 0);
}

int main() {
	Node* nh = (Node*)malloc(sizeof(Node));
	try{
		if (nh == NULL) throw "null pointer error";
		nh->data = 0;
		nh->head = NULL;
		nh->tail = NULL;
	}
	catch (string err) {
		cout << err << endl;
	}

	show(nh, 1); cout << endl;

	addHead(nh, 1);
	addHead(nh, 10);
	addHead(nh, 100);
	addHead(nh, 10000);
	addHead(nh, 100000000);
	show(nh, 1); cout << endl;

	addHead(nh, 9);
	addHead(nh, 999);
	addHead(nh, 99999);
	addHead(nh, 999999999);
	show(nh, 1); cout << endl;
	show(nh, 0); cout << endl;
	showAll(nh);

	return 0;
}
```

## 스택
- LIFO

## 큐
- FIFO

## 이진트리
- 완전이진트리 : 포화이진트리의 leaf를 오른쪽부터 제거한 트리
- 포화이진트리 : 꽉참, leaf아닌 노드는 모두 2개 자식을 가지는 트리
- 편향이진트리 : 기움

## 해시테이블
- KEY/VALUE
- 해싱충돌시, CHAINING : 그다음 버킷으로 연결한다.
- 해싱충돌시, OPEN ADDRESSING
    - Linear Probing : 차례로 비어있는 버킷을 찾아넣는다.
    - Quadratic Probing : 저장순서폭을 늘린다.
    - Double Hashing Probing : 해싱을 한번 더 해싱한다!
- 해싱테이블 포화시, 동적으로 사이즈를 늘려주어야함
- 해싱방법
    - Division Method : 나눗셈법, 테이블 사이즈는 소수가 되는쪽이 효율적
    - Multiplication Method : 각 자릿수를 더해 해시값 만듦
    - Universal Hashing : 다수의 해시함수중 하나를 랜덤으로 선택

## TOO DEEP
- c++에서 추가된 문법(내용,위치,간단한 설명)
    - 범위 연산자, 7-3-가, 지역변수에 의해 가려진 전역변수를 참조한다.
    - 명시적 캐스팅, 5-3-라, (int)var형식이 아닌 int(var) 형식으로 캐스팅한다.
    - 인라인 함수, 16-3, 본체가 호출부에 삽입되는 함수
    - 디폴트 인수, 16-4, 실인수가 생략될 때 형식 인수에 적용되는 기본값
    - 함수 오버로딩, 16-5, 같은 이름의 함수를 여러 개 정의하는 기능
    - 태그가 타입으로 승격됨, 13-1-나, 구조체 태그로부터 변수를 바로 선언할 수 있다.
    - 이름없는 공용체, 13-5-나, 공용체 이름없이 멤버들이 기억 장소를 공유한다.
    - 한줄 주석, 2-4-가, // 로 줄 끝까지 주석을 단다.
    - 레퍼런스, 15-4, 변수에 대한 별명을 붙인다.
    - bool 타입, 3-7-마, 1바이트의 진위형 타입
- [키타마사 법](https://junis3.tistory.com/27?category=750796)
- 스킵리스트는 i/2일때 가장 효율적이다
- 해싱테이블 포화시 동적으로 사이즈를 늘려주어야...
- 해싱방법 나눗셈법은 테이블 사이즈가 소수가 되는 쪽이 효율적...
