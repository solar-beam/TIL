# Managing Memory

> JAVA의 가비지 콜렉션에 대한 내용은 아래 블로그에서 발췌/요약함
>
> https://yaboong.github.io/java/2018/06/09/java-garbage-collection/
> https://yaboong.github.io/java/2018/05/26/java-memory-management/

  

[프로그래머스 길 찾기 게임 문제](https://programmers.co.kr/learn/courses/30/lessons/42892)에서 JAVA로 답안을 제출했는데 자꾸만 런타임에러가 났다. [ArrayList를 정렬](https://includestdio.tistory.com/35)할 때 Comparable을 implement하고 `Collections.sort(list)`을 사용했다. 이 코드를 `Collections.sort(list, new Comparator<Node>())`로 바꿔주니 간단히 해결됐다. 왜 틀렸는지 여러가지 고민해보았다.

- 입력은 1이상 100,000이하인 정수로 구성된, 1이상 10,000길이의 리스트
- JAVA버전 `OpenJDK 14.0.2`, 컴파일 옵션 `javac -encoding UTF-8 -g:none -Xlint:deprecation FILENAME `

- Comparable과 Comparator의 차이

| **Comparable**                                               | **Comparator**                                               |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Comparable provides compareTo() method to sort elements in Java. | Comparator provides compare() method to sort elements in Java. |
| Comparable interface is present in java.lang package.        | Comparator interface is present in java.util package.        |
| The logic of sorting must be in the same class whose object you are going to sort. | The logic of sorting should be in separate class to write different sorting based on different attributes of objects. |
| The class whose objects you want to sort must implement comparable interface. | Class, whose objects you want to sort, do not need to implement a comparator interface. |
| It provides single sorting sequences.                        | It provides multiple sorting sequences.                      |
| This method can sort the data according to the natural sorting order. | This method sorts the data according to the customized sorting order. |
| It affects the original class. i.e., actual class is altered. | It doesn't affect the original class, i.e., actual class is not altered. |
| Implemented frequently in the API by: Calendar, Wrapper classes, Date, and String. | It is implemented to sort instances of third-party classes.  |
| All wrapper classes and String class implement comparable interface. | The only implemented classes of Comparator are Collator and RuleBasedColator. |

- Use a comparable interface when the comparison is standard for the specific class.
- You can use lambdas with a comparator.
- Many core classes available in implements a comparable interface.
- It is possible to use TreeSet and TreeMap or while sorting Set or Map.
- The compareTo() method works with comparator as well as comparable.
- Use the comparator interface only when you < required more flexibility.
- The compareTo() method will return a positive integer if the first object is greater than the other, negative if it is lower, and zero if both are the same.

>  https://www.guru99.com/comparable-vs-comparator-java.html

  

## Stack
- Heap 영역에 생성된 Object 타입 데이터의 참조값(레퍼런스 변수)
- 원시타입 데이터가 값과 함께 할당된다
- 지역변수는 scope에 따른 visibility를 가짐
- 각 thread는 자신만의 stack을 가짐

  

## Heap
- 긴 생명주기를 가지는 데이터를 저장(크기가 크고, 서로 다른 코드블럭에서 공유)
- 애플리케이션의 모든 메모리 중 stack에 있는 데이터를 제외한 나머지 부분
- 모든 Objec타입이 생성된다
- thread와 무관하게 하나의 heap 영역만 가짐
- heap 영역의 Object를 가리키는 참조값(레퍼런스 변수)가 stack에 올라감

  

## Immutable Wrapper class의 생성/참조
```
public class Main {
    public static void main(String[] args) {
        String s = "hello";
        changeString(s);
        System.out.println(s);
    }
    public static void changeString(String param) {
        param += " world";
    }
}
```
위 코드에서 `main()` 메소드의 `String s`는 모든 작업이 종료된 후에도 "hello"이다. `changeString()`을 호출하며 호출된 `String param`은 레퍼런스 변수로 스택영역에 생성되며, 힙영역에 생성된 문자열 데이터 "hello"를 가리키고 있다. `Integer, Character, Byte, Boolean, Long, Double, Float, Short`와 같은 Immutable Wrapper Class의 경우 내부에 실제 값을 저장하는 `value`멤버가 있는데 `private final`로 선언되어 생성자에 의해 생성되는 순간에만 초기화되고 변경불가능한 값으로 규정되어 있다. 이에 따라 `changeString()` 메소드에서 `param`은 "hello world"라는 새로운 문자열을 힙영역에 생성하고 참조하게 된다. 또한 `param`은 스택 영역에 생성되었으므로 `changeString()` 메소드가 종료됨에 따라 스택에서 해제되고 "hello world" 문자열은 가비지콜렉터에 의해 메모리가 해제된다. 결론적으로 `main()`의 `s`는 여전히 힙 영역 내 "hello"를 가리키게 된다.

  

## Garbage Collection
위에서 힙 영역의 "hello world" 문자열은 스택 영역의 `param`이 해제됨에 따라, 스택 영역에서 도달할 수 없게 되었는데 이런 경우를 `unreachable object`라고 부른다. 그리고 자바의 JVM은 이러한 `unreachable object`를 우선적으로 메모리에서 제거하여 공간을 확보한다. 이를 mark and sweep이라고 한다.

첫번째 단계인 marking 작업을 위해 모든 스레드는 중단되는데 이를 stop the world 라고 부르기도 한다. (System.gc() 를 생각없이 호출하면 안되는 이유이기도 하다) 그리고 나서 mark 되어있지 않은 모든 오브젝트들을 힙에서 제거하는 과정이 Sweep 이다.

Garbage Collection 이라고 하면 garbage 들을 수집할 것 같지만 실제로는 garbage 를 수집하여 제거하는 것이 아니라, garbage 가 아닌 것을 따로 mark 하고 그 외의 것은 모두 지우는 것이다. 만약 힙에 garbage 만 가득하다면 제거 과정은 즉각적으로 이루어진다.

  

### Java Virtual Machine

Java는 OS 메모리 영역에 직접 접근하지 않고 JVM이라는 가상머신을 이용해 간접적으로 접근한다. 오브젝트가 필요해지지 않는 시점에서 알아서 free()를 수행하여 메모리를 확보한다. 프로그램 실행시 JVM 옵션을 주어서 OS에 요청한 사이즈 만큼의 메모리를 할당받아 실행한다. 할당받은 이상의 메모리를 사용하게 되면 에러가 나며 자동으로 프로그램이 종료된다. 그러므로 현재 프로세스에서 메모리 누수가 발생하더라도 다른 프로그램에는 영향을 주지 않으며, OS레벨에서 메모리 누수가 일어나는 일을 막을 수 있다.

Garbage Collection의 원리는 위에서 설명한 것과 같다.

  

### System.gc()

`System.gc()`를 호출하면 명시적으로 가비지 콜렉션이 일어나도록 코드를 짤 수 있지만, 모든 스레드가 중단되기 때문에 코드단에서 호출해서는 안 된다. 시험삼아 아래코드에서 `System.gc()`를 각주처리하고 그 결과를 비교해보면 수행시간이 아주 크게 차이가 난다. 모든 스레드를 중단한다는 위험성을 충분히 인지하자.

```
public class GCTimeCheck {
    public static void main(String[] args) {
        long startTime = System.nanoTime();
        System.gc(); /* Garbage Collection */
        long endTime = System.nanoTime();
        System.out.println(endTime - startTime + "ns");
    }
}
```



### Usage

#1

```
public class ListGCTest {
    public static void main(String[] args) throws Exception {
        List<Integer> li = IntStream.range(1, 100).boxed().collect(Collectors.toList());
        for (int i=1; true; i++) {
            if (i % 100 == 0) {
                Thread.sleep(100);
            }
            IntStream.range(0, 100).forEach(li::add);
        }
    }
}
```

#2

```
public class ListGCTest {
    public static void main(String[] args)throws Exception {
        List<Integer> li = IntStream.range(1, 100).boxed().collect(Collectors.toList());
        for (int i=1; true; i++) {
            if (i % 100 == 0) {
                li = new ArrayList<>();
                Thread.sleep(100);
            }
            IntStream.range(0, 100).forEach(li::add);
        }
    }
}
```

#2 코드는 100번째 인덱스마다 새로운 어레이리스트를 생성함으로써 데이터로 과포화된 기존 데이터영역을 해제하고 가비지 컬렉션을 유도, 메모리 에러 없이 프로그램을 정상 동작할 수 있도록 한다.

  

### Visual VM으로 모니터해보기

Visual GC플러그인을 설치하고 사용해보자

1. Metaspace : Permanant Generation 힙영역에 저장되었던 클래스 메타데이터가 Metaspace로 이동했으며, 그 외 Symbols은 native 힙으로 [Interned String](https://www.latera.kr/blog/2019-02-09-java-string-intern/)(문자열을 JVM내부의 해시테이블에 저장하여 호출/비교를 용이하게 하는 메서드)과 Class statics는 java 힙으로 이동했다.

2. Heap(Old, Eden, SO, S1) : Young과 Old 크게 두 영역으로 나누어지고, Young은 `Eden, Survivor Space 0, 1`로 세분화된다.

![](https://s3.ap-northeast-2.amazonaws.com/yaboong-blog-static-resources/java/java-memory-management_gc-6.png)

[http://www.waitingforcode.com/off-heap/on-heap-off-heap-storage/read](http://www.waitingforcode.com/off-heap/on-heap-off-heap-storage/read)

  

**가비지 컬렉션 프로세스**

1. 새로운 오브젝트는 Eden 영역에 할당된다. 두개의 Survivor Space 는 비워진 상태로 시작한다.
2. Eden 영역이 가득차면, MinorGC 가 발생한다.
3. MinorGC 가 발생하면, Reachable 오브젝트들은 S0 으로 옮겨진다. Unreachable 오브젝트들은 Eden 영역이 클리어 될때 함께 메모리에서 사라진다.
4. 다음 MinorGC 가 발생할때, Eden 영역에는 3번과 같은 과정이 발생한다. Unreachable 오브젝트들은 지워지고, Reachable 오브젝트들은 Survivor Space 로 이동한다. 기존에 S0 에 있었던 Reachable 오브젝트들은 S1 으로 옮겨지는데, 이때, age 값이 증가되어 옮겨진다. 살아남은 모든 오브젝트들이 S1 으로 모두 옮겨지면, S0 와 Eden 은 클리어 된다. Survivor Space 에서 Survivor Space 로의 이동은 이동할때마다 age 값이 증가한다.
5. 다음 MinorGC 가 발생하면, 4번 과정이 반복되는데, S1 이 가득차 있었으므로 S1 에서 살아남은 오브젝트들은 S0 로 옮겨지면서 Eden 과 S1 은 클리어 된다. 이때에도, age 값이 증가되어 옮겨진다. Survivor Space 에서 Survivor Space 로의 이동은 이동할때마다 age 값이 증가한다.
6. Young Generation 에서 계속해서 살아남으며 age 값이 증가하는 오브젝트들은 age 값이 특정값 이상이 되면 Old Generation 으로 옮겨지는데 이 단계를 Promotion 이라고 한다.
7. MinorGC 가 계속해서 반복되면, Promotion 작업도 꾸준히 발생하게 된다.
8. Promotion 작업이 계속해서 반복되면서 Old Generation 이 가득차게 되면 MajorGC 가 발생하게 된다.

[[Oracle\] Java Garbage Collection Basics](http://www.oracle.com/webfolder/technetwork/tutorials/obe/java/gc01/index.html)

- MinorGC : Young Generation 에서 발생하는 GC
- MajorGC : Old Generation (Tenured Space) 에서 발생하는 GC
- FullGC : Heap 전체를 clear 하는 작업 (Young/Old 공간 모두)

  

### Garbage Collector의 종류

- Serial GC : gc작업시 힙영역 시작점으로 데이터를 옮겨놓음
- Parallel GC : 다중 스레드로 gc작업을 하나, 싱글코어인 경우 Serial GC를 수행
- Concurrent Mark Sweep (CMS) Collector : 애플리케이션 스레드와 동시에 수행함으로써 stop-the-world 시간을 최소화함. young generation에 대해서는 Parallel GC를 수행하여 메모리 파편화가 문제될 수 있는데 그 경우 더 큰 힙사이즈를 할당한다.
- G1 Garbage Collector : 장기적으로 CMS를 대체하기 위한 것으로 작동방식이 다른 GC와는 상이하니 자세한 내용은  [[Oracle\] Getting Started with the G1 Garbage Collector](http://www.oracle.com/technetwork/tutorials/tutorials-1876574.html) 를 참조 

  

> 더알아보기 : Android 앱 메모리 최적화 https://d2.naver.com/helloworld/539525
