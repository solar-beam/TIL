# Tree

```java
package November.week19;

import java.util.ArrayList;
import java.util.Stack;

/**
 * Created by belobster on 16. 11. 20.
 */
public class Tree {
    Node root;
    int size_tree;
    int radius_tree;

    Tree(){
        root = new Node();
        size_tree = 0;
        radius_tree = 0;
    }

    private Node addNode(int key, int in)
    {
        Node parent = findNode(key);
        Node child = new Node(in);
        parent.child.add(child);
        return child;
    }


    private Node findNode(int key) {
        Node current = root;
        Stack<Node> stack = new Stack<>();

        do{
            if(current.data == key) break;
            for(int i=0; i<current.child.size(); i++)
                stack.push(current.child.get(i));
            current = stack.pop();
        }while(!stack.isEmpty());

        return current;
    }

    private Node findParent(Node rm) {
        Node current = root;
        Node parent = null;
        Stack<Node> stack = new Stack<>();

        do{
            if(current.data == rm.data) break;
            for(int i=0; i<current.child.size(); i++)
                stack.push(current.child.get(i));
            parent = current;
            current = stack.pop();
        }while(!stack.isEmpty());

        return parent;
    }

    private Node deleteNode(int key)
    {
        Node rm = findNode(key);
        Node parent = findParent(rm);
        //자식 노드가 없을 때
        if(rm.child.isEmpty()) {
            parent.child.remove(rm);
        }
        //자식 노드가 있고, 루트 노드가 아닐 때
        else if(parent != null){
            //부모 노드에 저장된 해당 노드로의 레퍼런스를 삭제하고
            //자식 노드를 부모 노드로 옮긴다.
            parent.child.remove(rm);
            for(int i=0; i<rm.child.size(); i++)
                parent.child.add(rm.child.get(i));
        }//자식 노드가 있고, 루트 노드일 때
        else{
            //루트 노드의 자식 중 하나를 루트로 교체하고
            //다른 자식들을 해당 노드의 자식으로 추가한다
            Node temp = root.child.get(0);
            for(int i=1; i<root.child.size(); i++)
                temp.child.add(root.child.get(i));
            root = temp;
        }
        return parent;
    }

}

class Node{
    int data;
    ArrayList<Node> child = new ArrayList<>();

    Node(){
    }

    Node(int in){
        data = in;
    }
}
```

