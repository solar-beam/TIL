# 삽입정렬

## 들어가기전에
### 분석하기(시간복잡도)
- 입력크기/실행시간으로 분석한다.
- 코드라인별 실행시간은 동일한것으로 간주하며(=메모리 구조에 따른 접근시간 차이는 고려하지 않음), 서브루틴 내부 실행시간은 고려하지 않는다.
- 코드라인별 실행횟수를 더하고 곱하여 대략적인 알고리즘 성능을(소요자원/시간) 구한다.
- 최악의 경우를 가정하고, 실행횟수 산식의 최고차항만을 남겨 성능예측에 활용할 수 있다(제타 표기법이라 부른다.)

### 증명하기(정당성증명)
- 수학적 귀납법 : 자연수에 관한 명제 P(n)이 모든 자연수(또는 어떤 자연수 보다 큰 모든 자연수)에 대하여 성립함을 증명함. 최소원 n=n0에 대하여 성립함을 보이고, 어떤 자연수 k에 대하여 P(k)가 참이면 P(k+1)도 성립함을 보인다.
  - loop invariant(유한한 수학적귀납) : true prior to the first iteration of the loop. true before an iteration of the loop, and remains true before next iteration. when the loop terminates, the invariant(true) will show algorithm is correct.
  - arr[1...i-1]은 반복문 진입전 정렬되어있다. 다음 반복문 진입 전까지도 arr[1...i-1]은 정렬되어있다. 반복문이 종료되면 arr[1...k]는 우리가 원하는대로 정렬되어 있을 것이다.

## 구현하기
- 일반

```c++
#include <iostream>
using namespace std;

int main()
{
    int arr[8] = { 8,6,5,3,1,2,7,4 };
    int compareKey = 0;
    for (int i = 1; i < 8; i++) {
        compareKey = arr[i];
        int currentIndex = i;
        while (currentIndex > 0 && (arr[currentIndex - 1] > compareKey)) {//비교부 : O(n^2)
            arr[currentIndex] = arr[currentIndex - 1];//교환부 : O(n^2)
            currentIndex--; 
        }
        arr[currentIndex] = compareKey;
    }
    for (int i = 0; i < 8; i++) {
        cout << arr[i] << " ";
    }
}
```

- 이진삽입

```c++
#include <iostream>
using namespace std;

int main()
{
    int arr[8] = { 8,6,5,3,1,2,7,4 };
    int compareKey = 0;
    for (int i = 1; i < 8; i++) {
        compareKey = arr[i];
        int lowIndex = 0, highIndex = i - 1, midIndex;//midIndex의 초기화는 필요한가?
        while (lowIndex < highIndex) {//비교부 : O(log n)
            midIndex = (lowIndex + highIndex) / 2;
            if (compareKey >= arr[midIndex]) lowIndex = midIndex + 1;
            else highIndex = midIndex;
        }
        //교환부 : O(n) memcpy(dest, src, size)
        memcpy(arr + highIndex + 1, arr + highIndex, sizeof(arr[0]) * (i - highIndex));
        arr[highIndex] = compareKey;
    }

    for (int i = 0; i < 8; i++) {
        cout << arr[i] << " ";
    }

}
```

- 참고

```java
package old.August;

import java.util.Scanner;

/**
 * Created by belobster on 16. 8. 29.
 */

public class Insertion {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int tc = sc.nextInt();
        int[][] o = new int[tc][2];
        for(int i=0; i<tc; i++){
            o[i][0] = sc.nextInt();
            o[i][1] = sc.nextInt();
        }

        array_sort(o);
        array_print(o);

    }

    private static void array_print(int[][] o) {

        for(int i=0; i<o.length; i++){
            System.out.println(o[i][0]+" "+o[i][1]);
        }
    }

    private static void array_sort(int[][] o) {

        for(int i=1; i<o.length; i++){

            int[] key = {o[i][0], o[i][1]};
            int pos = i;

            while(pos>0 && (o[pos-1][0]>=key[0])){
                // x좌표가 같다. y좌표로 비교한다.
                if(o[pos-1][0]==key[0]){
                    while(pos>0 && o[pos-1][0]==key[0] && o[pos-1][1]>=key[1]){
                        o[pos][0] = o[pos-1][0];
                        o[pos][1] = o[pos-1][1];
                        pos--;
                    }
                }
                // x좌표만으로 정렬 가능하다.
                else{
                    o[pos][0] = o[pos-1][0];
                    o[pos][1] = o[pos-1][1];
                    pos--;
                }
            }

            o[pos][0]=key[0];
            o[pos][1]=key[1];
        }

    }

    private static void array_bisort(int[][] o) {

        for(int i=1; i<o.length; i++){
            int l = 0, r = i, m = r/2;
            do{
                if(o[i][0]>o[m][0]) l=m+1;
                else if(o[i][0]<o[m][0]) r=m;
                else break;
                m = l+((r-l)/2);
            }while(l<r);

            if(m<i){
                int[] tmp = {o[i][0], o[i][1]};
                for(int j=i; j>m; j--){
                    o[j][0] = o[j-1][0];
                    o[j][1] = o[j-1][1];
                }
                o[m][0]=tmp[0];
                o[m][1]=tmp[1];
            }

        }


    }

}
```

  

## TOO DEEP

- `std::cin`,  `std::cout` : [SoEn](http://soen.kr/)에서 꽤나 DEEP한 수준의 C++강좌를 볼수 있다.
- `std::move`, `std::forward` : [std::move, std::forward 이해하기](https://github.com/jwvg0425/ModernCppStudy/wiki/item-23), [C++ `move()`는 언제나 효율적일까?](https://ozt88.tistory.com/47)
- hex, oct, dec 등의 함수를 직접 호출하는 대신 << 연산자로 함수를 cout으로 보내도 마찬가지 효과가 있다. << 연산자가 함수 포인터에 대해서도 오버로딩되어 있어 전역 함수를 대신 호출하도록 되어 있기 때문이다. << 연산자가 함수이고 인수로 함수 포인터가 전달되었으므로 전달된 함수를 호출할 수 있는 것은 당연하다. 또한 << 연산자가 객체의 레퍼런스를 리턴하므로 cout으로 hex를 보낸 후 곧바로 정수를 출력하는 것도 가능하다. 예제의 실행 결과는 다음과 같다.  
- `void printLength(const std::array<double, 5>& myArray)` 위 예제에서 printLength() 함수에서 매개 변수로 std::array를 (const) 참조형(reference)으로 받는다는 것에 주목하자. 이는 std::array가 함수로 전달될 때 (성능상의 이유로) 컴파일러가 배열의 복사본을 만드는 것을 방지하기 위한 것이다.
