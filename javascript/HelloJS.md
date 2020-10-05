## Hello, Javascript
> 2018/12/30, ES6 slide1~2

### 숫자비교
- FALSE
```javascript
let n = 0;
while(true)
{
  n+=0.1;
  if(n===0.3)break;
}//루프를 빠져나오지 못함 0.30000000000004
```
- CORRECT
```javascript
let n = 0;
while(true)
{
  n+=0.1;
  if(Math.abs(n-0.3)<Number.EPSILON)break;
}//음...
```

### 자동형변환
- 숫자/문자열의 곱셈연산시 숫자로 자동형변환
- 숫자/문자열의 덧셈연산시 문자열로 자동형변환
- 3*'30'=90
- '30'*3=90
- 3+'30'='330'
- '30'+3='303'

--

### Gulp

### 새로알게된 내용
- let, const
- ${interpolation}
- Symbol()
- 원시값 할당은 값에의한 참조, 객체 할당은 레퍼런스 참조
  원본의 값이 변하면 사본도 변하나, 원본에 새 객체를 할당하면 사본과 원본은 달라진다
- 객체 해체할당, 배열 해체할당, 매개변수 해체
- 화살표 표기법
- this의 scope
- 스코프와 클로저
- 블록스코프 변수
- let과 var(호이스팅)
- 배열의 함수
- reduce함수

### 형변환
- Number([대상문자열])
- parseInt([])|parseFloat([]) : 문자열은 무시함
- [Date객체].valueOf() : Date를 숫자로 바꿈

### 제어문
- for...in loop
- for...of loop

### Falsy와 Truthy
- falsy : undefined, null, false, 0, NaN, ''
- true : 모든객체(valueOf()해서 false를 반환하는 객체 포함), ' ', 배열, 빈 배열, 문자열 "false"

### call, apply, bind
- [함수명].call(this객체) 일시적으로 해당객체 내부에 선언된 함수인 것처럼 동작
- [함수명].apply([this객체|null...],배열명) 배열을 인자로 넘김
- [함수명].bind(this객체) 영구적으로 this를 바꿈
