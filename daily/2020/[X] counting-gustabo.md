셈(Counting)
구스타보는 수를 셀줄은 알지만 수를 쓰는 방법은 아직 배운지 얼마 되지 않았다. 1, 2, 3, 4까지는 배웠지만 아직 4와 1이 서로 다르다는 것은 잘 모르기 때문에 4라는 숫자가 1이라는 숫자를 쓰는 또 다른 방법에 불과하다고 생각한다.
그는 그가 만든 간단한 게임을 하면서 놀고 있다. 그가 알고 있는 네 개의 숫자를 가지고 수를 만든 다음 그 값을 모두 더한다. 예를 들면 다음과 같은 식이다.

132 = 1+3+2 = 6
112314 = 1+1+2+3+1+1 = 9 (구스타보는 4=1이라고 생각한다.)

구스타보는 합이 n인 수를 몇 개 만들 수 있는지 알고 싶어한다. n = 2일 경우에는 11, 14, 41, 44, 2, 이렇게 다섯 개의 숫자를 만들 수 있다(5 이상의 수도 셀 수는 있다. 다만 쓰지 못할 뿐이다.) 하지만 2보다 큰 경우에 대해서는 그가 만들 수 있는 수의 개수를 알 수가 없어서 여러분에게 도움을 청했다.

>> 입력
1이상 1000 이하의 임의의 정수 n이 한 줄에 하나씩 입력된다. 파일 끝 문자가 입력될 때까지 계속 읽어와야 한다.

>> 출력
입력된 각 정수에 대해, 합이 n이 되는 숫자의 가지 수를 나타내는 정수를 한 줄에 하나씩 출력한다.

>>> 입력 에
2
3

>>> 출력 예
5
13

##Stream I/O
Bytes단위로 파일을 읽어온다  
OutputStream str = new FileOutputStream([filepath])  
FileReader fr = new FileReader(new File([filepath]))  
fr.read() 아스키코드, 그리고 EOF에서 -1을 반환한다.  

##BufferedStream I/O
어.. 이건 메모리버퍼에 모았다가 한번에 읽어온다  
HDD>>프로그램 보다 HDD>>메모리버퍼>>프로그램이 더 효율적 그래서 BufferedReader를 쓴다  
BufferedOutputStream bs = new BufferedOutputStream(new FileOutputStream([filepath]))  
FileInputStream fs = new FileInputStream([filepath])  
byte[ ] readBuffer = new byte[fileStream.available()];  
        while (fileStream.read( readBuffer ) != -1){}  
BufferedInputStream br = new BufferedInputStream([I/O]) 이런걸 Wrapper객체라한다  
`BufferedInputStream`와 `BufferedReader`의 차이는 :  ???  
```java
    //written by aldehyde7 : https://aldehyde7.tistory.com/159
    private static byte[] intToByteArray(final int integer){
        ByteBuffer buff = ByteBuffer.allocate(Integer.SIZE/8);
        buff.putInt(integer);
        buff.order(ByteOrder.BIG_ENDIAN);
        //buff.order(ByteOrder.LITTEL_ENDIAN);
        return buff.array();
    }

    private static int byteArrayToInt(byte[] bytes) {
        final int size = Integer.SIZE / 8;
        ByteBuffer buff = ByteBuffer.allocate(size);
        final byte[] newBytes = new byte[size];
        for (int i = 0; i < size; i++) {
            if (i + bytes.length < size) {
                newBytes[i] = (byte) 0x00;
            } else {
                newBytes[i] = bytes[i + bytes.length - size];
            }
        }
        buff = ByteBuffer.wrap(newBytes);
        buff.order(ByteOrder.BIG_ENDIAN); // Endian에 맞게 세팅
        return buff.getInt();
    }
```

##Scanner내부 reader메소드
```java
/*
@buf는 CharBuffer, 객체생성 시점에 아래와 같이 초기화됨
buf = CharBuffer.allocate(BUFFER_SIZE);
buf.limit(0);
matcher = delimPattern.matcher(buf);

@source는 Readable, 객체생성 시점에 인자로 넘겨받음
BufferedReader, FileReader 같은 거당

Reader로 읽어와서 Buffer에 저장한당
*/

    // Tries to read more input. May block.
    private void readInput() {
        if (buf.limit() == buf.capacity())
            makeSpace();

        // Prepare to receive data
        int p = buf.position();
        buf.position(buf.limit());
        buf.limit(buf.capacity());

        int n = 0;
        try {
            n = source.read(buf);
        } catch (IOException ioe) {
            lastException = ioe;
            n = -1;
        }

        if (n == -1) {
            sourceClosed = true;
            needInput = false;
        }

        if (n > 0)
            needInput = false;

        // Restore current position and limit for reading
        buf.limit(buf.position());
        buf.position(p);
    }

```

##풀이
n = 1x + 2y + 3z  
f(n) = nC(y+z) * 2^(n-y-z)  
2와3의 조합으로 만들 수 있는 n보다 작은 수의 경우에 대하여  
각각의 나머지 자리수로 2를 거듭제곱하면 된다.  
결국 이 문제는 2와3으로 n이하의 수를 만들 수 있는 경우를 구하는 문제다.  


