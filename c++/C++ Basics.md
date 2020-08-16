# C++ Basics

## BASIC OF BASIC

### C I/O

- `scanf` `printf` 

### C++ I/O

- `getline`
  - `istream:getline()` : 마지막에 `'/0'`이 붙는 `char*` 방식 C언어 문자열 방식
  - `string:getline()` : `std::string` 방식
- `setprecision` 
- `cin`, `cout` : 입출력 객체의 <<, >> 연산자는 여러 가지 기본 타입에 대해 오버로딩되어 있다.

### C++11

- Range-based for
- 초기화 리스트
- 람다 함수

### Container

- `pair`
- `tuple`
-  `vector`
-  `deque`
-  `list`
-  `set`
-  `map`
-  `stack`
-  `queue`
-  `priority_queue`
-  `bitset`

### Algorithm

- `count`
- `find`
- `fill`
-  `reverse`
-  `rotate`
-  `swap`
-  `unique`
-  `sort`
-  `stable_sort`
-  `binary_search`
-  `lower_bound`
-  `uppder_bound`
-  `min`
-  `max`
-  `min_elemnet`
-  `max_element`

### String Usage



## GRAMMER

- 보다 재미있는 실습환경을 위해, 다양한 콘솔용 함수를 지원하는 `turboc.h` 헤더파일을 추가한다. 경로는 `visual studio` 이하 `include`폴더다. 못 찾으면, `iostream` 을 추가하고, `#include`문에서 우측클릭해 헤더파일을 연다. 상단 메뉴창에서 우측클릭해 상위폴더로 들어가서 `turboc.h` 파일을 복사붙여넣기 한다.

- c++ 프로젝트 구조 : 헤더파일=인터페이스, 구현파일=클래스, 메인파일=프로그램진입점

  ![img](http://soen.kr/lecture/ccpp/cpp3/25-4-4.files/image004.gif)

- `new`, `delete`
  
  - c의 `mallac`, `free`에 대응한다. `int *ar = new int[5]`와 같이 `new []`로 메모리를 할당한 경우, `delete [] ar`로 해제해야 한다. `delete` 경우는 정해져 있지 않고, 일반적으로 배열 첫번째 요소만 해제하고 나머지는 메모리 누수가 발생한다. 혹은 비정상종료될 수 있다.
  - `new`는 메모리 크기를 바꿔 재할당하기 위해서는 매번 새로 할당하고 원래 메모리를 해제해줘야 한다. 객체가 아니고 메모리 재할당이 빈번한 경우 기존 `malloc`과 `free`를 사용해 `realloc`으로 재할당하고, 실행 도중 `_msize`로 할당 블록의 크기를 조사할 수 있다.
  
- `struct`/`class` : 멤버 함수를 쓸 수 있다. c++의 창시자인 스트로스트룹은 확장된 구조체에 '클래스'라는 이름을 새로 붙여주었다. 구조체 정의부에서 `struct`를 `class`로 바꾸기만 하면 된다. 구조체는 디폴트 액세스 지정자가 `public`이고, 클래스는 `private`이다.

  - 정의방법

    - 내부정의 : 인라인 속성을 가진다. 실제로 함수가 호출되는 것이 아니라 멤버 함수를 호출하는 코드가 함수의 본체 코드로 대체된다. 호출 부담이 없기 때문에 속도가 빠르지만 여러 번 호출할 경우 실행 파일의 크기를 증가시킨다. 멤버 함수의 코드가 아주 짧을 때, 보통 3줄 이하일 때 내부 정의하는 것이 보통이다.

    - 외부정의 : 일반적인 함수 호출과 마찬가지 방법으로 멤버 함수를 호출한다. 외부에 정의하면서도인라인으로 만들고 싶다면 inline 키워드를 함수 원형이나 정의부 앞에 밝히면 된다.

      ```
      struct Position
      {
          int x;
          int y;
          char ch;
          //내부에서 함수정의
          void inPosition()
          {
              gotoxy(x, y);
              _putch(ch);
          }
          void OutPosition();//함수 원형만 선언
      };
      
      //외부에서 함수정의
      void Position::OutPosition()
      {
          gotoxy(x, y);
          _putch(ch);
      }
      ```

      > 공용체도 멤버함수를 가질 수 있으나, 기억 장소만 공유할 뿐 어떤 멤버가 저장되어 있는지 알지 못하므로 정적 멤버를 가질 수 없다. 또한 멤버가 생성자, 파괴자를 정의할 수 없는 등 복잡한 제약이 있다. 멤버 함수를 가지는 공용체는 무척 드물다.

  - 액세스지정 : `private`, `public`(=interface), `protected`

    ```
    struct Babo
    {
    private:
         int a;
         double b;
         char ch;
         void Initialize();
    public:
         int x;
         int y;
         void func(int i);
    protected:
        float k;
    };
    ```

  - 확장된 구조체는(클래스) 타입이다.

    | int      | Complex class       | c++문법                                    |
    | -------- | ------------------- | ------------------------------------------ |
    | int i;   | Complex C;          | 클래스 이름이 타입과 같은 자격을 가진다.   |
    | int i=3; | Complex C(1.0, 2.0) | 생성자, 선언과 동시에 초기화할 수 있다.    |
    | int i=j; | Complex D=C;        | 복사 생성자, 같은 타입의 다른 객체를 복사* |
    | i=j;     | D=C;                | 대입 연산자                                |
    | i+j;     | D+C;                | 연산자 오버로딩                            |
    | i=3.14;  | Complex C(1.2)      | 변환 생성자, 변환 함수                     |
    | 3+i      | 1.0+C               | 전역 연산자 함수와 프렌드*                 |

    - 복사생성자 : java는 객체 a = b를 하면 레퍼런스를 복사하지만, c++는 객체 a = b에서 b의 값을 복사하여 새로운 객체를 생성한다. 구조체 포인터에서 a = b를 했을 경우 레퍼런스(주소값)가 복사되므로, a에서 값을 수정하면 b에도 적용된다.
    - 프렌드함수 : `friend 클래스이름 함수이름(매개변수목록)`과 같이 클래스 내부에 선언한다. 이렇게 선언된 프렌드 함수는 클래스 선언부에 포함되지만 클래스의 멤버함수는 아니지만, 멤버함수와 같은 접근권한을 가진다. 이에 따라 클래스의 멤버함수가 아니어도, `private` 멤버에 접근할 수 있게 된다.

- C++표준에서 배열의 크기는 컴파일 타임에 정해지므로, 배열의 크기는 일반 변수로 정해질 수 없다. 대신 `vector` 컨테이너를 사용하자. L항에 선언만 해도 객체가 생성된다(`Lvalue = new Rvalue` 불필요.)