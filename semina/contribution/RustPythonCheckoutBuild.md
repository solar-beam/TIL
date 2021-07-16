# RustPython

[RustPython/RustPython: A Python Interpreter written in Rust (github.com)](https://github.com/RustPython/RustPython) 저장소를 클론하고 데모 파일을 실행해보았으나, 호환성 에러가 발생했다.

- version: cargo `1.46.0`, rustc `1.47.0`

![](../../img/cargoErr.PNG)

에러메시지만 보면 호환성을 지원하는 `resolver` 패키지를 추가해줘야하는데, 문제는 매니페스트 파일 어디에 어떻게 추가해야하는지 모른다는 것이다. 대신 [Feature 'resolver' is required · Issue #297 · emilk/egui (github.com)](https://github.com/emilk/egui/issues/297)를 참고하여 `cargo`와 `rust`를 업데이트 했다. 방법은 [Installation - The Cargo Book (rust-lang.org)](https://doc.rust-lang.org/cargo/getting-started/installation.html)를 참고. 

우분투 패키지 아카이브에는 최신 버전이 올라가 있지 않다. `cargo`, `rustc` 패키지를 완전히 삭제하고 `curl` 명령어로 설치 스크립트를 실행한다. 커맨드 쉘을 재실행하면 완료!

> 우분투랑 카카오 미러에는 왜 옛날 버전이 올라가 있는 것인가. [패키지 관리 - Ubuntu 리포지토리에 최신 버전의 소프트웨어가 없는 이유는 무엇입니까? - 우분투에 물어보세요 (askubuntu.com)](https://askubuntu.com/questions/151283/why-dont-the-ubuntu-repositories-have-the-latest-versions-of-software) 참고.

```
# apt-get remove cargo rustc
# curl https://sh.rustup.rs -sSf | sh
```

​    

그러나 이번에는 파이썬 컴파일 오류가 발생했다. 오류 넘어 오류.. [Can't build on windows · Issue #1624 · RustPython/RustPython (github.com)](https://github.com/RustPython/RustPython/issues/1624)를 참고해서 오류가 발생한 파일을 열어 상대경로를 절대경로로 바꿔주었다. 윈도우 환경에서 `wsl`로 접근하니 윈도우와 동일한 오류가 발생하는 것 같다.

- version: cargo `1.53.0` rustc `1.53.0`

![](../../img/cargoPythonErr.PNG)

수정한파일

- vm/Lib/python_builtins/_frozen_importlib.py
- vm/Lib/python_builtins/_frozen_importlib_external.py
- vm/Lib/core_modules/copyreg.py

​    

컴파일은 잘 되는데 이번에는 메인 쓰레드가 패닉 상태라고 한다. 나한테 왜그러는거야.. :frowning_face: 

![](../../img/mainthreadpanic.PNG)

먼저 오류 메시지에서 지시한대로 `RUST_BACKTRACE=1` 옵션을 주고 실행했다. 시간이 더 걸릴뿐 오류메시지가 더 정확히 나오진 않는다.

```
$ cargo run RUST_BACKTRACE=1 --release demo.py
```

`panic`을 던진 파일을 열어보면 다음과 같다. 그냥 예외처리함수를 정의한 부분 같은데, 어디서 던졌고 왜 던졌는지는 모르겠다. 

![](../../img/pycode.PNG)

[Vanilla checkout as described in README does not work on Windows · Issue #2687 · RustPython/RustPython (github.com)](https://github.com/RustPython/RustPython/issues/2687) 나말고도 같은 오류를 겪은 사람이 있었다. 윈도우 PATH문제인것 같은데 우분투에서도 그 문제였을까? 

[Install panic on Ubuntu 20.04 in Windows Subsystem for Linux · Issue #2293 · rust-lang/rustup (github.com)](https://github.com/rust-lang/rustup/issues/2293#issuecomment-619248357) 아무래도 Rust랑 윈도우, 특히나 WSL는 조합이 잘 안맞는 것 같다. 해당 이슈를 보면 WSL에서 glibc관련해서 문제가 있었는데 우분투 20.04가 배포된 이후에 식별된 문제라 반영이 안된것 같다.

​    

`18.04`로 바꾼 후에도 참신한 오류가 발생했다. 2.29는 `19.04`이상에서 지원된다.

![](../../img/glibcnotfound.PNG)

​    

WSL의 문제인지, ubuntu문제인지, cargo나 rust 문제인지 모르겠다. 어디서 문제가 생겼는지 모르니 해결방법을 찾지도 못하겠고. 

윈도우에서 빌드해도 같은 오류메시지가 나온다.  그런데 CMD 쉘에서는 상대경로 관련 오류 메시지를 뿜고, git bash 쉘에서는 thread main panic 오류 메시지를 뿜는다. 가설이지만, '경로문제'는 운영체제 때문이 아니라 쉘에서 해당파일을 읽어들이지 못하는 게 문제인 것 같다. WSL에 `..`같은 경로도 읽을 수 있게 바뀌면 좋겠다. 아니면 관련 기능을 지원하는 크로스 스크립트를 지원하던가.

Docker(Ubuntu 20.04)에서 빌드해보았다. 환장하겠다. 

![](../../img/dockerRustLinkerNotFound.PNG)

`sudo apt install build-essential` 명령어로 `gcc`를 설치하고 다시 빌드해보았다. docker가 멈췄다. 왜일까.

​    

커뮤니티에 글을 남겼다. 코드잘알이 알려줄 때까지, 다른 일에 집중하자. 우선 잘 되는 환경에서 helloworld라도 돌려보고 다시 이 오류로 돌아오자.

```
solar-beam @solar-beam 19:25
Hi, I'm troubling with cargo run on Windows10 WSL(ubuntu 20.04, cargo 1.53.0, rustc 1.53.0.) It seems WSL has a compatibility issue with Rust. Could you share your well-working environments including os/cargo/rust version?
Also, windows cmd shell arouses symlink error, but I cannot find the symlinks-to-hardlinks.ps1 file mentioned as solution on #1624 issue RustPython/RustPython#1624. Was it deprecated?
```



뭐 답이 없다. git log로 파일을 삭제한 사람을 찾아봤다. 그런데 커밋 내용을 보니 derive/src 디렉토리 아래 `compile_bytecode.rs`에 windows 분기를 추가해놨다. 그럼 상대경로 절대경로 문제는 아닌것 같은데..

```
$ git log | grep symlinks  # 해당스크립트를 추가한 커밋도 있고, 삭제한 커밋도 보였다
$ git log                  # /[keyword] 입력후 [n]키를 눌러 내용을 확인해봤다
$ git show [commit hash]   # 해당커밋 개요보기
$ git diff [commit hash]^! # 해당커밋 변경내용 보기
```

![](../../img/RustPythongitCommit.PNG)



WSL을 윈도우로 잘못 인식한게 원인은 아닐까? 해당 파일에 print문을 하나 추가해 다시 빌드했다. 음 출력이 되지는 않는데, 따로 테스트 코드를 만들어서 실행해보니 윈도우로 인식하는건 아니었다. 그럼혹시 윈도우 시스템의 경로 자체를 못 읽어들이는 것은 아닐까? 마운트된 윈도우 파일시스템 말고, WSL 내부 디렉토리에 프로젝트를 복사해 빌드해보았다. HEAD는 이전 커밋으로 hard reset해서 코드를 초기화했다. 환장하겠다.

![](../../img/rpErr101.PNG)



깃헙 페이지를 보니 이미 확인된 문제다. 아래와 같이 테스트를 자동화해서 수행하고 있다.

![](../../img/rpErr102.PNG)



깃헙 페이지 커밋 로그에서 테스트를 모두 정상 통과한 버전으로 롤백해보자.

```
$ git reset --hard [commit hash]  # 커밋 이력을 남기지 않고 되돌리기
$ git reset --hard HEAD~3         # 현재 HEAD부터 3개 커밋을 롤백한다
$ git reset --hard HEAD^^^        # N번 반복할 경우 ^을 N번 반복
$ git push -f origin master       # 커밋 이력을 강제로 덮어씌운다
```

```
$ git revert --no-commit HEAD~3
$ git commit -m 'Revert "Commit 4,3,2"'
$ git push
```

![](../../img/prSUCCEED.PNG)

됐따!



결론, WSL과 윈도우 파일시스템의 호환성 문제로 추정. WSL에서는 `mnt`디렉토리에 접근하려면 그 앞에도 `/`를 붙여야 한다. `/mnt/d/[디렉토리]/[파일]`로 접근해야 한다. 그런데 rust에서는 이런 경로를 읽지 못한다. 맨앞에 `/`를 붙이면 컴파일이 안되고, `/`를 제외하면 메인 쓰레드에서 패닉을 던진다.일단 내 가정은 그렇고, 정말 그래서 panic을 던진건지는 모르겠다. 언젠가 프로젝트를 잘 이해하게 되면, `bytecode_compile.rs`에 새 분기를 만들어서 지원할 수 있을 것 같다. 

![](../../img/RustPython100.PNG)
