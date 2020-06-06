# String Match

## 단순비교
- 시간복잡도는 O((n-m+1)m), m=n/2인 경우 O(n^2)
- 의사코드는 아래와 같다. 대상문자열 T에서 P를 탐색할 때, 인덱스를 하나씩 늘려가며 비교하는 방식이다.
```
NAIVE-STRING-MATCHER(T,P)
n = T.length
m = P.length
for s = 0 to n-m
    if P[1..m] == T[s+1..s+m]
	    "s 시프트에 의한 패턴"을 출력한다.
```
![](../img/naive-match.PNG)
- JAVA로 구현하면 아래와 같다.
```java
    public static void naiveSearch(String Text, String Pattern) {
        System.out.println("NAIVE-SEARCH");
        MStack m = new MStack(Text.length());
        for (int begin = 0; begin + Pattern.length() <= Text.length(); ++begin) {
            boolean matched = true;
            for (int i = 0; i < Pattern.length(); ++i) {
                if (Text.charAt(begin + i) != Pattern.charAt(i)) {
                    matched = false;
                    break;
                }
            }
            if (matched) m.push(begin);
        }
        while (m.pos >= 0) {
            System.out.println(m.pop());
        }
        System.out.println("-END-");
    }
```
- 종만피셜) 입력이 큰 경우 비효율적이지만, 이런 경우 흔치 않으며 구현이 단순하다는 장점이 있기 때문에 표준 라이브러리 구현에 널리 사용된다. C의 strstr(), C++의 string::find(), java의 indexOf() 등이 이와 같은 알고리즘을 사용한다. 이하 `indexOf()` 내부 구현(JAVA8)
```java
    /**
     * Code shared by String and StringBuffer to do searches. The
     * source is the character array being searched, and the target
     * is the string being searched for.
     *
     * @param   source       the characters being searched.
     * @param   sourceOffset offset of the source string.
     * @param   sourceCount  count of the source string.
     * @param   target       the characters being searched for.
     * @param   targetOffset offset of the target string.
     * @param   targetCount  count of the target string.
     * @param   fromIndex    the index to begin searching from.
     */
    static int indexOf(char[] source, int sourceOffset, int sourceCount,
            char[] target, int targetOffset, int targetCount,
            int fromIndex) {
        if (fromIndex >= sourceCount) {
            return (targetCount == 0 ? sourceCount : -1);
        }
        if (fromIndex < 0) {
            fromIndex = 0;
        }
        if (targetCount == 0) {
            return fromIndex;
        }

        char first = target[targetOffset];
        int max = sourceOffset + (sourceCount - targetCount);

        for (int i = sourceOffset + fromIndex; i <= max; i++) {
            /* Look for first character. */
            if (source[i] != first) {
                while (++i <= max && source[i] != first);
            }

            /* Found first character, now look at the rest of v2 */
            if (i <= max) {
                int j = i + 1;
                int end = j + targetCount - 1;
                for (int k = targetOffset + 1; j < end && source[j]
                        == target[k]; j++, k++);

                if (j == end) {
                    /* Found whole string. */
                    return i - sourceOffset;
                }
            }
        }
        return -1;
    }
```

## 라빈-카프
- [라이 블로그 : 라빈 카프 알고리즘(Rabin-Karp Algorithm) (수정: 2019-08-29)](https://m.blog.naver.com/PostView.nhn?blogId=kks227&logNo=220927272165&proxyReferer=https:%2F%2Fwww.google.com%2F)
- [me 깃헙 : 라빈 카프(Rabin-Karp)알고리즘](https://doorisopen.github.io/algorithm/2019/08/03/rabinkarp.html)
- 라빈-카프 알고리즘의 아이디어는 검색어와 대상텍스트를 각각 [해시](http://wiki.hash.kr/index.php/%ED%95%B4%EC%8B%9C)값을 구해 비교하여 일치하면 비교연산을 수행하고, 그렇지 않으면 생략한다는 것이다.
- Rabin Fingerprint라는 해시함수를(H[i]) 주로 사용하는데, 문자 아스키코드 값 등에 x^n을 곱해서 더한다. 이를테면 "abcd"의 해시값은 97*8 + 98*4 + 99*2 + 100*1이다. 
![](../img/rabinKarp2.jpg)
- H[i]를 알면 H[i+1]을 알 수 있으므로, 이전 연산결과를 참조해가면서 반복되는 연산을 생략할 수 있다.
![](../img/rabinKarp.PNG)
![](../img/rabinKarp3.jpg)
```java
    public static void rabinKarpSearch(String Text, String Pattern) {
        System.out.println("RABIN-KARP");
        int textHash = 0, patternHash = 0;
        int pow = 1;
        for (int i = 0; i <= Text.length() - Pattern.length(); i++) {
            //해시테이블
            if (i == 0) {
                for (int j = 0; j < Pattern.length(); j++) {
                    textHash += Text.charAt(Text.length() - 1 - j) * pow;
                    patternHash += Pattern.charAt(Pattern.length() - 1 - j) * pow;
                    if (j < Pattern.length() - 1) pow *= 2;
                }
            } else {
                textHash = 2 * (textHash - Text.charAt(i - 1) * pow) + Text.charAt(Pattern.length() - 1 + i);
            }

            //일치하면 비교연산
            if (textHash == patternHash) {
                boolean matched = true;
                for (int j = 0; j < Pattern.length(); j++) {
                    if (Text.charAt(i + j) != Pattern.charAt(j)) {
                        matched = false;
                        break;
                    }
                }
                if (matched) System.out.println(i);
            }
        }
        System.out.println("-END-");
    }
```
- (??)Rabin Fingerprint라는 해시함수를(H[i]) 주로 사용하는데

## 크누스-모리스-프랫(KMP)
- [bowbowbow 블로그 : KMP 문자열 검색 알고리즘](https://bowbowbow.tistory.com/6)
- [코딩스낵 블로그 : 문자열 알고리즘(3) KMP 알고리즘](https://gusdnd852.tistory.com/172)
- 단순비교 알고리즘과 달리 KMP알고리즘은 먼저 비교하며 얻은 결과를, 다음 비교시 활용할 수 있다. 이를 프로그램상에서 구현하기 위해 T에 대하여 접두사면서 접미사인 문자열의 길이를 구하여 활용한다. 탐색하려는 문자열 길이로 대상텍스트에서 접두사면서 접미사인 문자열을 찾으면, 중간 과정을 건너뛰고 접두사 위치에서 접미사 위치로 건너뛸 수가 있다.
- (??)기러기, 기럭ㅣ
- (??)효과
- [유한 오토마타](http://blog.skby.net/%EC%9C%A0%ED%95%9C-%EC%98%A4%ED%86%A0%EB%A7%88%ED%83%80-fa-finite-automata/)
```java

```
