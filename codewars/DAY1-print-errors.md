## [Printer Errors](https://www.codewars.com/kata/printer-errors/train/javascript)

* INPUT : `string(/[a-z]/+)`
* OUTPUT : `the length of the control string / the number of errors(/[n-z]/)`

```javascript
function printerError(s) {
    var comp = s.replace(/[n-z]+/gi, '');
    var denom = s.length;
    return (denom-comp.length) + "/" + (denom);
}
```
> match�޼��� ����Ұ�, g�÷��״� �ʼ����ص� i�� ����?

### [JS String Methods](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/String)
- ���ڿ� ���ͷ��� ��ü�� �ٸ���. �׷��� JS�� �ڵ����� ���ڿ� ���ͷ��� ��ü�� ��ȯ�ϰ�, ���ڿ� ��ü�� ���ͷ��� �ٲ��ִ� �޼��带 �����Ѵ�(..��ü��?)
- `eval()`�� �����ϸ�, ���ڿ� ���ͷ��� �ҽ��ڵ�� ��޵ȴ�. �׷��� ���ڿ� ��ü�� valueOf()�޼���� ���ڿ� ���ͷ��� �ٲ��� �� �ִ�(..�Ʊ�װ�)
- String Generic �޼��� : JS1.6�̸� ESǥ���� �ƴϴ�.
- String Instance
  - `.length`
  - `.charAt()` ��
- ���ڿ��� ��ȯ�� �� `.toString()`�ᵵ ������, `new String()`�� ���� �����ϴ�.

### [JS RegEx Pattern](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/RegExp)
```javascript
/pattern/flags               /*����ǥ��*/
new RegExp(pattern[, flags]) /*�����ڷ� ���鶧*/
```
- flags
  - g(global match, ��ġ�ϴ� ù��° ���ڿ��� ������ �ʰ� ��ü���� ��ġ�ϴ� ��� ���ڸ� �˻�)
  - i(ignore case, ��ҹ��ڸ� �������� ����)
  - m(multiline, ����/������ ������ �����࿡ ������. ���� ������ ���� Ȥ�� ���� �ƴ϶� ��ü ������ ���� Ȥ�� ������ ����)
  - y(sticky, `lastIndex` ������Ƽ�� ����Ű�� �� ������ ����. ��) abaaba���ڿ����� �޼ҵ带 ������ ȣ���ϸ� `lastIndex`�� ���ʷ� 3,6�� �ȴ�)
- literal : ǥ������ �򰡵ɶ� �����ϵ� ���·� �����Ǹ�, ��� ���·� ������� ������ ����Ѵ�. ��ǻ�� �ڿ��� ������ �� �ִ�.
- constructor : ǥ������ ��Ÿ�ӿ� �����ϵ�(ES6���ʹ� ���Խ� �����ڿ� ���ڿ��� �ƴ϶� ���Խ� ���ͷ��� �Է��ص� `[TypeError](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/TypeError)`�� ���� �ʴ´�.)
- [JavaScript Regex Cheatsheet](https://www.debuggex.com/cheatsheet/regex/javascript)
![](../img/regex-cheat-sheet.PNG)

## [���� : JS �񱳿�����](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/Comparison_Operators)
