# Basic Types
Kotlin에서 모든 것은 객체다. 어떤 변수에서도 멤버 함수와 프로퍼티를 호출할 수 있다는 점에서 그렇다. Kotlin의 기본타입인 numbers, characters, booleans, arrays, strings는 런타임시점에 원시값이지만 사용자는 일반 클래스라고 생각한다. 살펴보자.

## Numbers
- 정수는 `Int`로 추론되며, 숫자리터럴 뒤에 L을 붙이면 `Long`으로 간주한다.
  - Byte : 8bits, -128 ~ 127
  - Short : 16bits, -32768 ~ 32767
  - Int : -2,147,483,648(-2^31) ~ 2,147,483,647(2^31 -1)
  - Long : -9,223,372,036,854,775,808 (-2^63) ~ 9,223,372,036,854,775,807 (2^63 -1)
- 소수는 `Double`로 추론되며, 숫자리터럴 뒤에 F또는 f를 붙이면 `float`으로 간주한다. 6-7 이상의 십진수 자릿수를 가지면 라운딩 처리된다.
| Type | Size(bits) | Significant bits | Exponent bits | Decimal digits |
| --- | --- | --- | --- | --- |
| Float | 32 | 24 | 8 | 6-7 |
| Double | 64 | 53 | 11 | 15-16 |
> Note : Float은 IEEE 754 single precision을 반영하지만, Double은 double precision이다. 세부사항은 다음항목을 참고하라. [#?Wiki - IEEE754](https://en.wikipedia.org/wiki/IEEE_754)
- Kotlin은 다른 언어와 다르게 `Double`함수 매개인자에 대하여, `float`과 `int`같은 다른 숫자형 값을 넘겨도 묵시적으로 변환해주지는 않는다.
- 명시적으로 자료형을 바꾸고 싶다면 `toInt()`, `toFloat()`같은 메소드를 호출한다.

## Literal constants
- 숫자형 : 십진수 `123`, Long타입 `123L`, 16진수 `0x0F`, 2진수 `0b00001011` (8진수는 지원안한다)
- 부동소수점 : double타입 `123.5`, `123.5e10`, float타입 `123.5f`
- 숫자 사이에 언더바를 넣어서 읽기 쉽게 만들 수 있다.

## Representation
- #?`Int`형 변수 A를 참조하는 레퍼런스 BoxedA가 있다. 이때 A==A이지만, BoxedA!=A이다. 동일한 변수A를 참조하는 BoxedB에 대하여 BoxedA==BoxedB이다.
> NOTE : #?Generic이란, 다음에 araboza[Medium, Java의 Generics](https://medium.com/@joongwon/java-java%EC%9D%98-generics-604b562530b3)

## Bitwise operations
- 숫자 연산자는 생략했는데, C랑 크게 다를 것 없고 대신 연산자 오버로딩이 가능하다.
- `Int`와 `Long`에 대하여 다음 비트연산이 가능하다.shl(bits) – signed shift left
  - shr(bits) – signed shift right
  - ushr(bits) – unsigned shift right
  - and(bits) – bitwise **and**
  - or(bits) – bitwise **or**
  - xor(bits) – bitwise **xor**
  - inv() – bitwise inversion

## Floating point number comparison
```
#?
The operations on floating point numbers discussed in this section are:

Equality checks: a == b and a != b
Comparison operators: a < b, a > b, a <= b, a >= b
Range instantiation and range checks: a..b, x in a..b, x !in a..b
When the operands a and b are statically known to be Float or Double or their nullable counterparts (the type is declared or inferred or is a result of a smart cast), the operations on the numbers and the range that they form follow the IEEE 754 Standard for Floating-Point Arithmetic.

However, to support generic use cases and provide total ordering, when the operands are not statically typed as floating point numbers (e.g. Any, Comparable<...>, a type parameter), the operations use the equals and compareTo implementations for Float and Double, which disagree with the standard, so that:

NaN is considered equal to itself
NaN is considered greater than any other element including POSITIVE_INFINITY
-0.0 is considered less than 0.0
```

## Characters
`Char`로 표기한다. 바로 아스키코드 숫자로 취급할 수 있다. 문자 리터럴은 싱글quote 안에 넣는다. 이스케이핑도 지원된다. 명시적으로 '1'을 1로 형변환할 수 있다.

## Booleans
- 조건문에는 nullable Boolean이 못온다. nullable로 분기를 세울 때는 `true == a`와 같이 표현하라.

## Arrays
Kotlin에서 배열은 `Array`클래스로 `get`과 `set`함수를 가진다. `[]`도 사용할 수 있다.
```
class Array<T> private constructor() {
    val size: Int
    operator fun get(index: Int): T
    operator fun set(index: Int, value: T): Unit

    operator fun iterator(): Iterator<T>
    // ...
}
```

## Primitive type arrays
원시값 배열도 있다. `ByteArray`, `ShortArray`, `IntArray`가 그러한데, `Array`와 상속관계가 아니다. 각각 팩토리 함수를 가진다.
```
val x: IntArray = intArrayOf(1,2,3)
x[0] = x[1]+x[2] //이건 되고
x =  intArrayOf(2, 5, 10) //이건 안된다
```