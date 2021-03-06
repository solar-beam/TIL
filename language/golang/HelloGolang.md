# Hello, Golang

![](../img/installer-err-msg.PNG)  
ㅠㅜ....

## See You Soon, Golang

- Golang Internals series : [https://golangkorea.github.io/post/golang-internals/part2/](https://golangkorea.github.io/post/golang-internals/part2/)
- Golang grammer cheetsheet : [https://github.com/golang/go/blob/release-branch.go1.4/src/cmd/gc/go.y](https://github.com/golang/go/blob/release-branch.go1.4/src/cmd/gc/go.y)
- Golang/Bloter : [http://www.bloter.net/archives/245951](http://www.bloter.net/archives/245951)
- A Tour of Go : [https://knight76.tistory.com/entry/Go-lang-workspace-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0](https://knight76.tistory.com/entry/Go-lang-workspace-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0)
- `=`와 `:=` : 함수내부에서 `:=`는 var나 변수형을 생략할 수 있다
- Full Clousres
  - Closure in JS : [](https://poiemaweb.com/js-closure)

## Long Time No See, Golang

- GO는 `;` 대신 개행문자로 문장을 구분할 수 있다.
- 사용되지 않은 변수가 있으면 실행이 안된다. `__`키워드를 이용하면 가능하긴 한데, 굳이?
- 타입을 명시한 경우(=), 타입을 추론하는 경우(:=), 다중 할당을 하는 경우(=)로 나뉜다.
  - 구조체 멤버에 대하여 다중할당을 하는 경우(:=), 예시 : variable_name := structure_variable_type {value1, value2, ..., valueN}
- GO는 함수, 조건문, 반복문을 시작할 때 반드시 같은 줄에서 중괄호를 시작해야 한다.
- GO의 조건문은 ELSE구문을 이전 IF의 닫히는 중괄호와 같은 줄에서 시작해야 한다.
- FUNCTIONS
  - [functions as values](https://www.tutorialspoint.com/go/go_function_as_values.htm) : 함수 리터럴을 별도의 형식지정 없이 변수에 저장할 수 있다.
  - [function closure](https://www.tutorialspoint.com/go/go_function_closures.htm) : 함수 클로저처럼 작동하는 익명함수를 지원한다? JS의 클로저 : 내부함수가 외부함수의 지역변수에 접근할 수 있고, 외부함수는 해당 지역변수를 사용하는 내부함수가 소멸될 때까지 소멸되지 않는 특성을 가리킨다. 그렇다면, JS의 클로저 방식은 안전한가? 그렇다. '변수접근을 제한한다'는 면에서 그렇다. [세부내용 : JS Closures](http://jibbering.com/faq/notes/closures/)
  - [method](https://www.tutorialspoint.com/go/go_method.htm) : 구조체를 매개인자로 받는 함수는, 이미 생성된 구조체 인스턴스에 대하여 . 연산자를 이용해 마치 해당 객체 내부에 정의된 함수처럼 호출하여 사용할 수 있다.
- 지역/전역변수는 다음과 같이 초기화된다. (int)0, (float32)0, (pointer)nil
- (포인터 정의) 변수명 \*변수타입, (포인터로 참조) \*변수명
  - nil포인터는 0을 가리킴(보통은)
  - (포인터 배열) 변수명 \[배열크기]\*변수타입
  - (포인터 포인터) 변수명 \*\*변수타입
  - (포인터를 함수 매개인자로) (함수정의부)=(포인터정의) (함수내부)=(포인터로 참조)
- slice는 go배열인데, 길이len()와 함께 확장 가능한 배열의 크기cap()를 지정할 수 있다.
  1. var numbers \[]int와 같이 크기를 지정하지 않고 배열을 선언하면 slice가 된다.
  2. var numbers = make(\[]int,5,5)와 같이 make()함수를 사용해도 된다.
  3. slice_name[lower-bound:upper-bound]로 서브슬라이스를 얻을 수 있다.
  4. append(slice_name, value1, value2,...values)
  5. copy(dest_slice, source_slice)
- range는 for문에서 다음과 같이 사용하며, string은 인덱스로 0부터 시작하는 정수, []참조시 아스키코드를 반환한다.
```go
for i:= range slice_or_array_or_map_or_string_etc {
	fmt.Println("index num is",i," is",variable[i])
}
```
- (map정의) 1. var map_v map[key_type]value_type  2. map_v = make(map[key_type]value_type)
- comma ok idiom : 배열, 슬라이스, 맵과 같이 키를 이용해 참조하여 값을 할당하는 경우 다음과 같이 사용하여, 해당 키값에 대응하는 값이 존재하는지 알 수 있다. ok로 성공여부를 T/F값으로 반환한다.
```go
var value, ok = array_name[key_value]
if(ok) /* go through */
else /* do sth when failed */
```
- c와 같이 go도 재귀함수를 지원하나, 종료조건을 면밀히 살펴서 무한루프가 돌지 않도록 유의해야 한다.
- go의 인터페이스 ?? 구조체와 관계는 ?? -> [How to use interfaces in Go](http://jordanorelli.com/post/32665860244/how-to-use-interfaces-in-go)
- go Error Handling : err 인터페이스 구현??