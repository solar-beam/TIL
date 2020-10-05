# Graph Algorithm
- 그래프는 정점과 간선의 집합으로, G=(V,E)로 표현한다.
- 그래프의 표현방식
  - E < V^2일때(작은밀도일때) 인접리스트로 표현한다
  - E =? V^2일때(높은밀도일때), 또는 두 정점을 연결하는 간선이 있는지 빠르게 확인할 필요가 있을 때는 인접행렬로 표현한다
- 가중치가 없는 그래프의 최단경로 구하기
```java
//방문여부를 기록하는 배열
int[] chk = new int[wordSet.length];
chk[0]=1;
//최단거리를 갱신할 배열, 정수 최대값으로 초기화
int[] dist = new int[wordSet.length];
for(int i=1; i<dist.length; i++) dist[i]=Integer.MAX_VALUE;
//스택으로 넓이우선탐색
Stack<Integer> m = new Stack<>();
//시작정점을 삽입하고 탐색시작
m.add(0);
while(!m.isEmpty()){ //도착여부 확인하려면, 여기에 if(cur==도착지점)break;
    int cur = m.pop();
    chk[cur]=1;
    for(int i=0; i<wordSet.length; i++){
        if(adj[cur][i]==1 && chk[i]==0){
            m.add(i);
            if(dist[cur]+1<dist[i]){
                dist[i]=dist[cur]+1;
            }
		}
	}
}
```

## 최단거리탐색

### Dijkstra
- [EBS링크소프트웨어 세상, "가장 빠른 길을 찾아라, 최단경로 알고리즘"](https://www.youtube.com/watch?v=tZu4x5825LI)
- 구현방법 : [자바로 만드는 다익스트라 알고리즘](https://bumbums.tistory.com/4)
  - dist[]는 MAX값으로 초기화해둔다. chk[]배열에 방문여부를 기록하고, 시작정점을 true로 바꾼다.
  - 시작정점부터 연결된 정점의 dist값을 갱신한다. 방문하지 않은 정점중 dist값이 최소인 min_node를 찾는다. min_node를 방문했다고 chk[]에 기록한다. dist[]를 갱신한다.
  - 모든 정점을 방문할 때까지 반복한다.
- 시작-최단경로. 가중치 음수아닌 경우 최단거리 찾을 때 사용한다. 최소우선순위 큐 사용 : 루프돌 때마다 가장 가깝거나 가중치 낮은 정점을 선택. 그리디 전략을 채택했다는 점을 알 수 있다. 증명을 통해서 다익스트라가 최단경로 찾을 수 있음을 알 수 있다.
- 루프불변성
  - 시작조건 : 공집합이므로 참이다
  - 유지조건 : S에 추가되는 정점은 시작점이 아니어야 하고, 추가되는 정점U까지의 거리는 반드시 존재한다(경로가 없으면 무한대 가중치를 가지는데, 이를 최단경로로 볼 수 없기 때문). U를 추가하기 전에, S-X-Y-U경로로 분리할 수 이는데, S집합에 속하므로 S-X는 최단경로. S-Y는 S-U보다 작거나 같다(가중치가 음수 아니므로).
- 탐색할 정점을 우선순위큐에 넣어서, 가중치 낮은 곳부터 방문한다. 정점 개수 적으면 그때그때 비교해서 찾아도 되고.

### 플로이드-워셜
- 그래프에서 가능한 모든 정점에 대하여 최단거리를 구한다. 음의 가중치를 가지는 그래프에서도 쓸 수 있고, 시간복잡도는 N^3이다. 구현도 단순하고 좋다.
- 모든정점에서 모든정점에 대하여 계산. 최적부분구조의 합은 최적구조다.
- [pandahun : 알고리즘 정리, 플로이드 워셜](https://velog.io/@pandahun/%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98-%EC%A0%95%EB%A6%AC-%ED%94%8C%EB%A1%9C%EC%9D%B4%EB%93%9C-%EC%9B%8C%EC%85%9C-%EB%B0%B1%EC%A4%80-11404-java)
- adj matrix : 간선의 가중치, 연결되지 않았으면 INF
- D[i][j]를 구할 때, i와 j 사이의 모든 정점 k에 대하여 d[i][j]와 d[i][k]+d[k][j]를 비교한다. 최소값으로 d[i][j]를 갱신한다.
```java
for (int k = 1; k <= N; k++) {
	for (int i = 1; i <= N; i++) {
		for (int j = 1; j <= N; j++) {
			distances[i][j] = Math.min(distances[i][j], (distances[i][k] + adj[k][j]));
		}
	}
}
```

## 최소비용신장트리

### PRIM
- [ssarang8649 : 최소비용신장트리 Minimum Spanning Tree 프림 알고리즘](http://blog.naver.com/PostView.nhn?blogId=ssarang8649&logNo=220992988177)

### Kruskal
- [gmlwjd9405 : Kruskal 알고리즘이란](https://gmlwjd9405.github.io/2018/08/29/algorithm-kruskal-mst.html)
- 사이클을 형성하지 않게끔, 오름차순으로 간선을 선택한다.
- 사이클 생성여부는 [union-find알고리즘](https://gmlwjd9405.github.io/2018/08/31/algorithm-union-find.html)을 이용한다.
```c
//https://gmlwjd9405.github.io/2018/08/31/algorithm-union-find.html
/* 초기화 */
int root[MAX_SIZE];
for (int i = 0; i < MAX_SIZE; i++)
    parent[i] = i;

/* find(x): 재귀 이용 */
int find(int x) {
    // 루트 노드는 부모 노드 번호로 자기 자신을 가진다.
    if (root[x] == x) {
        return x;
    } else {
        // 각 노드의 부모 노드를 찾아 올라간다.
        return find(root[x]);
    }
}

/* union(x, y) */
void union(int x, int y){
    // 각 원소가 속한 트리의 루트 노드를 찾는다.
    x = find(x);
    y = find(y);

    root[y] = x;
}
https://gmlwjd9405.github.io/2018/08/31/algorithm-union-find.html
```