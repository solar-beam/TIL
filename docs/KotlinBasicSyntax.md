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
fun printSum(a : Int, b : Int): Unit{
	println("sum of $a and $b is ${a+b})
}
```

### Variables
`val`키워드로 읽을 수만 있는 지역변수를 정의할 수 있다. 할당은 한번만 할 수 있다.
```
val a: Int = 1
val b = 2 //타입추론
val c: Int  //변수할당을 바로 안하고 나중에 해도된다
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
nullable변수를 반환하는 함수
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
`is`연산자로 주어진 표현식이 특정 타입의 인스턴스인지 확인한다. 변경할수 없는 지역변수나 프로퍼티의 타입을 구별할 수 있으며느 명시적으로 형변환할 필요가 없어진
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
//TODO https://kotlinlang.org/docs/reference/idioms.html

## Coding Conventions
//TODO https://kotlinlang.org/docs/reference/coding-conventions.html

## Lexical grammar
- documenation : `/** */`으로 마크다운/javadoc형식 문서를 작성할 수 있다
- Identifiers : `(Letter | '_') {Letter | '_' | UnicodeDigit}*` 또는 `'\`'<any character excluding CR, LF and '`'> {<any character excluding CR, LF and '\`'>}`
- Tokens : 공백, 주석, 예약어, 연산자, 리터럴, 문자열
  - Whitespace(WS) and comment : 공백과 주석
  - Keywords and operators : 예약어와 연산자
    - keys : return, continue, break, this, super, file, field, property, get, set, setparam, delegate, package, import, class, interface, fun, object, val, var, typealias, constructor, by, companion, init, typeof, where, if, else, when, try, catch, finally, for, do, while, throw, as, is, in, !is, !in, out, dynamic, public, private, protected, internal, enum, sealed, annotation, data, inner, tailrec, operator, inline, infix, external, suspend, override, abstract, final, open, const, lateinit, varag, noinline, crossinline, reified, expect, actual 등
  - Literals : 10진수/8진수/16진수/2진수, double/float/integer/real/exponent, boolean, null, character, unicode character, escapedIdentifier(t/b/r/n/'/"/\/$)
  - String : 큰따옴표 하나는 일반문자열, 큰따옴표 세개짜리는 이스케이핑 없이 문자열을 그대로 보여줄 수 있다. `"""C:\Repository\read.me"""`
- statement and expression
  - statement :  수행할 작업을 나타내는 명령형 프로그래밍 언어에서, 가장 작은 독립 실행 요소이다.
  - expression : 프로그래밍 언어가 다른 값을 산출하기 위해 해석하고 계산하는 하나 이상의 명시적 값, 상수, 변수, 연산자 및 함수의 조합이다. 변수선언/할당, 지역 클래스 선언은 표현식이 아니다.
  - 모든 Kotlin함수는 적어도 `unit`을 반환하기 때문에 표현식이다. 리턴유형을 지정하지 않은 java함수 호출은 표현식이 아니다. Kotlin 값 할당은 표현식이 아니나, java는 할당된 값을 반환하기 때문에 표현식이다. java에서 제어구조(if, switch)의 모든 용도는 표현식이 아니지만, kotlin은 값을 반환하는 것을 허용하므로 표현식이다.
