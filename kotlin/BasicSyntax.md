# Kotlin Basic Syntax
> 일단 해보자. [Kotlin language specificaion_full](https://kotlin.github.io/kotlin-spec/)

- Kotlin은 Google I/O 2017에서 안드로이드의 공식 개발 언어로 채택되었으며, I/O 2019에서 Kotlin을 최우선으로 사용하겠다는 **Kotlin First**를 선언한 바 있다.
- Kotlin은 JetBrains에서 2011년에 공개한 언어로 JVM에서 구동되며 JAVA와 호환가능하게끔 만들었다. JAVA를 완전히 대체할 수 있는 언어를 목표로 한다. Kotlin은 정적타입지정(+타입추론) 언어이며, 함수형/객체지향 프로그래밍 패러다임을 따르고, 오픈소스이며 무료이다. 웹/안드로이드/서버측 등 JVM이 구동가능한 모든 환경에 응용가능하다.

## Basic Syntax
### Package definition and imports
패키지 명세는 소스파일 가장 위에 기술한다.
```
package my.demo
import kotlin.text.*
import kotlin.is.wonderful
import solarbeam.is.wonderful as beautiful
// ...
```
디렉토리와 패키지명을 맞출 필요는 없다. 다만, 패키지를 기술하지 않으면 이름없는 디폴트 패키지에 포함된다. `import`할 때 이름이 충돌하면 `as`키워드로 이름을 바꿔줄 수 있다. `import`키워드는 class, top-level functions and properties, functions and properties declared in object declarations, enum contants에 적용할 수 있다.
>NOTE : top-level functions, [object delcarations](https://kotlinlang.org/docs/reference/object-declarations.html#object-declarations), [enum constants](https://kotlinlang.org/docs/reference/enum-classes.html), [visibility modifiers](https://kotlinlang.org/docs/reference/visibility-modifiers.html)

### Program entry point
프로그램 진입점은 `main`함수다.
```
fun main(){
	println("Hello world!")
}
```

### Functions
매개변수가 `Int` 두 개이고, 리턴타입도 `Int`인 함수
```
fun sum(a : Int, b : Int): Int {
	return a + b
}
```
리턴타입을 추론하고 expression body를 가지는 함수
```
fun sum(a : Int, b : Int) = a + b
```
의미없는 값을 반환하는 함수
```
fun printSum(a : Int, b : Int): Unit{
	println("sum of $a and $b is ${a+b})
}
```
`Unit` 리턴타입은 생략 가능하다
```
fun printSum(a : Int, b : Int) {
	println("sum of $a and $b is ${a+b})
}
```

함수인자는 묵시적으로 const, final

### Variables

`val`키워드로 읽을 수만 있는 지역변수를 정의할 수 있다. 할당은 한번만 할 수 있다.
```
val a: Int = 1
val b = 2 //타입추론
val c: Int  //변수할당을 바로 안하고 나중에 해도된다(컴파일러 설정에 따라 다르다)
c = 3
```
`var`키워드는 변경할 수 있다.
```
var x = 5
x += 1
```
변수범위
```
val PI = 3.14
var x = 0

fun incrementX(){
	x += 1
}
```

### Comments
주석처리는 이렇게 할 수 있다.
```
//end-of-line 주석이라 부른다
/*블럭코멘트라 부른다*/

/*코멘트는 여기서 시작하는데
/*중간에 겹쳐서 쓸수도 있고*/
코멘트는 여기서 끝난다*/
```

### String templates
```
var a = 1
var s1 = "a is $a"
a = 2
val s2 = "${s1.replace("is", "was")}, but now is $a"
```

`${}`내부에는 표현식만 들어갈 수 있는데, 할당은 안되지만 함수호출은 가능하다

### Conditional expressions

```
fun maxOf(a: Int, b: Int): Int{
	if(a>b) return a
	else return b
}
```
Kotlin에서는 if문도 표현식이다.
```
fun maxOf(a: Int, b: Int) = if(a>b) a else b
```

### Nullable values and null checks
null이 될 수 있는 변수는 반드시 nullable로 표시해준다.  
`str`을 파싱할때 정수값이 없다면 null을 반환한다. 그래서 리턴값에 nullable표시를 해준다.

```
fun parseInt(str: String): Int?{
	//...
}
```
null check한 다음에는 non-nullable로 캐스팅한다
```
fun printProduct(arg1: String, arg2: String){
	val x = parseInt(arg1)
	val y = parseInt(arg2)
	if(x!=null && y!=null){ // yields null error ('항복한다'와 같은의미로 '손을들다')
		println(x*y)   // after null checking, automaically casted to non-nullable 
	}
	else{
		println("'$arg1' of '$arg2' is not a number")
	}
}
```
> NOTE : Kotlin의 꽃, [Null-safety](https://kotlinlang.org/docs/reference/null-safety.html)

### Type checks and automatic casts
`is`연산자로 주어진 표현식이 특정 타입의 인스턴스인지 확인한다.  
변경할수 없는 지역변수나 프로퍼티의 타입이 식별되면, 명시적으로 형변환할 필요가 없다.
```
fun getStringLength(obj: Any): Int?{
	if(obj is String){
	//obj 타입체크가 끝나서, String으로 캐스팅되었다.
		return obj.length
	}
	//타입체크 브랜치(스코프) 밖에서는 아직 'any'타입이다.
	return null
}
```
또는
```
fun getStringLength(obj: Any): Int?{
	if(obj !is String) return nul
	//obj는 String으로 캐스팅되었다
	return obj.length
}
```
더 나아가
```
fun getStringLength(Obj: Any): Int?{
	//obj는 오른쪽 &&에 가서 String으로 캐스팅된다
	if(obj is String && obj.length>0) return obj.length
	return null
}
```

### for loop
```
val items = listOf("apple", "banana", "kiwifruit")
for (item in items) println(item)
```
또는
```
val items = listOf("apple", "banana", "kiwifruit")
for (index in items.indices) println("item at $index is ${items[index]}")
```

### while loop
```
val items = listOf("apple", "banana", "kiwifruit")
var index = 0
while (index < items.size) {
    println("item at $index is ${items[index]}")
    index++
}
```
또는
```
do {
    val y = retrieveData()
} while (y != null) // y는 여기서도 유효하다
```

### when expression
```
fun describe(obj:Any): String = 
    when(obj){
		1		-> "One"
		"Hello" -> "Greeting"
		is Long -> "Long"
		!is String -> "Not a string"
		else	-> "Unknown"
	}
```
Kotlin 1.3부터는 when절 내부에 val변수할당 표현식을 사용할 수 있고, 해당 변수는 when내부에서만 유효하다.

### Returns and Jumps
- 다음 키워드는 표현식의 어디에서도 쓰일 수 있다.
  - **return** 키워드를 둘러싼, 가장 가까운 함수/익명함수로 돌아간다
  - **break** 키워드를 둘러싼, 가장 가까운 반복문을 정지한다
  - **continue** 키워드를 둘러싼, 가장 가까운 반복문의 다음 단계로 진행한다
- 라벨링을 통해 '가장 가까운'을 '라벨링한'으로 바꿔 동작한다.
```
loop@ for(i in 1..100){
    for(j in 1..100){
         if( ... ) break@loop
    }
}
```
> NOTE : Return에 라벨 붙이는 건 다음에 araboza.[Return at Lables](https://kotlinlang.org/docs/reference/returns.html#return-at-labels) 인라인 익명 람다식에서 리턴값을 내부의 지역함수로 보낼 수 있다. 호출한 함수와 같은 이름으로 라벨링해도 된다. 마치 반복문의 continue처럼. 혹은 바깥으로 빼서 break처럼 쓸 수도 있다.

### Ranges
(포함여부)`in` 연산자로 수가 주어진 범위에 포함되는지 확인한다.
```
val x = 10
val y = 9
if (x in 1..y+1) {
    println("fits in range")
}
```
범위에 포함되지 않는지 확인하는 것도 가능하다.
```
val list = listOf("a", "b", "c")

if (-1 !in 0..list.lastIndex) {
    println("-1 is out of range")
}
if (list.size !in list.indices) {
    println("list size is out of valid list indices range, too")
}
```
(순회)주어진 범위를 순회할 수도 있다.
```
for(x in 1..5){
    print(x)
}
```
증가시키면서 범위순회
```
for(x in 1..10 step 2){
    print(x)
}
println()
for(x in 9 downTo 0 step 3){
	print(x)
}
```

### Collections
콜렉션 순회하기
```
for(item in items) println(item)
```
`in`연산자로 콜렉션이 어떤 객체를 포함하는지 확인하기
```
when{
    "orange" in items -> println("juicy")
	"apple" in items -> println("apple is fine too")
}
```
람다식으로 맵콜렉션을 필터링할 수 있다.
```
val fruits = listOf("banana", "avocado", "apple", "kiwifruit")
fruits
	.filter{it.startsWith("a")}
	.sortedBy{it}
	.map{it.toUpperCase()}
	.forEach{println(it)}
```

> NOTE: 람다식이란, 별도로 이름을 붙여 정의하거나 변수에 대입하지 않고 함수 호출/반환시 상수 표현식으로 작성한 함수이다. 함수().체인1().체인2()와 같이 작성할 수 있다. 오류발생시 함수콜스택을 추적하기 어려워진다는 문제가 있다.  

> NOTE: 고차함수란, 프로그래밍 언어에서 함수를 구현할 때 함수를 인자로 넘길 수 있거나 반환할 수 있을 때, 함수를 일급객체(언어 내부에서 값으로 표현되고 전달할 수 있는 자료형)으로 취급한다 하고, 그 함수를 고차함수라 부른다. 고차함수가 아닌 것은 일차함수라고 부른다.  

> NOTE: `it`키워드는, 다음에 araboza.[kotlin과 람다](https://tourspace.tistory.com/110), [JS에서 ->함수](https://hacks.mozilla.org/2015/06/es6-in-depth-arrow-functions/)

### Creating basic classes and their instances
```
val rectangle = Rectangle(5.0, 2.0)
val triangle = Triangle(3.0, 4.0, 5.0)
```

## Idioms
Kotlin관용어 중에서 임의로 몇 가지를 추려보았다. 아울러 자주 사용되는 관용어도 기술한다.

### Creating DTOs(POJOs/POCOs)
```
data class Customer(val name: String, val email:String)
```
- 다음 기능을 자동으로 제공한다.
  - getter(var형식이면 setter도)
  - `equals()`
  - `hashcCode()`
  - `toString()`
  - `copy()`
  - `component1()`, `component2()`, ...
> NOTE: DAO는 DataAccessObject로서, 실제로 DB에 접근하는 객체이다. DTO는 DataTransferObject로서 계층간 데이터교환을 위한 객체다. EntityClass는 실제 DB 테이블과 매칭할 클래스이다.

> NOTE: POJO는 PlainOldJavaObject, POCO는 PlainOldCLRObject. 프레임워크에 종속되지 않은 순수 자바객체를 가리킨다. 사실 큰 의미없다. 그런데 getter/setter를 제외한 메소드를 가지지 않고, 값으로만 정의되는 객체를 말하기도 한다.

### Default values for function parameters
```
fun foo(a: Int = 0, b: String = "") { ... }
```

### Filtering a list
```
val positives = list.filter { x -> x > 0 }
val positives = list.filter { it > 0 }
```

### Checking element presence in a collection
```
if ("john@example.com" in emailsList) { ... }
if ("jane@example.com" !in emailsList) { ... }
```

### String interpolation
```
println("Name $name")
```

### Instance Checks
```
when (x) {
    is Foo -> ...
    is Bar -> ...
    else   -> ...
}
```

### Traversing a map/list of pairs
```
for((k,v) in map) println("$k->$v")
```
`k`,`v`는 임의의 식별자

### Using ranges
```
for(i in 1..100) { ... } //closed range : 1이상 100이하
for(i in 1 until 100) { ... } //half-open : 1이상 100미만
for(x in 2..10 step 2) { ... }
for(x in 10 downTo 1) { ... }
if(x in 1..10) { ... }
```

### Read-only list
Kotlin의 콜렉션은 변경가능한 것과 그렇지 않은 것을 구분하여 사용한다. List는 기본적으로 변경불가하며, 생성자에 길이와 초기화 람다식을 넣어 생성한다.
```
val list: List<Int> = List(5, {i->i})
```
또는
```
val list = listOf("a", "b", "c")
```
변경가능한 리스트는 MutableList또는 ArrayList클래스를 이용한다. 생성자를 이용할 수도 있고, mutableListOf()같이 함수로 초기화할 수도 있다.  

요약하면  

| 콜렉션 | Immutable | Mutable |
| --------- | --------- | --------- |
| List | listOf | mutableListOf, arrayListOf |
| Set | setOf | mutableSetOf, hashSetOf, linkedSetOf, sortedSetOf |
| Map | mapOf | mutableMapOf, hashMapOf, linkedMapOf, sortedMapOf |

>REF : [Collections - List, Set, Map](https://m.blog.naver.com/PostView.nhn?blogId=yuyyulee&logNo=221237499417&proxyReferer=https%3A%2F%2Fwww.google.com%2F)

### Read-only map
```
val map = mapOf("a" to 1, "b" to 2, "c" to 3)
```

### Accessing a map
```
println(map["key"])
map["key"] = value
```

### Lazy property

`val`은 선언과 동시에 값을 가져야하는데, 아래와 같이 객체가 고유 수명주기를 가지는 경우 초기화 시점을 특정할 수 없는 문제가 생긴다.

```
class MainActivity : AppCompatActivity() {
    private val mWelcomeTextView: TextView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        // 다음 초기화 코드는 어디에?????
        // mWelcomeTextView = findViewById(R.id.msgView) as TextView
    }
}
```
이때 `by lazy`키워드를 통해 초기화를 지연할 수 있으며, 중괄호 안의 코드는 프로퍼티를 처음으로 참조하는 시점에 수행한다.
```
class MainActivity : AppCompatActivity() {
    private val messageView : TextView by lazy {
        // messageView의 첫 액세스에서 실행됩니다
        findViewById(R.id.message_view) as TextView
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }
    fun onSayHello() {
        messageView.text = "Hello"
    }
}
```

>NOTE: lateinit키워드로 non-null 프로퍼티가 생성자 시점에 null이어도 정상 컴파일 되도록 강제할 수 있다.  

>NOTE: 세부내용은 다음 링크를 참조,[by lazy는 어떻게 동작하는가](https://medium.com/til-kotlin-ko/kotlin-delegated-property-by-lazy%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EB%8F%99%EC%9E%91%ED%95%98%EB%8A%94%EA%B0%80-74912d3e9c56)

### Extension Functions
```
fun String.spaceToCamelCase(): Unit = { ... }
//반환값이 없으면 등호는 생략할 수 있다

"Convert this to camelcase".spaceToCamelCase()
```

### Creating singleton
```
object Resource{
    val name = "Name"
}
```

### If not null shorthand
NullSafety참조, safe call
```
val files = File("Test").listFiles()
println(files?.size)
//files가 null이 아니면 size참조
```

### If not null else shorthand
이른바 Elvis idiom되시겠다.
```
val files = File("Test").listFiles()
println(files?.size ?: "empty")
//files.size가 null이라면 "empty"
```
### Executing a statement if null
Elvis idiom으로 예외를 던질수도 있다.
```
val values = ...
val email = values["email"] ?: throw IllegalStateException("Email is missing")
```

### Get first item of a possibly empty collection
```
val emails = ... 
val mainEmail = emails.firstOrNull() ?: ""
```

### Execute if not null
```
val value = ...
value?.let {

}
```
let함수는 호출하는 객체를 블록의 인자로 넘기고 결과값을 반환한다. 블록(람다식) 인자가 하나일 경우 이름을 생략하고 `it`을 사용할 수 있다. safe call `?.`과 함께 사용해 `if(null!=obj) ...`을 대체할 수 있다.

>REF : [코틀린의 유용한 함수들 let, apply, run, with](https://www.androidhuman.com/lecture/kotlin/2016/07/06/kotlin_let_apply_run_with/)

### Map nullable value if not null
```
val value = ...

val mapped = value?.let { transformValue(it) } ?: defaultValue 
// defaultValue is returned if the value or the transform result is null.
```
위에서 언급했듯 let은 호출하는 객체를 블록의 인자로 넘긴다. 여기서는 value가 람다식 인자로 넘겨졌다. 그런데 인자가 하나이므로 이름을 생략하고 it으로 표시했다.

### Return on when expression
표현식을 반환할 수 있다(결과값이 있으니까)
```
fun transform(color: String): Int {
    return when (color) {
        "Red" -> 0
        "Green" -> 1
        "Blue" -> 2
        else -> throw IllegalArgumentException("Invalid color param value")
    }
}
```

### try/catch expression
표현식으로 할당할 수 있다(결과값이 있으니까)
```
fun test(){
    val result = try {
        count()
    } catch (e: ArithmeticException) {
        throw IllegalStateException(e)
    }

    // Working with result
}
```

### if expression
```
fun foo(param: Int) {
    val result = if (param == 1) {
        "one"
    } else if (param == 2) {
        "two"
    } else {
        "three"
    }
}
```

### Builder-style usage of methods that return Unit
```
fun arrayOfMinusOnes(size: Int): IntArray {
    return IntArray(size).apply { fill(-1) }
}
```
`apply()`는 호출한 객체를 블록의 *리시버*로 전달하고 객체 자체를 반환한다. 리시버란 블록 내 메서드 및 속성에 바로 접근할 수 있도록 할 객체이다. 아래와 같이 객체 초기화할 때 쓸 수 있다. 객체생성과 연속된 작업필요시.

```
val param = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT).apply {
    gravity = Gravity.CENTER_HORIZONTAL
    weight = 1f
    topMargin = 100
    bottomMargin = 100
}
```
> NOTE: run은 호출한 객체를 블록의 리시버로 전달하고 블록의 결과값을 반환한다. 이미 생성된 객체에 대하여 연속된 작업이 필요할 때 사용한다.  

> NOTE: with은 인자로 받는 객체를 블록의 리시버로 전달하며 블록의 결과값을 반환한다. run은 객체.run이고 with은 with(객체)이다. 리시버로 전달할 객체 위치가 다르다.

| 구분 |         let          |           apply           | run(anonymous)  |        run(object)        |            with             |
| :--: | :------------------: | :-----------------------: | :-------------: | :-----------------------: | :-------------------------: |
|  IN  | 호출한 객체를 인자로 |  호출한 객체를 리시버로   |    객체 없이    |  호출한 객체를 리시버로   | 인자로 받은 객체를 리시버로 |
| OUT  |    블록의 결과값     |         객체 자체         | Unit또는 결과값 |       블록의 결과값       |        블록의 결과값        |
| WHEN |                      | 새로운 객체로 연속된 작업 |                 | 생성된 객체로 연속된 작업 |       safe call미지원       |

### Single-expression function
```
fun theAnswer() = 42
```
아래와 같은 코드다.
```
fun theAnswer(): Int{
  return 42
}
```
다른 관용구와 함께 쓸 수 있다.
```
fun transform(color: String): Int = when (color) {
    "Red" -> 0
    "Green" -> 1
    "Blue" -> 2
    else -> throw IllegalArgumentException("Invalid color param value")
}
```

### Calling multiple methods on an object instance(with)
객체를 리시버로 전달하여 결과값을 반환한다. 객체는 괄호안.
```
class Turtle {
    fun penDown()
    fun penUp()
    fun turn(degrees: Double)
    fun forward(pixels: Double)
}

val myTurtle = Turtle()
with(myTurtle) { //draw a 100 pix square
    penDown()
    for(i in 1..4) {
        forward(100.0)
        turn(90.0)
    }
    penUp()
}
```

### Configuring properties of an object(apply)
호출한 객체를 리시버로 전달하여 결과값을 반환한다.
```
val myRectangle = Rectangle().apply {
    length = 4
    breadth = 5
    color = 0xFAFAFA
}
```

### Java 7's try with resources
`use`메소드는 이하 블럭에서 예외발생과 관계없이 리소스를 사용하고 다시 닫으라는 뜻이다.
```
val stream = Files.newInputStream(Paths.get("/some/file.txt"))
stream.buffered().reader().use { reader ->
    println(reader.readText())
}
```

### Convenient form for a generic function that requires the generic type information
```
//  public final class Gson {
//     ...
//     public <T> T fromJson(JsonElement json, Class<T> classOfT) throws JsonSyntaxException {
//     ...

inline fun <reified T: Any> Gson.fromJson(json: JsonElement): T = this.fromJson(json, T::class.java)
```
### Consuming a nullable Boolean
```
val b: Boolean? = ...
if (b == true) {
    ...
} else {
    // `b` is false or null
}
```
### Swapping two variables
```
var a = 1
var b = 2
a = b.also { b = a }
```
### TODO(): Marking code as incomplete
```
fun calcTaxes(): BigDecimal = TODO("Waiting for feedback from accounting")
```
Kotlin표준 라이브러리에는 `todo()`함수가 있다. 언제나 `NotImplementedError` 예외를 던진다. 리턴타입은 `Nothing`인데 그래서 어디든 기대되는 타입과 무관하게 쓸 수 있다. 구현안된 이유를 인자로 넘기는 식으로 오버로딩도 가능하다. 인텔리J에서는 `todo()`를 자동으로 인식해 `TODO`창에서 볼 수 있다.

## Coding Conventions
이 스타일 가이드대로 포맷팅하려면 IntelliJ에서 Kotlin플러그인 1.2.20이상을 설치하고 Settings-Editor-CodeStyle-Kotlin에서 Set From...링크로 들어간다. PredefinedStyle-KotlinStyleGuide를 선택한다.  

스타일 가이드를 만족하는지 확인하려면 inspectionSetting메뉴에서 Kotlin-Styleissues-File is not formatted according to project settings를 선택한다.  

`Ctrl+Alt+L`누르면 잘 다듬어준다.

이하 번역은 다음 문서를 참조하라
- [ko, Kotlin coding convention](https://github.com/AgustaRC/Dev-Log/blob/master/%5BKotlin%5D%20Coding%20Conventions.md)
- [간추린 Kotlin coding convention](https://medium.com/@joongwon/kotlin-%EC%BD%94%EB%94%A9-%EC%BB%A8%EB%B2%A4%EC%85%98-%EC%A0%95%EB%A6%AC-7681cde920ce)

- tab대신 4spaces
- camelCase
- 중괄호는 그 구조가 시작되는 줄 끝에서 연다.
- 클래스 헤더가 길 경우 중괄호를 그 다음줄에서 연다.
- 제어자를 여러 개 기술할 때는 다음 순서를 따른다. 어노테이션은 제어자 앞.
```
public / protected / private / internal
expect / actual
final / open / abstract / sealed / const
external
override
lateinit
tailrec
vararg
suspend
inner
enum / annotation
companion
inline
infix
operator
data
```
- 여러줄에 걸쳐 체이닝 호출할 때 `.`과 `?.`는 개행처리한다.
- 컬렉션 인스턴스는 가급적 immutable 타입으로 생성하라.
- 범위지정시 1..9보다 1 until 10을 써라
- 라이브러리 작성할 때 API안전성을 보장하기 위해 멤버가시성을 명시적으로 지정하고, 함수의 반환타입/속성타입을 명시적으로 지정하고, 모든 public멤버에 대한 주석을 제공하여 문서생성을 지원한다.  

## 더 공부가 필요한 주제

- #? typealias
- #? lamda : pram, return
- #? Nullable Boolean
- #? function & property
- #? extension function
- #? infix function
- #? factory function

## Lexical grammar
- documenation : `/** */`으로 마크다운/javadoc형식 문서를 작성할 수 있다
- Identifiers : `(Letter | '_') {Letter | '_' | UnicodeDigit}*` 또는 Backtik 안에 `<any character excluding CR, LF and '(backtik)'> {<any character excluding CR, LF and '(backtik)'>}`
- Tokens : 공백, 주석, 예약어, 연산자, 리터럴, 문자열
  - Whitespace(WS) and comment : 공백과 주석
  - Keywords and operators : 예약어와 연산자
    - keys : *return, continue, break, this, super, file, field, property, get, set, setparam, delegate, package, import, class, interface, fun, object, val, var, typealias, constructor, by, companion, init, typeof, where, if, else, when, try, catch, finally, for, do, while, throw, as, is, in, !is, !in, out, dynamic, public, private, protected, internal, enum, sealed, annotation, data, inner, tailrec, operator, inline, infix, external, suspend, override, abstract, final, open, const, lateinit, varag, noinline, crossinline, reified, expect, actual 등*
  - Literals : 10진수/8진수/16진수/2진수, double/float/integer/real/exponent, boolean, null, character, unicode character, escapedIdentifier(t/b/r/n/'/"/\/$)
  - String : 큰따옴표 하나는 일반문자열, 큰따옴표 세개짜리는 이스케이핑 없이 문자열을 그대로 보여줄 수 있다. `"""C:\Repository\read.me"""`
- statement and expression
  - statement :  수행할 작업을 나타내는 명령형 프로그래밍 언어에서, 가장 작은 독립 실행 요소이다.
  - expression : 프로그래밍 언어가 다른 값을 산출하기 위해 해석하고 계산하는 하나 이상의 명시적 값, 상수, 변수, 연산자 및 함수의 조합이다. 변수선언/할당, 지역 클래스 선언은 표현식이 아니다.
  - 모든 Kotlin함수는 적어도 `unit`을 반환하기 때문에 표현식이다. 리턴유형을 지정하지 않은 java함수 호출은 표현식이 아니다. Kotlin 값 할당은 표현식이 아니나, java는 할당된 값을 반환하기 때문에 표현식이다. java에서 제어구조(if, switch)의 모든 용도는 표현식이 아니지만, kotlin은 값을 반환하는 것을 허용하므로 표현식이다.
    - 그런데 Kotlin 1.3부터는 when절 내부에 val 변수할당 표현식을 사용할 수 있고, 해당 변수는 when내부에서만 유효하다.