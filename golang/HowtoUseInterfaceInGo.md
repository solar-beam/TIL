# [How to use interfaces in Go](http://jordanorelli.com/post/32665860244/how-to-use-interfaces-in-go)

Go로 프로그래밍하기 전에는, 대부분 Python으로 작업해왔다. Python 프로그래머로서 Go의 인터페이스를 배우는 것이 너무도 힘들었다. 기초는 쉽다. 표준 라이브러리에서 인터페이스를 어떻게 사용하는지는 알 수 있었지만, 정작  인터페이스를 직접 만들려고 하면 많은 시행착오가 필요했다. 이 포스트에서는, Go의 타입 시스템을, 인터페이스를 어떻게 효과적으로 사용할 수 있는지 

## Introduction to interfaces

그래서 interface는 무엇인가? 인터페이스는 1) 메소드의 집합이며, 2) 동시에 타입이다. 먼저 인터페이스를 메소드의 집합이라는 관점에서 살펴보겠다.

전형적이긴 하지만, interface를 인위적인 예를 들어 소개할 수밖에 없겠다. 응용프로그램 개발을 하다가, Animal이란 데이터타입을 정의해야 한다고 가정해보자. Animal타입은 interface이며, 우리는 이것을 *말할 수 있는 것/대상*으로 정의하겠다. 바로 이것이 Go 타입시스템의 핵심개념이다. 추상화 설계 단계에서, 어떤 데이터를 가질 수 있는지를 정의하는 게 아니라, interface 타입이 무엇을 할 수 있는지로 정의한다.

Animal 인터페이스를 정의해보자.
```go
type Animal interface{
	Speak() string
}
```

꽤 간단하다. Speak()란 메소드를 가지는 타입으로 Animal 인터페이스를 정의해보았다. Speak메소드는 매개인자가 없으며 문자열을 반환하는 함수다. 이 메소드를 정의하는 타입이면 무엇이든 Animal 인터페이스를 만족하는 것이다. Go에는 implements 키워드가 없으며, 인터페이스를 만족하는지는 자동으로 결정된다. 아래에서는 인터페이스를 만족하는 여러 타입을 정의해보겠다.
```go
type Dog struct {
}

func (d Dog) Speak() string {
    return "Woof!"
}

type Cat struct {
}

func (c Cat) Speak() string {
    return "Meow!"
}

type Llama struct {
}

func (l Llama) Speak() string {
    return "?????"
}

type JavaProgrammer struct {
}

func (j JavaProgrammer) Speak() string {
    return "Design patterns!"
}
```

네 종류의 동물들을 정의해보았다. 개, 고양이, 라마와 자바프로그래머. main함수 아래에 Animal 슬라이스를 생성하고, 각각의 타입을 슬라이스 안에 할당해서 동물들이 어떤 말을 하는지 보도록하자.
```go
func main(){
	animals := []Animal{Dog{}, Cat{}, Llama{}, JavaProgrammer{}}
	for _, animal := range animals {
		fmt.Println(animal.Speak())
	}
}
```

웹에서 동작하는 예제를 보려면, 다음 링크를 참고 : [http://play.golang.org/p/yGTd4MtgD5](http://play.golang.org/p/yGTd4MtgD5)

사용하는 법을 알았으니, 여기서 글을 끝맺어야 할까? 사실, 그렇지만은 않다. 몇 가지, 자라나는 새싹 Go프로그래머에게는 그다지 명쾌하지만은 않은 몇 가지를 짚어보겠다.

...