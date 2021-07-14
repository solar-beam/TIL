# Hello Rust

[The Rust Programming Language (rinthel.github.io)](https://rinthel.github.io/rust-lang-book-ko/)에서 공부한 내용을 요약정리

:goal_net: **3.2 / 21**

  

## Hello, world!

코드를 작성하고

```rust
fn main() {
    println!("Hello, world!");
}
```

컴파일해서 실행

```shell
$ rustc main.rs
$ ./main
Hello, world!
```

Rust는 `ahead-of-compile` 언어

  

## Hello, Cargo!

`Cargo`로 프로젝트 만들기

```
$ cargo new hello_cargo --bin
```

`Cargo` 프로젝트 내부 구조

```
.
├── Cargo.toml  # Cargo환경설정
└── src         # 소스코드
    └── main.rs
```

`Cargo`는 Linux/macOS/Windows 모두 명령어가 동일하다.

```
$ cargo build  # 빌드
$ cargo run    # 실행
$ caro check   # 빌드 가능한지 확인, 실행파일 생성X
```

​    

## Exercise Code

[추리 게임 튜토리얼 - The Rust Programming Language (rinthel.github.io)](https://rinthel.github.io/rust-lang-book-ko/ch02-00-guessing-game-tutorial.html)

프로그램이 생성한 난수를 알아맞히는 간단한 게임을 만들어본다. Hello World 코드에 Rust 컨셉을 순차적으로 추가해가며 배운다. 과정이 꽤나 재미있으니 해보길 권한다.

> **배우는 개념**: `let`, `mut`, 메소드, 연관함수, 외부 크레이트, `Result`(`Ok`,`Err`), `Cargo` 의존성관리

​    

## Basic Grammars

변수는 선언할 때 값을 바꿀 수 있는지 표시한다

```rust
let variables //값을 바꿀 수 없는 변수
let mut variables //값을 바꿀 수 있고, 위에서 선언한 불변변수를 가림(쉐도잉)
```

상수는 값을 바꿀 수 없고, 오직 상수 표현식으로만 값을 할당할 수 있다. 함수 호출의 결과나 그 외 런타임에 결정되는 값으로는 할당할 수 없다.

```rust
const MAX_POINTS: u32 = 100_000;
```

쉐도잉으로 아래와 같이 변수의 값뿐 아니라 형식도 바꿀 수 있다. Rust는 정적타입 언어이기 때문에, `mut` 키워드로 아래와 같이 실행하면 컴파일 오류가 발생한다.

> **정적타입**: 컴파일할 때 타입정보를 결정한다. Rust, C/C++, Java 등
> **동적타입**: 런타임시 타입정보를 결정한다. JavaScript, Ruby, Python 등

```rust
//Shadowing success
let spaces = "    ";
let spaces = spaces.len();
```
```rust
//mutable fail
let mut spaces = "    ";
spaces = spaces.len();

//ERROR CODE
error[E0308]: mismatched types
 --> src/main.rs:3:14
  |
3 |     spaces = spaces.len();
  |              ^^^^^^^^^^^^ expected &str, found usize
  |
  = note: expected type `&str`
             found type `usize`
```

​    

  





























