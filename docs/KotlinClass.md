# Kotlin Class and object

## Classes and Inheritance

### Class members
- Constructor and initailizer blocks
- Functions
- Properties
- Nested and Inner Classes
- Object Declarations

### Classes Declaration
```
class Person { /* ... */ }
class Empty //클래스 몸체를 따로 기술하지 않아도된다.
```
생성자는 primary/secondary 두 종류가 있는데, primary는 클래스 헤더에 함께 쓰고 초기화 코드는 클래스 몸체에 `init` 몸체 내부에 적는다. visibility modifier가 없으면 `constructor` 키워드는 생략할 수 있다. `init`내부에서 인스턴스 자신을 가리키는 키워드 `this`를 사용할 수 있다.
```
class Person public @Inject constructor(firstName: String){ 
  val personName = firstName.toUpperCase()
  init{
    this.personName += "is wonderful"
    todo("initialization code comes here")
  }
}
//constructor 키워드를 생략한 코드
class Person(firstName: Sring){ /*...*/ }
```
Kotlin에서는 아래와 같이 생성자 매개인자로 초기화를 할 수도 있다.
```
class Person(val firstName: String, val lastName: String){ /*...*/ }
```
Secondary생성자는 클래스 몸체에 `constructor`키워드로 기술하며, primary생성자를 상속해야(정확히 표현하면 'secondary constructor needs to delegate to primary constructor'로 대리/참조하는 것) 한다. `this`키워드로 헤더측에 기술한다. 물론 Primary 생성자의 매개인자도 함께 와야 한다. 
```
class Person(country: String) {
    var children: MutableList<Person> = mutableListOf<Person>();
	
	init{
	  //init code
	  //secondary생성자 이전에 primary생성자가 호출되고, init코드가 순차적으로 실행된 다음에 secondary생성자가 실행된다.
	}
	
    constructor(parent: Person): this(country) { //primary생성자 상속은 이렇게 this키워드로 한다.
        parent.children.add(this)
    }
}
```
물론 Primary생성자를 안쓰고, Secondary생성자만 쓸 수도 있다. 그런데 Secondary생성자 헤더에서는 매개인자 정의에서 바로 변수선언/할당을 할 수가 없다.
```
class Person{
  counstrunctor(var name: String){ /*...*/ } //이런거안됨
}
```
생성자를 아예 선언하지 않으면, non-abstract클래스의 경우 public primary생성자를 디폴트로 만들어준다. public생성자를 두고 싶지 않으면 빈 private생성자를 만들어두자.

### Creating instances of classes
인스턴스 생성은 `new`키워드가 없다는 점만 다르다.
```
val invoice = Invoice()
val customer = Customer("Joe Smith")
```

### Inheritance
슈퍼클래스가 기술되지 않은 모든 클래스는, `Any`를 상속하며 `equals()`,`hashcode()`,`toString()`메소드를 가진다. 다시말해 코틀린의 모든 클래스는 앞서 말한 세 가지 메소드를 가지고 있다. 상속은 다음과 같이 한다.
```
open class Base(p: Int)
class Derived(p: Int) : Base(p)
```
Derived클래스에 primary생성자가 있다면, base클래스는 생성자 코드로 초기화할 수 있다. 만약 없다면, Secondary생성자에 `this`대신 `super`키워드로 초기화해줘야 한다. 이때 base클래스의 여러 생성자 중 하나를 택할 수 있다.
> NOTE: 자바는 상속 재정의를 막기 위해 final을 사용하나, kotlin은 상속 재정의를 허용하기 위해 명시적으로 open키워드를 사용한다.  
>+클래스 멤버가 open이려면 클래스도 open이어야 한다.

### Overriding methods
이렇게 하면된다.
```
open class Shape {
    open fun draw() { /*...*/ }
    fun fill() { /*...*/ }
}

class Circle() : Shape() {
    override fun draw() { /*...*/ }
}
```
`override`키워드는 묵시적으로 `open`이므로 재정의를 막으려면 `final`키워드를 사용한다.

### Overriding properties
메소드랑 별로 다를 것이 없다.
```
open class Shape {
    open val vertexCount: Int = 0
}

class Rectangle : Shape() {
    override var vertexCount = 4 //val을 var로 오버라이드할수있다
}
```

### Derived class initialization order
super클래스 생성자 + init코드, sub클래스 생성자 + init코드. 다시말해, super클래스 생성자를 호출할 때는 sub클래스에 선언/override된 프로퍼티는 초기화되지 않은 상태이므로, 이를 참조할 때 오류가 발생할 수 있다. 따라서 생성자/프로퍼티초기화/init블럭 내부에는 open멤버를 사용하지 않는 편이 좋다.

### Calling the superclass implementation
sub클래스에서 `super`키워드로 super클래스의 함수/프로퍼티접근자를 호출할 수 있다. 내부클래스에서 `super@[outerclassname]`으로 외부클래스를 참조할 수 있다.
```
class FilledRectangle: Rectangle() {
    fun draw() { /* ... */ }
    val borderColor: String get() = "black"
    
    inner class Filler {
        fun fill() { /* ... */ }
        fun drawAndFill() {
            super@FilledRectangle.draw() // Calls Rectangle's implementation of draw()
            fill()
            println("Drawn a filled rectangle with color ${super@FilledRectangle.borderColor}") // Uses Rectangle's implementation of borderColor's get()
        }
    }
}
```

### Overriding rules
다중상속인데, 직전 super클래스의 멤버 구현이 서로 다를 경우, sub클래스도 멤버를 재정의해야 한다. 이때 `super<SUPERCLASS_NAME>`키워드로 super클래스 참조할 수 있다. 

```
open class Rectangle {
    open fun draw() { /* ... */ }
}

interface Polygon {
    fun draw() { /* ... */ } // interface members are 'open' by default
}

class Square() : Rectangle(), Polygon {
    // The compiler requires draw() to be overridden:
    override fun draw() {
        super<Rectangle>.draw() // call to Rectangle.draw()
        super<Polygon>.draw() // call to Polygon.draw()
    }
}
```

### Abstract classes
추상클래스는 멤버를 내부에 구현하지 않아도 된다. 추상클래스는 기본적으로 open이다. non-abstract open멤버를 추상클래스에서 오버라이드할 수 있다.

```
open class Polygon {
    open fun draw() {}
}

abstract class Rectangle : Polygon() {
    override abstract fun draw()
}
```

### Companion objects
함수인데, 클래스 인스턴스는 없어도 되지만 클래스 내부에 접근해야 한다면(이를테면 factory메소드처럼) 클래스 내부에 object declaration의 멤버로 작성하면 된다.
혹은 companion object를 내부에 선언하고, 그 멤버를 클래스 이름으로만 참조할 수도 있다(인스턴스 없이도)
>NOTE: #? Object부분 보고 다시 온다!

## Properties and Fields

### Declaring Properties
여기서 초기화 코드랑 getter/setter는 선택이다.
```
var <propertyName>[: <PropertyType>] [= <property_initializer>]
    [<getter>]
    [<setter>]
```
nullable은 초기화해줘야 하고, 타입추론 가능하면 타입명 안써도 된다.
```
var allByDefault: Int? // error: explicit initializer required, default getter and setter implied
var initialized = 1 // has type Int, default getter and setter
```
get/set코드는 아래처럼 쓸 수 있다. 매개인자 이름은 기본적으로 value다.
```
var heapSize: Int
    get() = this.size
	set(value) {
        value.todo("set heapSize as value")
    }
```
Kotlin클래스는 바로 field를 선언할 수 없는데, 프로퍼티에 backing field가 필요하면 Kotlin에서 자동으로 제공해준다. `field`식별자로 참조할 수 있다.
```
var firstName : String
    set(value) { firstName = value } //stackoverflow!! 
				//이 코드는 다음과 같다 : { set(value) } 무한재귀호출..
    set(value) { field = value }
```
싫으면 이렇게 해도 되고.
```
private var _table : Map<String, Int>? = null
public val table: Map<String, Int>
    get() {
	    if(_table == null){
		   _table = HashMap()
		}
		return _table ?: throw AssertionError("Set to null by another thread")
	}
```

### Complie-Time Constants
컴파일 시점에 읽을수만 있는 프로퍼티라면 `const`modifier로 표시한다. 다음 조건을 충족한다.
- top-level(전역), 또는 object declaration, companion object의 멤버
- String이나 원시값으로 초기화됨
- cumstom getter가 없다
어노테이션에 쓸 수 있다.

```
const val SUBSYSTEM_DEPRECATED: String = "This subsystem is deprecated"
@Deprecated(SUBSYSTEM_DEPRECATED) fun foo() { ... }
```

- [Kotlin Annotation](https://kotlinlang.org/docs/reference/annotations.html)은 코드에 메타데이터 추가하는 것이다.
- meta-annotations : `annotation class ANNOTATION_NAME`과 같이 커스텀 어노테이션 만들 수 있는데, 그 위에 아래와 같은 메타 어노테이션을 붙일 수 있다.
  - `@Target` : 대상을 이하 괄호 안에, class/function/property/expression/...etc
  - `@Retention` : 컴파일된 클래스 파일 안에 저장되는지, 런타임시 보이는지
  - `@Repeatable` : 같은 어노테이션을 같은 element에 여러 번 쓸 수 있는지
  - `@MustbeDocumented` : 문서작업하란뜻
- 쓸때는 이렇게 쓰면됨

```
//class declaration
@Fancy class Foo(val why: String) { //매개인자를 가질 수도 있다
    @Fancy fun baz(@Fancy foo: Int): Int {
        return (@Fancy 1)
    }
}

//primary constructor
class Foo @Inject constructor(dependency: MyDependency) { ... }

//property accessor
class Foo {
    var x: MyDependency? = null
        @Inject set
}

//lamda
annotation class Suspendable
val f = @Suspendable { Fiber.sleep(10) }
```

### Late-Initialized Properties and variables
null아닌 프로퍼티는 생성자에서 초기화되어야 하는데, 이게 불편할 때가 있다. 의존성주입, 단위테스트 셋업 등 자체 생애주기가 있을 때 그렇다. 그렇다고 null참조 오류 여부를 매번 확인하기가 어려울때면 이렇게 하면 된다. `lateinit`프로퍼티를 초기화전에 참조하면 다른 오류와 구별되는 예외가 던져진다.

```
public class MyTest {
    lateinit var subject: TestSubject

    @SetUp fun setup() {
        subject = TestSubject()
    }

    @Test fun test() {
        subject.method()  // dereference directly
    }
}
```

Kt1.2부터는 `.isInitialized`사용하면 된다.

### Overriding Property
알지?

### Delegated Property
프로퍼티는 대부분 backing field를 읽어오거나, 해당 field에 직접 쓰기도 한다. 사용자가 직접 정의할 수도 있고. 주로 `lazy value`, 주어진 key로 map에서 읽어오기, DB접근, 리스너 알려주기 등이 있는데, 이런건 [#?delegated properties](https://kotlinlang.org/docs/reference/delegated-properties.html)사용하는 라이브러리에 구현되어 있다.

## Interfaces
코틀린 인터페이스는 추상 메소드를 선언하고, 또 정의할 수 있다. 추상 클래스와 다른 점은 '상태'를 저장할 수 없다는 점이다. 프로퍼티를 가질 수는 있지만 추상 프로퍼티거나 accessor를 정의해두어야 한다. 이때 backing field를 가질 수 없어 결론적으로 accessor는 자신을 참조할 수 없다.
```
interface Myinterface {
  fun bar()
  fun foo() {
    //body is optional
  }
}
```
클래스/객체는 아래와 같이 하나 이상의 인터페이스를 구현할 수 있다.
```
class Child : MyInterface {
  override fun bar() {
    //body
  }
}
```
인터페이스가 다른 인터페이스를 상속할 수도 있는데, 함수/프로퍼티를 재정의할 수 있다. 

```
interface Named {
    val name: String
}

interface Person : Named {
    val firstName: String
    val lastName: String
    override val name: String get() = "$firstName $lastName"
}

data class Employee(
    // implementing 'name' is not required
    override val firstName: String,
    override val lastName: String,
    val position: Position
) : Person
```

클래스가 여러 개 인터페이스를 구현할 때는, 아래와 같이 경우에 따라 재정의해주어야 한다. C를 보면, A에서 bar가 정의되어 있지 않으므로 재정의하고 있다. D에서는 오버라이드 충돌을 막기 위해 재정의하고 있다.

```
interface A {
    fun foo() { print("A") }
    fun bar()
}

interface B {
    fun foo() { print("B") }
    fun bar() { print("bar") }
}

class C : A {
    override fun bar() { print("bar") }
}

class D : A, B {
    override fun foo() {
        super<A>.foo()
        super<B>.foo()
    }
    override fun bar() {
        super<B>.bar()
    }
}
```

## Visibility Modifiers
getter는 언제나 visibility modifier(이하 'VM')을 가지고, 그밖에 class/object/interface/constructor/function/property/setter는 선택사항이다. VM에는 네 종류가 있다. 디폴트는 public이다.

| 구분 | package | class&Interface | Constructor |
| ----- | ----- | ----- | ----- | ----- |
| private | 선언된 파일안에서만 접근할 수 있다 | 해당 클래스 안에서만 | 클래스 안에서만 |
| protected | top-level(전역) 선언부에서 불가 | 하위 클래스까지만 |  |
| internal | 같은 모듈이면 어디서든 | 같은 모듈에서 클래스 볼수있는 범위까지 |    |
| public | 제한없음 | 제한없음 | 제한없으나, 포함된 클래스 볼 수 있는 범위까지 | 

- 다른 패키지는 여전히 `import`로 포함시킨다
- `constructor` 디폴트 VM은 `public`이다
- `module`은 함께 컴파일된 코틀란 파일 집합으로, IDE모듈/Maven프로젝트/Gradle소스집합/Ant에서 한번에 컴파일된 묶음을 가리킨다.

## Extensions
Decorator패턴을 사용하거나 다른 클래스를 상속하지 않고도, 클래스를 확장할 수 있다. `extensions`라 부르는데, 서드파티 라이브러리에서 변경할 수 없는 함수를 새로 쓸 수가 있다. 원래부터 해당 클래스의 메소드인 것처럼 호출만 하면 된다. 이런 방식을 `extenstion function`이라 부르는데, `extenstion property`도 있다.

### Extension function
`this`키워드는 리시버객체와 대응하는데, 리시버란 점 바로앞에서 호출한 함수 매개인자로 던져지는 객체를 가리킨다.
```
fun MutableList<Int>.swap(index1: Int, index2: Int) {
    val tmp = this[index1] // 'this' corresponds to the list
    this[index1] = this[index2]
    this[index2] = tmp
}
```
### Extension, resolved statically
확장함수는 호출되는 리시버의 클래스에 대응한다. 반환되는 결과값하고는 무관하다. 이를테면 아래에서 마지막 코드의 결과값은 "Shape"인데, 매개인자로 Shape클래스를 던졌기 때문이다.

```
open class Shape

class Rectangle: Shape()

fun Shape.getName() = "Shape"

fun Rectangle.getName() = "Rectangle"

fun printClassName(s: Shape) {
    println(s.getName())
}    

printClassName(Rectangle())
```

어떤 클래스에 확장함수와 동일한 멤버함수가 있다면, 멤버쪽이 우선시된다. 아래 코드의 결과값은 "Class method"다.

```
class Example {
    fun printFunctionType() { println("Class method") }
}

fun Example.printFunctionType() { println("Extension function") }

Example().printFunctionType()
```

그런데 매개인자를 다르게 오버라이드 하는건 된다.

```
class Example {
    fun printFunctionType() { println("Class method") }
}

fun Example.printFunctionType(i: Int) { println("Extension function") }

Example().printFunctionType(1)
```

### Nullable receiver
nullable리리버에서도 호출할 수 있는데, 그럴땐 코드 내부에서 `this==null`코드로 확인해주면 된다. 아래 코드의 결과값은 "null exception"이며, null체크를 안해주면 코드 내부는 스킵한다.

```
class Example{
    fun printFunctionType(){ println("Class method\n") }
}

fun Example?.printFunctionType(){ 
    if(this==null){
        println( "null exception\n" )
        return
    }
    println("Extension function\n") 
}

Example().printFunctionType()
val e :Example? = null
e.printFunctionType()
```

### Extension properties
확장프로퍼티는 backing field를 가질 수 없고, 그래서 직접 초기화도 할 수가 없다. 반드시 명시적인 getter/setter를 통해서 정의해야 한다.
```
//OK
val <T> List<T>.lastIndex: Int
    get() = size - 1
	
//ERR
val House.number = 1
```

### Companion object extensions
>#? 두고보자

### Scope of extensions
일반적으로 패키지 아래에 top-level에서 확장을 정의한다.
```
package org.example.declarations
 
fun List<String>.getLongestString() { /*...*/}
```
패키지 밖에서도 사용하려면 아래와 같이 호출한다.
```
package org.example.usage

import org.example.declarations.getLongestString

fun main() {
    val list = listOf("red", "green", "blue")
    list.getLongestString()
}
```

### Declaring extensions as members
클래스 내부에 다른 클래스에 대한 확장을 선언할수도 있다. 그런데, 확장함수의 예를 들어 설명하면, 그 내부에서 리시버를 명시적으로 기술하지 않기 때문에 주의해야 한다. 이런 클래스의 인스턴스는 *dispatch receiver*라 하고, 확장메소드 리시버 클래스의 인스턴스는 *extension receiver*라 한다. 사실 이름 따위는 중요치 않다. 까라해라. 머리만 복잡하다.
```
class Host(val hostname: String) {
    fun printHostname() { print(hostname) }
}

class Connection(val host: Host, val port: Int) {
     fun printPort() { print(port) }

     fun Host.printConnectionString() {
         printHostname()   // calls Host.printHostname() 리시버표시 X
         print(":")
         printPort()   // calls Connection.printPort() 리시버표시 X
     }

     fun connect() {
         /*...*/
         host.printConnectionString()   // calls the extension function 확장리시버 인스턴스에서 메소드를 호출하고 있다
     }
}

fun main() {
    Connection(Host("kotl.in"), 443).connect()
    //Host("kotl.in").printConnectionString(443)  // error, the extension function is unavailable outside Connection
}
```
dispatch/extension 리시버간 멤버 이름이 충돌할 경우, extension(원래 클래스의) 멤버가 우선한다. dispatch(확장함수 정의한 클래스의) 멤버를 호출할 때는 this를 이용.
```
class Connection {
    fun Host.getConnectionString() {
        toString()         // calls Host.toString()
        this@Connection.toString()  // calls Connection.toString()
    }
}
```
확장함수/프로퍼티는 `open`으로 정의해서 하위클래스에서 재정의할 수 있다. 무슨 의미냐면, 확장함수는 리시버 클래스 타입을 따라 호출되는 것이 아니라, 호출되어 넘겨진 여기서는 `call()`의 매개인자 타입에 따라 호출된다.
```
open class Base { }

class Derived : Base() { }

open class BaseCaller {
    open fun Base.printFunctionInfo() {
        println("Base extension function in BaseCaller")
    }

    open fun Derived.printFunctionInfo() {
        println("Derived extension function in BaseCaller")
    }

    fun call(b: Base) {
        b.printFunctionInfo()   // call the extension function
    }
}

class DerivedCaller: BaseCaller() {
    override fun Base.printFunctionInfo() {
        println("Base extension function in DerivedCaller")
    }

    override fun Derived.printFunctionInfo() {
        println("Derived extension function in DerivedCaller")
    }
}

fun main() {
    BaseCaller().call(Base())   // "Base extension function in BaseCaller"
    DerivedCaller().call(Base())  // "Base extension function in DerivedCaller" - dispatch receiver is resolved virtually
    DerivedCaller().call(Derived())  // "Base extension function in DerivedCaller" - extension receiver is resolved statically
}
```
>NOTE: JAVA는 런타임 시점에 호출하는 확장함수를 결정하지만, Kotlin은 컴파일 시점에 결정한다. super클래스로 선언된 sub클래스 객체 인스턴스에 대하여, Kotlin은 super클래스 함수가 호출된다. 잘 모르겠으면 다음 글을 보자. [kotlin extension의 동작 원리](https://medium.com/@joongwon/kotlin-kotlin-extensions-%EC%9D%98-%EB%8F%99%EC%9E%91-%EC%9B%90%EB%A6%AC-ea1759b8d556)

### Visibility
- 리시버가 정의된 파일의 private멤버에 접근할 수 있다.
- 확장함수가 리시버 클래스 외부에서 정의되었다면, 리시버 클래스 private멤버에는 접근할 수 없다.
- 결론 : 확장함수는 정의된 시점의 파일/클래스에 visibility가 귀속된다.

## Data Classes
데이터를 담기 위한 클래스를 만들기도 하는데, 그런 클래스에는 standard functionality와 utility function이 데이터에 따라 기계적으로 정해진다. 코틀린에서는 그런 클래스를 *data class*라 하고 `data`키워드로 표시한다.
```
data class User(val name: String, val age: Int)
```

컴파일러는 primary생성자에 선언된 변수에 대하여 다음 멤버를 자동으로 만들어준다.  
- `equals()`/`hashCode()`
- `toString()` : "User(name=John, age=42"같은 형태로
- 선언순서대로 `component1()`, `component2()`... 함수
- `copy()`
>NOTE: ComponentN함수는 ??????????? 다음에 araboza.. #?두고보자! [destructuring declaration](https://kotlinlang.org/docs/reference/multi-declarations.html)

데이터 클래스는 다음 조건을 만족해야 한다. 신뢰성을 보장하고 의미없는 코드 생성을 막기 위해서다.
- primary생성자는 하나 이상의 매개인자를 가져야 한다
- 모든 primary생성자 매개인자는 `val`이나 `var`로 표기해야 한다
- 데이터 클래스는 `abstract`, `open`, `sealed`, `inner`여야 한다
- (1.1이전) 데이터 클래스는 인터페이스만을 구현할 수 있다(이젠 아니지롱)

아울러서, 멤버생성은 멤버상속에 맞춰 다음 규칙에 따른다.
- 데이터 클래스 몸체에 `equals()`, `hashCode()`, `toString()` 함수를 명시적으로 구현되어있거나 상위 클래스에 `final`로 구현되어 있으면, 앞서말한 함수는 자동으로 생성되는 게 아니라 기존에 있는 함수를 쓴다.
- 슈퍼타입이 open이나 호환되는 signature(함수명/매개인자)를 반환하는 componentN함수를 가지고 있다면,해당 함수를 오버라이드 하는 함수가 생성된다. 만약 슈퍼타입이 signature가 호환되지 않거나 final때문에 재정의를 할 수 없다면, 오류가 보고된다. *#? If a **supertype** has the componentN() functions that are open and return **compatible types**, the corresponding functions are generated for the data class and override those of the supertype. If the functions of the supertype cannot be overridden due to **incompatible signatures** or being final, an error is reported;*
- 카피함수가 있는 타입으로부터 데이터클래스를 뽑아내는건 1.2부터 막혔다 *#? Deriving a data class from a type that already has a copy(...) function with a **matching signature** is deprecated in Kotlin 1.2 and is prohibited in Kotlin 1.3.*
- `componentN()`과 `copy()` 함수를 명시적으로 구현할 수는 없다.
>NOTE: 메소드 시그니처란 메소드의 입출력을 정의하는 것으로, 매개인자와 그 타입, 반환값과 타입, 발생할 수 있는 예외, 메소드 접근권한 정보를 포함한다.

코틀린1.1부터는 다른 클래스를 확장할 수도 있다. JVM에서, 생성된 클래스에 매개인자 없는 생성자가 필요하다면 모든 프로퍼티에 대하여 기본값을 지정해줘야 한다.
```
data class User(val name: String = "", val age: Int = 0)
```

### Properties Declared in the Class Body
데이터 클래스에 자동으로 만들어주는 함수에서는, 기본생성자에서 정의된 함수만 사용한다는 점에 유의하자. 자동생성함수에서 접근못하게 하려면, 클래스 몸체 내부에 선언하면 된다. 그래서 생성자 헤더에 선언된 프로퍼티가 모두 동일하면(equal함수 내부에 정의된대로), 클래스 몸체에 선언된 프로퍼티는 다르더라도 두 객체는 같은 것으로 인정된다. 다음코드의 결과값은 true다.
```
data class Person(val name: String){
  var age: Int = 0
}

val person1 = person("John")
val person2 = person("John")
person1.age = 10
person2.age = 2
println(person1==person2)
```

### Copying
객체에서 어떤 프로퍼티는 바꾸고, 나머지는 그대로 남겨놓은채로 복제를 해야할 경우가 종종 있다. 이럴때 `copy()`함수가 쓰인다. 이를테면 아래와 같다.
```
fun copy(name: String = this.name, age: Int = this.age) = User(name, age)

val jack = User(name = "Jack", age = 1)
val olderJack = jack.copy(age = 1) //잭에게 떡국을 한그릇 줬다
```

### Data Classes and Destructuring Declarations
>#?두고보자! [destructuring declaration](https://kotlinlang.org/docs/reference/multi-declarations.html)
```
val jane = User("Jane", 35) 
val (name, age) = jane
println("$name, $age years of age") // prints "Jane, 35 years of age"
```

### Standard Data Classes
표준 데이터 클래스는 `Pair`, `Triple`을 제공한다. 그런데 대부분 이름 있는 클래스가 더 낫다. 프로퍼티에 더 읽기좋고 의미있는 이름을 붙일 수 있기 때문이다.