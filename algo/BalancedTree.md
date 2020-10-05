# Balanced Tree

이진검색트리는 아래와 같이 구현할 수 있으나, 긴 사슬처럼 한 쪽으로 치우칠 경우 O(n)의 시간복잡도를 가진다. 한 쪽으로 치우치지 않도록(=루트에서 리프까지 경로의 최장길이가 비슷하도록) 아래와 같이 레드블랙, AVL, B트리 등이 고안되었다. _test()코드에서는 이진검색트리로 정렬된 노드가, 이하 다른 노드에서도 동일하게 정렬되어 있음을 살펴볼 것이다. 아울러 트리의 특성에 따라 루트에서 리프까지 경로의 최장길이가 경로별로 크게 다르지 않음을 확인하겠다.

```c++
#include <iostream>
#include <stack>

using namespace std;

template <typename T>
struct BSTnode {
	T data;
	BSTnode<T>* left;
	BSTnode<T>* right;

	BSTnode(T d) {
		data = d;
		left = NULL;
		right = NULL;
	}

	BSTnode(T d, BSTnode* l, BSTnode* r) {
		data = d;
		left = l;
		right = r;
	}

	friend ostream& operator<<(ostream& os, const BSTnode<T>& node) {
		os << "[data] " << node.data << ", ";
		if (node.left != NULL) {
			os << "[left] " << node.left->data << ", ";
		}
		if (node.right != NULL) {
			os << "[right] " << node.right->data;
		}
		return os;
	}
};

template <typename T>
struct BSTtree {
	BSTnode<T>* root;

	BSTtree(T data = 0) {
		root = new BSTnode<T>(data);
	}

	void traverse(BSTnode<T>* cur) {
		if (cur == NULL) return;
		traverse(cur->left);
		cout << cur->data << endl;
		traverse(cur->right);
	}

	BSTnode<T>* searchNode(BSTnode<T>* current, T key) {
		if (current == NULL) return NULL;
		cout << current->data << " ";
		if (key == current->data) return current;
		else if (key < current->data) searchNode(current->left, key);
		else searchNode(current->right, key);
	}

	int insertNode(BSTnode<T>* node) {
		if (root==NULL) {
			root = node;
			return 0;
		}

		BSTnode<T>* parent = NULL;
		BSTnode<T>* current = root;
		while (current != NULL) {
			if (current->data == node->data) {
				cout << "INSERT ERR, NODE ALREADY EXISTS" << endl;
				return -1;
			}
			else if (current->data > node->data) {
				parent = current;
				current = current->left;
			}
			else {
				parent = current;
				current = current->right;
			}
		}

		if (node->data < parent->data) parent->left = node;
		else parent->right = node;
		return 0;
	}

	int deleteNode(T key) {
		BSTnode<T>* parent = NULL;
		BSTnode<T>* current = root;
		while (current != NULL) {
			if (current->data == key) {
				//leaf node, without sub tree
				if (current->left == NULL && current->right == NULL) { 
					if (parent != NULL) {
						if (parent->left == current) parent->left = NULL;
						else parent->right = NULL;
					}
					else root = NULL;
				}
				//having one sub tree
				else if (current->left == NULL || current->right == NULL) { 
					BSTnode<T>* successor = current->left!=NULL ? current->left : current->right;
					if (parent != NULL) {
						if (parent->left == current) parent->left = successor;
						else parent->right = successor;
					}
					else root = successor;
				}
				//having two sub tree
				else { 
					BSTnode<T>* successor_p = current;
					BSTnode<T>* successor = current->right;
					while (successor->left != NULL) {
						successor_p = successor;
						successor = successor->left;
					}
					if (successor_p->left == successor) successor_p->left = successor->right;
					else successor_p->right = successor->right;
					successor->left = current->left;
					successor->right = current->right;
				}
				delete(current);
				return 0;
			}
			else if (current->data > key) {
				parent = current;
				current = current->left;
			}
			else {
				parent = current;
				current = current->right;
			}
		}
		cout << "DELETE ERR, NODE DOSENOT EXIST" << endl;
		return -1;
	}

};

int _testBST() {
    
	BSTtree<int> t = BSTtree<int>(8);
	t.insertNode(new BSTnode<int>(14));
	t.insertNode(new BSTnode<int>(25));
	t.insertNode(new BSTnode<int>(3));
	t.insertNode(new BSTnode<int>(17));
	t.insertNode(new BSTnode<int>(7));
	t.insertNode(new BSTnode<int>(9));
	t.traverse(t.root);
	t.deleteNode(-1);
	t.traverse(t.root);
	t.deleteNode(7);
	t.deleteNode(9);
	t.deleteNode(0);
	t.traverse(t.root);

	return 0;
}
```

  

## Red/Black Tree

레드블랙 트리는 루트에서 리프까지 나타나는 노드의 색을 제한함으로써, 그러한 경로 중 어떠한 것도 다른 것보다 두 배 이상 길지 않음을 보장한다.

- 노드 멤버 : 색상, 키값, 포인터(왼쪽 자식, 오른쪽 자식, 부모 노드)
- 트리의 조건

	1. 모든 노드는 적색 또는 흑색이다.
	2. 루트는 흑색이다.
	3. 모든 리프는 흑색이다.
	4. 어떤 노드가 적색이면 그 자식은 모두 흑색이다.
	5. 어떤 노드로부터 자손 리프로 가는 경로는 모두 같은 수의 흑색 노드를 포함한다.

- 리프노드는 모두 `NULL` 대신 '경계노드(`sentinel`)'를 가리킴으로써, 어떤 노드 X의 `NULL`인 자식을 일반 노드처럼 처리할 수 있게 한다.

  

위와 같은 조건을 만족하는 레드블랙 트리는 최대 2log(n+1)의 높이를 가진다. 이를 다음과 같이 증명한다.

- 어떤 노드에서 자손 리프로 가는 경로에 나타나는 흑색 노드의 개수를, 그 노드의 흑색높이라 하고 bh(X)로 표기한다(자기 자신은 제외.)
- 루트가 노드 X인 서브트리는 적어도 2^bh(X)^-1개의 내부 노드를 가진다. 이는 아래와 같이 귀납적으로 증명된다.
  - X의 높이가 0이면, X는 리프노드이다. 2^bh(X)^-1 = 2^0^-1 = 0이므로 위 명제를 만족한다.
  - X가 양의 높이를 가지고 두 자식을 두고 있다면, 자식이 적색 또는 흑색이냐에 따라 bh(X) 또는 bh(X)-1의 높이를 가진다. X자식의 높이는 X의 높이 보다 작으므로, X자식의 서브트리는 적어도 2^bh(X)-1^-1개의 내부노드를 가진다고 볼 수 있다. 이에 따라 노드 X는 (2^bh(X)-1^-1) + (2^bh(x)-1^-1) + 1 = 2^bh(x)^-1개의 내부 노드를 가지므로 위 명제를 만족한다.
- 트리의 높이를 h라 할 때, 루트에서 리프로 가는 경로 중 조건4에 따라 절반 이상이 흑색이므로 bh는 적어도 h/2이다. 따라서 노드의 개수 n에 대하여 다음 식을 만족한다.
  - n >= 2^h/2^-1
  - n+1 >= 2^h/2^
  - log~2~(n+1) >= h/2
  - 2log~2~(n+1) >= h
- 결론 : 위 조건을 만족하는 레드블랙 트리는 최대 2log(n+1)의 높이를 가지며, 이에 따라 레드블랙 트리의 탐색/최대/최소/계승 등의 연산 또한 O(logN) 이내 수행할 수 있다.

  

### 삽입과 FIX-UP/ROTATE 연산

이진검색트리의 삽입연산과 다음과 같은 차이점이 있다.

- 삽입연산의 모든 `NULL`은 `sentinel`로 교체한다.
- 올바른 트리구조 유지를 위해 신규노드의 왼쪽, 오른쪽 자식을 `sentinel`로 지정한다.
- 신규노드는 적색으로 표시한다.
- 삽입종료전 `FIX-UP` 프로시저를 호출하여 레드블랙 트리의 특성을 복구한다.

  

삽입하는 노드는 흑색이 아닌 적색인데, Z가 루트일 때 루트는 흑색이어야 한다는 규칙을 위반한다. 또는 Z가 부모노드인 Y와 함께 모두 적색인 경우 적색 노드는 흑색 자식을 가진다는 규칙을 위반한다. 따라서 삽입 연산은 다음과 같은 불변식을 만족한다.

- 노드 Z는 적색이다.

- Z의 부모노드가 루트면, Z의 부모노드는 흑색이다.

- 트리가 레드블랙 트리의 특성을 위반할 경우, 루트가 적색노드여야 한다는 조건2 또는 적색노드는 흑색자식을 가져야한다는 조건4 중 한 가지를 위반한 것이다.

  *루프불변식 : 루프 첫번째 반복 수행 직전에 만족하며, 각 반복 수행이 끝난 뒤에도 유지되고, 종료시 유용한 특성을 얻을 수 있는 것으로써 프로시저가 의도한 바대로 작동하는지 증명하는 귀납적인 방법이다.

  

불변식의 초기/종료/유지조건은 다음과 같다.

- 초기조건 : 레드블랙 트리를 만족하는 트리에 새로운 노드를 추가한다.

  - Z는 추가되는 적색노드이다.
  - Z의 부모노드가 루트면 흑색이며, FIX-UP을 호출하기 전에 변경되지 않는다.
  - FIX-UP 호출시 조건1,3,5는 만족하나 조건2 또는 조건4 중 하나를 위반한다.

- 종료조건 : 루프 종료시 Z의 부모노드는 흑색이다(Z가 루트면 Z 부모노드는 `sentinel`로 처리.) 또한 프로시저 종료 전 루트를 흑색으로 바꾸므로, Z를 삽입한 레드블랙트리는 언제나 조건4를 만족한다.

- 유지조건 : Z.p가 Z.p.p의 왼쪽 자식인 경우와 오른쪽 자식인 경우로 나뉜다. 동작은 대칭이다.

  *Z.p가 적색일 때 FIX-UP을 호출하고, Z삽입전 트리는 레드블랙트리 특성을 만족하는 트리이다. 적색 노드는 적색자식을 갖지 못하고 루트는 반드시 흑색이므로, Z.p는 루트가 아니며 Z.p.p는 반드시 존재하고 그 색은 흑색이다.

  

레드블랙 트리의 특성을 위반하는 경우는 신규노드와 그 부모노드가 모두 적색일 때이다. 이때 조건5 어떤 루트로부터 자손 리프까지 가는 경로 중 흑색 노드의 개수는 동일해야 한다는 조건을 유념하며, 색을 새로 칠한다.

- 경우1 : Z.p의 형제노드가 RED인 경우

  Z.p와 그 형제가 모두 RED이므로 FIX-UP 호출시 모두 흑색으로 바꾸고 Z.p.p를 적색으로 바꾼다. 이에 따라, Z.p.p를 루트로 하는 리프까지 경로에서 흑색높이는 ±1로 바뀌지 않는다. 이를 'Recoloring'이라 한다.

- 경우2 : Z.p의 형제노드가 BLK이고 Z는 오른쪽 자식인 경우

  Z.p와 그 형제 중 하나만 RED이므로 경우1과 같이 모두 흑색으로 바꾸면, 한쪽 경로의 흑색높이가 다른 쪽보다 길어지게 된다. 먼저 트리를 왼쪽으로 쏠린 사슬 모양으로 바꾼 다음, 중간에서 꺾어 BLK인 형제노드를 공통조상으로 올린다. 시계방향으로 회전하듯 구조를 변경하므로 이를 'Right-Rotate'라 한다(세부내용은 다음에)

- 경우3 : Z.p의 형제노드가 BLK이고 Z는 왼쪽 자식인 경우

  경우2와 마찬가지 방법으로, 오른쪽으로 쏠린 사슬 모양으로 바꾼 다음 중간에서 꺾어 BLK인 형제노드를 공통조상으로 올린다. 반시계방향으로 회전하듯 구조를 바꾸므로 이를 'Left-Rotate'라 하고, 조건2와 조건3을 합쳐 색상만 변경하는 경우1과 대조하여 'Restructuring'이라 부른다.

  

궁금한 점

- 왜 루트는 흑색일까?
- 왜 리프는 흑색일까?
- 왜 색 구분은 왜 두 가지일까? 세 가지, 네 가지일 때는 비효율적일까? (쉽게 이해하거나 코딩할 수 없다면 추상화/모듈화해서 사용할 수 있는 방법은 없을까)
- 왜 흑색 노드의 자식에 대한 규칙은 없을까?
- 트리의 높이를 더 낮출 수 있는 방법은 없을까?

  

## AVL Tree

  

## B Tree

B-트리는 이진 검색 트리를 일반화한 것으로, 자식을 수 개에서 수천 개까지 가질 수 있다.

- 내부 노드 x가 n개의 키를 포함한다면 x는 x.n+1개의 자식을 가진다.
- 노드 x에 저장된 키는, 자식노드를 x.n+1개의 부분 범위로 분할한다.













## TOO DEEP





















