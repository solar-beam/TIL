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

- `fstream`

  - `ifstream`

    ```c++
    ifstream readFile;
    readFile.open("test.txt");
    if(readFile.is_open()){
    	while(!readFile.eof()){
    		string str;
    		getline(readFile, str);
    	}
    	readFile.close();
    }
    ```

  - `ofstream`

    ```c++
    ofstream writeFile;
    writeFile.open("test.txt");
    //char[]
    char arr[20] = "Hello, world!"";
    writeFile.write(arr, 20);
    //string
    string str = "Hello, world!";
    writeFile.write(str.c_str(), str.size());
    writeFile.close();
    ```

    

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

- `char arry_name[max_size] = "STRING"` : char 배열에 문자열을 저장할 수 있다. 마지막에는 `\0`이 온다. 공백문자는 `\t`, `\n`, `\r`과 같이 이스케이핑한다. 한글은 1byte로 배열에서 2칸을 차지한다. 영문과 달리 글자별 조회할 수는 없다.
- https://jhnyang.tistory.com/115
- https://modoocode.com/292



## COMMON SENSE

- **ARRAY** : C++표준에서 배열의 크기는 컴파일 타임에 정해지므로, 배열의 크기는 일반 변수로 정해질 수 없다. 대신 `vector` 컨테이너를 사용하자. L항에 선언만 해도 객체가 생성된다(`Lvalue = new Rvalue` 불필요.)

  - 함수인자에 포인터로 이차원배열 넘기기

    ```
    // Note: You need to specify the array size in the function declaration 
    void printElements(int (*arr)[4]) { 
    	// we can now do this since the array won't decay 
    	int length{ sizeof(arr) / sizeof(arr[0]) }; 
    	for (int i{ 0 }; i < length; ++i) { 
    		std::cout << arr[i] << std::endl; 
    	} 
    }
    //출처: https://boycoding.tistory.com/217 [소년코딩]
    ```

  - 함수인자에 레퍼런스로 이차원 배열 넘기기

    ```
    // Note: You need to specify the array size in the function declaration 
    void printElements(int (&arr)[4]) { 
    ```

- **VARIALBE**

  - **normal variable** : 직접 값을 보유

  - **pointer** : 다른 값의 주소(또는 null)를 보유

  - **reference** : 다른 객체 또는 값의 별칭

    - `[type]& [name] = [non-const|const|r-value]` : 선언과 동시에 반드시 초기화해야 한다. null참조는 없음. &는 주소가 아니라 참조를 뜻한다. 초기화할 때는 non-const l-value로 초기화할 수 있다. const또는 r-value로는 안된다. 한번 초기화하면 다른 변수를 참조하도록 변경할 수 없다.

      ```
      int value = 5;
      int& ref = value;
      
      //ERR!!
      int test = 0;
      ref = test;
      ```

    - 일종의 별칭으로 쓰이며, 레퍼런스를 이용해 값을 바꾸면 참조한 값도 바뀐다. `&[레퍼런스변수명]`은 참조한 변수의 주소값을 반환한다.

      ```
      Object.complexive.chain.and.chain.rvalue = 2;
      int& ref = Object.complexive.chain.and.chain.rvalue;
      ref++;
      cout << ref << endl;
      
      if(&value == &ref) cout << "&REFERENCE is address of value"
      ```

    - C스타일 배열을 함수 매개인자로 던질 때 참조로 전달하면, 평가될 때 포인터로 변환되지 않는다.

      ```
      #include <iostream> 
      // Note: You need to specify the array size in the function declaration 
      void printElements(int (&arr)[4]) { 
      	// we can now do this since the array won't decay 
      	int length{ sizeof(arr) / sizeof(arr[0]) }; 
      	for (int i{ 0 }; i < length; ++i) { 
      		std::cout << arr[i] << std::endl; 
      	} 
      } 
      
      int main() { 
      	int arr[]{ 99, 20, 14, 80 }; 
      	printElements(arr); return 0; 
      }
      //출처: https://boycoding.tistory.com/207 [소년코딩]
      ```

    - 참조형은 접근할 때 암시적으로 역참조되는 포인터와 같은 역할을 한다. 내부적으로는 포인터를 사용하여 컴파일러에서 구현한다. 선언과 동시에 유효한 객체로 초기화해야하고, 일단 초기화되면 변경할 수 없으므로 안전하다.

- **PASS BY ??**

  - **pass by value** : 포인터가 아닌 인수는 값으로 전달된다. 해당 함수 매개인자 값으로 복사된다. 함수 내부에서 호출스택의 원래 인수를 수정할 수는 없다. 복사본을 전달받은 것이기 때문이다. 그러나 함수 내부로 복사된 값도 바꿀 수 없도록 하려면 `const` 키워드를 사용한다.

    - 장점 : 호출스택의 인수가 변경되지 않으므로 예기치 못한 부작용이 없다.
    - 단점 : 여러번 호출하는 경우 값을 복사(구조체, 클래스 등)하는 데 큰 비용이 들어 성능저하 가능.

  - **pass by address** : 인수는 주소이며, 함수 매개인자는 포인터다. 

    1. 가리키는 값에 접근/변경하기 위해 포인터를 역참조할 수 있다. `null` 포인터를 역참조하면 프로그램이 중단되므로, 역참조하기 전에 항상 확인해야 한다. 배열을 `int *ptr`로 전달하고 길이를 별도 매개변수로 전달해서 사용할 수 있다. 역시나 `const` 키워드를 사용해 함수 내 또는 호출스택의 인수를 수정할 수 없게 제한할 수 있다. 

    2. 그러나 포인터 변수 자체는 값으로 전달된다. 다시 말해 함수 매개인자의 포인터를 역참조하여 값을 변경하면, 호출스택의 값도 변경된다. 그러나 함수 내부에서 인자로 넘어온 포인터에 다른 변수의 주소값을 입력하면, 호출스택의 포인터는 변화가 없다. 인자로 넘긴 주소값을 복사해왔기 때문이다. 

    3. 참조로 주소를 전달하면 함수 인자로 넘어온 포인터가 가리키는 주소를 변경할 수 있다.

       ```
       void setToNull(int*& tempPtr) { 
       	tempPtr = nullptr; // use 0 instead if not C++11 
       }
       //출처: https://boycoding.tistory.com/218?category=1011971 [소년코딩]
       ```

    - 장점 : 호출스택의 인수 값을 변경할 수 있고, 인수 복사본을 만들지 않아 구조체/클래스 사용시 비용절감할 수 있다.
    - 단점 : 리터럴과 표현식은 주소가 없으므로 사용할 수 없다. 모든 값에 대하여 null인지 확인해야 한다. null 역참조시 프로그램 중단. 포인터 역참조는 값에 직접 접근하는 것보다 느리다.

  - **pass by reference** : 인수는 참조형 변수이다. const 참조형 변수 사용해 함수 내 또는 호출스택 인수 변경을 막을 수 있다.

    ```
    void addOne(int& y) { // y is a reference variable
    	y = y + 1; 
    }
    //출처: https://boycoding.tistory.com/217 [소년코딩]
    ```

    - 장점 : 호출스택의 인수 값을 변경할 수 있다. 또는 cosnt 참조형 변수로 변경을 제한할 수 있다. 인수 복사본을 만들지 않아 구조체/클래스 사용시 비용절감할 수 있다. / 참조는 선언시 유효한 객체로 초기화되므로 null 값에 대해 걱정하지 않아도 된다. 
    - 단점 : `non-const` 참조는 `const` 또는 `r-value`로 초기화할 수 없으므로 참조 매개인자로 넘길 때는 일반 변수여야 한다. / 인수가 변경될 수 있는지는 함수 호출에서 알 수 없다. 값으로 전달도, 참조로 전달도 함수호출할 때는 동일하다. 프로그래머가 인수 값이 변경될 수 있다는 점을 인식하지 못할 수 있다.

  

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



## TWEAK

- 미리 컴파일된 헤더(Precompiled header) : 컴파일 시간을 줄이기 위하여, 자주 변경되지 않고 모듈화된 코드를 미리 컴파일해 저장해두고 컴파일하지 않은 코드와 결합할 수 있다. 이렇게 미리 컴파일한 코드를 *PCH*라고 하고 일반적으로 `stdafx.h`로 네이밍한다. PCH파일은 프로그램 메모리 주소와 컴퓨터 환경에 대한 정보도 포함하기 때문에 생성된 컴퓨터에서만 사용해야 한다. `/Yc`옵션으로 만들고, `/Yu` 옵션으로 만들어진 PCH를 사용할 수 있다. (세부내용은 [MSDN::Precompiled Header File](https://docs.microsoft.com/ko-kr/cpp/build/creating-precompiled-header-files?view=vs-2019) 또는 [noirstar::PrecompiledHeader로 컴파일 시간 줄이기](https://noirstar.tistory.com/12) 참조)