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
> `parseInt()`�Ǵ� `Math.floor()`��� JAVA Int�� ���� ȿ���� �� �� �ְ�, `toString(2)` �Լ��� �ᵵ �ƴ�. `toFixed()`����ص� �ȴ�

### [JS ������](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Number)
- `parseInt()`
- [`toFixed()`](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed)
  - ����ǥ����� ������� �ʰ� ��Ȯ�� �Ҽ� �ڸ����� ���´�. �ʿ�� �ݿø� �����ϸ�, �Ҽ� �κ��� 0���� ä������.
  - `var a = 1` �� ǥ���Ŀ��� a�� �Ǽ��̴�. `1.0`
- `toPrecision()`
- `toString(<����, default:10>)`
- `valueOf()`
### [JS MATH](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Math)
- Math�� ��� �Ӽ��� �޼���� `static`�̴�.
