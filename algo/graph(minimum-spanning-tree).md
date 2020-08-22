# graph(minimum-spanning-tree)

- **Kruskal**

  - 간선을 오름차순으로 정렬 `O(ElogE)`

  - 사이클이 생기지 않도록 간선을 선택 `O(1)*E`

  - 모든 정점을 방문할 때까지 반복

    ```
    O(ElogE + E)
    = O(ElogV^2)
    = O(2*ElogV)
    = O(ElogV)
    ```

    ![img](https://media.vlpt.us/images/fldfls/post/bfc8ca76-a339-45c2-b1cd-17be367b9f8c/image.png)

    

- **Prim**
  - 임의의 간선을 선택
  - 선택한 간선으로부터 가중치가 낮은 순서대로 정점 선택 `O(ElogE)`
  - 모든 정점을 방문할 때까지 반복 `O(1)*E`
  ![img](https://media.vlpt.us/images/fldfls/post/4b407297-f4c6-4487-a62b-4d5f52fa64f3/image.png)


  

  


> **REFERENCE**
> [https://velog.io/@fldfls/최소-신장-트리-MST-크루스칼-프림-알고리즘](https://velog.io/@fldfls/최소-신장-트리-MST-크루스칼-프림-알고리즘)
> https://godls036.tistory.com/26