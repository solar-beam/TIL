# Linux inside Docker

윈도우에서 도커를 깔고, 리눅스를 사용해보자. 도커설치는 잘 설명한 블로그가 많으니 생략하겠다. 먼저 도커를 실행하고, 다음과 같이 우분투 이미지를 내려받아 도커 컨테이너를 실행한다.

```
$ docker pull ubuntu
$ docker run -it ubuntu
$ docker start [ubuntu_contatiner]  # [ubuntu_container]는 container id | name
$ docker attach [ubuntu_container]  # git bash에선mintty로 설정했으면, 앞에 wintty를 붙인다
```

아래 내용은 LFS(Linux From Scratch)라는, 리눅스를 소스코드 단계부터 컴파일해 구성하는 프로젝트의 배경지식 문서([LFS_essential_prereading](https://www.linuxfromscratch.org/hints/downloads/files/essential_prereading.txt))를 정리한 것이다. 리눅스를 처음 사용해보는 사람이라면 도움이 될 것이다. 

명령어 등은 우분투 18.04LTS 버전에서 확인했다. 배포판/버전이 다른 경우 다르게 동작할 수 있다.

  

## 기본 유틸리티

- 파일 및 디렉토리 생성, 조회, 복사, 이름변경, 편집 및 삭제

  ```
  $ mkdir [디렉토리명]  # 디렉토리 생성
  $ mkdir -p [디렉토리명]/[파일명]  # 디렉토리/파일 생성
  $ rmdir [디렉토리명]  # 디렉토리 삭제
  $ touch [파일명]   # 파일 생성
  $ cat > [파일명]   # 표준입력을 파일에 입력
  $ vi [파일명]      # 종료는 [esc]버튼 누르고 q, [enter]
  $ rm -rf [파일명]  # 디렉토리/파일 강제삭제 반복
  ```

- 디렉토리간 변경 및 현재 작업중인 디렉토리 조회

  ```
  $ cd [경로]  # 상위디렉토리는 .. 현재디렉토리는 .
  $ pwd       # 현재 작업중인 디렉토리 조회
  ```

- 디렉토리/파일 네이밍규칙

  - 파일과 디렉토리 이름에는 `/`를 사용할 수 없다. 경로명에서 구분자로 사용하기 때문.
  - 알파벳, 숫자, 대시(`-`), 밑줄(`_`), 온점(`.`)만 사용한다.
  - 공백문자와 특수문자(`*|"'@#$%^&`)를 사용하지 않는다.
  - 이름이 `,`로 시작하면 숨김파일로 간주한다.

- 표준 입출력과 매개인자, 파이프라인

  - [표준입출력이란](https://shoark7.github.io/programming/knowledge/what-is-standard-stream) 사용자가 다른 입출력 매체를 지정하지 않았을 때의 기본 입출력이다. 쉘 프로세스의 경우 키보드를 표준입력으로 받고 모니터 콘솔 출력을 표준출력으로 한다. 표준입출력은 부모프로세스에서 상속하며, 표준출력은 표준오류와 표준출력으로 나뉜다. 표준오류와 출력은 입출력 재지정을 통해 분리하여 출력할 수 있다. 

    ```
    $ ls -l             # 화면에 출력된다
    $ ls -l > list.txt  # 출력을 파일로 재지정했다
    $ echo              # 키보드입력을 받는다
    $ echo < list.txt   # 입력을 파일로 재지정했다
    ```

  - 파이프라인은 한 명령어의 결과를 다른 명령어의 입력으로 재지정하는 것이다.

    ```
    $ history | grep apt-cache  # history명령어 결과를 grep에 입력으로 넘겼다
    ```

  

## Unix-like OS의 작동방식

- **multi-user** : 다중사용자 권한

  리눅스는 다중 사용자 시스템으로 유저별로 권한을 다르게 설정할 수 있다. 기본적으로 root 슈퍼유저가 있고 모든 작업을 할 수 있다. 각 사용자는 하나 이상 그룹에 속해 있고, 그냥 유저를 만들면 유저 이름으로 그룹이 생성된다. 보통은 그 반대로 그룹을 만들고 권한을 설정한 다음 유저를 만들어 그룹에 속하게끔 한다.

  유저는 `etc/passwd`에 정의되어 있으며, 사용자 비밀번호는 암호화되어 `etc/shadow`에 정의되어 있다. 그룹은 `etc/group`에서 찾을 수 있다.

  ```
  ## user관련
  $ useradd [username]  # 유저추가
  $ userdel [username]  # 유저삭제
  $ usermod [username]  # 변경
  $ passwd [username]   # 비밀번호 저장/변경
  $ chage -m 2 [username]  # 비밀번호를 주기적으로 변경하도록 설정
  ```

  ```
  ## group관련
  $ groups  # 현재 사용자가 속한 그룹들을 보여줌
  $ gpasswd # 그룹의 비밀번호 변경/저장
  $ groupadd # 그룹추가
  $ groupmod # 그룹수정
  $ groupdel # 그룹삭제
  ```

- **file, file descriptor** : 파일 식별자

  리눅스에서 모든 것은 파일이다. 일반파일, 디렉토리(Directory), 소켓(Socket), 파이프(PIPE), 블록 디바이스, 캐릭터 디바이스 등 모두 파일이다. 이 파일에 접근할 때 파일 디스크립터라는 고유번호를 이용한다. 음수가 아닌 0이 아닌 정수를 파일 디스크립터로 사용한다. 표준입력에는 `0(STDIN_FILENO)`, 표준출력은 `1(STDOUT_FILENO)`, 표준에러에는 `2(STDERR_FILENO)`가 할당되어 있다. 그래서 배시에서 표준에러 출력을 재지정할 때 `2>`와 같이 표기하는 것이며, 표준출력 재지정은 `1>`을 `>`로 줄여쓴 것이다.

  > 더 공부해볼 주제: open file description table, struct file fd_array 커널구조체

- **process, process id** : 프로세스 식별자

  리눅스에서 새로운 프로세스는 `fork()` 시스템 호출로 만들어진다. 부모 프로세스에서 새로운 가지가 뻗어나가 자식 프로세스가 된다고 이해하자. 이를테면 `grep` 명령어는 쉘 프로세스에서 포크된 자식 프로세스이다. 이때 부모프로세스는 자식 프로세스에 프로세스 아이디(PID)라는 고유번호를 지정해준다. PID 0번은 커널에서 페이징을 담당하며, 1번은 주로 시스템을 시작하고 종료하는 데 사용되는 init 프로세스이다.

- **bash (The Bourne Again Shell)**

  자세한 내용은 다음 절에서 설명한다.

- **패키지 관리 (apt-get)** : 리눅스에서 프로그램을 설치하는법

  ```
  $ apt-get update  # 원격저장소 패키지목록 업데이트
  $ apt-get upgrade # 최신 패키지로 업그레이드
  $ apt-get install [package_name]   # 패키지 설치
  $ apt-cache search [package_name]  # 패키지 이름으로 검색
  ```

  - **cmatrix** 매트릭스처럼 초록색 글자가 쏟아져내리게 할 수 있다 

    ![image-20210707150528646](../img/cmatrix.PNG)

  - **aafire** 콘솔창에 불지르기

    ![](../img/aafire.PNG)
    
  - **GNU-Emacs 설치해보기**: 홈페이지 확인 → gzip 압축된 tar 파일로 소스코드 다운로드 → tar 및 gunzip으로 압축풀기 → README 파일 확인 → 설치 및 빌드

  - :trophy: **MPlayer 설치해보기**: 모든 종속성을 먼저 추적하고 설치해야하므로 좋은 도전과제임. 힌트는 [Beyond Linux From Scratch](https://www.linuxfromscratch.org/blfs/)를 참조

- 새 부트로더를 테스트하기 전에 시스템을 부팅할 대체 수단이 있어야 한다. Grub, Lilo 관련문서를 잘 읽고 수행할 것. (LFS프로젝트를 따라해보는 경우에만 해당된다.)

- 더 공부할 주제

  - :book: [Linux kernel user's and administrator's guide](https://www.kernel.org/doc/html/v5.7/admin-guide/index.html), [Linux Network Administrator's Guide](https://tldp.org/LDP/nag2/nag2.pdf)
  - :book: [Building and Installing Software Packages for Linux](http://wiki.kldp.org/wiki.php/LinuxdocSgml/Software-Building-HOWTO) `Autoconf`, `Automake`, `Libtoo` 
  - :book: [The advanced scripting guide]([Advanced Bash-Scripting Guide (tldp.org)](https://tldp.org/LDP/abs/html/))

  

## Bash Shell Cheat Sheet

배시 쉘이란? 아래와 같은 명령줄 콘솔이다. 링크를 따라 읽어보며 자유롭고 명확한 명령줄 세계에 발을 담가보자. 생각한 모든 것을 직접 해볼 수 있다. 한번 발을 들이면, 윈도우 GUI가 답답하게 느껴질 것이다.

![Bash (Unix shell) - Wikipedia](https://upload.wikimedia.org/wikipedia/commons/e/e7/Bash_screenshot.png)

- [핵심 Shell 커맨드 9개 살펴보기 - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/Top-basic-unix-shell-command)

- [새로운 리눅스 Shell 커맨드를 만났을 때 대처법 - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/ways-to-search-information-for-linux-commands)

  ```
  $ whatis [명령어]  # 명령어 기능을 출력
  $ type [명령어]  # 명령어 종류를 출력 / 1은 쉘 빌트인 2는 리눅스 프로그램 3은 쉘 스크립트 4는 유저가 정의한 함수
  $ apropos [문자열]  # 입력한 문자열을 포함하는 whatis 출력들을 모두 출력
  $ [명령어] --help
  $ man [명령어]
  ```

- [<중요> Shell: I/O Redirection - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/IO-Redirection-in-Shell)

- [유용한 쉘 명령어 소개 Part 1 - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/Useful-shell-commands-1)

- [alias: 나만의 쉘 커맨드 만들기 - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/make-my-own-shell-commands)

  ```
  $ echo "alias gg='git add; git commit'" >> ~./bashrc
  $ source ~/.bashrc 
  ```

  쉘은 처음 실행될 때만 '.bashrc' 파일(쉘의 설정파일)을 읽기 때문에 alias 명령어로 입력한 내용은 쉘을 다시 실행해야 적용된다. 지금바로 적용하려면, 쉘 스크립트 파일을 실행하는 source 명령어로 '.bashrc'를 실행한다.

- [<중요> Shell 확장 - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/shell-expansions)

  | 문자 클래스 | 매칭문자           |
  | ----------- | ------------------ |
  | [:alnum:]   | 모든 알파벳과 숫자 |
  | [:alpha:]   | 모든 알파벳        |
  | [:digit:]   | 모든 숫자          |
  | [:lower:]   | 소문자 알파벳      |
  | [:upper:]   | 대문자 알파벳      |

  ```
  ## 와일드카드
  $ echo [[:lower:][:digit:]]*  # 파일이름이 소문자 알파벳이나 숫자인 경우
  $ echo [^[:lower:]]*          # 파일이름이 소문자 알파벳이 아닌 경우
  $ echo [abc]                  # 파일이름이 a,b,c 중 하나로 시작하는 경우
  $ echo {김, 이, 박}태영
  김태영 이태영 박태영
  $ echo {A..Z}
  A B C D (생략) X Y Z
  ```

  ```
  ## 수식확장
  $ echo (5+5)
  10
  $ testvariant=10
  $ echo $testvariant
  10
  $ echo testvariant is $testvariant!  ## ERROR
  $ echo testvariant is $((testvariant))!
  testvariant is 10
  ```

  ```
  ### 확장억제
  $ echo "$USER $((3*4)) \n $(date)"
  tae0 12 Wed Jul  7 05:21:21 UTC 2021
  $ echo "* {1..3} ~"
  * {1..3} ~
  
  $ echo '$USER $((3*4)) $(date) * {1..3} ~'
  $USER $((3*4)) $(date) * {1..3} ~
  ```

- [유용한 쉘 명령어 소개 Part 2: find - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/Useful-shell-commands-2-find)

- (MacOS用) [둘이 코딩하다 하나가 죽어도 모르는 유익한 쉘 기능 소개 - Parkito's on the way (shoark7.github.io)](https://shoark7.github.io/programming/shell-programming/useful-shell-features)

  - **[CTRL] + a** : 커서를 맨앞으로 이동
  - **[CTRL] + e** : 커서를 맨뒤로 이동
  - **[CTRL] + u** : 커서보다 앞의 커맨드를 모두삭제
  - **[CTRL] + k** : 커서보다 뒤의 커맨드를 모두삭제
