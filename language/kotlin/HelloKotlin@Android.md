# Hello Kotlin at Android

> Android에서 Kotlin시작하기 : https://developer.android.com/kotlin/get-started?hl=ko

- [Kotlin언어 배우기](https://developer.android.com/kotlin/learn?hl=ko) :  Kotlin 기본사항에 관한 30분 단기 집중 과정
- [Kotlin 샘플](https://developer.android.com/samples?language=kotlin&hl=ko) : Kotlin으로 작성된 샘플 Android 앱의 대규모 라이브러리
- [Kotlin 리소스](https://developer.android.com/kotlin/resources?hl=ko) : 샘플, Codelab, 동영상, 도서 등 Kotlin의 모든 것에 관한 선별된 리소스 세트

- 기존 앱에 Kotlin추가하기 가이드 :  안드로이드 스튜디오에는 Java-Kotlin 코드 변환기가 포함됨
  1. Kotlin으로 테스트 코드를 작성하고, 회귀 테스팅을 수행. 테스트는 패키징 중 앱에 번들로 묶이지 않으므로 테스트로 Kotlin을 코드에 추가하는 좋은 시작점.
  2. Kotlin으로 새 코드를 작성. 작은 클래스 또는 toplevel utility 기능으로 시작하고 관련 주석을 추가하여 적절한 상호운용성을 보장하자.
  3. 기존 코드를 Kotlin으로 업데이트. 익숙해지면 기존 자바 코드를 변환. 일부 기능을 추출하여 변환해보자.

> software regression : 휘귀 테스팅은, 이전에 발생한 버그를 누적하여 테스트하는 것을 가리킨다. 코드 리팩토링이나, 잦은 코드수정으로 이전에 고쳤던 버그가 재발하는 경우를 막기 위해서다. 너무 많은 테스트케이스가 누적되지 않도록 우선순위를 골라 수행하기도 한다.

- 코드 최소화보다 가독성이 중요하며, 불필요한 kotlin코드를 과도하게 사용하지 않도록 주의
- 팀작업에 가장 적합한 코딩규칙과 관용구를 확립하는 것이 좋다

*예시) [Android KTX](https://blog.yena.io/studynote/2019/12/26/Android-Kotlin-ClickListener.html)를 이용해 뷰 중복 클릭 방지하기*

  

## Developing Android Apps with Kotlin - Udacity

### lamda

`setOnClickListener`  in java

```java
public void setOnClickListener(OnClickListener l){
	...
}
```

in kotlin, 익명 클래스를 선언하지 않아도 되고, UI 컴포넌트를 간단하게 초기화할 수 있다.

```kotlin
fun setOnClickListener(l: (View) -> Unit)
```

익명 클래스를 생성해야 한다면 원래는 이렇게 작성해야 하지만,

```kotlin
view.setOnClickListener(object : View.OnClickListener {
	override fun onClick(v: View?){
		...
	}
})
```

편집기에 알림 문구가 뜨고 아래와 같이 바꿀 수 있다.

```kotlin
view.setOnClickListener({ v -> toast("Hello") })
```

마지막 매개인자가 '함수'인 경우, 중괄호 밖으로 뺄 수 있다. 두 개 이상인 경우 마지막 것만 빼내고, 나머지는 중괄호 안에 남겨야 한다.

```kotlin
view.setOnClickListener() { v -> toast("Hello") }
```

'함수' 하나만 매개인자로 받는다면 빈 소괄호를 없앨 수 있다.

```kotlin
view.setOnClickListener { v -> toast("Hello")}
```

매개인자가 하나이고, 람다 매개인자 `v`를 사용하지 않는다면 생략할 수 있다.

```kotlin
view.setOnClickListener { toast("Hello") }
```

매개인자를 받아서 넘겨주기만 한다면, 좌항의 `v ->` 대신 `it` 키워드를 사용할 수 있다.

```kotlin
view.setOnClickListener { v -> dosomething(v) } //before
view.setOnClickListener { dosomething(it) }     //after
```

자 이제, 타이핑도 훨씬 적게 하는데다 가독성도 더 좋아졌다.

REFFERED TO [How lambdas work in Kotlin. setOnClickListener transformation (KAD 18) (antonioleiva.com)](https://antonioleiva.com/lambdas-kotlin-android/)

  

### lateinit

컴포넌트 생애주기에 맞게 변수의 초기화를 미뤄야할 때가 있다. 이를테면 View에서 Rest API로 받아온 데이터를 표시하는 경우, Rest API가 호출되는 시점에 View를 초기화하면 된다. 

- Late initialization : 필요할 때 초기화하고 사용. 초기화하지 않고 쓰면 Exception 발생.

- Lazy initiation : 변수를 선언할 때 초기화 코드도 함께 정의. 변수가 사용될 때 동작함.

#### Late initialization

```kotlin
class Rectangle {
    lateinit var area: Area
    fun initArea(param: Area): Unit {
        this.area = param
    }
}

class Area(val value: Int)

fun main() {
    val rectangle = Rectangle()
    rectangle.initArea(Area(10))
    println(rectangle.area.value)
}
```

area 변수는 nullable이 아니었기 때문에 `lateinit` 식별자가 없었다면 에러가 발생합니다. initArea 함수를 호출하지 않고 area 변수에 접근하면 `UninitializedPropertyAccessException`가 발생합니다. java로 디컴파일하면 해당 변수가 null일 때 예외를 발생시키는 코드가 나옵니다(`if(variable == null) throw Intrinsics.throwUninitializedPropertyAccessException("[className]") `)

```kotlin
fun main() {
    val rectangle = Rectangle()
    rectangle.initArea(Area(10))
    if(::Rectangle.isInitialized){
     	//do something   
    }
    println(rectangle.area.value)
}
```

kotlin 1.2부터는 초기화여부를 미리 확인할 수 있습니다. `::`을 통해서만 접근 가능한 `.isInitialized`를 체크합니다. 해당기능은 Higher-Order function과 koltin extenstions을 통해 구현되어 있습니다.

#### Lazy initialization

```kotlin
class Account() {
    val balance : Int by lazy {
        println("Setting balance!")
        100
    }
}

fun main() {
    val account = Account()
    println(account.balance)
    println(account.balance)
}
```

balance 변수는 두번째 출력할 때도 100입니다. 변수에 처음 접근할 때만 초기화코드가 작동하기 때문입니다.

```java
public final class Account {
   @NotNull
   private final Lazy balance$delegate;

   public Account() {
      this.balance$delegate = LazyKt.lazy((Function0)null.INSTANCE);
   }

   public final int getBalance() {
      Lazy var1 = this.balance$delegate;
      return ((Number)var1.getValue()).intValue();
   }
}

public static final void main() {
   Account account = new Account();
   int var1 = account.getBalance();
   System.out.println(var1);
   var1 = account.getBalance();
   System.out.println(var1);
}
```

위의 코틀린 코드를 자바로 디컴파일한 결과입니다. getBalance()가 처음 호출될때 초기화 코드가 동작합니다.

```kotlin
val temp: String by lazy(옵션) {
	//...
}
```

lazy는 위와 같이 Synchronized 옵션으로 thread-safety를 보장합니다. 디폴트는 `SYNCHRONIZED`입니다.

- `SYNCHRONIZED` : 오직 하나의 스레드만 [Lazy] 인스턴스를 초기화 코드를 호출할 수 있습니다.
- `PUBLICATION` : 초기화되지 않은 [Lazy] 인스턴스에 여러 번, 동시에 초기화 코드를 호출할 수 있습니다. 다만, 가장 처음 리턴한 값만 [Lazy] 인스턴스값으로 사용합니다.
- `NONE` : [Lazy] 인스턴스 초기화 코드에 접근할 때 아무런 제약이 없습니다. 여러 스레드에서 호출할 때 어떻게 동작할지 정해진 바 없습니다. 한 스레드에서만 [Lazy] 인스턴스를 호출하는 것이 확실할 때만 사용해야 합니다.

#### lateinit vs lazy

비슷해 보이지민 차이점이 있습니다.

- lazy는 val 프로퍼티에만 사용할 수 있지만, lateinit은 var에만 사용할 수 있습니다
- 그렇기 때문에 lateinit은 immutable(불변) 프로퍼티가 아닙니다.
- lateinit은 nullable 또는 primitive type의 프로퍼티를 사용할 수 없습니다. 반면에 lazy는 모두 가능합니다.
- lateinit은 직접적으로 프로퍼티를 갖고 있는 구조지만(자바에서 field를 갖고 있음), lazy는 Lazy라는 객체 안에 우리가 선언한 field를 갖고 있습니다. 그래서 lazy의 프로퍼티를 직접 변경할 수 없습니다.

REFFERED TO

[Kotlin - lateinit과 lazy로 초기화를 지연하는 방법 (codechacha.com)](https://codechacha.com/ko/kotlin-late-init/)
[Kotlin lazy property - lateinit/lazy 살펴보기 (thdev.tech)](https://thdev.tech/kotlin/2018/03/25/Kotlin-lateinit-lazy/)

