## [Binary Addition](https://www.codewars.com/kata/551f37452ff852b7bd000139/train/javascript)

* INPUT : `a, b`
* OUTPUT : `(a+b) in binary`

```javascript
function addBi(a, b)
{
	var remainder, result="", sum=a+b;
	while(sum>=2)  //
	{	
		remainder=sum%2;
		sum=parseInt(sum/2);
		result=remainder+result;
		console.log(remainder, ",", sum)
	}
	return ("1"+result);
}
```
> `parseInt()`또는 `Math.floor()`써야 JAVA Int와 같은 효과를 볼 수 있고, `toString(2)` 함수를 써도 됐다. `toFixed()`사용해도 된다

### [JS 숫자형](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Number)
- `parseInt()`
- [`toFixed()`](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed)
  - 지수표기법을 사용하지 않고 정확한 소수 자리수를 갖는다. 필요시 반올림 가능하며, 소수 부분은 0으로 채워진다.
  - `var a = 1` 이 표현식에서 a는 실수이다. `1.0`
- `toPrecision()`
- `toString(<진수, default:10>)`
- `valueOf()`
### [JS MATH](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Math)
- Math의 모든 속성과 메서드는 `static`이다.
