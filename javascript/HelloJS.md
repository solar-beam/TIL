## Hello, Javascript
> 2018/12/30, ES6 slide1~2

### ���ں�
- FALSE
```javascript
let n = 0;
while(true)
{
  n+=0.1;
  if(n===0.3)break;
}//������ ���������� ���� 0.30000000000004
```
- CORRECT
```javascript
let n = 0;
while(true)
{
  n+=0.1;
  if(Math.abs(n-0.3)<Number.EPSILON)break;
}//��...
```

### �ڵ�����ȯ
- ����/���ڿ��� ��������� ���ڷ� �ڵ�����ȯ
- ����/���ڿ��� ��������� ���ڿ��� �ڵ�����ȯ
- 3*'30'=90
- '30'*3=90
- 3+'30'='330'
- '30'+3='303'

--

### Gulp

### ���ξ˰Ե� ����
- let, const
- ${interpolation}
- Symbol()
- ���ð� �Ҵ��� �������� ����, ��ü �Ҵ��� ���۷��� ����
  ������ ���� ���ϸ� �纻�� ���ϳ�, ������ �� ��ü�� �Ҵ��ϸ� �纻�� ������ �޶�����
- ��ü ��ü�Ҵ�, �迭 ��ü�Ҵ�, �Ű����� ��ü
- ȭ��ǥ ǥ���
- this�� scope
- �������� Ŭ����
- ��Ͻ����� ����
- let�� var(ȣ�̽���)
- �迭�� �Լ�
- reduce�Լ�

### ����ȯ
- Number([����ڿ�])
- parseInt([])|parseFloat([]) : ���ڿ��� ������
- [Date��ü].valueOf() : Date�� ���ڷ� �ٲ�

### ���
- for...in loop
- for...of loop

### Falsy�� Truthy
- falsy : undefined, null, false, 0, NaN, ''
- true : ��簴ü(valueOf()�ؼ� false�� ��ȯ�ϴ� ��ü ����), ' ', �迭, �� �迭, ���ڿ� "false"

### call, apply, bind
- [�Լ���].call(this��ü) �Ͻ������� �ش簴ü ���ο� ����� �Լ��� ��ó�� ����
- [�Լ���].apply([this��ü|null...],�迭��) �迭�� ���ڷ� �ѱ�
- [�Լ���].bind(this��ü) ���������� this�� �ٲ�
