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

[Kotlin Annotation](https://kotlinlang.org/docs/reference/annotations.html)은 코드에 메타데이터 추가하는 것이다.
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
