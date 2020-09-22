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
	2. 루프는 흑색이다.
	3. 모든 리프는 흑색이다.
	4. 어떤 노드가 적색이면 그 자식은 모두 흑색이다.
	5. 어떤 노드로부터 자손 리프로 가는 경로는 모두 같은 수의 흑색 노드를 포함한다.

- 리프노드는 모두 `NULL` 대신 '경계노드(sentinel)'를 가리킴으로써, 어떤 노드 X의 `NULL`인 자식을 일반 노드처럼 처리할 수 있게 한다.



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





















