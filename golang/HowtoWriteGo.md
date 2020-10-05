# [How to Write Go Code](https://golang.org/doc/code.html)

## Introduction

이 문서는 간단한 Go 패키지의 개발, go tool 소개, Go 패키지와 명령어를 fetch, build, install하는 방법을 다룹니다.
go tool을 쓰기 위해서는, 코드를 특정한 방식으로 조직해야 합니다. 이 문서를 주의깊게 읽기 바랍니다.

## Code organization

### Overview

- Go 프로그래머는 대게 코드를 단일 workspace에 작성합니다.
- workspace는 다수의 형상 관리 저장소를(repo)(이를테면 Git으로 관리되는) 아래에 둡니다.
- 각 저장소는 하나 이상의 패키지를 포함합니다.
- 각 패키지는 하나 이상의 Go 소스파일을 단일 디렉토리 아래 가지고 있습니다.
- 패키지 디렉토리 경로는 import시 경로를 결정합니다.

프로그램 개발환경에 따라 다르다는점에 유의하기 바랍니다. 프로젝트마다 workspace를 별도로 둔다거나, workspace가 형상 관리 도구로 긴밀하게 묶여있을 수도 있습니다.

### Workspaces

workspace는 다음 두 디렉토리의 루트가 되는 디렉토리입니다.
- src는 Go소스파일
- bin은 실행가능한 명령어

go tool은 bin 디렉토리에 바이너리를 빌드/설치합니다.
src 디렉토리는 대게 하나 이상의 소스 패키지를 추적 관리하는 다수의 형상 관리 저장소를 가지고 있습니다(이를 테면 Git이나 Mercurial)
정리하면, workspace는 실제로는 아래와 같은 모습을 하고 있을 겁니다.
```
bin/
    hello                          # command executable
    outyet                         # command executable
src/
    github.com/golang/example/
        .git/                      # Git repository metadata
		hello/
			hello.go               # command source
		outyet/
			main.go                # command source
			main_test.go           # test source
		stringutil/
			reverse.go             # package source
			reverse_test.go        # test source
    golang.org/x/image/
        .git/           		   # Git repository metadata
		bmp/
			reader.go              # package source
			writer.go              # package source
    ... (many more repositories and packages omitted) ...
```

위 디렉토리 트리를 보면, workspace 아래 example과 image 저장소가 있습니다. example 저장소는 hello와 outyet 명령어를 가지고 있고, stringutil 라이브러리를 가지고 있습니다. image 저장소는 bmp 패키지 등등을 가지고 있습니다.
일반적인 workspace는 여러 패키지를 가진 다수의 소스 저장소를 포함하고 있습니다. 대다수의 Go 프로그래머는 모든 Go 소스코드와 의존성을 단일한 workspace 아래에 둡니다.
workspace의 파일이나 디렉토리로 연결되는 심볼릭 링크는 사용하지 말아야 합니다. 이점에 유의하기 바랍니다.
명령어와 라이브러리는 다른 종류의 소스 패키지로 지어져 있는데, 이건 나중에 알아보도록 합시다.

### GOPATH environment variable

GOPATH 환경변수는 workspace의 위치를 특정하는 역할을 합니다. 디폴트값은 홈디렉토리의 go디렉토리를 가리킵니다.
다른 위치에서 작업하고 싶다면, GOPATH를 그 디렉토리로 수정해야 합니다. (보통 GOPATH=$HOME으로 설정해두고 작업을 하기도 합니다) GOPATH가 GO가 설치된 경로와 반드시 달라야 한다는 것에 주의하기 바랍니다.
`go env GOPATH` 명령어는 실행환경의(effective, 유효한?) 현재 GOPATH를 출력합니다. 환경변수가 설정되지 않았다면 디폴트 경로를 출력하구요.
편의성을 위해, workspace의 bin 서브디렉토리를 경로에 추가하기도 합니다.
```
$ export PATH=$PATH:$(go env GOPATH)/bin
```

본 문서에서 이 아래로는 `$(go env GOPATH)`대신 `$GOPATH`로 줄이겠습니다. 본 문서의 스크립트대로 실행하려면 GOPATH를 설정하지 않았다면, $HOME/go로 대체하거나 아래 명령어를 입력하기 바랍니다.
```
$ export GOPATH=$(go env GOPATH)
```

GOPATH 환경변수에 대해 더 알고 싶다면, `go help gopath`를 참고하기 바랍니다.
사용자정의 위치의 workspace를 사용하려면, GOPATH환경변수를 설정하기 바랍니다.

### Import paths

import경로는 패키지를 유일하게 가리키는 문자열로서, 패키지의 import 경로는 workspace 내부 위치 혹은 (아래에서 기술하는대로) 원격 저장소를 가리킵니다.

표준 라이브러리의 패키지는 "fmt"나 "net/http"처럼 import경로 문자열이 매우 짧습니다. 직접만든 패키지는 나중에라도 추가할지 모를 표준 라이브러리나 다른 외부 라이브러리와 충돌하지 않도록 경로를 설정해야 합니다.
코드를 어딘가의 원격 저장소에 저장하고 있다면, 그 원격 저장소를 기본 경롤로 설정해야 합니다. 예를 들어, Github계정이 있으면 github.com/user를 기본 경로로 사용해야 합니다.
빌드하기 전에 원격 저장소에 코드를 배포할 필요는 없습니다. 하지만 언젠가 그 코드를 배포할 것처럼 코드를 정돈해두는 것은 좋은 습관입니다. 실제로는 표준 라이브러리나 Go 생태계에서 유일한 임의의 경로를 사용하면 됩니다.
여기서는 github.com/user를 기본 경로로 사용하겠습니다. workspace 내부에 디렉토리를 생성해주세요.
```
$ mkdir -p $GOPATH/src/github.com/user
```

### Your first program

(디렉토리를 만들고 hello world프로그램을 짜는 내용)

```
$ go install github.com/user/hello
```
GOPATH로 사용자의 workspace를 찾아내기 때문에, 어떤 위치에서도 위 명령어를 실행할 수 있습니다. (번역 주 - go아래에 workspace를 별도로 만드는 것이 아니라, src 아래에 바로 디렉토리를 만들어야 위 명령어가 실행됨)

(해당 workspace에서는 위 명령어에서 패키지 경로를 생략할 수 있다는 내용)
(go는 오류가 발생했을 때만 결과를 출력)
(그 뒤에는 어떤 위치에서도 아래 명령어로 프로그램을 실행할 수 있다는 내용)
```
$ $GOPATH/bin/hello
```
(git 사용 권장)

### Your first library

(install은 bin디렉토리 아래에 실행가능한 파일을 출력
build는 컴파일된 패키지를 로컬 빌드 캐시에 저장(import경로를 모두 써야함)
- command source / command executable
- package source / complied package)

### Package names

`package name`
한 패키지 안의 모든 파일은 동일한 name을 가져야한다.
Go는 관습상 import경로의 마지막 요소를 패키지 이름으로 한다.
실행가능한 명령어는 `package main`을 사용해야 한다.
패키지 이름이 유일할 필요는 없으며, import경로만 유일하면 된다.

## TESTING

`go test`명령어와 `testing`패키지로 구성된 가벼운 테스트 프레임워크를 가지고 있다.
`_test.go`로 끝나는 파일을 생성하는데, 그 파일에는 TESTXXX라는 함수를 포함해야 하며 func `(t *testing T)`형식이어야 한다. 테스트 프레임워크는 함수 단위로 실행되며, 함수가 실패함수 이를테면 t.Error나 t.Fail을 호출하면 테스트는 실패한 것으로 간주된다.
예시)
```go
package stringutil

import "testing"

func TestReverse(t *testing.T) {
	cases := []struct {
		in, want string
	}{
		{"Hello, world", "dlrow ,olleH"},
		{"Hello, 世界", "界世 ,olleH"},
		{"", ""},
	}
	for _, c := range cases {
		got := Reverse(c.in)
		if got != c.want {
			t.Errorf("Reverse(%q) == %q, want %q", c.in, got, c.want)
		}
	}
}
```
패키지 디렉토리 안에서는 경로를 생략하고 `go test`, 다른 위치에서는 경로를 포함해서 실행하면 결과를 출력한다. 자세한 내요은 `go help test`참조.

## Remote Packages

go get명령어로 원격 패키지를 다운로드
패키지 이름이 같아도 import 경로를 모두 적으면 됨

## Next
- [golang-announce](https://groups.google.com/group/golang-announce)
- [Effective Go](https://golang.org/doc/effective_go.html)
- [A Tour of Go](https://tour.golang.org/)
- [Documentation Page](https://golang.org/doc/#articles)

## More help

